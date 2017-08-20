require_relative '../Helpers/jso_nable'
require_relative '../Entities/beneficiary'
require_relative '../Entities/customer_entity_response'
class CustomerEntity < JSONable

  def initialize(h = nil)

    if(h != nil)
      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="


        if(CustomerEntity.instance_methods(false).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end
      }
    end

  end

  def CustomerId=(customerId)
    @customerId = customerId
  end

  def FriendlyName=(friendlyName)
    @friendlyName = friendlyName
  end

  def Status=(status)
    @status = status
  end

  def Id=(id)
    @id = id
  end

  def AccountNumber=(accountNumber)
    @accountNumber = accountNumber
  end

  def ServiceType=(serviceType)
    @serviceType = serviceType
  end

  def ServiceTypeName=(serviceTypeName)
    @serviceTypeName = serviceTypeName
  end

  def CustomFields=(customFields) #Hash type
    @customFields = customFields
  end

  def PrimaryReferenceEntityValue=(primaryReferenceEntityValue)
    @primaryReferenceEntityValue = primaryReferenceEntityValue
  end

  def EntityBeneficiary=(entityBeneficiary) #Beneficiary type
    @entityBeneficiary = entityBeneficiary
  end

  def ResponseDetails=(responseDetails) #CustomerEntityResponse type
    @responseDetails = responseDetails
  end

  def AccountToken=(accountToken)
    @accountToken = accountToken
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

  def getId
    return @id
  end

  def getAccountNumber
    return @accountNumber
  end

  def getServiceType
    return @serviceType
  end

  def getServiceTypeName
    return @serviceTypeName
  end

  def getCustomFields
    return @customFields
  end

  def getPrimaryReferenceEntityValue
    return @primaryReferenceEntityValue
  end

  def getEntityBeneficiary
    return @entityBeneficiary
  end

  def getResponseDetails
    return @responseDetails
  end

  def getAccountToken
    return @accountToken
  end

  #private String Id;
  #private String AccountNumber;
  #private String ServiceType;
  #private String ServiceTypeName;
  #private HashMap CustomFields;
  #private String PrimaryReferenceEntityValue;
  #private Beneficiary EntityBeneficiary;
  #private CustomerEntityResponse ResponseDetails;
  #private String AccountToken;

end