version: "3"
services:

  app:
    image: ortussolutions/commandbox:adobe2016
    volumes:
      - ./app/:/app/
    ports:
      - "80:8080"
    environment:
      - DEBUG=true
      - CFENGINE=adobe@2016
      - box_install=true
      - cfconfig_license=${cf_license}
