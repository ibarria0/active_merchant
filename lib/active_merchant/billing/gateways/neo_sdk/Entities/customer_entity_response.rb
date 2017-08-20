require_relative '../Entities/validation_error'
require_relative '../Helpers/jso_nable'
class CustomerEntityResponse < JSONable

  def initialize(h = nil)

    if(h != nil)

      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="

        if(CustomerEntityResponse.instance_methods(false).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end

      }

    end

  end

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

  def accountToken=(accountToken)
    @accountToken = accountToken
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



  #private ValidationError ValidationErrors;
  #private boolean IsSuccess;
  #private String ResponseSummary;
  #private String ResponseCode;
  #private String Id;
  #private String AccountToken;

end