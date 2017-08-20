require_relative '../Entities/validation_error'
class InstrumentResponse

  def initialize(h = nil)

    if(h != nil)
      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="

        #passing true because we also need to check if property exists in parent class.
        if(InstrumentResponse.instance_methods(true).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end
      }
    end

  end

  def Id=(id)
    @id = id
  end

  def ResponseCode=(responseCode)
    @responseCode = responseCode
  end

  def ResponseSummary=(responseSummary)
    @responseSummary = responseSummary
  end

  def IsSuccess=(isSuccess)
    @isSuccess = isSuccess
  end

  def ValidationErrors=(validationErrors) #ValidationError type
    @validationErrors = validationErrors
  end


  #Getters
  def getId
    return @id
  end

  def getResponseCode
    return @responseCode
  end

  def getResponseSummary
    return @responseSummary
  end

  def getIsSuccess
    return @isSuccess
  end

  def getValidationErrors
    return @validationErrors
  end

end


#private ValidationError ValidationErrors;
#private String ResponseSummary;
#private String ResponseCode;
#private String Id;
#private boolean IsSuccess ;#