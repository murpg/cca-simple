version: "3"
services:

  app:
    image: ortussolutions/commandbox:lucee5-snapshot
    volumes:
      - ./app/:/app/
    environment:
      - CFENGINE=lucee@5
      - box_install=true
      - cfconfig_adminPassword=${admin_password}

  proxy:
    image: nginx:1.12-alpine
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    ports:
      - "80:80"
