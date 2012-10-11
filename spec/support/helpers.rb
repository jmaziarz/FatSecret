module Helpers
  def configure
    FatSecret.configure do |c|
      c.access_key    = '1234'
      c.consumer_key  = 'abcd'
      c.shared_secret = 'secret'
    end
  end
end
