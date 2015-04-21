module RequestHelpers
  def parse_json(body)
    JSON.parse(body, symbolize_names: true)
  end

  def mime_json
    { 'Accept' => Mime::JSON.to_s, 'Content-Type' => Mime::JSON.to_s }
  end

  def authorization_header(token)
    header = mime_json
    header['Authorization'] = token
    header
  end
end
