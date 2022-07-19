#!/usr/bin/env bash                                                                                
# Will set up a web server ready for deployment of webstatic                                       
sudo apt-get update                                                                                
sudo apt-get install -y nginx                                                                      
                                                                                                   
sudo ufw allow 'Nginx HTTP'                                                                        
                                                                                                   
# Creates /data/web_static/releases/test/ and /data/web_static/shared/ folders                     
sudo mkdir -p /data/                                                                               
sudo mkdir -p /data/web_static/                                                                    
sudo mkdir -p /data/web_static/releases/test/                                                      
sudo mkdir -p /data/web_static/shared/                                                             
#Creates a sample html file                                                                        
sudo echo "<html>                                                                                  
        <head>                                                                                     
        </head>                                                                                    
        <body>                                                                                     
          Holberton School                                                                         
        </body>                                                                                    
      <html>" > /data/web_static/releases/test/index.html                                          
                                                                                                   
if [[ -L /data/web_static/current ]]                                                               
then                                                                                               
    rm /data/web_static/current                                                                    
fi                                                                                                 
                                                                                                   
#Creates a symbolic link /data/web_static/current linked to /data/web_static/releases/test/ folder 
sudo ln -sf /data/web_static/releases/test /data/web_static/current                                
                                                                                                   
#Gives ownership of the /data/ folder to the ubuntu user AND group                                 
sudo chown -R ubuntu:ubuntu /data/                                                                 
sudo chgrp -R ubuntu /data/                                                                        
                                                                                                   
#Updates the Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static  
sudo sed -i '/listen 80 default_server/a location /hbnb_static/ { alias /data/web_static/current/;}
                                                                                                   
#Restarts Nginx                                                                                    
service nginx restart
