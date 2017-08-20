require_relative '../Helpers/jso_nable'
class CustomerSearch < JSONable

  def CustomerId=(customerId)
    @customerId = customerId
  end

  def UniqueIdentifier=(uniqueIdentifier)
    @uniqueIdentifier = uniqueIdentifier
  end

  def CardToken=(cardToken)
    @cardToken = cardToken
  end

  def Merchant=(merchant)
    @merchant = merchant
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
    @company = company
  end

  def CardNumber=(cardNumber)
    @cardNumber = cardNumber
  end

  def CardHolderName=(cardHolderName)
    @cardHolderName = cardHolderName
  end

  def DateCreated=(dateCreated) #DateRangeFilter type
    @dateCreated = dateCreated
  end

  def SearchOption=(searchOption)
    @searchOption = searchOption
  end

  #private String CustomerId;
  #private String UniqueIdentifier;
  #private String CardToken;
  #private String Merchant;
  #private TextFilter Email;
  #private TextFilter Fax;
  #private TextFilter FirstName;
  #private TextFilter LastName;
  #private TextFilter Phone;
  #private TextFilter Website;
  #private TextFilter Company;
  #private TextFilter CardNumber;
  #private TextFilter CardHolderName;
  #private DateRangeFilter DateCreated;
  #private CustomerSearchOption SearchOption;

end