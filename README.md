# cartelera
autonomous security group management based on a users IP address


list security groups by tags
```
aws ec2 describe-security-groups --filters Name=tag:Name,Values=xxxxxx --query "SecurityGroups[*].{Name:GroupName,ID:GroupId}"
and
aws ec2 describe-security-groups --group-name xxxxxx --query "SecurityGroups[*].{Name:GroupName,ID:GroupId}" --output text

aws ec2 describe-security-groups --group-id sg-101010101010101 --query "SecurityGroups[*].IpPermissions[*].IpRanges[*].{Name:CidrIp}" --output text
```

Adding a rule to a security group
```
aws ec2 authorize-security-group-ingress --group-id sg-101010101010101 --protocol tcp --port 1627  --cidr 10.10.10.1/32
```


removing a rule to a security group
```
aws ec2 revoke-security-group-ingress --group-id sg-101010101010101 --protocol tcp --port 10001 --cidr 10.10.10.1/32
```


 





