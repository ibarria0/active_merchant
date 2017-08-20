require 'json'
require 'net/http'
require 'openssl'
require 'uri'
require_relative '../Entities/request_model'
require_relative '../Entities/response_model'
class APIHelper

  def SendAPIRequest(requestData, requestURL)
    #response = RestClient.get requestURL, {:params => {:id => 50, 'foo' => 'bar'}}
    #RestClient.post()

    begin

      #check if logs enabled
      if(requestData.getEnableLogs == true)
        @logsEnabled = true
      else
        @logsEnabled = false
      end

      #puts requestData.instance_variable_get("@requestMessage").to_json
      reqJson = requestData.to_json

      if(@logsEnabled == true)
        LogAPIDetails("URL", requestURL.to_s)
        LogAPIDetails("REQ", reqJson)
      end

      uri = URI(requestURL)


      http = Net::HTTP.new(uri.host, uri.port)

      if(requestURL.include?("https:"))

        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER

        #gems/certified-1.0.0/certs/ca-bundle.crt"
        http.ca_file = File.expand_path("../../", __FILE__) + "/Certificates/ca-bundle.crt"

        #http.ssl_version =  :TLSv1_2 #TLSv1_1
        http.ssl_version =  :SSLv23
        #:SSLv23 has fallback feature
      end

      req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})
      req.body = reqJson #{param1: 'some value', param2: 'some other value'}.to_json
      #puts req.body

      #res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      #  http.request(req)
      #end

      res = http.request(req)

      #puts res.body
      responseModel = ResponseModel.new
      responseModel.from_json!(res.body) #will require same deserialization ResponseMessage prop, in corresponding manager/method


      if(@logsEnabled == true)
        LogAPIDetails("RES", responseModel.to_json)
      end

      return responseModel

    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
        Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      puts e.http_body

    end


  end

  def LogsEnabled=(logsEnabled)
    @logsEnabled = logsEnabled
  end

  #Private Methods
  private
  def LogAPIDetails(type, content)

    timeStamp = Time.now.strftime("%d/%m/%Y %H:%M")
    logLine = timeStamp.to_s + ": " + type.to_s + ": " + content.to_s

    out_file = File.new("request_logs.txt", "a")
    out_file.puts(logLine)

    out_file.close

  end

end