module Pushbots
  # Device class
  class Device
    attr_accessor :token, :platform, :tags, :device_alias
    PLATFORM_TYPE = { ios: 0, android: 1, chrome: 2 }.freeze
    PLATFORM_TYPE_R = [:ios, :android, :chrome].freeze

    def initialize(token, platform = nil, tags = nil, device_alias = nil)
      self.token = token
      self.platform = platform if platform
      self.tags = tags if tags
      self.device_alias = device_alias if device_alias
    end

    def info
      response = Request.info(token)
      if response.code == 200
        http_response = JSON.parse(response)
        self.platform = PLATFORM_TYPE_R[http_response['platform']]
        self.tags = http_response['tags']
        self.device_alias = http_response['alias']
      end
    end

    def register
      body = { token: token, platform: PLATFORM_TYPE[platform], tags: tags, alias: device_alias }
      response = Request.register(body)
      response.code == 201
    end

    def delete
      body = { token: token, platform: PLATFORM_TYPE[platform] }
      response = Request.delete(body)
      response.code == 200
    end
  end
end
