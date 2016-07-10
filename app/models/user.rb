class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  has_many :notes
  has_many :likes


  # 後の演習にてdeviseでnameを登録できるようにするまで、一時的にnameのバリデーションをコメントアウトしています
  # validates :name, presence: true
  # deviseのvalidatableによって以下と同じバリデーションが設定されるのでコメントアウトしています
  # validates :email, presence: true, uniqueness: true

  def set_image(file)
    if !file.nil?
      file_name = file.original_filename
      File.open("public/user_images/#{file_name}", 'wb'){|f| f.write(file.read)}
      self.image = file_name
    end
  end

end
