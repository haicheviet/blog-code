PROJECT_NAME=${PROJECT_NAME?Variable not set}
APP_ENV=${APP_ENV?Variable not set}
APP_IMAGE=${APP_IMAGE?Variable not set}

echo ">>>>>>>>>>> App for $PROJECT_NAME $APP_ENV<<<<<<<<<<<<"
aws cloudformation deploy \
    --template-file aws/task-definition/app-$APP_ENV.yml \
    --stack-name app-$APP_ENV-$PROJECT_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides ParentVPCStack=vpc-$APP_ENV-$PROJECT_NAME \
        AppEnvironment1Key=APP_ENV \
        ParentClusterStack=cluster-fargate-$APP_ENV-$PROJECT_NAME \
        ParentClientStack1=client-$APP_ENV-$PROJECT_NAME \
        AppEnvironment1Value=$APP_ENV \
        AppImage=$APP_IMAGE \
        Cpu=0.25 \
        Memory=0.5 \
        DesiredCount=3 \
    --tags $PROJECT_NAME-$APP_ENV-cluster=service-$APP_IMAGE