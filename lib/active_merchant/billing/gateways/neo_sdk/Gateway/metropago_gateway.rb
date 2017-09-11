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
      #@gatewayURL = "http://localhost:15927/api/"

      #TLS Enabled server
      #@gatewayURL = "https://gateway12.merchantprocess.net/sdk/api/"


    else if(envrionment == EnvironmentType::PRODUCTION.to_str)
      @gatewayURL = "https://gateway12.merchantprocess.net/sdk/api/"
    else
      raise "Invalid Enviroment"
     end

    end

    #Logs enabled?
    #env = 'development'
    #config = YAML::load(File.open('Config/application.yml'))[env]
  # if(config["enable_logs"] != nil && config["enable_logs"] == true)
    # @enableLogs = true
   #else
     #@enableLogs = false
   #end

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
