require_relative '../Entities/instrument'
require_relative '../Entities/address'
class CreditCard < Instrument

  def initialize(h = nil)

    if(h != nil)
      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="

        #set true because parent props are used
        if(CreditCard.instance_methods(true).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end
      }
    end

  end

  def Token=(token)
    @token = token
  end

  def IssuerBank=(issuerBank)
    @issuerBank = issuerBank
  end

  def CardholderName=(cardholderName)
    @cardholderName = cardholderName
  end

  def CustomerIdentifier=(customerIdentifier)
    @customerIdentifier = customerIdentifier
  end


  def Number=(number)
    @number = number
  end

  def CVV=(cVV)
    @cVV = cVV
  end

  def ExpirationDate=(expirationDate)
    @expirationDate = expirationDate
  end

  #def ExpirationMonth=(expirationMonth)
   # @expirationMonth = expirationMonth
  #end

  #def ExpirationYear=(expirationYear)
   # @expirationYear = expirationYear
  #end

  def CardType=(cardType)
    @cardType = cardType
  end

  def IsVerified=(isVerified)
    @isVerified = isVerified
  end

  def CreatedDate=(createdDate)
    @createdDate = createdDate
  end

  def Address=(address) #Address type
    @address = address
  end

  def CustomFields=(customFields) #h = Hash.new (Hash type)
    @customFields = customFields
  end

  #Format: MMYY
  def SetExpiration(month, year)
    if(year.length > 2)
      self.ExpirationDate = month + year[2..-1]
    else
      self.ExpirationDate = month + year
    end
  end

  #Getters
  def getAddress
    return @address
  end

  def getToken
    return @token
  end

  def getCustomFields
    return @customFields
  end

  def getCardHolder
    return @cardholderName
  end

  def getNumber
    return @number
  end

  def getCVV
    return @cVV
  end

  def getExpirationDate
    return @expirationDate
  end

  def getCardType
    return @cardType
  end

  def getIssuerBank
    return @issuerBank
  end

  def getCustomerIdentifier
    return @customerIdentifier
  end

  def getIsVerified
    return @isVerified
  end

  def getCreatedDate
    return @createdDate
  end

  #private String CardholderName;
  #private String Number;
  #private String CVV;
  #private String ExpirationDate;
  #private String ExpirationMonth;
  #private String ExpirationYear;
  #private String CardType;
  #private boolean IsVerified;
  #private String CreatedDate;
  #private Address Address;
  #private HashMap CustomFields;#


end