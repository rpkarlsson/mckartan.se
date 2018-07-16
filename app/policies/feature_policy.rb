class FeaturePolicy
  def self.destroy?(feature, user)
    return false unless feature and user
    is_creator?(feature, user) or is_admin?(user)
  end

  private_class_method def self.is_creator?(feature, user)
    user.id == feature.user.id
  end

  private_class_method def self.is_admin? user
    user.id == 1
  end
end
