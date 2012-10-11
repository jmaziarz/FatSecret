module FatSecret
  module Relations
    extend ActiveSupport::Concern

    include FatSecret::Relations::HasMany
    include FatSecret::Relations::BelongsTo
  end
end
