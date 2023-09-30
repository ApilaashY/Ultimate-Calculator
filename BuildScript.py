import subprocess, shutil, os, sys

LINES = [6, 595, 596, 597, 598]

print("Building apk")
p = subprocess.run(
    ["flutter", "build", "apk", "--no-tree-shake-icons"],
    stdout=subprocess.PIPE,
    encoding="UTF-8",
    shell=True,
)
print(p.stdout)

if p.returncode != 0:
    sys.exit()

print("\nSetting up project for web")
w = open("lib/main.dart", "r")
data = w.readlines()

for i in LINES:
    data[i - 1] = data[i - 1].replace("//", "")

w.close()

w = open("lib/main.dart", "w")
w.writelines(data)
w.close()


print("Copying over new apk")
shutil.copy("build/app/outputs/flutter-apk/app-release.apk", "web/app-release.apk")
os.remove("web/ultimatecalculator.apk")
os.rename("web/app-release.apk", "web/ultimatecalculator.apk")


print("Building web")
p = subprocess.run(
    ["flutter", "build", "web", "--no-tree-shake-icons"],
    stdout=subprocess.PIPE,
    encoding="UTF-8",
    shell=True,
)
print(p.stdout)

for i in LINES:
    data[i - 1] = f"//{data[i - 1]}"


w = open("lib/main.dart", "w")
w.writelines(data)
w.close()


print("Deleting Old Website Data")


def checkAndDelete(path):
    files = os.listdir(path)
    for i in files:
        if str(i).startswith(".git"):
            continue

        if os.path.isdir(f"{path}/{i}"):
            checkAndDelete(f"{path}/{i}")
            os.rmdir(f"{path}/{i}")
        else:
            os.remove(f"{path}/{i}")


checkAndDelete("../Ultimate-Calculator-WebSite")

print("Copying over new website data")

for file in os.listdir("build/web"):
    if os.path.isdir(f"build/web/{file}"):
        shutil.copytree(f"build/web/{file}", f"../Ultimate-Calculator-WebSite/{file}")
    else:
        shutil.copy(f"build/web/{file}", f"../Ultimate-Calculator-WebSite/{file}")
