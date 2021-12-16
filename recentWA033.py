import http.client

conn = http.client.HTTPSConnection("api.ebird.org")
payload = ''
headers = {
  'x-ebirdapitoken': 'j6c7l80ga2ib'
}
conn.request("GET", "/v2/data/obs/US-WA-033/recent?detail=full", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))