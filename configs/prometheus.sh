EXTERNAL_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=prom-ec2" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)

echo $EXTERNAL_IP

scp -i ~/.ssh/id_rsa -r * ec2-user@$EXTERNAL_IP:~/
scp -i ~/.ssh/id_rsa -r $(pwd)/../service-discovery ec2-user@$EXTERNAL_IP:~/