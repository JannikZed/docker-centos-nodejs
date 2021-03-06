# Use the base CentOS image.  If systemd is required in the future, change to 'creativeux/centos-base-systemd'
FROM centos/systemd

MAINTAINER Jannik Zinkl <jannik.zinkl@trieb.work>

# Install the EPEL repository
RUN yum -y install \
  epel-release

# Install core RPMs
RUN yum -y install \
  tar \
  bzip2

# Install required developer tools
RUN yum -y install \
  make \
  gcc \
  git \
  fontconfig \
  freetype 
  
RUN curl -fsSL https://get.docker.com/ | sh \
  && systemctl start docker

# Install node & npm and upgrade to desired versions.
RUN yum -y install \
  nodejs \
  npm && \
  npm install -g n && \
  n 6 && \
  npm install -g npm

# Install ruby
RUN yum -y install ruby \
  ruby-devel \
  rubygems

# Install compass
RUN gem install compass

# Install required libs
RUN yum -y install \
  libpng-devel

# Install Grunt and Bower
RUN npm install -g \
  grunt-cli \
  bower

# Clean up
RUN yum clean all && \
  npm cache clean -f

# Create a static file serve folder
RUN mkdir /var/www

# Execute the commands in the file serve folder
WORKDIR /var/www

# Open port 9000 for app, 35729 for livereload, and 22 for SSH
EXPOSE 9000 35729 22

# Expose our web root and log directories log.
VOLUME ["/vagrant", "/var/www", "/var/log", "/var/run"]
