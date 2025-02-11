# For Testing
```
git clone https://github.com/profuzzbench/profuzzbench.git
cd profuzzbench
export PFBENCH=$(pwd)
export PATH=$PATH:$PFBENCH/scripts/execution:$PFBENCH/scripts/analysis

profuzzbench_build_all.sh
NUM_CONTAINERS=1 profuzzbench_exec_all.sh "TARGET" "FUZZER" 60[Fuzzing TIMEOUT(s)]
```
# After Testing
```bash
cd $PFBENCH/results-lightftp

profuzzbench_generate_csv.sh lightftp 4 aflnet results.csv 0
profuzzbench_generate_csv.sh lightftp 4 aflnwe results.csv 1

cd $PFBENCH/results-lightftp

profuzzbench_plot.py -i results.csv -p lightftp -r 4 -c 60 -s 1 -o cov_over_time.png
```
