#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

USERID=$(id -u)
CHECK_ROOT(){
if [ $USERID -ne 0 ]
then
    echo "please run the user with root privilleges"
    exit 1
fi
}

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
if [ $1 -ne 0 ]
then
    echo -e "$2 is..$R FAILURE $N" | tee -a $LOG_FILE
    exit 1
else
    echo -e "$2 is..$G SUCCESS $N | tee -a $LOG_FILE    
fi
}

CHECK_ROOT

for $package in $@
do
    dnf list installed $package -y &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
       echo -e "$package is $R not installed..going to install it $N" | tee -a $LOG_FILE
       dnf install $package -y &>>$LOG_FILE
       VALIDATE $? "installing $package"
    else
       echo -e "$package is $G already installed..Nothing to do $N" | tee -a $LOG_FILE
    fi
done