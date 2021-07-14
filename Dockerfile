FROM jmercha/raspbian

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install curl raspi-config dbus systemd libraspberrypi-bin -y
RUN apt-get clean -y
RUN rm -rf /var/run/apt/sources.list*

RUN find /etc/systemd -name '*.timer' | xargs rm -v && \
	systemctl set-default multi-user.target

RUN curl https://download.argon40.com/argon1.sh | bash
RUN systemctl enable argononed

COPY ./argononed.conf /etc/

ENTRYPOINT ["/lib/systemd/systemd"]
