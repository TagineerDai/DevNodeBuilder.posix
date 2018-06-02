# DevNodeBuilder.posix

### CUDA & cuDNN

#### Current version of CUDA and cuDNN

```shell
nvcc -V
    nvcc: NVIDIA (R) Cuda compiler driver
    Copyright (c) 2005-2017 NVIDIA Corporation
    Built on Fri_Nov__3_21:07:56_CDT_2017
    Cuda compilation tools, release 9.1, V9.1.85
whereis cudnn
	/usr/include/cudnn.h
vim $CUDNN_DIR
```

```cpp
#define CUDNN_MAJOR 7
#define CUDNN_MINOR 0
#define CUDNN_PATCHLEVEL 5

#define CUDNN_VERSION	(CUDNN_MAJOR * 1000 + CUDNN_MINOR * 100 + CUDNN_PATCHLEVEL)
```

Current version: cuda-9.1 and cuDNN 7.0.5. 

#### CUDA Installation

Tensorflow ask for cuda-9.0 with cuDNN7.0.5, install CUDA-9.0 as [Installation Guide](http://developer.download.nvidia.com/compute/cuda/9.0/Prod/docs/sidebar/CUDA_Installation_Guide_Linux.pdf) mentioned.

```sh
# Uninstall the installed incompatible cuda-9.1.
sudo /usr/local/cuda-X.Y/bin/uninstall_cuda_X.Y.pl
# Install the meta-data
wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb
mv cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb cuda9.0.deb
sudo dpkg -i cuda9.0.deb
sudo apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub

wget https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/1/cuda-repo-ubuntu1604-9-0-local-cublas-performance-update_1.0-1_amd64-deb
mv cuda-repo-ubuntu1604-9-0-local-cublas-performance-update_1.0-1_amd64-deb cuda9.0.patch1.deb
sudo dpkg -i cuda9.0.patch1.deb

wget https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/2/cuda-repo-ubuntu1604-9-0-local-cublas-performance-update-2_1.0-1_amd64-deb
mv cuda-repo-ubuntu1604-9-0-local-cublas-performance-update-2_1.0-1_amd64-deb cuda9.0.patch2.deb
sudo dpkg -i cuda9.0.patch2.deb
# Installation
sudo apt-get update
sudo apt-get install cuda-9.0 -Y
# View the installed package
cat /var/lib/apt/lists/*cuda*Packages | grep "Package:"
# Test cuda
cd /usr/local/cuda-9.0/samples/1_Utilities/deviceQuery
sudo make
sudo ./deviceQuery
# Path manage
vim ~/.bashrc
```

in `~/.bashrc`, add the following lines:

```bash
PATH=/usr/local/cuda-9.0/bin:$PATH
LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH
```

![CUDA_AND_SYMBOLIC_LINK](https://github.com/TagineerDai/DevNodeBuilder.posix/blob/master/CUDA_AND_SYMBOLIC_LINK.png?raw=true)

#### cuDNN Installation

We should Downgrade libcudnn7 from 7.0.5.15-1+cuda9.1 to 7.0.5.15-1+cuda9.0.

Install manually according to [cuDNN Installation Guide](https://docs.nvidia.com/deeplearning/sdk/cudnn-install/).

Download cuDNN-7.0.5 for CUDA9.0 here: [Download cuDNN v7.0.5 (Dec 5, 2017), for CUDA 9.0](https://developer.nvidia.com/rdp/cudnn-archive#a-collapse705-9) 

```sh
sudo dpkg -i libcudnn7_7.0.5.15-1+cuda9.0_amd64.deb
sudo dpkg -i libcudnn7-dev_7.0.5.15-1+cuda9.0_amd64.deb
sudo dpkg -i libcudnn7-doc_7.0.5.15-1+cuda9.0_amd64.deb
# hint: using /usr/include/x86_64-linux-gnu/cudnn_v7.h to provide /usr/include/cudnn.h (libcudnn) in auto mode
```

### Basic Packages and IDEs

#### Packages

```sh
sudo apt-get install python-numpy python-scipy
sudo apt-get install python3-pip python3-dev
sudo apt-get install eog
sudo pip3 install jupyter pandas graphviz opencv-python
```

#### Terminal

```sh
sudo apt-get install zsh
sudo wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
sudo chsh -s /usr/local/bin/zsh
vim ~/.bashrc
```

Add lines at the end of `~/.bashrc`

```sh
PATH=/usr/local/cuda-9.0/bin:$PATH
LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH

tmux_init()
{
    tmux new-session -s "States" -d
    tmux new-window -n "GPU" "watch -n 1 nvidia-smi"
    tmux split-window -v
    tmux new-window -n "Processes" "htop"
    tmux new-session -s "Editor" -d
    tmux new-window -n "Page1" "cd ~/Projects"
    tmux split-window -h
    tmux split-window -v
}

if which tmux 2>&1 >/dev/null; then
    test -z "$TMUX" && (tmux attach || (tmux_init && tmux attach))
fi
```

#### Editor

```sh
sudo apt-get install build-essential cmake ycmd
sudo pip3 install jedi
cd ~
touch .vimrc
mkdir ~/.vim && mkdir ~/.vim/bundle && mkdir ~/Projects
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/TagineerDai/DevNodeBuilder.posix.git ~/Projects/DevNodeBuilder.posix
cp ~/Projects/DevNodeBuilder.posix/.vimrc ~/.vimrc
```

Then run `:PluginInstall` in the restarted vim.

```sh
cd ~/.vim/bundle/YouCompleteMe
python3 ./install.py --all
```

Feel free to change the `Plugin` part and pick your favorites from [Vim Awesome](https://vimawesome.com/). Error at the end of installing `YouCompleteMe` is caused by C# incompatible and could be omitted. 

### Frameworks

#### Tensorflow

```shell
sudo pip3 install --upgrade tensorflow-gpu
```

#### PyTorch

```
sudo pip3 install --upgrade torch torchvision
```

#### Keras

```shell
sudo pip3 install keras
```

#### MXNet

```sh
sudo pip install mxnet-cu90 --pre
```

#### Caffe

```sh
# Install Pre-requisites
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev
sudo apt-get install libopenblas-dev liblapack-dev libatlas-base-dev
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev
# Install & Make
git clone https://github.com/TagineerDai/caffe.git
cd caffe
cp Makefile.config.example Makefile.config
vim Makefile.config
# 6 is number of core, got by `echo $(($(nproc) + 1))`
sudo make all -j6
sudo make test -j6
sudo make pycaffe -j6
# Runtest should make without parallel, if there are any error, just repeated without make clean.
sudo make runtest 
```

![PASSED_RUNTEST_CAFFE](https://raw.githubusercontent.com/TagineerDai/DevNodeBuilder.posix/master/PASSED_RUNTEST_CAFFE.png)

