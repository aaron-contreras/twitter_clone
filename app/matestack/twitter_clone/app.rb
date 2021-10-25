class TwitterClone::App < Matestack::Ui::App
  def response
    div class: "container" do
      heading size: 1, text: "Twitter Clone", class: "mb-5"
      yield if block_given? 
    end
  end
end