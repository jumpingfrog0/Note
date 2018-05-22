#!/bin/bash

###
# iOS 开发环境配置脚本
###

############################   Functions   ###############################

function installRvm() {
    \curl -sSL https://get.rvm.io | bash -s stable --ruby
    source ~/.rvm/scripts/rvm
}

function installHomebrew() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap caskroom/cask
}

function installRuby() {
    rvm install 2.3.1
    rvm use 2.3.1
    rvm list
}

function installBundler() {
    gem install bundler
}

function RunBundleInstall() {
    # 将配置写入Gemfile
    echo 'Gemfile initialing...'
    echo "# frozen_string_literal: true\n \
    source \"https://rubygems.org\"\n \
    gem 'cocoapods', '~> 1.0.1'\n\
    gem 'fastlane', '~> 2.38.1'" > ~/Documents/.dev/Gemfile

    # bundle install
    current_dir=$PWD
    cd ~/Documents/.dev
    bundle install
    cd ${current_dir}
}

function installCommandLineTools() {

    # oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # autojump
    brew install autojump
    echo "\n# autojump configuration\n\
    [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh" >> ~/.zshrc
    source ~/.zshrc

    # tree
    brew install tree
}

function installVimPlugins() {
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

##########################################################################

############################   Run scripts   #############################

installRvm
installHomebrew
installRuby
installBundler
RunBundleInstall
installCommandLineTools
installVimPlugins

##########################################################################




