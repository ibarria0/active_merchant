#require_relative '../Entities/base_entity'
require_relative '../Helpers/jso_nable'
require_relative '../Entities/credit_card'
require_relative '../Entities/customer_response'
require_relative '../Entities/ach'
require_relative '../Entities/address'
require_relative '../Entities/instruction'
require_relative '../Entities/customer_entity'
require_relative '../Entities/wallet'
class Customer < JSONable #BaseEntity

  def initialize(h = nil)

    if(h != nil)
      #thisCust = Customer.new
      #Customer.public_methods
      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="


        if(Customer.instance_methods(false).include?(propNameFormatted.to_sym))
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

  def UniqueIdentifier=(uniqueIdentifier)
    @uniqueIdentifier = uniqueIdentifier
  end

  def Email=(email)
    @email = email
  end

  def Fax=(fax)
    @fax = fax
  end

  def FirstName=(firstName)
    @firstName = firstName
  end

  def LastName=(lastName)
    @lastName = lastName
  end

  def Phone=(phone)
    @phone = phone
  end

  def Website=(website)
    @website = website
  end

  def Company=(company)
    @company=company
  end

  def Created=(created)
    @created = created
  end

  def Updated=(updated)
    @updated = updated
  end

  def Username=(username)
    @username = username
  end

  def CreditCards=(creditCards) #List<CreditCard>
    @creditCards = creditCards
  end

  def CustomFields=(customFields) #Hash type
    @customFields = customFields
  end

  def ResponseDetails=(responseDetails) #CustomerResponse type
    @responseDetails = responseDetails
  end

  def Options=(options) #CustomerResponse type
    @options = options
  end

  def BillingAddress=(billingAddress) #List<Address> type
    @billingAddress = billingAddress
  end

  def ShippingAddress=(shippingAddress) #List<Address> type
    @shippingAddress = shippingAddress
  end

  def ACHs=(aCHs) #List<ACH> type
    @aCHs = aCHs
  end

  def CustomerEntities=(customerEntities) #List<CustomerEntity> type
    @customerEntities = customerEntities
  end

  def Wallet=(wallet)
    @wallet = wallet
  end

  def PaymentInstructions=(paymentInstructions) #List<Instruction> type
    @paymentInstructions = paymentInstructions
  end

  #getters
  def getUniqueIdentifier
    return @uniqueIdentifier
  end

  def getCustomerId
    return @customerId
  end

  def getFirstName
    return @firstName
  end

  def getLastName
    return @lastName
  end

  def getUsername
    return @username
  end

  def getCompany
    return @company
  end

  def getWebsite
    return @website
  end

  def getPhone
    return @phone
  end

  def getCustomFields
    return @customFields
  end

  def getCustomerEntities
    return @customerEntities
  end

  def getCreditCards
    return @creditCards
  end

  def getBillingAddress
    return @billingAddress
  end

  def getShippingAddress
    return @shippingAddress
  end

  def getPaymentInstructions
    return @paymentInstructions
  end

  def getACHs
    return @aCHs
  end

  def getWallet
    return @wallet
  end

  def getResponseDetails
    return @responseDetails
  end

  #private String UniqueIdentifier;
  #private String Email;
  #private String Fax;
  #private String FirstName;
  #private String LastName;
  #private String Phone;
  #private String Website;
  #private String Company;#
  #private String Created;
  #private String Updated;
  #private List<CreditCard> CreditCards;
  #private HashMap CustomFields;
  #private CustomerResponse ResponseDetails;
  #private CustomerResponse Options;
  #private List<Address> BillingAddress;
  #private List<Address> ShippingAddress;
  #private List<ACH> ACHs;
  #private List<CustomerEntity> CustomerEntities;
  #private Wallet Wallet;
  #private List<Instruction> PaymentInstructions;
  #private String Username;#

end