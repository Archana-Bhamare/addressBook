#!/bin/bash
name(){
	patName="^[A-Z]{1}[a-z]{3,}$"
	patMob="^[91]{2}[ ]?[0-9]{10}$"
	patMail="^[a-zA-Z0-9]+([.+-_][a-z-A-Z0-9]+)*@[a-zA-Z0-9]+.[a-z]{2,3}([.][a-z]{2})*$"
 	patZip="^[0-9]{3}[ ]?[0-9]{3}$"
	read -p "Enter First Name : " fname
	echo $fname | grep -P -q $patName
	if [ $? -eq 0 ]
	then
		echo "Valid Name"
	else
		echo "Please enter the name in proper format"
		read -p "Enter First Name : " fname	
	fi
	read -p "Enter Last Name : " lname
	echo $lname | grep -P -q $patName
	if [ $? -eq 0 ]
	then
		echo "Valid Name"
	else
		echo "Please enter the name in proper format"
		read -p "Enter Last Name : " lname	
	fi
	read -p "Enter Mobile Number : " mnum
	if [[ $mnum =~ $patMob ]]
	then
		echo "Valid Mobile Number"
	else
		echo "Please enter the valid mobile number"
		read -p "Enter Mobile Number : " mnum
	fi
	read -p "Enter Email : " email
	echo $email | grep -P -q $patMail
	if [ $? -eq 0 ]
	then
		echo "Valid Email"
	else
		echo "Please enter valid email id"
		read -p "Enter Email : " email	
	fi
	read -p "Enter City Name : " city
	echo $city | grep -P -q $patName
	if [ $? -eq 0 ]
	then
		echo "Valid City"
	else
		echo "Please enter the city name in proper format"	
		read -p "Enter City Name : " city
	fi
	read -p "Enter State Name : " state
	echo $state | grep -P -q $patName
	if [ $? -eq 0 ]
	then
		echo "Valid State"
	else
		echo "Please enter the state name in proper format"
		read -p "Enter State Name : " state	
	fi
	read -p "Enter Zip code : " zip
	if [[ $zip =~ $patZip ]]
	then
		echo "Valid Zipcode"
	else
		echo "Please enter valid Zip code"
		read -p "Enter Zip code : " zip	
	fi
}
name
