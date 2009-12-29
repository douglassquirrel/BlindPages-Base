mkdir .ssh
cd .ssh
scp squirrel@192.168.2.2:/home/squirrel/.ssh/id* .
cd
ssh git@github.com
sudo apt-get install git-core
git init
git clone git@github.com:douglassquirrel/BlindPages-Base.git
eval `ssh-agent`
ssh-add ~/.ssh/id_rsa
ssh-add -l
