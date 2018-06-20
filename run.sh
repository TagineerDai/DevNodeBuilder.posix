# TODO#1: Find how to concat file without vim : )
### libcudnn
mkdir ~/Setup && cd ~/Setup
git clone https://github.com/TagineerDai/libcudnn7.0.5-cuda9.0-ubuntu16.04.git
cd libcudnn7.0.5-cuda9.0-ubuntu16.04
sudo dpkg -i libcudnn7_7.0.5.15-1+cuda9.0_amd64.deb
sudo dpkg -i libcudnn7-dev_7.0.5.15-1+cuda9.0_amd64.deb
sudo dpkg -i libcudnn7-doc_7.0.5.15-1+cuda9.0_amd64.deb
### basic package
sudo apt-get install python3-numpy python3-scipy -y
sudo apt-get install python3-pip python3-dev python3-matplotlib -y
sudo apt-get install eog -y
sudo pip3 install jupyter pandas graphviz opencv-python jedi
### IDEs
sudo apt-get install zsh -y
sudo wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
sudo apt-get install build-essential cmake ycmd -y
cd ~
touch .vimrc
mkdir ~/.vim && mkdir ~/.vim/bundle && mkdir ~/Projects
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/TagineerDai/DevNodeBuilder.posix.git ~/Projects/DevNodeBuilder.posix
cp ~/Projects/DevNodeBuilder.posix/.vimrc ~/.vimrc
vim -c :PluginInstall
# TODO#2: Find how to exist vim after installed.
cd ~/.vim/bundle/YouCompleteMe
python3 ./install.py --all
### Frameworks
sudo pip3 install --upgrade tensorflow-gpu
echo TensorFlow Installed.
sudo pip3 install --upgrade torch torchvision
echo PyTorch Installed.
sudo pip3 install keras
echo Keras Installed.
sudo pip install mxnet-cu90 --pre
echo MXNet Installed.
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler -y
sudo apt-get install --no-install-recommends libboost-all-dev -y
sudo apt-get install libopenblas-dev liblapack-dev libatlas-base-dev -y
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev -y
cd ~/Setup
git clone https://github.com/TagineerDai/caffe.git
cd caffe
# cp Makefile.config.example Makefile.config
# vim Makefile.config
# 6 is number of core, got by `echo $(($(nproc) + 1))`
sudo make all -j$(($(nproc) + 1))
sudo make test -j$(($(nproc) + 1))
sudo make pycaffe -j$(($(nproc) + 1))
# Runtest should make without parallel, if there are any error, just repeated without make clean.
sudo make runtest 