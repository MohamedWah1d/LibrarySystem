class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :user_type, :email_verified_at, :created_at, :updated_at
end
