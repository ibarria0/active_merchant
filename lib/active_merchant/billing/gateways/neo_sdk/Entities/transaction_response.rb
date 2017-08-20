require_relative '../Helpers/jso_nable'
class TransactionResponse < JSONable

  def initialize(h = nil)

    if(h != nil)

      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="

        if(TransactionResponse.instance_methods(false).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end

      }

    end

  end

  def ResponseSummary=(responseSummary)
    @responseSummary = responseSummary
  end

  def AuthorizationNumber=(authorizationNumber)
    @authorizationNumber = authorizationNumber
  end

  def ResponseCode=(responseCode)
    @responseCode = responseCode
  end

  def TransactionId=(transactionId)
    @transactionId = transactionId
  end

  def ValidationErrors=(validationErrors) #ValidationError type
    @validationErrors = validationErrors
  end

  def IsSuccess=(isSuccess)
    @isSuccess = isSuccess
  end

  #Getters
  def getIsSuccess
    return @isSuccess
  end

  def getResponseCode
    return @responseCode
  end

  def getResponseSummary
    return @responseSummary
  end

  def getAuthorizationNumber
    return @authorizationNumber
  end

  def getTransactionId
    return @transactionId
  end

  def getValidationErrors
    return @validationErrors
  end

  #private String ResponseSummary;
  #private String AuthorizationNumber;
  #private String ResponseCode;
  #private String TransactionId;
  #private ValidationError ValidationErrors;
  #private boolean IsSuccess;

end