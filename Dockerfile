FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

# Install necessary packages
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    x11vnc xvfb \
    novnc websockify \
    wget net-tools curl sudo \
    && apt-get clean

# Add a non-root user (optional but recommended)
RUN useradd -m devuser && echo "devuser:devuser" | chpasswd && adduser devuser sudo

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
CMD ["bash"]
