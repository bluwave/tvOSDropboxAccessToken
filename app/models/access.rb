class Access < ActiveRecord::Base

  def self.gen_tv_token()
    return Digest::SHA1.hexdigest([Time.now, rand].join)[0..6]
  end

  def self.cleanup_expired_tv_requests()
    Access.delete_all ["updated_at < ?", Time.now - 5.minutes]
  end

end
