FROM python
RUN pip install webssh
COPY index.html /usr/local/lib/python3.8/site-packages/webssh/templates/index.html
EXPOSE 8000
CMD ["/usr/local/bin/wssh"]