addpath(genpath('/home/inb/soporte/lanirem_software/mrtrix_3.0.4/matlab'));

f_json = 'streamlines_180720175.json';
f_tck  = 'test.tck'

template = 'reference_permuted.nii.gz';

json2tck(f_json,f_tck);

fprintf(1,'View this with the command:\n');
fprintf(1,'mrview %s -tractography.load %s\n',template,f_tck);