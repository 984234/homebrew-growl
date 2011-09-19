require 'formula'

class BrewGrowl < Formula
  url 'https://github.com/secondplanet/brew-growl/tarball/master'
  homepage 'https://github.com/secondplanet/brew-pip'
  version '0.0.1'
  md5 '8f20f14dac46ad4298847af9545bc01c'

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
