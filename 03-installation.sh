#!/bin/bash

USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
       echo "please run this user with root privillages"
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
       echo -e "$2 is ... $R FAILURE $N"
       exit 1
    else
       echo -e "$2 is ... $G SUCCESS $N"
    fi   
}

CHECK_ROOT

dnf list installed git

if [ $? -ne 0 ]
then
   echo "git is not installed...going to install it"
   dnf install git -y
   VALIDATE $? "installing git"
else
   echo -e "$Y git is already installed $N ...nothing to do"

fi

dnf list installed mysql

if [ $? -ne 0 ]
then
   echo -e "$Y Mysql is not installed $N ....going to install it"
   dnf install mysql -y
   VALIDATE $? "installing Mysql"   
else 
   echo "Mysql is Already installed....Nothing to do"

fi
