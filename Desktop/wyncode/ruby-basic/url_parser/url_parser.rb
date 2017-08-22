# url_parser.rb
class UrlParser
  def initialize url_to_parse
    @url = url_to_parse
    @split_on_slash = url_to_parse.split("/")
  end

  def scheme
    @scheme = @url.split("://").[](0)
  end

  def domain
    @domain = @split_on_slash.[](2).split(":").[](0)
  end

  def port
    port = @split_on_slash.[](2).split(":").[](1)
    if port.eql?(nil) 
      if self.scheme == "http"
        @port =  "80" 
      elsif self.scheme == "https"
        @port = "443"
      end
    else
      @port = port
    end
  end

  def path
    path = @split_on_slash.[](3).split("?").[](0)
    @path = path.eql?("") ? nil : path
  end

  def query_string
    @query_string = {}
    query_string = @split_on_slash.[](3).split("?").[](1).split("#").[](0)
    query_string.split("&").each do |i|
      i = i.split("=")
      @query_string["#{i[0]}"] = "#{i[1]}"
    end
    @query_string
  end

  def fragment_id
    @fragment_id = @split_on_slash.[](3).split("#").[](1)
  end
end