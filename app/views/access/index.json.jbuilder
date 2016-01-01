json.array!(@access) do |access|
  json.extract! access, :id, :tv_token, :dropbox_access_token
  json.url access_url(access, format: :json)
end
