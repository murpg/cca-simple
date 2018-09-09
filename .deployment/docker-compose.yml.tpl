version: "3"
services:

  app:
    image: ortussolutions/commandbox:adobe11-alpine
    volumes:
      - ./app/:/app/
    ports:
      - "80:8080"
    environment:
      - box_install=true
      - cfconfig_license=${cf_license}
