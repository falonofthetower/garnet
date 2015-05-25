module ApplicationHelper
  def fix_url(string)
    string.starts_with?("http://") ? string : "http://#{string}"
  end
end
