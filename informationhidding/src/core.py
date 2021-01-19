"""
encrypting data in html
"""

from bs4 import BeautifulSoup
import logging

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
        result_soup, encrypted_length = self._encrypt(soup, text)
        print(f"encrypted length is {encrypted_length}")
        self.save_result(result_soup)

    @staticmethod
    def _binary_text(text:str):
        binary_text = None
        binary_text = ''.join('{:08b}'.format(x, 'b') for x in bytearray(text, 'utf-8'))
        return binary_text

    @staticmethod
    def _string_text(text:str):
        v = int(text, 2)
        b = bytearray()
        while v:
            b.append(v & 0xff)
            v >>= 8
        return bytes(b[::-1]).decode("utf-8")

    def _encrypt(self, soup: BeautifulSoup, text:str) -> BeautifulSoup:
        attrs = []
        binary_text = self._binary_text(text)

        encrypt_number = 0
        tags = sorted(set([tag for tag in soup.find_all(limit=100)]), key=lambda x: str(x))
        used_elm = 0
        finished = False
        while not finished or encrypt_number * 2 < len(binary_text):
            if tags:
                for elm in tags:
                    keys = sorted(list(elm.attrs.keys()))
                    values = [elm.attrs[k] for k in keys]
                    length = len(elm.attrs)

                    for index in range(length):
                        if type(values[index]) == list:
                            continue
                        new_key = None
                        new_value = None
                        _encrypt_binary = binary_text[encrypt_number*2:encrypt_number*2 + 2]
                        if not _encrypt_binary:
                            break
                        new_key = keys[index] + " " if _encrypt_binary[0] == "1" else keys[index]
                        if type(values[index]) == str:
                            new_value = " " + values[index] if _encrypt_binary[1] == "1" else values[index]
                        else:
                            new_value = " " + values[index] if _encrypt_binary[1] == "1" else values[index]

                        del elm.attrs[keys[index]]
                        elm.attrs[new_key] = new_value
                        encrypt_number +=1

                    used_elm +=1

                    if encrypt_number * 2 >= len(binary_text):
                        finished = True
                        break

                    if used_elm >= len(tags):
                        finished = True
                        break
                if finished:
                    break
            else:
                finished = True
        return soup, len(binary_text)

    def _decrypt(self, soup:BeautifulSoup, data_length):
        decrypt_data = ""
        decrypt_number = 0
        tags = sorted(set([tag for tag in soup.find_all()]), key=lambda x: str(x))
        used_elm = 0
        finished = False
        while not finished and decrypt_number * 2 < data_length:
            for elm in tags:
                keys = sorted(list(elm.attrs.keys()))
                values = [elm.attrs[k] for k in keys]
                length = len(elm.attrs)

                for index in range(length):
                    if type(values[index]) == list:
                        continue
                    _one = "1" if keys[index].endswith(" ") else "0"

                    if type(values[index]) == str:
                        _two = "1" if values[index].startswith(" ") else "0"
                    else:
                        _two = "1" if values[index].startswith(" ") else "0"

                    decrypt_data += _one
                    decrypt_data += _two
                    decrypt_number += 1

                used_elm +=1
                if decrypt_number * 2 >= data_length:
                    finished = True
                    break

                if used_elm >= len(tags):
                    finished = True
                    break

            if finished:
                break

        return self._string_text(decrypt_data)

    def decrypt(self, src_path, path, data_length):
        soup = self.load_data(src_path, format=False)

        decrypt_data = self._decrypt(soup, data_length)

        with open(path, "w") as fp:
            fp.write(decrypt_data)