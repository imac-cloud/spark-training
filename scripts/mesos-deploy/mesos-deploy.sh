#!/bin/bash
# Program:
#       This program is install mesos.
# History:
# 2015/12/21 Kyle.b Release
# 
source common.sh
source install-packages.sh


function master-install {
	array=("$@")
	arraylength=${#array[@]}
	for (( i=2; i<${arraylength}+1; i++ ));
	do
   		echo "[ ---------------- Processing ${array[$i-1]} ---------------- ]"
   		install_jdk ${array[$i-1]}
   		install_mesos "master" ${array[$i-1]}
	done
}

function slave-install {
	array=("$@")
	arraylength=${#array[@]}
	MASTER_INDEX=$(index "--masters" ${array[@]})

	if [ -z $MASTER_INDEX ]; then
		msg "${SLAVE_INFO}" "Usage"
		exit 1
	fi

	if [ -z "${array[$MASTER_INDEX]}" ]; then
		msg "${SLAVE_INFO}" "Usage"
		exit 1
	fi

	# Get all slave node
	for (( i=2; i<${MASTER_INDEX}; i++ ));
	do
   		msg "Install ${array[$i-1]} ..."
	done

	# Get all master node
	for (( i=MASTER_INDEX+1; i<${arraylength}+1; i++ ));
	do
   		msg "Configure to ${array[$i-1]} ..."
	done
}

if [ "$1" == "master-install" ]; then
	if [ -z "$2" ]; then
		msg "${MASTER_INFO}" "master-install Usage"
	else
		master-install $@
	fi
elif [[ "$1" == "slave-install" ]]; then
	if [ -z "$2" ]; then
		msg "${SLAVE_INFO}" "slave-install Usage"
	else
		slave-install $@
	fi
else
	msg "${MASTER_INFO} ${SLAVE_INFO}" "Usage"
fi


