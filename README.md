# Web scraping using Puppeteer Scraper and hosting using Python API

This project is a Dockerized application that performs web scraping using Puppeteer (Node.js) and serves the scraped data via a Python-based API.

## How to Build the Docker Image
To build the Docker image, run the following command in the project directory:

```bash
docker build -t puppeteer-python-app .
```
## How to Run the Container
To run the container, use the following command:
```
docker run -p 2003:2003 -e SCRAPER_URL=<URL_TO_SCRAPE> puppeteer-python-app
```
Replace <URL_TO_SCRAPE> with the URL you want to scrape. This value is passed as an environment variable (SCRAPER_URL) to the scraper.

For example:
```
docker run -p 2003:2003 -e SCRAPER_URL=https://example.com puppeteer-python-app
```
## How to Pass the URL to Be Scraped
The URL to be scraped can be passed via the SCRAPER_URL environment variable when running the container. Use the -e flag in the docker run command to specify the URL.

Alternatively, you can modify the .env file in the project directory to include the URL:
```
SCRAPER_URL=https://example.com
```
If the .env file is used, ensure it is included in the Docker build process.

## How to Access the Hosted Scraped Data
Once the container is running, the scraped data will be served via a Python-based API. You can access the data using the following endpoint:

GET /data: Returns the scraped data in JSON format.
Example Request
To access the data, open your browser or use a tool like curl or Postman to make a GET request to:
```
http://localhost:2003/data
```
Example Response
```
{
  "title": "Example Page",
  "description": "This is an example description.",
  "links": [
    "https://example.com/link1",
    "https://example.com/link2"
  ]
}
```
## Notes
Ensure that the URL provided in SCRAPER_URL is valid and accessible.
The container exposes port 2003 for the API. If you want to use a different port on your host machine, modify the -p flag in the docker run command (e.g., -p 8080:2003).
## Troubleshooting
If the scraper does not work as expected, check the logs using:
```
docker logs <container_id>
```
Ensure that the URL provided in SCRAPER_URL is correct and reachable.
If the API is not accessible, verify that the container is running and the correct port is mapped.



