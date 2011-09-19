require 'formula'

class BrewGrowl < Formula
  url 'https://github.com/secondplanet/brew-growl/tarball/master'
  homepage 'https://github.com/secondplanet/brew-pip'
  version '0.0.1'
  md5 '2762120cb23da531c9f2b8159214d995'

  def install
    inreplace 'brew-growl.rb', /^BREW_PREFIX = '.*'$/, "BREW_PREFIX = '#{HOMEBREW_PREFIX}'"
    bin.install 'bin/brew-growl'
  end

  def caveats; <<-EOS
To turn on brew growl,

  brew growl on

Add the following to your ~/.zshrc or ~/.bashrc:

  source ~/.brew-growl

To switch of later,

  brew growl on
    EOS
  end
end
