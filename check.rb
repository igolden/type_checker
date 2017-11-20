##
# TypeCheck module
#
#	Include this module in your test class to
#	explicitly check types on the fly.
#
#	The goal of this gem is to minimize your 
#	side effects when making changes across
#	your ruby and/or rails app.
#
# Usage: 
#
# include TypeCheck
#
# def method(a, b)
#   type_check(Float: a, Integer: b)
# end
#
# method(1.1, 2) # passes
# method("a", 2) # TypeCheckError -- a should be of type Float
#
module TypeCheck
  ##
  # type_check(type_hash)
  #
  # Main method to call when checking types.
  #
  def type_check(type_hash)
    type_hash.each_pair do |k,v|
      k = Array if k == :Array || :array
      k = Float if k == :Float || :float
      k = Hash if k == :Hash || :hash
      k = Integer if k == :Integer || :integer
      k = String if k == :String || :string
      if v.class != k
        handle_type_error
      end end
  end
  ##
  # This is a direct pull from ActiveRecord source,
  # since they have solved it with their inflector.
  # This is purely a Rails construct, and not available
  # in plain Ruby, thus I pulled it in.
  #
  # The Ruby method Object.const_get is available
  # for anyone that wants to use that for simple
  # comparisons.
  #
  # Credit to Rails/ActiveRecord Team:
  #
  # https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
  #
  def constantize(camel_cased_word)
    names = camel_cased_word.split("::".freeze)

    # Trigger a built-in NameError exception including the ill-formed constant in the message.
    Object.const_get(camel_cased_word) if names.empty?

    # Remove the first blank element in case of '::ClassName' notation.
    names.shift if names.size > 1 && names.first.empty?

    names.inject(Object) do |constant, name|
      if constant == Object
        constant.const_get(name)
      else
        candidate = constant.const_get(name)
        next candidate if constant.const_defined?(name, false)
        next candidate unless Object.const_defined?(name)

        # Go down the ancestors to check if it is owned directly. The check
        # stops when we reach Object or the end of ancestors tree.
        constant = constant.ancestors.inject(constant) do |const, ancestor|
          break const    if ancestor == Object
          break ancestor if ancestor.const_defined?(name, false)
          const
        end

        # owner is in Object, so raise
        constant.const_get(name, false)
      end
    end
  end
end

