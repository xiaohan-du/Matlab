classdef canbeam < beam
    
    properties
        
        cons
        fce
        
    end
    
    methods
        
        function obj = canbeam(abaInpFile, masFile, damFile, stiFile, ...
                locStart, locEnd, INPname, domLengi, ...
                domBondi, domMid, trial, noIncl, ...
                noStruct, noPm, noMas, noDam, tMax, tStep, ...
                errLowBond, errMaxVal, errRbCtrl, ...
                errRbCtrlThres, errRbCtrlTNo, cntInit, refiThres, ...
                drawRow, drawCol, fNode, ftime, fRange, nConsEnd)
            
            obj = obj@beam(abaInpFile, masFile, damFile, stiFile, locStart, ...
                locEnd, INPname, domLengi, ...
                domBondi, domMid, trial, noIncl, ...
                noStruct, noPm, noMas, noDam, tMax, tStep, ...
                errLowBond, errMaxVal, errRbCtrl, ...
                errRbCtrlThres, errRbCtrlTNo, cntInit, refiThres, ...
                drawRow, drawCol); % only base class properties
            
            obj.fce.time = ftime;
            
            obj.fce.node = fNode;
            
            obj.fce.range = fRange;
            
            obj.no.consEnd = nConsEnd;
        end
        %%
        function obj = gaussian(obj, shift, sig, unit_amp, debugMode)
            % generate Gaussian function.
            % Input:
            % obj.fce.xaxis: x-axis, contains length of gap.
            % shift: negative value moves the curve to right.
            % sig: small value = narrow curve.
            % unitAmp: set to 1 normalise the amplitude.
            % debugMode: set to 1
            % Output:
            % obj.fce.gaus: 1-by-n array gaussian bell shape force.
            if debugMode == 1
                % if in debug mode, use xaxis of fce with shift to generate
                % efunc.
                efunc = - (obj.fce.xaxis - shift) .^ 2 / 2 / sig ^ 2;
                obj.fce.gaus = 1 / sqrt(2 * pi * sig ^ 2) * exp(efunc);
            elseif debugMode == 0
                % if not in debug mode, use a wide range without shift to
                % generate efunc.
                xRange = linspace(-1, 1, obj.fce.range);
                efunc = - xRange .^ 2 / 2 / sig ^ 2;
                obj.fce.gaus = 1 / sqrt(2 * pi * sig ^ 2) * exp(efunc);
                idx = obj.fce.gaus > 1e-5;
                obj.fce.gaus = obj.fce.gaus(idx);
                obj.fce.gaus = obj.fce.gaus - obj.fce.gaus(1);
            end
            
            if unit_amp == 1
                obj.fce.gaus = obj.fce.gaus / max(obj.fce.gaus);
            end
            
        end
        
        %%
        function obj = generateNodalFce(obj, ndofPerNode, sig, debugMode)
            % works for both 2d and 3d.
            obj.fce.dof = ndofPerNode * obj.fce.node;
            obj.fce.val = sparse(obj.no.dof,  obj.no.t_step);
            obj.fce.xaxis = (0 : obj.time.step : obj.fce.time);
            % gaussian(obj, shift, sig, unit_amp)
            obj = gaussian(obj, 0.03, sig, 1, debugMode);
            
            obj.fce.val(obj.fce.dof, 1:length(obj.fce.gaus)) = ...
                obj.fce.val(obj.fce.dof, 1:length(obj.fce.gaus)) + ...
                obj.fce.gaus;
            
        end
        
        %%
        function obj = generateNodalFceStatic(obj, ndofPerNode)
            % generate -1 static force.
            obj.fce.dof = ndofPerNode * obj.fce.node;
            obj.fce.val = sparse(obj.no.dof, 1);
            % gaussian(obj, shift, sig, unit_amp)
            obj.fce.val(obj.fce.dof) = obj.fce.val(obj.fce.dof) - 1;
            
        end
        
        %%
        function obj = readINPconsCanti(obj, dim)
            % Read constraint information from INP file. Still manually
            % input the constraint informations (left and right for fixie case).
            % obj.INPname: dir and name of Abaqus INP file.
            lineConsStart = [];
            lineConsEnd = [];
            fid = fopen(obj.INPname);
            tline = fgetl(fid);
            lineNo = 1;
            % find the line no of constraints.
            while ischar(tline)
                lineNo = lineNo + 1;
                tline = fgetl(fid);
                celltext{lineNo} = tline;
                for i = 1:obj.no.consEnd
                    
                    line_cons1 = strfind(tline, obj.str.locStart{i});
                    location = isempty(line_cons1);
                    if location == 0
                        lineConsStart = [lineConsStart; lineNo];
                    end
                    
                    line_cons2 = strfind(tline, obj.str.locEnd{i});
                    location = isempty(line_cons2);
                    if location == 0
                        lineConsEnd = [lineConsEnd; lineNo];
                    end
                end
            end
            
            strtext = char(celltext(2:(length(celltext)-1)));
            
            fclose(fid);
            obj.cons.node = cell(1, obj.no.consEnd);
            obj.cons.dof = cell(1, obj.no.consEnd);
            for i = 1:obj.no.consEnd
                txtCons = strtext((lineConsStart(i, 1) : ...
                    lineConsEnd(i, 1) - 2), :);
                trimCons = strtrim(txtCons);
                consNode = [];
                for iCons = 1:size(trimCons, 1)
                    
                    cons0 = str2num(trimCons(iCons, :));
                    consNode = [consNode; cons0'];
                    
                end
                obj.cons.node(i) = {consNode};
                obj.no.cons(i) = length(obj.cons.node{i});
                consDof = zeros(dim * obj.no.cons(i), 1);
                
                for j = 1:obj.no.cons
                    
                    consDof(j * dim - (dim - 1) : j * dim) = ...
                        consDof(j * dim - (dim - 1) : j * dim) + ...
                        (dim * obj.cons.node{i}(j) - (dim - 1): dim * ...
                        obj.cons.node{i}(j))';
                    
                end
                
                obj.cons.dof(i) = {consDof};
                
            end
        end
    end
end