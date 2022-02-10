echo "List of Running instances"
for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo $REGION && aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Type:InstanceType,Status:State.Name,VpcId:VpcId}" --filters Name=instance-state-name,Values=running --region $REGION; done

echo "Total number of Running Instances in all region"
aws ec2 describe-regions --query "Regions[].{Name:RegionName}" --output text |xargs -I {} aws ec2 describe-instances --query Reservations[*].Instances[*].[InstanceId] --filters Name=instance-state-name,Values=running --output text --region {} | wc -l

echo "list of stopped instances"
for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo $REGION && aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Type:InstanceType,Status:State.Name,VpcId:VpcId}" --filters Name=instance-state-name,Values=stopped --region $REGION; done

echo "Total number of Stopped Instances in all region"
aws ec2 describe-regions --query "Regions[].{Name:RegionName}" --output text |xargs -I {} aws ec2 describe-instances --query Reservations[*].Instances[*].[InstanceId] --filters Name=instance-state-name,Values=stopped --output text --region {} | wc -l

echo "List of IAM users"
aws iam list-users --output text | cut -f 6

echo "List of IAM Users with ID"
aws iam list-users

echo "List of IAM  access key and users  "

aws iam list-users -- output text

echo "Total number of IAM users and access _key"

aws iam list-users --output text | wc -l

echo "List of Groups names"
aws iam list-groups

echo "List of security group"

#aws ec2 describe-security-groups

echo "List all AMI"
aws ec2 describe-images --filter "Name=is-public,Values=false" \--query 'Images[].[ImageId, Name]' \--output text | sort -k2

echo "Total number of AMI"
aws ec2 describe-images --filter "Name=is-public,Values=false" \--query 'Images[].[ImageId, Name]' \--output text | sort -k2 | wc -l

echo "Lis of all EBS volume IN_USE"

for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo $REGION && aws ec2 describe-volumes --filter "Name=status,Values=in-use" --query 'Volumes[*].{VolumeID:VolumeId,Size:Size,Type:VolumeType,AvailabilityZone:AvailabilityZone}' --region $REGION; done

echo "List of all EBS volume available"

for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo $REGION && aws ec2 describe-volumes --filter "Name=status,Values=available" --query 'Volumes[*].{VolumeID:VolumeId,Size:Size,Type:VolumeType,AvailabilityZone:AvailabilityZone}' --region $REGION; done

echo "Total Number of EBS volumes available"
aws ec2 describe-regions --query "Regions[].{Name:RegionName}" --output text |xargs -I {} aws ec2 describe-volumes --query Reservations[*].Instances[*].[InstanceId] --filter "Name=status,Values=available" --query 'Volumes[*].{VolumeID:VolumeId,Size:Size,Type:VolumeType,AvailabilityZone:AvailabilityZone}' --region {} | wc -l

echo "Total Number of EBS volumes In-use "
aws ec2 describe-regions --query "Regions[].{Name:RegionName}" --output text |xargs -I {} aws ec2 describe-volumes --query Reservations[*].Instances[*].[InstanceId] --filter "Name=status,Values=in-use" --query 'Volumes[*].{VolumeID:VolumeId,Size:Size,Type:VolumeType,AvailabilityZone:AvailabilityZone}' --region {} | wc -l

#echo "List of ec2"

#for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo $REGION && aws ec2 describe-instances     --filters Name=tag-key,Values=Name     --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}'   --region $REGION; done

echo "Snap shot list"

aws ec2 describe-snapshots --owner-ids self  --query 'Snapshots[]'

#echo "List of Snapshots in all region"

#for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo "$REGION:"; for snap in $(aws ec2 describe-snapshots --owner self --output json --region $REGION --query 'Snapshots[*].SnapshotId' | jq -r '.[]'); do aws ec2 describe-snapshot-attribute --snapshot-id $snap --region $REGION --output text --attribute createVolumePermission --query '[SnapshotId,CreateVolumePermissions[?Group == `all`]]' | jq -r '.[]'; done; echo; done

echo "List of S3 buckets"
aws s3api list-buckets --query "Buckets[].Name"

echo "Count of S3 buckets"
aws s3api list-buckets --query "Buckets[].Name" --output json | wc -l


echo "List of Cloud Frount"
#An error occurred (AccessDenied) when calling the ListDistributions operation: User: arn:aws:iam::539355717448:user/Ashok.k is not authorized to perform: cloudfront:ListDistributions because no identity-based policy allows the cloudfront:ListDistributions action
#aws cloudfront list-distributions

echo "List of workspaces in Select region in aws configuration ap-southeast-1, eu-west-1"
aws workspaces describe-workspaces --output text 

echo "List of LIGHT SAIL"
aws lightsail get-bundles --region ap-south-1 --query 'bundles[].{price:price,cpuCount:cpuCount,ramSizeInGb:ramSizeInGb,diskSizeInGb:diskSizeInGb,bundleId:bundleId,instanceType:instanceType,supportedPlatforms:supportedPlatforms[0]}' --output text


echo "Total Number of Light sail"

aws lightsail get-bundles --region ap-south-1 --query 'bundles[].{price:price,cpuCount:cpuCount,ramSizeInGb:ramSizeInGb,diskSizeInGb:diskSizeInGb,bundleId:bundleId,instanceType:instanceType,supportedPlatforms:supportedPlatforms[0]}' --output text | wc -l

echo "Snap shot list"

aws ec2 describe-snapshots --owner-ids self  --query 'Snapshots[]'
