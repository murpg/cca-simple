version: "3"
services:

  app:
    image: ortussolutions/commandbox:adobe2018-snapshot
    volumes:
      - ./app/:/app/
    environment:
      - CFENGINE=adobe@2018
      - box_install=true
      - cfconfig_adminPassword=${admin_password}

  proxy:
    image: nginx:1.12-alpine
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    ports:
      - "80:80"
