EXTERNAL_IPS=$(aws ec2 describe-instances --filters "Name=tag:Monitoring,Values=true" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)

# echo $EXTERNAL_IPS

for ins_id in $EXTERNAL_IPS; do 
    scp -i ~/.ssh/id_rsa -r node-exporter ec2-user@$ins_id:~/
done
