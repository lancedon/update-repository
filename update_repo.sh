#!/usr/bin/expect -f

  	 set password "your password"

      	 spawn git fetch 
         expect "*:"
         send -- "$password\r"

         send "\r" 
	
	 
	 expect "*$"
    	 spawn git pull
         expect "*:"
         send -- "$password\r"

	 send "\r"
	 
	 expect eof 

	 
