#!/bin/bash
apt update -y
apt install apache2 -y


myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h2><font color="gold">Build by Terraform </h2><br><p>
<font color="green">Server PrivateIP: <font color="aqua">$myip<br><br>
<font color="magenta">
<b>jeka4el</b>
</body>
</html>
EOF

sudo systemctl start apache2
systemctl enable apache2
