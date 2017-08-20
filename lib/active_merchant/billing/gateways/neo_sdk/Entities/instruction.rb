require_relative '../Helpers/jso_nable'
require_relative '../Entities/instruction_response'
class Instruction < JSONable

  def initialize(h = nil)

    if(h != nil)

      h.each {
        |k,v|

        propNameFormatted = k.to_s + "="

        if(Instruction.instance_methods(false).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end

      }

    end

  end

  def Id=(id)
    @id = id
  end

  def CustomerId=(customerId)
    @customerId = customerId
  end

  def CustomerEntityId=(customerEntityId)
    @customerEntityId = customerEntityId
  end

  def InstrumentToken=(instrumentToken)
    @instrumentToken = instrumentToken
  end

  def Status=(status)
    @status = status
  end

  def ScheduleDay=(scheduleDay)
    @scheduleDay = scheduleDay
  end

  def CustomFields=(customFields) # Hash type
    @customFields = customFields
  end

  def Response=(response) #InstructionResponse type
    @response = response
  end

  def ExpirationDate=(expirationDate)
    @expirationDate = expirationDate
  end

  def AccountToken=(accountToken)
    @accountToken = accountToken
  end

  def CustomerEntityValue=(customerEntityValue)
    @customerEntityValue = customerEntityValue
  end

  def AccountNumber=(accountNumber)
    @accountNumber = accountNumber
  end



  #Getters
  def getId
    return @id
  end

  def getCustomerId
    return @customerId
  end

  def getCustomerEntityId
    return @customerEntityId
  end

  def getInstrumentToken
    return @instrumentToken
  end

  def getStatus
    return @status
  end

  def getScheduleDay
    return @scheduleDay
  end

  def getCustomFields
    return @customFields
  end

  def getResponse
    return @response
  end

  def getExpirationDate
    return @expirationDate
  end

  def getAccountToken
    return @accountToken
  end

  def getCustomerEntityValue
    return @customerEntityValue
  end

  def getAccountNumber
    return @accountNumber
  end

  #private String Id;
  #private String CustomerId;
  #private String CustomerEntityId;
  #private String InstrumentToken;
  #private String Status;
  #private String ScheduleDay;
  #private HashMap CustomFields;
  #private InstructionResponse Response;
  #private String ExpirationDate;
  #private String AccountToken;
  #private String CustomerEntityValue;
  #private String AccountNumber;

end