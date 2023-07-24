class Api::V1::CustomAuthTokenController < ApplicationController
    private

    def jwt_token(payload)
      exp_time = 1.day.from_now.to_i
      Knock::AuthToken.new(payload: payload, exp: exp_time).token
    end
  
end
