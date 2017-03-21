%--------------------------------------------------------------------------
%
%Description: Making a text file that gives the PSWFILE input for campari
%
%     Inputs: N/A
%
%    Outputs: A text document
%
%--------------------------------------------------------------------------

fh = fopen('Bounds2', 'w');

formatSpec = '%s\n';

fprintf(fh,formatSpec,'R');
for i = 1:1670
    %i represents the amino acids that we want to be restricted in sampling
    if (i > 111 && i < 169) || (i > 582 && i < 692) || (i > 743 && i < 869)...
            || (i > 1523 && i < 1671)
        line = [num2str(i) ' INT'];
        fprintf(fh,formatSpec,line);
        line = [num2str(i) ' FYO'];
        fprintf(fh,formatSpec,line);
        line = [num2str(i) ' CHI'];
        fprintf(fh,formatSpec,line);
        line = [num2str(i) ' PUC'];
        fprintf(fh,formatSpec,line);
        line = [num2str(i) ' OTH'];
        fprintf(fh,formatSpec,line);
    end
end
