
from ..src.core import Turing

def main(src: str, output:str):
    src_path = "/home/nauen/informationhiding/resources/test.html"
    out_path = "/home/nauen/informationhiding/result/encrypt.html"
    turing = Turing(src_path, out_path)
    print("Beginning encrypt....")
    turing.encrypt("/home/nauen/informationhiding/encrypt/info")
    print(f"Finishing encrypt, saved in {out_path}....")

    print("Beginning decrypt....")
    result_path = "/home/nauen/informationhiding/result/decrypt"
    turing.decrypt(out_path, result_path)
    print(f"Finishing decrypt, find the decrpted data in {result_path}")

if __name__ == "__main__":
    main()