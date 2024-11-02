# Amazon Linux 2023.03でのインストール

# パッケージの更新
sudo yum update -y

# パッケージのインストール
sudo dnf groupinstall -y "Development Tools"
sudo dnf install -y git

# rbenvのインストール
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

# rubyのインストール
sudo yum install -y openssl-devel readline-devel zlib-devel
rbenv install 3.0.5
rbenv global 3.0.5

# mysqlのインストール
sudo dnf install https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm -y
sudo dnf install mysql-community-server -y
sudo systemctl enable mysqld
sudo systemctl start mysqld

# MySQL開発用パッケージのインストール
sudo dnf install mysql-devel -y
