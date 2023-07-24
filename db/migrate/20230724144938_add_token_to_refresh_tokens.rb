class AddTokenToRefreshTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :refresh_tokens, :token, :string
    add_index :refresh_tokens, :token
  end
end
