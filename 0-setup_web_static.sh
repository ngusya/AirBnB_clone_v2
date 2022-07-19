#!/usr/bin/env bash                                                                                
# Will set up a web server ready for deployment of webstatic                                       
 apt-get update                                                                                
 apt-get install -y nginx                                                                      
                                                                                                   
 ufw allow 'Nginx HTTP'                                                                        
                                                                                                   
# Creates /data/web_static/releases/test/ and /data/web_static/shared/ folders                     
 mkdir -p /data/                                                                               
 mkdir -p /data/web_static/                                                                    
 mkdir -p /data/web_static/releases/                                                      
 mkdir -p /data/web_static/shared/
 mkdir -p /data/web_static/releases/test/
 
#Creates a sample html file                                                                        
 echo "<html>                                                                                  
            <head>                                                                                     
            </head>                                                                                    
            <body>                                                                                     
              Holberton School                                                                         
            </body>                                                                                    
           </html>" > /data/web_static/releases/test/index.html                                          
                                                                                                   
if [[ -L /data/web_static/current ]]                                                               
then                                                                                               
    rm /data/web_static/current                                                                    
fi                                                                                                 
                                                                                                   
#Creates a symbolic link /data/web_static/current linked to /data/web_static/releases/test/ folder
ln -sf /data/web_static/releases/test /data/web_static/current                                
                                                                                                   
#Gives ownership of the /data/ folder to the ubuntu user AND group
chown -R ubuntu:ubuntu /data/
chgrp -R ubuntu /data/                                                                        
                                                                                                   
#Updates the Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static  
sed -i '/listen 80 default_server/a location /hbnb_static/ { alias /data/web_static/current/;}
                                                                                                   
#Restarts Nginx                                                                 service nginx restart

#Ensures program exits successfully
exit 0
