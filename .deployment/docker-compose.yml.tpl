version: "3"
services:

  app:
    image: ortussolutions/commandbox:adobe2018
    volumes:
      - ./app/:/app/
    environment:
      - CFENGINE=adobe@2018
      - box_install=true

  proxy:
    image: nginx:1.12-alpine
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    ports:
      - "80:80"
