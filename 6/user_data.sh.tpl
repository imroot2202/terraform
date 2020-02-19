#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
cat <<EOF > /var/www/html/index.html
  <html>
<h2>Build by terraform<fornt clor "red"> v.012</font></h2>
WebServer number ${count_s} <br>
Owner = ${f_name} ${l_name} <br>
%{for peremennaya in names}
Hello to ${peremennaya} from ${f_name}<br>
%{endfor ~}
</html>
EOF

sudo service httpd start
chkconfig httpd on
