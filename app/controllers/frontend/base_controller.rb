class Frontend::BaseController < FrontendController

  def index
    @graph = open_flash_chart_object(600,300, '/frontend/base/extra_tt', true, '/')
  end
  
  def extra_tt
  data_1 = LineHollow.new(2,5,'#990000')
  data_1.key('Required Hours', 10)

  data_2 = LineHollow.new(2,5,'#000099')
  data_2.key("Current Hours",10)
  last1 = 0
  last2 = 0
  (0..5).each do |i|
    value1 = rand(5) + 14
    value2 = rand(5) + 8
    data_1.add_data_tip(value1, value1 - last1)
    data_2.add_data_tip(value2,  value2 - last2)
    last1 = value1
    last2 = value2
  end
  
  g = Graph.new
  g.title("Your Hours", "{font-size: 20px; color: #736AFF}")
  g.data_sets << data_1
  g.data_sets << data_2

  g.set_tool_tip('#x_label# [#val#]<br>#tip#')
  g.set_x_labels(%w(10/4 10/11 10/18 10/25 11/1 11/8))
  g.set_x_label_style(10, '#000000', 0, 1)

  g.set_y_max(20)
  g.set_y_label_steps(4)
  g.set_y_legend("Hours", 12, "#736AFF")
  
  render :text => g.render
end

end