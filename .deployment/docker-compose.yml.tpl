version: "3"
services:

  app:
    image: ortussolutions/commandbox:lucee5
    volumes:
      - ./app/:/app/
    ports:
      - "80:8080"
    environment:
      - DEBUG=true
      - CFENGINE=lucee@5
      - box_install=true
