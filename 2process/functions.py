import numpy as np
from collections import namedtuple

def read_H_file(file_H):
  with open(file_H,'r') as f:
    _a=f.read()
    _b=_a.split('\n')
    _b.remove('')
    _rows = []
    for _c in _b: # _c is a row
      _d = _c.split(')') # _d is a row as list
      _d.pop(-1)
      _row = []
      for _e in _d:
        _re,_im = _e.lstrip().lstrip('(').split(',')
        _c = float(_re) + 1j * float(_im)
        _row.append(_c)
      _rows.append(_row)
    Mat = np.zeros((len(_rows),len(_row)),dtype=complex)
    for i,_row in enumerate(_rows):
      Mat[i,:] = np.array(_row,dtype=complex)
  return Mat

Mat_it_k = namedtuple('Mat_it_k', ['matrix', 'iteration', 'kpt', 'file'])



if __name__ == "__main__":
  file = '../../floquet_matrices_yambo2python/1data/1-Print_out_Hamiltonian-IPA-hd/out_job20231125-20.18.25_eVec_after_4it/FL_Hamiltonian_kpt27.dat'
  matrix = read_H_file(file)
  print(matrix.shape)
  print(matrix)
