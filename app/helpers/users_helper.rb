module UsersHelper
  def image_for(user)
    if user.image
      #userのプロフィール画像を表示する
      image_tag "/user_images/#{user.image}", class: "profile_img"
    else
      #プロフィール画像が設定されていない場合、Defaule画像を表示する
      image_tag "wanko.png", class: "profile_img"
    end
  end
end
