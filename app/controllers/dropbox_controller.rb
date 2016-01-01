class DropboxController < ApplicationController

  require 'dropbox_sdk'

  def index
    redirect_to url_for(:action => 'login')
  end

  def tv
    token = Access.gen_tv_token()
    access_record = Access.new
    access_record.tv_token = token
    access_record.save
    json = {:tv_token => token, url: shorten_url(token)}
    respond_to do |format|
      format.json  { render :json => json }
      format.text {render :text => json }
      format.html {render :text => json }
    end

    Access.cleanup_expired_tv_requests
  end

  def addtv
    begin
      tv_token = params[:tv_token]
      access_record = Access.find_by_tv_token(tv_token)
      session[:tv_token] = tv_token
      dropbox_authorize_url = get_web_auth().start()
      redirect_to dropbox_authorize_url
      return
    rescue ActiveRecord::RecordNotFound => e
    end

    render :text => "Unable to find tv" # if this is missing, request from tvOS app may not be reaching web server
  end

  def callback
    begin
      access_token, user_id, url_state = get_web_auth.finish(params)
      begin
        tv_token = session[:tv_token]
        access_record = Access.find_by_tv_token(tv_token)
        # access_record.dropbox_access_token = access_token
        access_record.update(:dropbox_access_token => access_token)
        redirect_to url_for(:action => 'tv_added')
      rescue ActiveRecord::RecordNotFound => e
        access_record = nil
      end
    rescue DropboxOAuth2Flow::BadRequestError => e
      render :text => "Error in OAuth 2 flow Bad request to /dropbox-auth-finish: #{e}</p>"
    rescue DropboxOAuth2Flow::BadStateError => e
      render :text => "Error in OAuth 2 flow Auth session expired: #{e}".html_safe
    rescue DropboxOAuth2Flow::CsrfError => e
      logger.info("/dropbox-auth-finish: CSRF mismatch: #{e}")
      render :text => "Error in OAuth 2 flow <p>CSRF mismatch</p>"
    rescue DropboxOAuth2Flow::NotApprovedError => e
      render :text => "Not Approved? <p>Why not, bro?</p>"
    rescue DropboxOAuth2Flow::ProviderError => e
      render :text => "Error in OAuth 2 flow<br>Error redirect from Dropbox: #{e}"
    rescue DropboxError => e
      logger.info "Error getting OAuth 2 access token: #{e}"
      render :text => "Error in OAuth 2 flow<br><p>Error getting access token</p>"
    end
  end

  def tv_added
    render :text => 'please click ok on tv app'
  end

  private
  def get_web_auth()
    return DropboxOAuth2Flow.new(ENV['dropbox_key'], ENV['dropbox_secret'], url_for(:action => 'callback'), session, :dropbox_auth_csrf_token)
  end

  def shorten_url(token)
    host = request.host
    url = "#{request.protocol}#{host}:#{request.port}/addtv/#{token}"
    if host != 'localhost'
      url = Bitly.client.shorten(url).short_url
    end
    return url
  end
end
