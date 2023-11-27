#!/bin/bash
#SBATCH --job-name=".test_floquet"
#SBATCH --output=_out_%j
#SBATCH --error=_err_%j
#SBATCH --partition=main
#SBATCH --ntasks=1
#SBATCH --time=12:00:00

for iter in `seq 1 1 19`; do

bins="/s/martin/SOFTWARE/5YAMBO_DEVEL_FLOQUET/yambo-devel-merged-floquet/bin/"
datetag=`date +%Y%m%d-%H.%M.%S`
input_file=i2-fl-shg-$datetag

$bins/yambo_fl -f -I ../../../ -F $input_file -V fl
sed -i 's/1 | 20 |/4 | 5 |/' $input_file
sed -i 's/-1.000000 |-1.000000 |/ 9.823600 | 9.823600 |/' $input_file  
sed -i 's/NLEnSteps= 1/NLEnSteps= 1/' $input_file
sed -i 's/NLDamping= 0.200000/NLDamping= 0.150000/' $input_file 
sed -i 's/ 0.000000 | 0.000000 / 1.000000 | 1.000000 /' $input_file
sed -i 's/NLCorrelation= "IPA"/NLCorrelation= "HARTREE"/' $input_file
#sed -i 's/Xorder= 2/Xorder= 4/' $input_file
sed -i 's/HARRLvcs=.*.#/HARRLvcs= 2  Ha  #/' $input_file
sed -i "s/FL_max_it=.*.#/FL_max_it= $iter  #/" $input_file
sed -i 's/FL_beta=.*.#/FL_beta= 1.0  #/' $input_file
sed -i 's/Xthresh_1=.*.#/Xthresh_1= 0.01  #/' $input_file
#sed -i 's/FL_deg_thresh=.*.#/FL_deg_thresh= 0.100000E-4       #/' $input_file
#sed -i 's/FL_deg_lift=.*.#/FL_deg_lift= 0.100000E-1         #/' $input_file
cat <<EOT >> $input_file
% GfnQP_E
 3.300000 | 1.000000 | 1.000000 |        # [EXTQP G] E parameters  (c/v) eV|adim|adim
%
EOT
echo 'DensityPrecondition' >> $input_file
sed -i "s/FL_2D_ild=.*.#/FL_2D_ild= 0.1   #/g" $input_file

input_file=i_floptics
mv i2-fl-shg-$datetag $input_file

mpirun -np $SLURM_NTASKS $bins/yambo_fl -F $input_file -J job$datetag -C out_job$datetag -I ../../../

sleep 3
mv FL_* out_job$datetag
mv out_job$datetag out_job$datetag\_eVec_after_$iter\it
rm -r job$datetag
done
