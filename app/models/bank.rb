require 'account'

module Bank
  class Actions
    # concerning the action for deposit of money
    def deposit id_source, id_destination, value
      source      ||= Account.where("id = #{id_source}")
      destination ||= Account.where("id = #{id_destination}")
      
      result = Array.new

      # responsible for verifying that users exist.
      if source.blank? or destination.blank?
        result << 401

        return result << { 
          message: 'User not found',
          date: Time.now.to_s
        }
      end

      if less_than(value, 0)
        result << 401

        return result << { 
          message: 'Value can not be less than zero',
          status_code: 401,
          date: Time.now.to_s
        }
      end

      # In case fail
      data_result = { 
        message: 'Insufficient balance to carry out the operation.',
        status_code: 401,
        date: Time.now.to_s
      }

      if value.to_f < source[0].balance.to_f
        
        valor ||= destination[0].balance.to_f + value.to_f
        destination[0].update({balance: valor.to_f})

        source[0].update(balance: source[0].balance.to_f - value.to_f )

        data_result = {
          message: 'Action successfully!',
          origin: source[0].user_name,
          destination: destination[0].user_name,
          value: value,
          status_code: 200,
          date: Time.now.to_s
        }
      end

      result << 200
      result << data_result

      return result
    end

    # referring to the action to return the bank balance
    def balance account_id
      result = Array.new

      source ||= Account.where("id = #{account_id}")

      # responsible for verifying that users exist.
      if source.blank?
        result << 401
        return result << { 
          message: 'User not found',
          date: Time.now.to_s
        }
      end

      value ||= format("%.2f", source[0].balance.to_f)

      result << 200
      return result << {
        owner: source[0].user_name,
        balance: value.to_s.gsub('.', ','),
      }
    end

    # Responsible for verifying that a given value is less than the reference
    def less_than(value, references)
      return value.to_f < references.to_f
    end
  end
end