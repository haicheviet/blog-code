PROJECT_NAME=${PROJECT_NAME?Variable not set}
APP_ENV=${APP_ENV?Variable not set}

echo ">>>>>>>>>>>Bastion for $PROJECT_NAME - $APP_ENV<<<<<<<<<<<<"
sleep 1
aws cloudformation deploy \
    --template-file cloudformation/vpc-ssh-bastion.yml \
    --stack-name ssh-bastion-$APP_ENV-$PROJECT_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides ParentVPCStack=vpc-$APP_ENV-$PROJECT_NAME \
        KeyPairName=hai-key \
        EnableTCPForwarding=true \
    --tags $PROJECT_NAME-$APP_ENV--cluster=$APP_ENV-ssh-bastion
