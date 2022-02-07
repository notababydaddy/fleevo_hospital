client_scripts {
  "client.lua",
  "progressclient.lua"
}

files {
  "index.html",
  "scripts.js",
  "css/style.css"
}

server_scripts{
 '@oxmysql/lib/MySQL.lua',
}

ui_page 'index.html'

export "taskBar"