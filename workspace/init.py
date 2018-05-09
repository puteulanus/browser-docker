from selenium import webdriver

# For run from root
options = webdriver.ChromeOptions()
options.add_argument("--no-sandbox")
options.add_argument("--user-data-dir")
browser = webdriver.Chrome(chrome_options=options)

# User code
browser.get("https://www.baidu.com")