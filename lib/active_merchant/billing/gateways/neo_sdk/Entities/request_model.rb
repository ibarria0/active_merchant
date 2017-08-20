require_relative '../Helpers/jso_nable'
class RequestModel < JSONable

  def Identification=(identification)
    @identification = identification
  end

  def DateTimeStamp=(dateTimeStamp)
    @dateTimeStamp = dateTimeStamp
  end

  def SDKVersion=(sDKVersion)
    @sDKVersion = sDKVersion
  end

  def RequestMessage=(requestMessage)
    @requestMessage = requestMessage
  end

  def TerminalId=(terminalId)
    @terminalId = terminalId
  end

  def BeneficiaryEnabledMerchant=(beneficiaryEnabledMerchant)
    @beneficiaryEnabledMerchant = beneficiaryEnabledMerchant
  end

  def Culture=(culture)
    @culture = culture
  end

  def MerchantId=(merchantId)
    @merchantId = merchantId
  end

  def EnableLogs=(enableLogs)
    @enableLogs = enableLogs
  end


  #Getters
  def getIdentification
    return @identification
  end

  def getDateTimeStamp
    return @dateTimeStamp
  end

  def getSDKVersion
    return @sDKVersion
  end

  def getRequestMessage
    return @requestMessage
  end

  def getTerminalId
    return @terminalId
  end

  def getBeneficiaryEnabledMerchant
    return @beneficiaryEnabledMerchant
  end

  def getCulture
    return @culture
  end

  def getMerchantId
    return @merchantId
  end

  def getEnableLogs
    return @enableLogs
  end



end