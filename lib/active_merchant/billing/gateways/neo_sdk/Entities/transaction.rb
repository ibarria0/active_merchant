require_relative '../Helpers/jso_nable'
class Transaction < JSONable

  def initialize(h = nil)
    if(h != nil)

      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="

        if(Transaction.instance_methods(false).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end

      }

    end

  end

  def CreditCardDetail=(creditCardDetail) #CreditCard type
    @creditCardDetail = creditCardDetail
  end

  def PaymentMethodToken=(paymentMethodToken)
    @paymentMethodToken = paymentMethodToken
  end

  def BillingAddressId=(billingAddressId)
    @billingAddressId = billingAddressId
  end

  def TerminalId=(terminalId)
    @terminalId = terminalId
  end

  def OrderTrackingNumber=(orderTrackingNumber)
    @orderTrackingNumber = orderTrackingNumber
  end

  def CustomerId=(customerId)
    @customerId = customerId
  end

  def OrderId=(orderId)
    @orderId = orderId
  end

  def ShippingAddressId=(shippingAddressId)
    @shippingAddressId = shippingAddressId
  end

  def TransactionId=(transactionId)
    @transactionId = transactionId
  end

  def Amount=(amount) #double type
    @amount = amount
  end

  def BillingAddress=(billingAddress) #Address Type
    @billingAddress = billingAddress
  end

  def ShippingAddress=(shippingAddress)
    @shippingAddress = shippingAddress
  end

  def CustomFields=(customFields) #Hash type
    @customFields = customFields
  end

  def CustomerData=(customerData) #Customer Type
    @customerData = customerData
  end

  def TransactOptions=(transactOptions) #TransactionOptions type
    @transactOptions = transactOptions
  end

  def ResponseDetails=(responseDetails) #TransactionResponse type
    @responseDetails = responseDetails
  end

  def CustomerEntityDetail=(customerEntityDetail) #CustomerEntity Type
    @customerEntityDetail = customerEntityDetail
  end

  def ThirdPartyDescription=(thirdPartyDescription)
    @thirdPartyDescription = thirdPartyDescription
  end

  def ThirdPartyStatus=(thirdPartyStatus)
    @thirdPartyStatus = thirdPartyStatus
  end

  def success?
    (getResponseDetails != nil and getResponseDetails.getIsSuccess == true)
  end

  #Getters

  def getResponseDetails
    return @responseDetails
  end

  def getTransactionId
    return @transactionId
  end

  def getCustomerId
    return @customerId
  end

  def getCustomerEntityDetail
    return @customerEntityDetail
  end

  def getBillingAddress
    return @billingAddress
  end

  def getShippingAddress
    return @shippingAddress
  end

  def getCustomerData
    return @customerData
  end

  def getAmount
    return @amount
  end

  def getOrderId
    return @orderId
  end

  def getCreditCardDetail
    return @creditCardDetail
  end

  #private CreditCard CreditCardDetail;
  #private String PaymentMethodToken;
  #private String BillingAddressId;
  #private String TerminalId;
  #private String OrderTrackingNumber;
  #private String CustomerId;
  #private String OrderId;
  #private String ShippingAddressId;
  #private String TransactionId;
  #private double Amount;
  #private Address BillingAddress;
  #private Address ShippingAddress;
  #private HashMap CustomFields;
  #private Customer CustomerData;
  #private TransactionOptions TransactOptions;
  #private TransactionResponse ResponseDetails;
  #private CustomerEntity CustomerEntityDetail;
  #private String ThirdPartyDescription;
  #private String ThirdPartyStatus;

end
