class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :user_type
end
