version: "3"
services:

  app:
    image: ortussolutions/commandbox:adobe2018
    volumes:
      - ./app/:/app/
    ports:
      - "80:8080"
    environment:
      - CFENGINE=adobe@2018
      - box_install=true
