import boto3, sys
from botocore.exceptions import ClientError

# http://jpiedra.github.io/article/never-update-security-group/

ec2 = boto3.client('ec2');
print ("I seme to be working");
groupID='sg-012e2f6051908f77b'

def loadAWSSecuriyGroup():
    
    try:
        response = ec2.describe_security_groups(GroupIds=[groupID]);
#        ipcidr = response['SecurityGroups'][0]['IpPermissions'][0]['IpRanges'][0]['CidrIp']
#        print ('Removing IP block %s' % (ipcidr));

        old_access = response['SecurityGroups'][0]['IpPermissions'][0]
        print(old_access)

        data = ec2.revoke_security_group_ingress(
        GroupId=groupID,
        IpPermissions=[
            old_access
        ])
        print(data);
    
#need to capture 'IndexError' when nothing is in the sucurity group
    except ClientError as e:
        print(e)


def addIPAddress():
    ext_ip = '11.11.11.1/32'
    try:
	    data = ec2.authorize_security_group_ingress(
        GroupId=groupID,
        IpPermissions=[
            {
                'IpProtocol': 'tcp',
                'FromPort': 3389,
                'ToPort': 3389,
                'IpRanges': [{'CidrIp': ext_ip}]
            }    
        ])
	    print(data)
    except ClientError as e:
        print(e)



def check_arguments(args):
    print('not used as this time')


def main(args):
	loadAWSSecuriyGroup()
	addIPAddress()
#    loader = ContainerLoader()
#    loader.main(sys.argv[1:])

if __name__ == '__main__':
    main(sys.argv[1:])