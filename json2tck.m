function json2tck(fjson,ftckout)
%json2tck(fjson,ftckout)
%
% fjson   : Input json file name.
%           Download them from https://neuroinformatics.nl/HBP/allen-connectivity-viewer/streamline-downloader.html
% ftckout : File name for output .tck file.
%
% Requirements:
% mrtrix matlab tools. You can get them from https://github.com/lconcha/mrtrix3/tree/master/matlab
% Do not forget to add them to your matlab path.
% e.g. addpath(genpath('/home/inb/soporte/lanirem_software/mrtrix_3.0.4/matlab'));
%
% LU15 (0N(H4
% INB-UNAM
% lconcha@unam.mx



txt = fileread(fjson);
json = jsondecode(txt);

imdim   = [456 528 320]; % from the file reference+permuted.nii.gz
voxsize = [25 25 25];    % um, from the file reference+permuted.nii.gz

nLines = length(json.lines);
fprintf(1,'Converting %s (%d lines) ... ',fjson,nLines);
for L = 1 : nLines
   s = json.lines{L};
   c = struct2cell(s);
   x = cell2mat(c(3,:));
   y = cell2mat(c(1,:));             % notice the permutation
   z = cell2mat(c(2,:));

   y = (imdim(2) .* voxsize(2)) - y; % notice the dimension flip
   z = (imdim(3) .* voxsize(3)) - z; % dimension flip.

   newtck.data{L} = [x' y' z'];
end

write_mrtrix_tracks (newtck, ftckout)
fprintf(1,'Done\n');

