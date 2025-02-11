#!/bin/bash
set -e
DOCIMAGE=$1   # name of the docker image
RUNS=$2       # number of runs
SAVETO=$3     # path to folder keeping the results

FUZZER=$4     # fuzzer name (e.g., aflnet)
OUTDIR=$5     # name of the output folder created inside the docker container
OPTIONS=$6    # all configured options for fuzzing
TIMEOUT=$7    # time for fuzzing
SKIPCOUNT=$8  # used for calculating coverage over time

WORKDIR="/home/ubuntu/experiments"

# Get total number of CPUs
NUM_CPUS=$(nproc)  

# Function to dynamically find an available CPU in real time
get_unused_cpu() {
  # Get list of CPUs currently used by running containers
  USED_CPUS=($(docker ps -q | xargs -r -I{} docker inspect --format '{{.HostConfig.CpusetCpus}}' {} | tr ',' ' ' | tr '\n' ' ' | sed 's/  */ /g'))

  # Find the first unused CPU
  for cpu in $(seq 0 $((NUM_CPUS - 1))); do
    if [[ ! " ${USED_CPUS[*]} " =~ " ${cpu} " ]]; then
      printf "%s" "$cpu"  # Use printf to avoid newline issues
      return
    fi
  done

  # If all CPUs are in use, print an error and abort the script
  echo "Error: No available CPU cores left! Aborting." >&2
  exit 1
}


# Keep all container IDs
cids=()

# Create one container for each run
for i in $(seq 1 $RUNS); do
  CPU_CORE=$(get_unused_cpu)  # Get a real-time available CPU
  
  id=$(docker run --cpus=1 --cpuset-cpus="${CPU_CORE}" -v /proc:/host/proc:ro --privileged -d -it $DOCIMAGE /bin/bash -c "cd ${WORKDIR} && run ${FUZZER} ${OUTDIR} '${OPTIONS}' ${TIMEOUT} ${SKIPCOUNT}")
  cids+=(${id::12})  # Store only the first 12 characters of a container ID
  printf "\n${FUZZER^^}: Started container ${id::12} on CPU core ${CPU_CORE}"
done

dlist="" # Docker container list
for id in ${cids[@]}; do
  dlist+=" ${id}"
done

# Wait until all these dockers are stopped
printf "\n${FUZZER^^}: Fuzzing in progress ..."
printf "\n${FUZZER^^}: Waiting for the following containers to stop: ${dlist}"
docker wait ${dlist} > /dev/null
wait

# Collect the fuzzing results from the containers
printf "\n${FUZZER^^}: Collecting results and saving them to ${SAVETO}"
mkdir -p ${SAVETO}
index=1
for id in ${cids[@]}; do
  printf "\n${FUZZER^^}: Collecting results from container ${id}"
  docker cp ${id}:/home/ubuntu/experiments/${OUTDIR}.tar.gz ${SAVETO}/${OUTDIR}_${index}.tar.gz > /dev/null
  index=$((index+1))
done

printf "\n${FUZZER^^}: I am done!\n"