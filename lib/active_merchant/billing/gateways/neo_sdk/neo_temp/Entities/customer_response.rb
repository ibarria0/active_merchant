require_relative '../Helpers/jso_nable'
require_relative '../Entities/validation_error'
class CustomerResponse < JSONable

  def initialize(h = nil)

    if(h != nil)

      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="

        if(CustomerResponse.instance_methods(false).include?(propNameFormatted.to_sym))
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

  def ResponseCode=(responseCode)
    @responseCode = responseCode
  end

  def CustomerId=(customerId)
    @customerId = customerId
  end

  def CustomerToken=(customerToken)
    @customerToken = customerToken
  end

  def UniqueIdentification=(uniqueIdentification)
    @uniqueIdentification = uniqueIdentification
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

  def getCustomerId
    return @customerId
  end

  def getCustomerToken
    return @customerToken
  end

  def getUniqueIdentification
    return @uniqueIdentification
  end

  #private ValidationError ValidationErrors;
  #private boolean IsSuccess;
  #private String ResponseSummary;
  #private String ResponseCode;
  #private String CustomerId;
  #private String CustomerToken;
  #private String UniqueIdentification;#

end