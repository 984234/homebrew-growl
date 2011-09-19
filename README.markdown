# brew-growl

    A simple Homebrew extension adding Growl support.

## Install

    brew install https://raw.github.com/secondplanet/brew-growl/master/Formula/brew-growl.rb

## Usage

Simply follow the instructions on install. If you want to use brew-growl without turning it on all the time,

    brew growl install formula
    
will work. Just use brew growl before pretty much any command. (brew-pip and brew-gem are supported)

## growlnotifier.rb

This includes a simple Growl wrapper I wrote in Ruby that I am using for this.
It requires `growlnotify` and Growl.

    brew install growlnotify

The usage and details for the script are found at https://gist.github.com/1209632

