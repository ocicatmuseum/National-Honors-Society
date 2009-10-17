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
  g.set_bg_color '#FFFFFF'
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
def bar_sketch
  bar = BarSketch.new(55,6,'#d070ac', '#000000')
  bar.key('2006', 10)

  10.times do |t|
          bar.data << rand(7) + 2
  end

  g = Graph.new
  g.title("Sketch Bar", '{font-size:20px; color: #ffffff; margin:10px; background-color: #d070ac; padding: 5px 15px 5px 15px;}' )
  g.set_bg_color('#fdfdfd')
  g.data_sets << bar

  g.set_x_axis_color('#e0e0e0', '#e0e0e0')
  g.set_x_tick_size(9)
  g.set_y_axis_color('#e0e0e0', '#e0e0e0')
  g.set_x_labels(%w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct))
  g.set_x_label_style(11,'#303030')
  g.set_y_label_style(11,'#303030')
  g.set_y_max(10)
  g.set_y_label_steps(5)
  render :text => g.render
end
end