function FASTA2SEQ()
%--------------------------------------------------------------------------
%
%Description: Taking in a FASTA file and converting it to a sequence file
%             campari can read.
%
%     Inputs: A FASTA text file, a number for the amount of CL- or NA+
%             ions, NA or CL for CL-/NA+
%
%    Outputs: A txt file of the AA sequence
%
%--------------------------------------------------------------------------

%ask for inputs
fprintf('FASTA2SEQ\n');
txtInput = prompt('Please input name of input file', 's');
txtOutput = prompt('Please input name of file you want outputted', 's');
NaCl = prompt('Please write Na if adding sodium or Cl if adding chloride', 's');
num = prompt('please enter amount of ions you want to add');

%open the input file
fh = fopen(txtInput);
line1 = fgetl(fh);
line = line1;
%Get concatinate all of the input file into one string
while ischar(line1)
    line1 = fgetl(fh);
    line = [line line1];
end
%remove everything that is not a amino acid abbreviation
line(ismember(line,' ,.:;!1234567890')) = [];

%lowercase the sequence, add ACE to the front and NME to the back
line = lower(line');
newLine = {'ACE'};
for i = 1:length(line)
    newLine{i+1} = line(i);
end
newLine{length(line)+1} = 'NME';
%add specified number of CL- ions to counteract charge
if strcmp(NaCl,'NA')
    for i = 1:num
        newLine{length(line)+1+i} = 'NA-';
    end
else
    for i = 1:num
        newLine{length(line)+1+i} = 'CL-';
    end
end
newLine{length(line)+65} = 'END';

%change each letter abbreviation to a three letter abbreviation
[newLine{ismember(newLine,'g')}] = deal('GLY');
[newLine{ismember(newLine,'a')}] = deal('ALA');
[newLine{ismember(newLine,'s')}] = deal('SER');
[newLine{ismember(newLine,'t')}] = deal('THR');
[newLine{ismember(newLine,'c')}] = deal('CYS');
[newLine{ismember(newLine,'v')}] = deal('VAL');
[newLine{ismember(newLine,'l')}] = deal('LEU');
[newLine{ismember(newLine,'i')}] = deal('ILE');
[newLine{ismember(newLine,'m')}] = deal('MET');
[newLine{ismember(newLine,'p')}] = deal('PRO');
[newLine{ismember(newLine,'f')}] = deal('PHE');
[newLine{ismember(newLine,'y')}] = deal('TYR');
[newLine{ismember(newLine,'w')}] = deal('TRP');
[newLine{ismember(newLine,'d')}] = deal('ASP');
[newLine{ismember(newLine,'e')}] = deal('GLU');
[newLine{ismember(newLine,'n')}] = deal('ASN');
[newLine{ismember(newLine,'q')}] = deal('GLN');
[newLine{ismember(newLine,'h')}] = deal('HIE');
[newLine{ismember(newLine,'k')}] = deal('LYS');
[newLine{ismember(newLine,'r')}] = deal('ARG');

%transpose cell array
newLine = newLine';

%create a new txt file and rewrite the thing to a new file
fh2 = fopen(txtOutput, 'w');
formatSpec = '%s\n';
for i = 1:length(newLine)
    fprintf(fh2,formatSpec,newLine{i,1});
end
fclose(fh2);
fclose(fh);
end
