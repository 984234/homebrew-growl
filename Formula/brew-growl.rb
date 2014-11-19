require 'formula'

class BrewGrowl < Formula
  url 'git://github.com/secondplanet/homebrew-growl'
  homepage 'https://github.com/secondplanet/homebrew-growl'
  version '0.0.1'

  def install
    inreplace 'bin/brew-growl', /^BREW_PREFIX = '.*'$/, "BREW_PREFIX = '#{HOMEBREW_PREFIX}'"
    bin.install 'bin/brew-growl'
  end

  def caveats; <<-EOS
To turn on brew growl,

  brew growl on

Add the following to your ~/.zshrc or ~/.bashrc:

  source ~/.brew-growl 2> /dev/null

To switch off later,

  brew growl off
    EOS
  end
end
