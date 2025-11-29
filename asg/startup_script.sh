#!/bin/bash


sudo yum update -y
sudo yum install httpd -y


sudo systemctl start httpd
sudo systemctl enable httpd


# cat <<EOF > /var/www/html/index.html
# <body style="background-color: lightblue;">
#     <h1>Version 2, Jai babu </h1>
# </body>
# EOF
echo "<h1>Version 1, Jai NTR </h1>" | sudo tee /var/www/html/index.html 
echo "<h1>This is fallback page, main page is not working</h1>" | sudo tee /usr/share/httpd/noindex/index.htm

