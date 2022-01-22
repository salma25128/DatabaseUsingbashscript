#! /bin/bash
while true
do
    PS3="Enter the number of selection : "
    #menu database    
    select choice in "Create Database" "List Databases" "Connect To Databases" "Drop Database" "Exit"
    do
        #change directory
        if [ $(pwd) == "/home/yasmina" ]
        then
            cd BashDatabaseProject
        else
            cd ..
        fi

        case $choice in
            #create database code
            "Create Database")
                read -p "Enter name of data base : " namedatabase
                if [ "$namedatabase" = "" ];
                then
                    echo -e "\nDatabase name can't be null\n";
                    cd
                    break
                elif [ -d $namedatabase ];
                then
                    echo -e "\nData Base is exist!\n";
                    cd
                elif [[ ! $namedatabase =~ ^[a-zA-Z][a-zA-Z0-9]*$ ]]
                then
                    echo -e "\nDatabase name must start a character\n"
                    cd
                    break    
                else
                    mkdir $namedatabase;     
                    echo -e "\nDatabase created successed.\n";
                    cd
                fi
                break
            ;;
            #list all exist database
            "List Databases")
                echo -e "\nCurrnt database is: \n"  
                ls -d */
                echo -e "\n"
                cd
                break        
            ;;
            #connection with DB
            "Connect To Databases")
                read -p "Enter name of data base that you want to connect : " databaseconn
                if [ "$databaseconn" = "" ];
                then
                    echo -e "\nDatabase name can't be null\n";
                    break
                elif [ -d $databaseconn ];
                then
                    cd $databaseconn
                    echo -e "\n"
                    echo -e $databaseconn "database is connected!\n";

                    while true
                    do
                    #menu of tables
                    select option in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select All" "Select From Table" "Delete From Table" "back"
                    do
                        case $option in
                            #create new table
                            "Create Table")
                                read -p "Enter the table name : " tablename
                                #check file is exist or not
                                if [ "$tablename" = "" ];
                                then
                                    echo -e "\nTable name can't be null\n";
                                    break
                                elif [ -f $tablename ]
                                then
                                    echo -e "\nTable is exist!\n";
                                    break
                                elif [[ ! $tablename =~ ^[a-zA-Z][a-zA-Z0-9].*$ ]]
                                then
                                    echo -e "\n Table name must start a character \n"
                                    break        
                                else
                                    touch $tablename;     
                                    echo -e "\n"$tablename "table is created successed.\n";
                                    #enter num of coulmns     
                                    read -p "Enter Number of columns : " numcol
                                    echo -e "\n"
                                    if [ "$numcol" = "" ]
                                    then
                                        echo -e "\nNumber of coulmns is required\n"
                                        rm $tablename 
                                        break
                                        #read -p "Enter Number of columns : " numcol
                                    else
                                        #enter pk in first feild
                                        echo -n 'PK:' >> $tablename;
                                        count=1;
                                        #enter names of feilds
                                        while [ $count -le $numcol ]
                                        do
                                            read -p "Enter Feild Name "$count":" feild
                                            
                                            if [ "$feild" = "" ];
                                            then
                                                echo -e "\nFaild Name can't be null\n";
                                                continue
                                            elif [[ ! $feild =~ ^[a-zA-Z][a-zA-Z0-9]*$ ]]
                                            then
                                                echo -e "\nField name must start a character\n"
                                                continue         
                                            else
                                                echo -n $feild':' >> $tablename;
                                                ((count++))
                                            fi    
                                        done
                                        #new line    
                                        echo -ne '\n'>> $tablename;
                                        #data type of pk
                                        echo  -n 'number:' >> $tablename;
                                        count=1
                                        #enter data type for other feilds
                                        echo -e "\n"
                                        while [ $count -le $numcol ]
                                        do
                                            read -p "Enter Data Type to feild "$count":" feildData
                                            if [ "$feildData" = "" ];
                                            then
                                                echo -e "\nFaild Data type can't be null\n";
                                                continue     
                                            else
                                                echo -n $feildData':' >> $tablename;
                                                ((count++))    
                                            fi    
                                        done
                                        #new line
                                        echo -ne '\n'>> $tablename;
                                        count=1;
                                        #enter num of record
                                        echo -e "\n" 
                                        read -p "Enter Number of record:" NR
                                        n=1
                                        #enter records content
                                        while [ $n -le $NR ]
                                        do
                                            #enter pk directly
                                            echo -n $n':' >> $tablename;
                                            echo -e "\nEnter Record number=>" $n
                                            #fill record feilds one by one
                                            while [ $count -le $numcol ]
                                            do
                                                read -p "Fill feild "$count":" feildname
                                                echo -ne $feildname':' >> $tablename;
                                                ((count++))
                                            done
                                            count=1;
                                            echo -ne '\n'>> $tablename;
                                            ((n++))
                                        done
                                        echo -e "\nTable created\n";
                                        break
                                    fi    
                                fi
                            ;;
                            #list all tables
                            "List Tables")
                            echo -e "\nCurrnt tables is: \n"
                            ls
                            echo -e "\n"
                            break 
                            ;;
                            #Delete table
                            "Drop Table")
                                read -p "Enter name of table that you want to drop: " tabledrop
                                if [ "$tabledrop" = "" ]
                                then
                                    echo -e "\n" $tabledrop "\nTable name can't be null\n";
                                    break
                                elif [ -f $tabledrop ]
                                then
                                    rm -i $tabledrop
                                    echo -e "\nTable is dropped!\n";
                                    break
                                else
                                    echo -e "\n" $tabledrop " table not exist!\n";
                                    break
                                fi
                            ;;
                            #insert into table 
                            "Insert into Table")
                                read -p "Enter the table name : " tableinsert
                                #check file is exist or not
                                if [ "$tableinsert" = "" ];
                                then
                                    echo -e "\nTable name can't be null\n";
                                    break
                                elif [ -f $tableinsert ]
                                then
                                    numbercol=$(cat ${tableinsert}| wc -l);
                                    count=1
                                    #enter pk 
                                    if ! grep -q ^$numbercol "$tableinsert";
                                    then
                                        echo -n $numbercol':' >> $tableinsert;
                                    else
                                        ((numbercol++))
                                        echo -n $numbercol':' >> $tableinsert;
                                    fi
                                    echo -e "\nEnter Record number=>" $numbercol
                                    #fill record feilds one by one
                                    while [ $count -le $numcol ]
                                    do
                                        read -p "Fill feild "$count":" feildname
                                        echo -ne $feildname':' >> $tableinsert;
                                        ((count++))
                                    done
                                    echo -ne '\n'>> $tableinsert;    
                                else
                                    echo -e "\nTable isn't exist!\n";
                                    break
                                fi
                                echo "insert"
                                break
                            ;;
                            #select all coulmns from table
                            "Select All")
                                read -p "Enter name of table that you want to select all coulmns: " selectname
                                if [ "$selectname" = "" ]
                                then
                                    echo -e "\n" $selectname " Table name can't be null\n";
                                    break
                                elif [ -f $selectname ]
                                then
                                    echo -e "\n"
                                    head $selectname
                                    echo -e "\n"
                                    break
                                else
                                    echo -e "\n" $selectname " table not exist!\n";
                                    break
                                fi 
                            ;;
                            #select with pk
                            "Select From Table")
                                read -p "Enter name of table that you want to select: " nameselect
                                if [ "$nameselect" = "" ]
                                then
                                    echo -e "\n" $nameselect " Table name can't be null\n";
                                    break
                                elif [ -f $nameselect ]
                                then
                                    read -p "Enter primary key for record select: " pk
                                    if ! grep -q ^$pk "$nameselect";
                                    then
                                        echo -e "\nPrimery key not found\n"
                                        break
                                    else
                                        echo -e "\n"
                                        grep ^$pk $nameselect
                                        echo -e "\n"
                                        break
                                    fi
                                else
                                    echo -e "\n" $nameselect "Table not exist!\n";
                                    break
                                fi 
                            ;;
                            #delete record from table
                            "Delete From Table")
                                read -p "Enter name of table that you want to delete from: " namedelete
                                if [ "$namedelete" = "" ]
                                then
                                    echo -e "\n" $namedelete " Table name can't be null\n";
                                    break
                                elif [ -f $namedelete ]
                                then
                                    read -p "Enter primary key for record delete: " Pk
                                    if [ "$Pk" = "" ]
                                    then
                                        echo -e "\nplease enter primery key\n"
                                        break   
                                    elif ! grep -q ^$Pk "$namedelete";
                                    then
                                        echo -e "\nPrimery key not found\n"
                                        break
                                    else
                                        sed -i /^$Pk/d $namedelete
                                        echo -e "\nRecord is deleted\n"
                                        break
                                    fi
                                else
                                    echo -e "\n" $namedelete "Table not exist!\n";
                                    break
                                fi 
                            ;;
                            #back one step
                            "back")
                                break 3
                            ;;
                            *)
                                echo -e "\nThe choices not exist,please enter true choice!\n"
                                break
                            ;;
                        esac    
                    done
                    done
                else
                    echo -e "\nDatabase not exist.\n";
                    break
                fi
            ;;
            #Drop DB
            "Drop Database")
                read -p "Enter name of data base that your drop : " databasedrop
                if [ "$databasedrop" = "" ]
                then
                    echo -e "\n" $databasedrop " Database name can't be null\n";
                    cd
                elif [ -d $databasedrop ];
                then
                    rm -ir $databasedrop
                    echo -e "\nData Base is Dropped!\n";
                    cd 
                else
                    echo -e "\nDatabase not exist.\n";
                    cd
                fi
                break        
            ;;
            "Exit")
                echo -e "\nPress ctrl+c to exit\n"
                cd
                ;;
            *) echo -e "\nThe choices not exist,please enter true choice\n"
               break
            ;;
        esac
    done
done


