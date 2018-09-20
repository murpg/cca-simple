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

  portainer:
    image: portainer/portainer
    ports:
      - "9000:9000"
    command: -H unix:///var/run/docker.sock
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data

volumes:
  portainer_data:
