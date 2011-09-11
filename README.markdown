# brew-growl

    A simple Homebrew extension adding Growl support.

## Install

Clone the repo into somewhere that's in your PATH.

## Usage

To start using it, type

    brew growl on

Then add this to your `~/.bashrc` or `~/.zshrc`

    source ~/.brew-growl

To stop notifications,

    brew growl off

Write now this is a bit weird and uses `alias` to make it work; but I'm going to make
some of the things work better in the future.

NOTE: Currently, if you don't have Homebrew in `/usr/local`, you'll have to change
the value of the `BREW_PREFIX` constant in `brew-growl.rb`

## growlnotifier.rb

This is a simple Growl wrapper I wrote in Ruby that I am using for this.
It requires `growlnotify` and Growl.

    brew install growlnotify

The usage and details for the script are found at https://gist.github.com/1209632.

