# Simple notifier for Prowl
# http://www.prowlapp.com/
module Notifier
  module Prowl
    extend self

    def supported?
      RUBY_PLATFORM =~ /(linux|freebsd|darwin)/
    end

    def notify(options)
      command = %W[
        curl
        -d 'apikey=#{options[:apikey]}'
        -d 'application=#{options[:title]||"Notifier"}'
        -d 'event=#{options[:event]||"Notification"}'
        -d 'priority=#{options[:priority]||0}'
        -d 'description=#{options[:message]}'
        https://www.prowlapp.com/publicapi/add
      ].join(" ")
      Thread.new { `#{command}` }
    end
  end
end
