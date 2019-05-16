def set_omniauth(provider)

  OmniAuth.config.test_mode = true

  if provider == "facebook"
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid => '123545',
      :extra => {
        :raw_info => {
          :name => 'Muhammad Zeeshan'
        }
      },
      :info => {
        :email => "foobar@example.com",
        :password => 'password123',
        :first_name => 'Muhammad',
        :last_name => 'Zeeshan',
        :gender => 'Male'
      }
    })
  elsif provider == "google_oauth2"
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '123545',
      :extra => {
        :raw_info => {
          :name => 'Muhammad Zeeshan'
        }
      },
      :info => {
        :name => "Muhammad Zeeshan",
        :email => "foobar@example.com",
        :first_name => 'Muhammad',
        :last_name => 'Zeeshan',
        :gender => 'Male'
      }
    })
  else
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      :provider => 'linkedin',
      :uid => '123545',
      :extra => {
        :raw_info => {
          :name => 'Muhammad Zeeshan'
        }
      },
      :info => {
        :name => "Muhammad Zeeshan",
        :email => "foobar@example.com",
        :first_name => 'Muhammad',
        :last_name => 'Zeeshan',
        :gender => 'Male'
      }
    })
  end

end

def set_invalid_omniauth(provider)

  credentials = { :provider => :facebook,
                  :invalid  => :invalid_crendentials
                 }.merge(provider)

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

end