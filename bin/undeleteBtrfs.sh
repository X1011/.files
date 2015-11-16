#!/bin/bash

# undeleteBtrfs.sh
# Copyright (C) 2014 Andreas Oelkers <info@oelkers.de>
# This program is free software; you can redistribute it and/or modify it under
# the term of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or any later version.

tmpDir=/tmp
exec 2> ${tmpDir}/${0##*/}.err
set -x

execBtrfsFindRoot=btrfs-find-root
execBtrfsRestore="btrfs restore"


if [ $# -lt 2 ]
then
	cat <<-EOF

		usage: $0 btrf_device_name file_name_pattern [ recovery_directory ]

		$0 will restore deleted files from an unmounted btrfs partition.
		Make sure it is unmounted. Otherwise you could get the wrong version.
		It will get the most recent version of a deleted file.
		It is depending on the tools btrfs-find-root and btrfs. Both should be already on
		your system if you are using btrfs partitions. If they are not or not in your default
		PATH variable set the variables execBtrfsFindRoot and execBtrfsRestore in this
		script.
		An error log will be stored at: ${tmpDir}/${0##*/}.err

		Parameters:
	 	btrf_device_name     block device name with a btrfs filesystem on it
	 			     If the partition is encrypted the decrypted block device.
	 			     example: /dev/mapper/luks-sda
	
	 	file_name_patern     relative from the partition root 
	 			     Wild card * and ? are allowed and work recursivly.
	 			     example: /daten/3D/myProjects/*

	  	recovery_directory   where the recovered files are stored
	 			     You need write permission to create it oder write to it.
	 			     It will be cleand before the recovery is started.
	 			     Make sure nothing important is in there.

	EOF
	exit 255
fi

eval btrfsPartition=$(blkid $1| tr : " ")
if [ "${TYPE}" != btrfs ]
then
	echo -e "\nERROR: no btrfs partion found on ${1}\n"
	exit 1
fi


eval recoverdDir=${3:-${tmpDir}/recoverd-${btrfsPartition##*/}}
if ! [ -d ${recoverdDir} -a -w ${recoverdDir} ]
then
	if ! mkdir ${recoverdDir}
	then
		echo -e "\nERROR: can not create recovery directory: ${recoverdDir}\n"
		exit 2 
	fi
fi
rm -rf ${recoverdDir}/*

# convert pattern to regular expression
regExp="${2//\//(|\/}"
openBrackets=${regExp//[^(]}
regExp="${regExp//\*/.*}"
regExp="${regExp//\?/.}"
regExp="${regExp}(|/.*)${openBrackets//(/)}"
regExp="^/${regExp/(|\//\(|}\$"


rootBlocks=($(${execBtrfsFindRoot} ${btrfsPartition} 2>&1| sed '/^Well/!d; s/Well block \(.*\) seems.*/\1/' | sort -run ))

for rootBlock in ${rootBlocks[@]}
do
	echo --------- recovering from rootBlock: ${rootBlock} --------- 
        ${execBtrfsRestore} -v -i -t ${rootBlock} --path-regex "$regExp" "${btrfsPartition}" $recoverdDir  2> /dev/null | grep ^Restoring
done

cat <<-EOF

the following root blocks where used for recovery: 
${rootBlocks[@]}

only the newest available version where saved to $recoverdDir. Older versions are skipped.

EOF
