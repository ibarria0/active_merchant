require_relative '../Helpers/jso_nable'
require_relative '../Entities/instrument_response'
class Instrument < JSONable
  def CustomerId=(customerId)
    @customerId = customerId
  end

  def FriendlyName=(friendlyName)
    @friendlyName = friendlyName
  end

  def Status=(status)
    @status = status
  end

  def Token=(token)
    @token = token
  end

  def IssuerBank=(issuerBank)
    @issuerBank = issuerBank
  end

  def CustomerIdentifier=(customerIdentifier)
    @customerIdentifier = customerIdentifier
  end

  def ResponseDetails=(responseDetails) #InstrumentResponse type
    @responseDetails = responseDetails
  end


  #Getters
  def getCustomerId
    return @customerId
  end

  def getFriendlyName
    return @friendlyName
  end

  def getStatus
    return @status
  end

  def getToken
    return @token
  end

  def getIssuerBank
    return @issuerBank
  end

  def getCustomerIdentifier
    return @customerIdentifier
  end

  def getResponseDetails
    return @responseDetails
  end

  #protected String Token;
  #private String IssuerBank;
  #private String CustomerIdentifier;
  #private InstrumentResponse ResponseDetails;

end