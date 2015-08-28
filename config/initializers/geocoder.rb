Geocoder.configure(
 :timeout => 15,
 :always_raise => [TimeoutError]
 # ip_lookup: :telize
 # lookup: :google
)

# Geocoder.configure(

#   :timeout=>20,

#   :lookup=>:yandex,

#   :ip_lookup=>:telize,

#   :language=>:en,

#   :http_headers=>{},

#   :use_https=>false,

#   :http_proxy=>nil,

#   :https_proxy=>nil,

#   :api_key=>nil,

#   :cache=>nil,

#   :cache_prefix=>"geocoder:",

#   :distances=>:linear

# )