require_relative '../Helpers/jso_nable'
class InstructionResponse < JSONable


  def ValidationErrors=(validationErrors) #ValidationError type
    @validationErrors = validationErrors
  end

  def IsSuccess=(isSuccess)
    @isSuccess = isSuccess
  end

  def ResponseSummary=(responseSummary)
    @responseSummary = responseSummary
  end

  def responseCode=(responseCode)
    @responseCode = responseCode
  end

  def Id=(id)
    @id = id
  end

  def PaymentInstructionToken(paymentInstructionToken)
    @paymentInstructionToken = paymentInstructionToken
  end



  #Getters
  def getValidationErrors
    return @validationErrors
  end

  def getIsSuccess
    return @isSuccess
  end

  def getResponseSummary
    return @responseSummary
  end

  def getResponseCode
    return @responseCode
  end

  def getId
    return @id
  end

  def getPaymentInstructionToken
    return @paymentInstructionToken
  end

  #private ValidationError ValidationErrors;
  #private boolean IsSuccess;
  #private String ResponseSummary;
  #private String ResponseCode;
  #private String Id;
  #private String PaymentInstructionToken;

end