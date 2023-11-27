from functions import read_H_file, Mat_it_k

NUM_ITER = 4
NUM_KPTS = 36
path_ipa = '../../floquet_matrices_yambo2python/1data/1-Print_out_Hamiltonian-IPA-hd/'
lof_dirs = [
           'out_job20231125-20.18.06_eVec_after_1it/',
           'out_job20231125-20.18.13_eVec_after_2it/',
           'out_job20231125-20.18.19_eVec_after_3it/',
           'out_job20231125-20.18.25_eVec_after_4it/',
           ] # lof is short for list_of

# <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

list_of_matrices = []

lof_iter = [i+1 for i in range(NUM_ITER)]
lof_kpts = [i+1 for i in range(NUM_KPTS)]

for _it,_file in zip(lof_iter,lof_dirs):
  for _kpt in lof_kpts:
    _fullpath = path_ipa+_file+f'FL_Hamiltonian_kpt{_kpt}.dat'
    _matrix = read_H_file(_fullpath)
    mat_it_k = Mat_it_k(_matrix, _it, _kpt, _fullpath)
    list_of_matrices.append(mat_it_k)



