# cartelera
autonomous security group management based on a users IP address


```
aws ec2 describe-security-groups --filters Name=tag:Name,Values=xxxxxx --query "SecurityGroups[*].{Name:GroupName,ID:GroupId}"
```
