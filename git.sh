cd .ssh
scp squirrel@192.168.2.2:/home/squirrel/.ssh/id* .
cd
sudo apt-get install git-core
git init
ssh git@github.com
git clone git@github.com:douglassquirrel/BlindPages-Base.git