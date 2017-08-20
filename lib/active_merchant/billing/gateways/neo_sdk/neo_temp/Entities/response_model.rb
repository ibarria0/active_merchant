require_relative '../Helpers/jso_nable'
class ResponseModel < JSONable

  def APIVersion=(aPIVersion)
    @aPIVersion = aPIVersion
  end

  def ResponseMessage=(responseMessage)
    @responseMessage = responseMessage
  end

  def Identification=(identification)
    @identification = identification
  end

  def Errors=(errors)
    @errors = errors
  end


  #Getters

  def getAPIVersion
    return @aPIVersion
  end

  def getResponseMessage
    return @responseMessage
  end

  def getIdentification
    return @identification
  end

  def getErrors
    return @errors
  end

end