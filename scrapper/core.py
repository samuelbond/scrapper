from decimal import Decimal

import requests
import simplejson as json
import lxml.html
from hurry.filesize import size

from scrapper.exceptions.exception import InvalidResponse


class Scrapper:
    def __init__(self):
        pass

    def scrape(self, ripe_fruit_url):
        try:
            self.start_message()
            main_page = self.get_web_page_content(ripe_fruit_url)
            result_list = {'results': []}
            main_page_tree = lxml.html.fromstring(main_page)
            product_names = self.get_product_names(main_page_tree)
            product_prices = self.get_product_prices(main_page_tree)
            total_price = 0
            count = 0
            for product in product_names:
                title = str(product.text).strip()
                des_link = product.attrib['href']
                des_response = self.get_web_page(des_link)
                des_size = self.get_page_size(des_response)
                des_content = self.get_web_page_content(requests_obj=des_response)
                description = self.get_item_description(des_content)
                count = count+1 if str(product_prices[count]).strip().strip("&pound").strip() == '' else count
                this_price = str(product_prices[count]).strip().strip("&pound").strip()
                total_price = total_price+Decimal(this_price)
                result_list['results'].append(
                    {'title': title, 'size': des_size, 'unit_price': Decimal(this_price), 'description': description[0]})
                count += 1
            result_list['total'] = total_price
            json_output = self.to_json(result_list)
            print json_output
            return json_output
        except InvalidResponse as e:
            msg = 'Error, '+str(e.args[0])+' '+str(e.args[1])
            print msg
            return msg
        except:
            msg = 'Unhandled exception'
            print msg
            return msg

    @staticmethod
    def get_web_page(page_url):
        response = requests.get(page_url)
        if response.status_code > 200:
            raise InvalidResponse("Invalid http response", response.status_code)
        return response

    def get_web_page_content(self, page_url=None, requests_obj=None):
        response = self.get_web_page(page_url) if requests_obj is None else requests_obj
        return response.text

    @staticmethod
    def get_product_names(web_page_tree):
        return web_page_tree.xpath('//div[@class="productInfo"]/h3/a')

    @staticmethod
    def get_product_prices(web_page_tree):
        return web_page_tree.xpath('//div[@class="pricing"]/p[@class="pricePerUnit"]/text()')

    def get_page_size(self, requests_obj):
        cont = requests_obj.content
        return size(len(self.strip_assets_from_content(cont)))

    @staticmethod
    def get_item_description(web_page):
        page_tree = lxml.html.fromstring(web_page)
        return page_tree.xpath('//div[@class="productText"]/p/text()')

    @staticmethod
    def to_json(dictionary):
        return json.dumps(dictionary)

    @staticmethod
    def start_message():
        print "Starting Scrapper"

    @staticmethod
    def strip_assets_from_content(content):
        str1 = content.find('<script type="text/javascript">')
        str2 = content.find('<script type="text/javascript" src="')
        first_asset_str = content[str1:str2]
        content = content.replace(first_asset_str, '', 1)
        str3 = content.find('<script type="text/javascript">require')
        str4 = content.find('Fade"]);</script>')
        second_asset_str = content[str3:str4+17]
        content = content.replace(second_asset_str, '', 1)
        str5 = content.find('<style id="antiCJ">')
        str6 = content.find('self.location;}</script>')
        third_asset_str = content[str5:str6+24]
        content = content.replace(third_asset_str, '', 1)
        str7 = content.find('<script type="text/javascript">')
        str8 = content.find('</head>')
        last_asset_str = content[str7:str8]
        content = content.replace(last_asset_str, '', 1)
        return content.replace(content[content.find('<script type="text/javascript">'):content.find('<noscript>')], '', 1)
