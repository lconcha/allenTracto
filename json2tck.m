function json2tck(fjson,ftckout)

txt = fileread(fjson);
json = jsondecode(txt);

nLines = length(json.lines);
fprintf(1,'Converting %s (%d lines) ... ',fjson,nLines);
for L = 1 : nLines
   s = json.lines{L};
   c = struct2cell(s);
   x = cell2mat(c(1,:));
   y = cell2mat(c(2,:));
   z = cell2mat(c(3,:));
   newtck.data{L} = [x' y' z'];
end

write_mrtrix_tracks (newtck, ftckout)
fprintf(1,'Done\n');
