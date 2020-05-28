import boto3, sys
from botocore.exceptions import ClientError

ec2 = boto3.client('ec2');
print ("I seme to be working");


def loadAWSSecuriyGroup():
    try:
        response = ec2.describe_security_groups(GroupIds=['sg-012e2f6051908f77b']);
        ipcidr = response['SecurityGroups'][0]['IpPermissions'][0]['IpRanges'][0]['CidrIp']
        print (ipcidr);
    except ClientError as e:
        print(e)






def check_arguments(args):
    print('not used as this time')


def main(args):
	loadAWSSecuriyGroup()
#    loader = ContainerLoader()
#    loader.main(sys.argv[1:])

if __name__ == '__main__':
    main(sys.argv[1:])