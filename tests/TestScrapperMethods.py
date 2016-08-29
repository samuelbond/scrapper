import json
import unittest
import requests_mock
from scrapper.core import Scrapper


class TestScrapperMethods(unittest.TestCase):

    @requests_mock.mock()
    def test_get_web_page_ok(self, mock_request):
        url = 'http://mock'
        self.set_up_mock(mock_request, url)
        expected_status_code = 200
        under_test = Scrapper()
        response = under_test.get_web_page(url)
        self.assertEqual(response.status_code, expected_status_code)

    @requests_mock.mock()
    def test_get_web_page_content_is_string(self, mock_request):
        url = 'http://mock/content'
        self.set_up_mock(mock_request, url, 'String content')
        under_test = Scrapper()
        content = under_test.get_web_page_content(url)
        self.assertTrue(isinstance(content, (str, unicode)))

    @requests_mock.mock()
    def test_scrapper_handles_exception(self, mock_request):
        url = 'http://mock'
        self.set_up_mock(mock_request, url, 'Page not found', 404)
        expected_output = 'Error, Invalid http response 404'
        under_test = Scrapper()
        actual_output = under_test.scrape(url)
        self.assertEqual(actual_output, expected_output)

    def test_it_returns_json_string(self):
        dictionary = {'results': [{'item': 'item_name'}]}
        under_test = Scrapper()
        output = under_test.to_json(dictionary)
        self.assertTrue(isinstance(output, (str, unicode)))
        json_dic = json.loads(output)
        self.assertTrue(isinstance(json_dic, dict))


    def set_up_mock(self, mock_obj, url, body='', status_code=200):
        mock_obj.get(url, text=body, status_code=status_code)

if __name__ == '__main__':
    unittest.main()