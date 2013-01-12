module HomeHelper
  def parse_resource_path(href)
    path = '/' + href.split('/v1/')[1]
  end
end
