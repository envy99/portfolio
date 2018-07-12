module FlashHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "is-info"
    when :alert then "is-danger"
    else ""
    end
  end
end
