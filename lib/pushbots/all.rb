module Pushbots
  # All class
  class All < Push
    attr_accessor :schedule, :tags, :sound, :badge, :except_tags, :device_alias,
                  :except_alias, :payload

    def initialize(platforms, message, schedule, options = {})
      super(platforms, message, :all)
      self.schedule = schedule
      self.tags = options[:tags]
      self.sound = options[:sound]
      self.badge = options[:badge]
      self.except_tags = options[:except_tags]
      self.device_alias = options[:alias]
      self.except_alias = options[:except_alias]
      self.payload = options[:payload]
    end

    def send
      self.response = Request.send(:all, body)
      self.status =
        response.failed? ? STATUS[:failed] : STATUS[:delivered]
    end

    def body
      data = {
        platform: @platform,
        msg: message,
        schedule: schedule
      }
      data[:tags] = tags if tags
      data[:badge] = badge if badge
      data[:alias] = device_alias if device_alias
      data[:except_tags] = except_tags if except_tags
      data[:payload] = payload if payload
      return data
    end
  end
end
