class JSONable
  def to_json
    hash = {}
    self.instance_variables.each do |var|
      hash[var] = self.instance_variable_get var
    end

    hash.keys.each do |k|
      if(k[0,1] == '@')
        #k[1] = k[1].upcase
        tempUp = k[1].upcase
        hash[tempUp + k[2, k.length - 1]] = hash[k]
        hash.delete(k)
        #puts k[0]

      end
    end

    hash.to_json
  end

  def to_h
    instance_variables.map do |iv|
        value = instance_variable_get(:"#{iv}")
    [
        iv.to_s[1..-1], # name without leading `@`
        case value
          when JSONable then value.to_h # Base instance? convert deeply
          when Array # Array? convert elements
            value.map do |e|
              e.respond_to?(:to_h) ? e.to_h : e
            end
          else value # seems to be non-convertable, put as is
        end
    ]
  end.to_h
end



  def from_json! string
    JSON.load(string).each do |var, val|

      #need to replace first letter with '@' + <firstletter>

      fChar = "@" + var[0].downcase
      varTrim = var[1..-1]
      var = fChar + varTrim
      #puts 'VARR: ' + var + '\n'
      #puts val

      self.instance_variable_set var, val

    end
  end
end