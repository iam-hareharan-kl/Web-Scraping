import puppeteer from "puppeteer"; 
import { config } from "dotenv";
import fs from "fs";
const scraper = async () => {
    config();
    const url = process.env.Scraper_url;
    const browser = await puppeteer.launch({
        headless: true, // Enabled headless mode
        args: ['--no-sandbox'], // Added necessary flags
    });
    const page = await browser.newPage();
    await page.goto(url);
    
    //contents of the page
    const content = await page.evaluate(() => {
        const details = document.querySelectorAll('.product_pod');
        return Array.from(details).map( (detail) => {
            const title = detail.querySelector('h3 a').getAttribute('title');
            const price = detail.querySelector('.price_color').textContent;
            const rating = detail.querySelector('.star-rating').className.split(' ')[1];
            return{
                title, price, rating
            };
        })
    });
    
    // Stores the scraped content to .json file
    fs.writeFileSync('details.json', JSON.stringify(content, null, 2));

    console.log('Data saved successfully in .json file');
    await browser.close();  
}

scraper();