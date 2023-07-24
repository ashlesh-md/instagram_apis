class AddUserIdToRefreshTokens < ActiveRecord::Migration[7.0]
  def change
    add_reference :refresh_tokens, :user, null: false, foreign_key: true
  end
end
