class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :id, :email, :name, :user_type
end
