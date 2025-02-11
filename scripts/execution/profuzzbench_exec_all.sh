#!/bin/bash

export NUM_CONTAINERS="${NUM_CONTAINERS:-4}"
#export TIMEOUT="${TIMEOUT:-3600}"
export SKIPCOUNT="${SKIPCOUNT:-1}"
export TEST_TIMEOUT="${TEST_TIMEOUT:-5000}"

export TARGET_LIST=$1
export FUZZER_LIST=$2
export TIMEOUT=$3

if [[ "x$TARGET_LIST" == "x" ]] || [[ "x$FUZZER_LIST" == "x" ]]
then
    echo "Usage: $0 TARGET FUZZER TIMEOUT(s)"
    exit 1
fi

echo
echo "# NUM_CONTAINERS: ${NUM_CONTAINERS}"
echo "# TIMEOUT: ${TIMEOUT} s"
echo "# SKIPCOUNT: ${SKIPCOUNT}"
echo "# TEST TIMEOUT: ${TEST_TIMEOUT}+ ms"
echo "# TARGET LIST: ${TARGET_LIST}"
echo "# FUZZER LIST: ${FUZZER_LIST}"
echo

for FUZZER in $(echo $FUZZER_LIST | sed "s/,/ /g")
do

    for TARGET in $(echo $TARGET_LIST | sed "s/,/ /g")
    do

        echo
        echo "***** RUNNING $FUZZER ON $TARGET *****"
        echo

