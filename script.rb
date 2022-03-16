require "csv"
require "httparty" # https://github.com/jnunemaker/httparty/tree/master/docs

URL = "https://httpbin.org/post"
filepath = './lost-leads.csv'

# parses csv file into an array of leads
def parse_leads(filepath)
  leads = []

  CSV.foreach(filepath, headers: :first_row) do |row|
    leads << row.to_h
  end

  return leads
end

def post_leads(leads)
  response = HTTParty.post(URL, body: { leads: leads })
  return response
end

leads = parse_leads(filepath)

response = post_leads(leads)

message = response.code == 200 ? "Request was successful" : "Something went wrong"

puts message
