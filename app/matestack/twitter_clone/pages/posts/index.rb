class TwitterClone::Pages::Posts::Index < Matestack::Ui::Page
  def prepare
    @posts = Post.all
  end

  def response
    post_form_partial
    post_list_partial
  end

  private
  
  def post_form_partial
    div class: "mb-3 p-3 rounded shadow-sm" do
      heading size: 4, text: "New Post", class: "mb-3"
      matestack_form form_config_helper do
        div class: "mb-3" do
          form_input key: :username, type: :text, placeholder: "Username", class: "form-control"
        end

        div class: "mb-3" do
          form_textarea key: :body, placeholder: "What's up?", class: "form-control"
        end

        div class: "mb-3" do
          button 'submit', type: :submit, class: "btn btn-primary", text: "Post!"
        end
      end
      toggle show_on: "submitted", hide_after: 5000 do
        div class: "container fixed-bottom w-100 bg-success text-white p-3 rounded-top" do
          heading size: 4, text: "Success: {{ event.data.message }}"
        end
      end
      toggle show_on: "form_failed", hide_after: 5000 do
        div class: "container fixed-bottom w-100 bg-danger text-white p-3 rounded-top" do
          heading size: 4, text: "Error: {{ event.data.message }}"
        end
      end
    end
  end

  def form_config_helper
    {
      for: Post.new,
      path: posts_path,
      method: :post,
      errors: {
        wrapper: { tag: :div, class: 'invalid-feedback' },
        input: { class: 'is-invalid' }
      },
      success: { emit: "submitted" },
      failure: { emit: "form_failed" }
    }
  end

  def post_list_partial
    async rerender_on: "submitted", id: "post-list" do
      @posts.each do |post|
        post_partial(post)
      end
    end
  end

  def post_partial(post)
    async rerender_on: "liked_post_#{post.id}", id: "post-#{post.id}" do
      div class: "mb-3 p-3 rounded shadow-sm" do
        heading size: 5 do
          plain post.username
          small text: post.created_at.strftime("%d.%m.%Y %H:%M") 
        end

        paragraph text: post.body
        action path: like_post_path(post), method: :put, success: { emit: "liked_post_#{post.id}" } do
          button class: "btn btn-light" do
            plain "Like (#{post.likes_count})"
          end
        end
      end
    end
  end
end
