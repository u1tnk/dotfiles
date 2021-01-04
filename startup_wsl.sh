sudo service ssh start
sudo service docker start

ip a show eth0 | grep "inet " | awk '{print $2}'
