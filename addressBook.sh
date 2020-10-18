#!/bin/bash
function name(){
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
		len=`cat addressbook1.csv | grep $email | wc -w`
		if [ $len -gt 0 ]
		then
			echo "Error : Email already exist!!!"
		fi
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
function createAddBook()
{
	read -p "Enter address book name : " ab
	res=`ls | grep $ab | wc -w`
	if [ $res -gt 0 ]
	then
		echo "Error : File is already exist!!!"
	else
		touch $ab
		echo "Address Book created..."
	fi
}
function displayAddressBook()
{
	echo "Enter address book name : "
	read ab
	res=`ls | grep $ab | wc -w`
	if [ $res -gt 0 ]
	then
		echo ""
		cat $ab
	else
		echo "Error : File is not exist!!!"
	fi
}
function insert()
{
	while true
	do
	name
	record=`echo $fname $lname $mnum $email $city $state $zip`
	echo $record >> addressbook1.csv
	echo ""
	echo "Record Inserted..."
	read -p "1) Add 2) Exit " var
	if [ $var == 1 ]
	then
		continue
	else
		break
	fi
	done
}
function edit()
{
	echo "Enter email"
	read email
	len=`cat addressbook1.csv | grep $email | wc -w`
	if [ $len -gt 0 ]
	then
		name
		newRecord=`echo $fname $lname $mnum $email $city $state $zip`
		oldRecord=`cat addressbook1.csv | grep $email`
		echo ""
		echo "New Record : $newRecord"
		echo ""
		echo "Old Record : $oldRecord"
		sed -i s/"$oldRecord"/"$newRecord"/g addressbook1.csv
		echo ""
		echo "Record Modified...."
	else
		echo "Error : Email not exist!!!"
	fi
}
function delete()
{
	echo "Enter email"
	read email
	len=`cat addressbook1.csv | grep $email | wc -w`
	if [ $len -gt 0 ]
	then
		old=`cat addressbook1.csv | grep $email`
		sed -i s/"$old"//g addressbook1.csv
		sed -i /^$/d addressbook1.csv
		echo ""
		echo "Record Deleted!!!"
	else
		echo "Error : Email not exist!!!"
	fi
}
function searchByName()
{
	echo "Enter Name"
	read fname
	len=`cat addressbook1.csv | grep $fname | wc -w`
	if [ $len -gt 0 ]
	then
		echo ""
		cat addressbook1.csv | grep $fname
	else
		echo "Error : Name not Found!!!"
	fi
}
function searchByZip()
{
	echo "Enter Zip Code"
	read zip
	len=`cat addressbook1.csv | grep $zip | wc -w`
	if [ $len -gt 0 ]
	then
		echo ""
		cat addressbook1.csv | grep $zip
	else
		echo "Error : Zip code not Found!!!"
	fi
}
while [ true ]
do
	echo ""
	echo "****************MENU****************"
	echo "1. Create Address Book"
	echo "2. displayAddressBook"
	echo "3. Insert"
	echo "4. Edit"
	echo "5. Delete Record"
	echo "6. SearchByName"
	echo "7. SearchByZip"
	echo "8. Exit"
	echo "Enter Your choice"
	read choice
	case $choice in
		1) createAddBook ;;
		2) displayAddressBook ;;
		3) insert ;;
		4) edit ;;
		5) delete ;;
		6) searchByName ;;
		7) searchByZip ;;
		8) exit ;;
		*) echo "Please enter valid choice!!!"
	esac
done
