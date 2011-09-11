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
