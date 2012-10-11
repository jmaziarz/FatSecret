module FatSecret
  class Base
    include ActiveAttr::Attributes
    include ActiveAttr::MassAssignment
    include ActiveAttr::TypecastedAttributes
    include FatSecret::Relations

    attribute :id, type: Integer
  end
end
