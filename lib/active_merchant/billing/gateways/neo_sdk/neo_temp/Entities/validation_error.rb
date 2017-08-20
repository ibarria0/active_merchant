require_relative '../Helpers/jso_nable'
class ValidationError < JSONable

  #private int Count;
  #private String ErrorSummary;
  #private String ErrorDescription;
  #private List<ValidationError> ErrorDetails;

  def initialize(h = nil)

    if(h != nil)
      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="


        if(ValidationError.instance_methods(false).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end
      }
    end

  end

  def Count=(count)
    @count = count
  end

  def ErrorSummary=(errorSummary)
    @errorSummary = errorSummary
  end

  def ErrorDescription=(errorDescription)
    @errorDescription = errorDescription
  end

  def ErrorDetails=(errorDetails) #list<ValidationError>
    @errorDetails = errorDetails
  end


  #Getters
  def getCount
    return @count
  end

  def getErrorSummary
    return @errorSummary
  end

  def getErrorDescription
    return @errorDescription
  end

  def getErrorDetails
    return @errorDetails
  end

end