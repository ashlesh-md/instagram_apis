class AddExpiresAtToRefreshTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :refresh_tokens, :expires_at, :datetime
  end
end
