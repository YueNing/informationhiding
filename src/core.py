"""
encrypting data in html
"""

from bs4 import BeautifulSoup

class Turing:

    def __init__(self, src_path, out_path):
        self.src_path = src_path
        self.out_path = out_path

    @staticmethod
    def load_data(src_path, format=True):
        with open(src_path) as fp:
            soup = BeautifulSoup(fp, "html.parser")
        return soup

    @staticmethod
    def load_text(path:str):
        """
        load source text
        :param path: path of source path
        :return: str
        """
        with open(path) as fp:
            text = fp.read()

        return text

    def save_result(self, result:BeautifulSoup):
        with open(self.out_path, "w") as fp:
            fp.write(str(result))

    def encrypt(self, path:str):
        soup = self.load_data(self.src_path)
        text = self.load_text(path)
        result_soup = self._encrypt(soup, text)
        self.save_result(result_soup)

    @staticmethod
    def _binary_text(text:str):
        binary_text = None
        binary_text = ''.join(format(x, 'b') for x in bytearray(text, 'utf-8'))
        return binary_text

    @staticmethod
    def _string_text(text:str):
        v = int(text, 2)
        b = bytearray()
        while v:
            b.append(text & 0xff)
            v >>= 8
        return bytes(b[::-1]).decode("utf-8")

    def _encrypt(self, soup: BeautifulSoup, text:str) -> BeautifulSoup:
        attrs = []
        binary_text = self._binary_text(text)

        encrypt_number = 0
        for elm in soup():
            for key, values in elm.attrs:
                _encrypt_binary = binary_text[encrypt_number:encrypt_number+2]

                new_key = key + " " if _encrypt_binary[0] == "1" else ""
                new_value = " " if _encrypt_binary[1] =="1" else "" + values

                del elm.attrs[key]
                elm.attrs[new_key] = new_value
                encrypt_number +=1
        return soup

    def _decrypt(self, soup:BeautifulSoup):
        decrypt_data = ""
        for elm in soup():
            for key, value in elm.attrs:
                _one = "1" if key.endswith(" ") else "0"
                _two = "1" if key.endswith(" ") else "0"
                decrypt_data += _one
                decrypt_data += _two

        return self._string_text(decrypt_data)

    def decrypt(self, src_path, path):
        soup = self.load_data(src_path, format=False)

        decrypt_data = self._decrypt(soup)

        with open(path, "w") as fp:
            fp.write(decrypt_data)