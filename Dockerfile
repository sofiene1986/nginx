FROM nginx
# Create new web user for nginx and grant sudo without password
RUN mkdir /app && useradd app -d /app -g www-data -s /bin/bash
RUN usermod -aG sudo app
RUN echo 'app ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
COPY config/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80 443 9000
VOLUME /app
WORKDIR /app
COPY config/.bashrc /root/.bashrc
RUN chown app:www-data /root/.bashrc