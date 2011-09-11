require 'formula'
require 'growlnotifier'
  
APPLICATION = 'Homebrew'
BREW_PREFIX = '/usr/local'
package = ""


ready_notifier = GrowlNotifier.new(
                                   :title => 'brew-growl',
                                   :name => APPLICATION,
                                   :message => 'Started.'
                                   )

stop_notifier = GrowlNotifier.new(
                                  :title => 'brew-growl',
                                  :name => APPLICATION,
                                  :message => 'Stopped.'
                                  )

install_notifier = GrowlNotifier.new(
                                     :title => package,
                                     :name => APPLICATION,
                                     :message => 'Installed.'
                                     )

upgrade_notifier = GrowlNotifier.new(
                                     :title => APPLICATION,
                                     :name => APPLICATION,
                                     :message => 'Upgrade complete.'
                                     )

uninstall_notifier = GrowlNotifier.new(
                                       :title => package,
                                       :name => APPLICATION,
                                       :message => 'Uninstalled.'
                                       )

update_notifier = GrowlNotifier.new(
                                    :title => APPLICATION,
                                    :name => APPLICATION,
                                    :message => "Updated."
                                    )

error_notifier = GrowlNotifier.new(
                                   :title => package,
                                   :name => APPLICATION,
                                   :message => 'Error; read ~/Library/Logs/Homebrew/config.log for details.'
                                   )

case ARGV.first
  when 'install'
    package = ARGV[1..ARGV.length].join(", ")
    system "#{BREW_PREFIX}/bin/brew install #{ARGV[1..ARGV.length].join(" ")} 2>&1"
    if $?.exitstatus == 0
      install_notifier.notify!
    else
      error_notifier.notify!
    end
  when 'uninstall'
    package = ARGV[1..ARGV.length].join(", ")
    system "#{BREW_PREFIX}/bin/brew uninstall #{ARGV[1..ARGV.length].join(" ")} 2>&1"
    if $?.exitstatus == 0
      uninstall_notifier.notify!
    else
      error_notifier.notify!
    end
  when 'update'
    system "#{BREW_PREFIX}/bin/brew update 2>&1"
    if $?.exitstatus == 0
      update_notifier.notify!
    else
      error_notifier.notify!
    end
  when 'upgrade'
    system "#{BREW_PREFIX}/bin/brew upgrade 2>&1"
    if $?.exitstatus == 0
      update_notifier.notify!
    else
      error_notifier.notify!
    end
  when 'on'
    system "echo alias \"brew='brew growl'\" > ~/.brew-growl"
    ready_notifier.notify!
  when 'off'
    system "rm ~/.brew-growl"
    stop_notifier.notify!
  else
    system "#{BREW_PREFIX}/bin/brew #{ARGV.join(" ")}"
end
