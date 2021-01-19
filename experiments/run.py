from informationhidding.src.core import Turing

def main(src: str, output:str):
    turing = Turing(src_path, out_path)
    print("Beginning encrypt....")
    turing.encrypt("/home/nauen/PycharmProjects/informationhiding/experiments/encrypt/info")
    print(f"Finishing encrypt, saved in {out_path}....")

    print("Beginning decrypt....")
    result_path = "/home/nauen/PycharmProjects/informationhiding/experiments/result/decrypt"
    turing.decrypt(out_path, result_path, data_length=1152)
    print(f"Finishing decrypt, find the decrpted data in {result_path}")

if __name__ == "__main__":
    src_path = "/home/nauen/PycharmProjects/informationhiding/experiments/resources/test.html"
    out_path = "/home/nauen/PycharmProjects/informationhiding/experiments/result/encrypt.html"
    main(src_path, out_path)