##### FTP #####

        if [[ $TARGET == "lightftp" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-lightftp

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh lightftp $NUM_CONTAINERS results-lightftp aflnet out-lightftp-aflnet "-P FTP -D 10000 -q 3 -s 3 -E -K -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh lightftp-nsfuzz $NUM_CONTAINERS results-lightftp aflnet out-lightftp-nsfuzz "-P FTP -D 10000 -q 3 -s 3 -E -K -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh lightftp-nsfuzz-v $NUM_CONTAINERS results-lightftp aflnet out-lightftp-nsfuzz-v "-P FTP -D 10000 -q 3 -s 3 -E -K -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi     

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh lightftp-stateafl $NUM_CONTAINERS results-lightftp stateafl out-lightftp-stateafl "-P FTP -D 10000 -q 3 -s 3 -E -K -m none -u /home/ubuntu/experiments/LightFTP/Source/Release/fftp -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh lightftp $NUM_CONTAINERS results-lightftp aflnwe out-lightftp-aflnwe "-D 10000 -K -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi


        if [[ $TARGET == "bftpd" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-bftpd

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh bftpd $NUM_CONTAINERS results-bftpd aflnet out-bftpd-aflnet "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh bftpd-nsfuzz $NUM_CONTAINERS results-bftpd aflnet out-bftpd-nsfuzz "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -w 1000 -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh bftpd-nsfuzz-v $NUM_CONTAINERS results-bftpd aflnet out-bftpd-nsfuzz-v "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh bftpd-stateafl $NUM_CONTAINERS results-bftpd stateafl out-bftpd-stateafl "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -u /home/ubuntu/experiments/bftpd/bftpd -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh bftpd $NUM_CONTAINERS results-bftpd aflnwe out-bftpd-aflnwe "-m none -D 10000 -K -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi


        if [[ $TARGET == "proftpd" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-proftpd

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh proftpd $NUM_CONTAINERS results-proftpd aflnet out-proftpd-aflnet "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi
            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh proftpd-nsfuzz $NUM_CONTAINERS results-proftpd aflnet out-proftpd-nsfuzz "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -w 10000 -R" $TIMEOUT $SKIPCOUNT &
            fi
            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh proftpd-nsfuzz-v $NUM_CONTAINERS results-proftpd aflnet out-proftpd-nsfuzz-v "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi
            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh proftpd-stateafl $NUM_CONTAINERS results-proftpd stateafl out-proftpd-stateafl "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -u /home/ubuntu/experiments/proftpd/proftpd -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh proftpd $NUM_CONTAINERS results-proftpd aflnwe out-proftpd-aflnwe "-m none -D 10000 -K -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi

        if [[ $TARGET == "pure-ftpd" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-pure-ftpd

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh pure-ftpd $NUM_CONTAINERS results-pure-ftpd aflnet out-pure-ftpd-aflnet "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi
            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh pure-ftpd-nsfuzz $NUM_CONTAINERS results-pure-ftpd aflnet out-pure-ftpd-nsfuzz "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -w 20000 -R" $TIMEOUT $SKIPCOUNT &
            fi
            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh pure-ftpd-nsfuzz-v $NUM_CONTAINERS results-pure-ftpd aflnet out-pure-ftpd-nsfuzz-v "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi
            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh pure-ftpd-stateafl $NUM_CONTAINERS results-pure-ftpd stateafl out-pure-ftpd-stateafl "-m none -P FTP -D 10000 -q 3 -s 3 -E -K -u /home/ubuntu/experiments/pure-ftpd/src/pure-ftpd -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
                fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh pure-ftpd $NUM_CONTAINERS results-pure-ftpd aflnwe out-pure-ftpd-aflnwe "-m none -D 10000 -K -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
                fi

        fi


##### SMTP #####

        if [[ $TARGET == "exim" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-exim

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh exim $NUM_CONTAINERS results-exim aflnet out-exim-aflnet "-P SMTP -D 10000 -q 3 -s 3 -E -K -W 100 -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh exim-nsfuzz $NUM_CONTAINERS results-exim aflnet out-exim-nsfuzz "-P SMTP -D 10000 -q 3 -s 3 -E -K -m none -t ${TEST_TIMEOUT}+ -w 50000 -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh exim-nsfuzz-v $NUM_CONTAINERS results-exim aflnet out-exim-nsfuzz-v "-P SMTP -D 10000 -q 3 -s 3 -E -K -W 100 -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh exim-stateafl $NUM_CONTAINERS results-exim stateafl out-exim-stateafl "-P SMTP -D 10000 -q 3 -s 3 -E -K -W 100 -m none -u /home/ubuntu/experiments/exim/src/build-Linux-x86_64/exim -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh exim $NUM_CONTAINERS results-exim aflnwe out-exim-aflnwe "-D 10000 -K -W 100 -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi



##### DNS #####

        if [[ $TARGET == "dnsmasq" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-dnsmasq

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh dnsmasq $NUM_CONTAINERS results-dnsmasq aflnet out-dnsmasq-aflnet "-P DNS -D 10000 -K -R -q 3 -s 3 -E -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi


            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh dnsmasq-nsfuzz $NUM_CONTAINERS results-dnsmasq aflnet out-dnsmasq-nsfuzz "-P DNS -D 10000 -K -R -q 3 -s 3 -E -m none -t ${TEST_TIMEOUT}+ -w 5000" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh dnsmasq-nsfuzz-v $NUM_CONTAINERS results-dnsmasq aflnet out-dnsmasq-nsfuzz-v "-P DNS -D 10000 -K -R -q 3 -s 3 -E -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh dnsmasq-stateafl $NUM_CONTAINERS results-dnsmasq stateafl out-dnsmasq-stateafl "-P DNS -D 10000 -K -R -q 3 -s 3 -E -m none -u /home/ubuntu/experiments/dnsmasq/src/dnsmasq -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh dnsmasq $NUM_CONTAINERS results-dnsmasq aflnwe out-dnsmasq-aflnwe "-D 10000 -K -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi


##### RTSP #####

        if [[ $TARGET == "live555" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-live555

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh live555 $NUM_CONTAINERS results-live555 aflnet out-live555-aflnet "-P RTSP -D 10000 -q 3 -s 3 -E -K -R -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh live555-nsfuzz $NUM_CONTAINERS results-live555 aflnet out-live555-nsfuzz "-P RTSP -q 3 -s 3 -E -K -R -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh live555-nsfuzz-v $NUM_CONTAINERS results-live555 aflnet out-live555-nsfuzz-v "-P RTSP -D 10000 -q 3 -s 3 -E -K -R -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh live555-stateafl $NUM_CONTAINERS results-live555 stateafl out-live555-stateafl "-P RTSP -D 10000 -q 3 -s 3 -E -K -R -m none -u /home/ubuntu/experiments/live555/testProgs/testOnDemandRTSPServer -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh live555 $NUM_CONTAINERS results-live555 aflnwe out-live555-aflnwe "-D 10000 -K -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi


##### SIP #####

        if [[ $TARGET == "kamailio" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-kamailio

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh kamailio $NUM_CONTAINERS results-kamailio aflnet out-kamailio-aflnet "-m none -P SIP -l 5061 -D 50000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh kamailio-nsfuzz $NUM_CONTAINERS results-kamailio aflnet out-kamailio-nsfuzz "-m none -P SIP -l 5061 -D 50000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -w 10000 -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh kamailio-nsfuzz-v $NUM_CONTAINERS results-kamailio aflnet out-kamailio-nsfuzz-v "-m none -P SIP -l 5061 -D 50000 -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh kamailio-stateafl $NUM_CONTAINERS results-kamailio stateafl out-kamailio-stateafl "-m none -P SIP -l 5061 -D 50000 -q 3 -s 3 -E -K -u /home/ubuntu/experiments/kamailio/src/kamailio -U /home/ubuntu/experiments/kamailio/ -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh kamailio $NUM_CONTAINERS results-kamailio aflnwe out-kamailio-aflnwe "-m none -D 50000 -K -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi


##### SSH #####

        if [[ $TARGET == "openssh" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-openssh

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh openssh $NUM_CONTAINERS results-openssh aflnet out-openssh-aflnet "-P SSH -D 10000 -q 3 -s 3 -E -K -W 10 -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh openssh-nsfuzz $NUM_CONTAINERS results-openssh aflnet out-openssh-nsfuzz "-P SSH -D 10000 -q 3 -s 3 -E -K -m none -t ${TEST_TIMEOUT}+ -w 50000 -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh openssh-nsfuzz-v $NUM_CONTAINERS results-openssh aflnet out-openssh-nsfuzz-v "-P SSH -D 10000 -q 3 -s 3 -E -K -W 10 -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh openssh-stateafl $NUM_CONTAINERS results-openssh stateafl out-openssh-stateafl "-P SSH -D 10000 -q 3 -s 3 -E -K -W 10 -l 30000 -e 20000 -m none -u /home/ubuntu/experiments/openssh/sshd -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh openssh $NUM_CONTAINERS results-openssh aflnwe out-openssh-aflnwe "-D 10000 -K -W 10 -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi


##### TLS #####

        if [[ $TARGET == "openssl" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-openssl

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh openssl $NUM_CONTAINERS results-openssl aflnet out-openssl-aflnet "-P TLS -D 10000 -q 3 -s 3 -E -K -R -W 100 -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh openssl-nsfuzz $NUM_CONTAINERS results-openssl aflnet out-openssl-nsfuzz "-P TLS -D 10000 -q 3 -s 3 -E -K -R -m none -t ${TEST_TIMEOUT}+ -w 10000" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh openssl-nsfuzz-v $NUM_CONTAINERS results-openssl aflnet out-openssl-nsfuzz-v "-P TLS -D 10000 -q 3 -s 3 -E -K -R -W 100 -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh openssl-stateafl $NUM_CONTAINERS results-openssl stateafl out-openssl-stateafl "-P TLS -D 10000 -q 3 -s 3 -E -K -R -W 100 -m none -u /home/ubuntu/experiments/openssl/apps/openssl -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh openssl $NUM_CONTAINERS results-openssl aflnwe out-openssl-aflnwe "-D 10000 -K -W 100 -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi


##### DTLS #####

        if [[ $TARGET == "tinydtls" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-tinydtls

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh tinydtls $NUM_CONTAINERS results-tinydtls aflnet out-tinydtls-aflnet "-P DTLS12 -D 10000 -q 3 -s 3 -E -K -W 30 -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh tinydtls-nsfuzz $NUM_CONTAINERS results-tinydtls aflnet out-tinydtls-nsfuzz "-P DTLS12 -D 10000 -q 3 -s 3 -E -K -m none -t ${TEST_TIMEOUT}+ -w 1000 -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh tinydtls-nsfuzz-v $NUM_CONTAINERS results-tinydtls aflnet out-tinydtls-nsfuzz-v "-P DTLS12 -D 10000 -q 3 -s 3 -E -K -W 30 -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh tinydtls-stateafl $NUM_CONTAINERS results-tinydtls stateafl out-tinydtls-stateafl "-P DTLS12 -D 10000 -q 3 -s 3 -E -K -W 30 -m none -u /home/ubuntu/experiments/tinydtls/tests/dtls-server -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh tinydtls $NUM_CONTAINERS results-tinydtls aflnwe out-tinydtls-aflnwe "-D 10000 -K -W 30 -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi

##### DICOM #####

        if [[ $TARGET == "dcmtk" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-dcmtk

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh dcmtk $NUM_CONTAINERS results-dcmtk aflnet out-dcmtk-aflnet "-P DICOM -D 10000 -E -K -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh dcmtk-nsfuzz $NUM_CONTAINERS results-dcmtk aflnet out-dcmtk-nsfuzz "-P DICOM -D 10000 -E -K -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh dcmtk-nsfuzz-v $NUM_CONTAINERS results-dcmtk aflnet out-dcmtk-nsfuzz-v "-P DICOM -D 10000 -E -K -m none -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh dcmtk-stateafl $NUM_CONTAINERS results-dcmtk stateafl out-dcmtk-stateafl "-P DICOM -D 10000 -E -K -m none -u /home/ubuntu/experiments/dcmtk/build/bin/dcmqrscp -t ${TEST_TIMEOUT}+ -R" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh dcmtk $NUM_CONTAINERS results-dcmtk aflnwe out-dcmtk-aflnwe "-D 10000 -K -m none -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi


##### DAAPD #####

        if [[ $TARGET == "forked-daapd" ]] || [[ $TARGET == "all" ]]
        then

            cd $PFBENCH
            mkdir -p results-forked-daapd

            if [[ $FUZZER == "aflnet" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh forked-daapd $NUM_CONTAINERS results-forked-daapd aflnet out-forked-daapd-aflnet "-P HTTP -D 200000 -m none -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh forked-daapd-nsfuzz $NUM_CONTAINERS results-forked-daapd aflnet out-forked-daapd-nsfuzz "-P HTTP -m none -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "nsfuzz-v" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh forked-daapd-nsfuzz-v $NUM_CONTAINERS results-forked-daapd aflnet out-forked-daapd-nsfuzz-v "-P HTTP -D 200000 -m none -q 3 -s 3 -E -K -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "stateafl" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh forked-daapd-stateafl $NUM_CONTAINERS results-forked-daapd stateafl out-forked-daapd-stateafl "-P HTTP -D 200000 -m none -q 3 -s 3 -E -K -u /home/ubuntu/experiments/forked-daapd/src/forked-daapd -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

            if [[ $FUZZER == "aflnwe" ]] || [[ $FUZZER == "all" ]]
            then
                sleep 1
                profuzzbench_exec_common.sh forked-daapd $NUM_CONTAINERS results-forked-daapd aflnwe out-forked-daapd-aflnwe "-D 200000 -m none -K -t ${TEST_TIMEOUT}+" $TIMEOUT $SKIPCOUNT &
            fi

        fi

        if [[ $TARGET == "all" ]]
        then
            # Quit loop -- all fuzzers and targets have already been executed
            exit
        fi

    done
done