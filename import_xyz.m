function [ geometry ] = import_poscar( filename )
%IMPORT POSCAR Import a VASP POSCAR/CONTCAR file.
%   geometry = import_poscar(filename) imports the given VASP
%   POSCAR/CONTCAR file. The data is contained in a geometry structure with
%   the following fields:
%
%    filename: string containing name of the file.
%    comment: first line of file.
%    lattice: 3x3 matrix whose rows are the lattice vectors.
%    symbols: cell array containing chemical symbols.
%    atomcount: nx1 array containing the number of atoms of each type.
%    selective: boolean indicating whether selective dynamics is enabled.
%    coords: nx3 matrix containing ion positions in fractional coordinates.
%
%   See also EXPORT_POSCAR.

% to do: 
% test
% handle negative scale factors (cell volume)
  
  if ~isnumeric(filename)
      geometry.filename = filename;
      fid = fopen(filename);
      if fid==-1
        error(['File ' filename ' not found.']); 
      end
  else
      fid = filename;
      geometry.filename = fopen(fid);
  end
 
    geometry.atomnumber= fgetl(fid); % comment
    
    geometry.energy = fscanf(fid, '%*s %f',1); % scale energy
    
    geometry.coordinates = fscanf(fid, '%s %f %f %f ',[4,inf])'; % scale factor for coordinates
    
    fclose(fid);
end