class TwitterClone::Pages::Posts::Index < Matestack::Ui::Page
  def prepare
    @posts = Post.all
  end

  def response
    @posts.each do |post|
      div class: "mb-3 p-3 rounded shadow-sm" do
        heading size: 5 do
          plain post.username
          small text: post.created_at.strftime("%d.%m.%Y %H:%M") 
        end

        paragraph text: post.body
      end
    end
  end
end