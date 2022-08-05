# frozen_string_literal: true

class PixKey
  attr_accessor(:key, :value, :type)
  alias :key :value

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  PHONE_REGEX = /^(\+\d{11})$/
  CPF_REGEX = /^(\d{11})$/
  CNPJ_REGEX = /^(\d{14})$/
  EVP_REGEX = /^([0-9a-f]{8})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{12})$/

  def initialize (value)
    if value.instance_of?(String)
      @value = value.strip.freeze
    else
      @value = "".freeze
    end
  end

  def to_s
    return @value
  end

  def phone?
    key =~ PHONE_REGEX ? true : false
  end

  def email?
    key =~ EMAIL_REGEX ? true : false
  end

  def cpf?
    key =~ CPF_REGEX ? true : false
  end

  def cnpj?
    key =~ CNPJ_REGEX ? true : false
  end

  def evp?
    key =~ EVP_REGEX ? true : false
  end
  
  def type
    if (phone?)
      @type = "phone"
    end

    if (email?)
      @type = "email"
    end

    if (cpf?)
      @type = "cpf"
    end

    if (cnpj?)
      @type = "cnpj"
    end

    if (evp?)
      @type = "evp"
    end

    return @type
  end

  def valid?
    phone? || email? || cpf? || cnpj? || evp?
  end

  def invalid?
    !valid?
  end

  def ==(other)
    (self.class == other.class) and
    (self.value == other.value)
  end
end
