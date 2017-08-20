require_relative '../Helpers/jso_nable'
class TransactionOptions < JSONable

  def initialize(h = nil)

    if(h != nil)

      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="

        if(TransactionOptions.instance_methods(false).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end

      }

    end

  end

  def GenerateToken=(generateToken) #bool type
    @generateToken = generateToken
  end

  def GenerateTokenOnSuccess=(generateTokenOnSuccess) #bool type
    @generateTokenOnSuccess = generateTokenOnSuccess
  end

  def AddShippingAddressForCustomer=(addShippingAddressForCustomer) #bool type
    @addShippingAddressForCustomer = addShippingAddressForCustomer
  end

  def UseDefaultCustomerPaymentMethod=(useDefaultCustomerPaymentMethod) #bool type
    @useDefaultCustomerPaymentMethod = useDefaultCustomerPaymentMethod
  end

  def Operation=(operation)
    @operation = operation
  end

  #private boolean GenerateToken;
  #private boolean GenerateTokenOnSuccess;
  #private boolean AddShippingAddressForCustomer;
  #private boolean UseDefaultCustomerPaymentMethod;
  #private String Operation;

end