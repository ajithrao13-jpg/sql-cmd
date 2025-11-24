# Base Liquibase image
FROM liquibase/liquibase:latest

# Switch to root to install packages and sqlcmd
USER root

# Set working directory
WORKDIR /liquibase

# Copy the JARs into the Liquibase lib directory
COPY liquibase-azure-deps-4.33.0.jar /liquibase/lib/
COPY mssql-jdbc-13.2.1.jre11.jar /liquibase/lib/

# -------------------------
# Install sqlcmd (Linux AMD64)
# -------------------------
RUN apk add --no-cache tar ca-certificates bzip2

# Copy sqlcmd archive
COPY sqlcmd-linux-amd64.tar.bz2 /tmp/sqlcmd-linux-amd64.tar.bz2

# Extract & install sqlcmd
RUN mkdir -p /opt/sqlcmd \
    && tar -xjf /tmp/sqlcmd-linux-amd64.tar.bz2 -C /opt/sqlcmd \
    && ln -s /opt/sqlcmd/sqlcmd /usr/local/bin/sqlcmd

# Ensure sqlcmd is available in PATH
ENV PATH="/opt/sqlcmd:${PATH}"
# -------------------------

# Fix permissions for liquibase user
RUN chown -R liquibase:liquibase /liquibase/lib

# Switch back to liquibase user
USER liquibase

# Default entrypoint for Liquibase
ENTRYPOINT ["liquibase"]

# Show liquibase help by default
CMD ["--help"]






































# FROM alpine:latest

# RUN apk add --no-cache tar ca-certificates bzip2

# COPY sqlcmd-linux-amd64.tar.bz2 /tmp/sqlcmd-linux-amd64.tar.bz2

# RUN mkdir -p /opt/sqlcmd \
#   && tar -xjf /tmp/sqlcmd-linux-amd64.tar.bz2 -C /opt/sqlcmd \
#   && ln -s /opt/sqlcmd/sqlcmd /usr/local/bin/sqlcmd

# ENV PATH="/opt/sqlcmd:${PATH}"

# ENTRYPOINT ["sqlcmd"]
