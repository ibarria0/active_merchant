require_relative '../Catalogs/environment_type'
require 'yaml'
class MetropagoGateway

  def initialize(envrionment, merchantId, terminalId, secretKey)  # terminalId, publicKey, privateKey, culture)
    @envrionment = envrionment
    @merchantId = merchantId
    @terminalId = terminalId
    @publicKey = secretKey
    @privateKey = ""
    @sdkVersion = "1.0"
    #@culture = "en"

    #set gateway API url
    if(envrionment == EnvironmentType::SANDBOX.to_str)
      @gatewayURL = "https://gateway.merchantprocess.net/api/test-v3/api/"
    else if(envrionment == EnvironmentType::PRODUCTION.to_str)
      @gatewayURL = "https://gateway.merchantprocess.net/api/prod-v1.0/api/"

    else
      raise "Invalid Enviroment"
     end

    end
    #Logs enabled?
     @enableLogs = true
  end

  def GatewayURL=(gatewayURL)
    @gatewayURL = gatewayURL
  end

  def EnableLogs=(enableLogs)
    @enableLogs = enableLogs
  end

  def Culture=(culture)
    @culture = culture
  end



end
