import os

q = open("lines.txt", "w")
q.write("0")
q.close()


def count(path):
    for i in os.listdir(path):
        try:
            w = open(f"{path}/{i}", "r")
            q = open("lines.txt", "r")
            num = q.read()
            q.close()

            amount = len(w.readlines())

            q = open("lines.txt", "w")
            q.write(str(int(num) + amount))
            q.close()
            print(f"{path}/{i} - {amount}")
            w.close()
        except:
            count(f"{path}/{i}")


count(os.getcwd())
