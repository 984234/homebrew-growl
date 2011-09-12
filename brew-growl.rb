class GrowlNotifier
  def initialize(options={})
    @command = "growlnotify "
    @valid_args = [:title, :name, :appicon, :message, :icon, :iconpath, :image, :priority, :identifier,
                   :wait, :host, :password, :upd, :port, :auth, :progress]
    options.each do |k, v|
      if @valid_args.include? k
        @command += "--#{k.to_s} \"#{v}\" "
      end
    end
  end

  def sticky!
    @command += '--sticky '
  end

  def crypt!
    @command += '--crypt '
  end

  def notify!
    system @command
  end

  def sticky?
    @command.inlude? ' --sticky'
  end

  def crypt?
    @command.include? ' --crypt'
  end

  class << self
    def growl_version
      `growlnotify -v`[12..16]
    end

    def growl_exists?
      `growlnotify --version 2>&1`
      $?.exitstatus == 0
    end
  end

end


require 'formula'
  
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
  when 'on'
    system "echo alias \"brew='brew growl'\" > ~/.brew-growl"
    ready_notifier.notify!
  when 'off'
    system "rm ~/.brew-growl"
    stop_notifier.notify!
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
  else
    system "#{BREW_PREFIX}/bin/brew #{ARGV.join(" ")}"
end
