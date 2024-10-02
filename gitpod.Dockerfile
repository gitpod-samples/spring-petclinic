FRM ubuntu:20.04  # Incorrect keyword; should be "FROM"
RUN apt-get update
CMD echo Hello World
COPY myapp /app  # This line is invalid because there is no source file
EXPOSE "80"  # Quotes are invalid; EXPOSE expects a number, not a string
WORKDIR /app
ENTRYPOINT ["bash", -c]  # "-c" should be inside quotes
