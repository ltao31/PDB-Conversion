function PDBChanger()
%--------------------------------------------------------------------------
%
%Description: Taking in a PDB file and adding in ions
%
%     Inputs: A PDB file, a number for the amount of CL- or NA+
%             ions, NA or CL for CL-/NA+, the new file name
%
%    Outputs: A PDB file with ions
%
%--------------------------------------------------------------------------

%ask for inputs
fprintf('PDBChanger\n');
txtInput = prompt('Please input name of input file', 's');
txtOutput = prompt('Please input name of file you want outputted', 's');
NaCl = prompt('Please write Na if adding sodium or Cl if adding chloride', 's');
num = prompt('please enter amount of ions you want to add');

%open the input file and another file to write to
fh = fopen(txtInput);
fh2 = fopen(txtOutput, 'w');
formatSpec = '%s\n';
line = fgetl(fh);

%write the pdb file up to the keyword 'END' to the output file
while ischar(line)
    line = fgetl(fh);
    if strcmp(line(1:3), 'END')
        break;
    end
    %Changing HIS to HIE
    for i = 1:length(line)
        if sum([i 2]) <= length(line) && strcmp(line(i:i+2), 'HIS')
            line(i+2) = 'E';
        end
    end
    fprintf(fh2,formatSpec,line);
    %randomly choose a reference line
    if rand()>0.9
        tempLine = line;
    end
    tempLine2 = line;
end
%set initial numbers
spaces = find(tempLine ==' ')
for i = 1:length(spaces)-1
    if spaces(i) == spaces(i+1)
        spaces(i+1) = [];
    end
end
%Using reference line to initialize values for CL-
num1 = strtrim(tempLine2(spaces(1):spaces(2)));
num2 = strtrim(tempLine2(spaces(4):spaces(5)));
x_Coo = strtrim(tempLine(spaces(5):spaces(6)));
y_Coo = strtrim(tempLine(spaces(6):spaces(7)));
z_Coo = strtrim(tempLine(spaces(7):spaces(8)));

%Adding CL- to the pdb
for i = 1:num
    num1 = num1 + i;
    num2 = num2 + i;
    aRand = (xCoo).*rand(1,1);
    rAnd2 = ceil((x_Coo - aRand).*1000)./1000;
    rAnd2 = num2str(rAnd2);
    
     %make sure rAnd2 has 3 decimal places
     while strcmp(rAnd2(5), '.') && length(rAnd2) <8
         rAnd2 = [rAnd2 '0'];
     end
    %format so that xx.xxx matches xxx.xxx
    if strcmp(rAnd2(4), '.')
        rAnd2 = [' ' rAnd2]
    end
    if strcmpi(NaCl, 'CL')
        aLine = ['HETATM' num2str(num1) '  CL- CL-  ' num2str(num2) '    ' rAnd2 ' ' num2str(y_Coo) ' ' num2str(z_Coo) '  ' '1.00  0.00 ' '         CL-'];
    else
        aLine = ['HETATM' num2str(num1) '  NA+ NA+  ' num2str(num2) '    ' rAnd2 ' ' num2str(y_Coo) ' ' num2str(z_Coo) '  ' '1.00  0.00 ' '         NA+'];        
    end
    fprintf(fh2,formatSpec,aLine);
end

%write the rest of the input file to the output file
fprintf(fh2,formatSpec,line);
while ischar(line)
     line = fgetl(fh);
     fprintf(fh2,formatSpec,line);
end
 
end