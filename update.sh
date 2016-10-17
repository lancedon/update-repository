#!/bin/bash -l

#get the actual branch
cd /var/www/html/blog/
git branch > /tmp/tmp.file
Branch=`grep '*' /tmp/tmp.file | awk -F"*" '{print $2}'`  

#get the branch in S3
S3_Branch=`/home/ec2-user/update_repo/s3-curl/s3curl.pl --id=s3_bash_scripts -- http://project_name.s3.amazonaws.com/branch_git`

#if the Branch was changed, update it
if [ $Branch !=  $S3_Branch ] ; then

	#update the git
	/home/ec2-user/update_repo/update_repo.sh
 	git checkout $S3_Branch	

	#log the Branch change
	DATE=`date +%Y-%m-%d:%H:%M:%S`	
	echo "(Branch Change) From $Branch to $S3_Branch on $DATE" >> /home/ec2-user/update_repo/log/log.txt

fi


