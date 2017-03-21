function Disordered_Comparator(txtInput)
%--------------------------------------------------------------------------
%
%Description: Compare a FASTA file with output from Disprot to determine
%             which areas are supposedly disordered
%
%     Inputs: A FASTA file
%
%    Outputs: A residue list is displayed with disordered areas replaced by
%             '_'
%
%--------------------------------------------------------------------------

fh = fopen(txtInput);
line1 = fgetl(fh);
line = line1;
while ischar(line1)
    line1 = fgetl(fh);
    line = [line line1];
end
line(ismember(line,' ,.:;!1234567890')) = [];

line = upper(line);
line2 = line;
line3 = line;
x = input('Loops/coils - Hot-Loops - Remark-465 - all');

%this part is hardcoded from what I found on disprot
a = [1:30, 60:85, 105:155, 174: 206, 214:305, 318:342, 351:373, ... 
        385:480, 497:595, 603:615, 621:631, 655:670, 678:747, 766:796, ... 
        805:822, 832:841, 858:1035, 1044:1097, 1110:1168, 1174:1223, ...
        1229:1282, 1302:1317, 1322:1433, 1445:1457, 1482:1552, 1562:1577, ...
        1585:1618, 1625:1634, 1653:1692];
b = [1:26, 70:84, 105:118, 147:56, 195:235, 247:374, 383:427, ...
        434:453, 465:561, 575:595, 603:616, 655:668, 678:685, 764:822, ...
        831:839, 891:1034, 1111:1220, 1250:1285, 1299:1315, 1335:1396, ...
        1408:1419, 1424:1500];
c = [1:13, 42:52, 66:84, 184:353, 371:393, 405:442, 496:557, ...
        575:590, 703:725, 792:799, 890:907, 927:966, 983:1009, ...
        1123:1183, 1195:1223, 1247:1278, 1301:1314, 1332:1374, ...
        1383:1392, 1419:1437, 1443:1468, 1479:1500];
d = [1:21, 183:604, 692:743, 851:1335, 1403:1537, 1641:1693];    

%these are found on http://www.uniprot.org/uniprot/Q86UR5#family_and_domains
RabBD = line(22:182);
PDZ = line(605:691);
C21 = line(744:850);
Naaxx = line(1336:1402);
C22 = line(1538:1640);

%found on http://www.rcsb.org/pdb/explore/explore.do?structureId=2Q3X
C22a = ['SPGPAQLVGRQTLATPAMGDIQIGMEDKKGQLEVEVIRARSLTQKPGSKSTPAPYVKVYLLE' ...
    'NGACIAKKKTRIARKTLDPLYQQSLVFDESPQGKVLQVIVWGDYGRMDHKCFMGVAQILLEELDL' ...
    'SSMVIGWYKLFPPSSLVDPTLAPLTRRASQSSLESSSGPPCIRS']

%replace disordered area with '_'
if x == 1
    line(a) = '_';
    line2(d) = '_';
elseif x == 2
    line(b) = '_';
    line2(d) = '_';
elseif x == 3
    line(c) = '_';
    line2(d) = '_';
elseif x == 4
    line([a,b,c]) = '_';
    line2(d) = '_';
end

n = 0;
newLine = cell(n);
newLine2 = cell(n);
newLine3 = cell(n);
for i = 1:ceil(length(line)/10/5)
    for j = 1:5
        if (j+n)+9 > length(line)
            newLine{i, j} = line((1+n):end);
            newLine2{i, j} = line2((1+n):end);
            newLine3{i, j} = line3((1+n):end);
            break;
        else
            newLine{i, j} = line((1+n):(1+n)+9);
            newLine2{i, j} = line2((1+n):(1+n)+9);
            newLine3{i, j} = line3((1+n):(1+n)+9);
            n = n+10;
        end
    end
end

fh2 = fopen('RIM1a Sequence New', 'w');
formatSpec = '%s ';
for i = 1:length(newLine)
    fprintf(fh2,formatSpec,[newLine3{i,:} '\n']);
end
fclose(fh2);
fclose(fh);
end

