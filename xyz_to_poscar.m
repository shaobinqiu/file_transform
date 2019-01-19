function [ xyz_to_poscar ] = xyz_to_poscar(Lat, name_xyz,path_vasp)
s=strsplit(name_xyz,{'.','/'});
name_vasp=s{1,end-1};
xyzfile=import_xyz(name_xyz)
xyzfile.coordinates=sortrows(xyzfile.coordinates,1);
elements=unique(xyzfile.coordinates(:,1))';
atomaccounts=zeros(1,size(elements,2));
for ii=1:size(elements,2)
    for jj=1:size(xyzfile.coordinates,1)
        if xyzfile.coordinates(jj,1)==elements(1,ii)
            atomaccounts(1,ii)=atomaccounts(1,ii)+1;
        end
    end
end
coordinates=xyzfile.coordinates(:,2:4)/Lat;
%coordinates(:,3)=zeros(size(coordinates,1),1);
pos=coordinates+repmat( [0.5 0.5 0.5] , size(coordinates,1) , 1 )-repmat( sum(coordinates)/size(coordinates,1) , size(coordinates,1) , 1 );
n=[path_vasp, name_vasp,'.vasp'];
fid=fopen(n,'w+');
fprintf(fid,[name_vasp '\n']);
fprintf(fid,'%g\n',1);
fprintf(fid,'%-4.6f     %-4.6f     %-4.6f\n',Lat');
for kk=1:size(elements,2)
    fprintf(fid,'%s     ',char(elements(1,kk))); 
end
fprintf(fid, '\n');
for kk=1:size(elements,2)
     fprintf(fid,'%g     ',atomaccounts(1,kk)); 
end
fprintf(fid, '\n');
fprintf(fid,'Direct\n');
for vv=1:size(pos,1)
    fprintf(fid,'%-4.6f     %-4.6f     %-4.6f      \n',pos(vv,:)');
end
fclose(fid);
end