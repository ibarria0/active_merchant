require_relative '../Helpers/jso_nable'
class Address < JSONable

  def initialize(h = nil)

    if(h != nil)
      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="


        if(Address.instance_methods(false).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end
      }
    end

  end


  def AddressId=(addressId)
    @addressId = addressId
  end

  def AddressLine1=(addressLine1)
    @addressLine1 = addressLine1
  end

  def AddressLine2=(addressLine2)
    @addressLine2 = addressLine2
  end

  def City=(city)
    @city = city
  end

  def CountryName=(countryName)
    @countryName = countryName
  end

  def SubDivision=(subDivision)
    @subDivision = subDivision
  end

  def State=(state)
    @state = state
  end

  def ZipCode=(zipCode)
    @zipCode = zipCode
  end


  #Getters
  def getAddressId
    return @addressId
  end

  def getAddressLine1
    return @addressLine1
  end

  def getAddressLine2
    return @addressLine2
  end

  def getCity
    return @city
  end

  def getCountryName
    return @countryName
  end

  def getSubdivision
    return @subDivision
  end

  def getState
    return @state
  end

  def getZipCode
    return @zipCode
  end

  #private String AddressId;
  #private String AddressLine1;
  #private String AddressLine2;
  #private String City;
  #private String CountryName;
  #private String SubDivision;
  #private String State;
  #private String ZipCode;

end