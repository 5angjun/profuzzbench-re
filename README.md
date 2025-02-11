# For Testing
```
pip3 install pandas==1.2.5
pip3 install matplotlib

git clone https://github.com/profuzzbench/profuzzbench.git
cd profuzzbench
export PFBENCH=$(pwd)
export PATH=$PATH:$PFBENCH/scripts/execution:$PFBENCH/scripts/analysis



profuzzbench_build_all.sh



echo core > /proc/sys/kernel/core_pattern
echo 0 | tee /proc/sys/kernel/randomize_va_space


NUM_CONTAINERS=1 profuzzbench_exec_all.sh "TARGET" "FUZZER" [Fuzzing TIMEOUT(s)]

ex)
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "lightftp" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "bftpd" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "proftpd" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "pure-ftpd" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "exim" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "dnsmasq" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "live555" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "kamailio" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "openssh" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "openssl" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "tinydtls" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "dcmtk" "all" 60
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "forked-daapd" "all" 60
```
# After Testing
```bash
cd $PFBENCH/results-lightftp

profuzzbench_generate_csv.sh lightftp 1 aflnet results.csv 0
profuzzbench_generate_csv.sh lightftp 1 aflnwe results.csv 1

cd $PFBENCH/results-lightftp

profuzzbench_plot.py -i results.csv -p lightftp -r 1 -c 60 -s 1 -o cov_over_time.png
```
