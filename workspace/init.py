from selenium import webdriver

# For run from root
options = webdriver.ChromeOptions()
options.add_argument("--no-sandbox")
browser = webdriver.Chrome(chrome_options=options)

# User code
browser.get("https://www.baidu.com")