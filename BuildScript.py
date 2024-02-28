import subprocess, shutil, os, sys

LINES = [6, 658, 659, 660, 661]
ADDIRECTORY = "/lib/main.dart"
slashPosition = -1

w = open(os.curdir + ADDIRECTORY, 'r')
adData = w.readlines()
w.close()

for line in enumerate(adData):
    if (line[1].count("showinter()") >= 1):
        if (line[1].count("//") >= 1):
            repeatQuestion = input("Ads are turned off, would you like to build wit[h] ads, withou[t] ads, or [s]top building (h/t/s): ").lower()
            while (repeatQuestion != "h" and repeatQuestion != "t" and repeatQuestion != "s"):
                print("Invalid Response")
                repeatQuestion = input("Ads are turned off, would you like to build wit[h] ads, withou[t] ads, or [s]top building (h/t/s): ").lower()
            
            if (repeatQuestion == "h"):
                print(line[0])
                adData[line[0]] = adData[line[0]].replace("//","")

                slashPosition = line[0]

                w = open(os.curdir + ADDIRECTORY, 'w')
                w.writelines(adData)
                w.close()

            elif (repeatQuestion == "t"):
                print("CONTINUING")
                print()
            else:
                print("STOPPING")
                sys.exit()
        else:
            print("Ads are already turned on")
            print()
        break

print("Building apk")
p = subprocess.run(
    ["flutter", "build", "apk", "--no-tree-shake-icons"],
    stdout=subprocess.PIPE,
    encoding="UTF-8",
    shell=True,
)

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
try:
    os.remove("web/ultimatecalculator.apk")
except:
    print("APK already non-existant")
os.rename("web/app-release.apk", "web/ultimatecalculator.apk")


print("Building web")
p = subprocess.run(
    ["flutter", "build", "web", "--no-tree-shake-icons"],
    stdout=subprocess.PIPE,
    encoding="UTF-8",
    shell=True,
)


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

if (slashPosition >= 0):
    adData[line[0]] = "//" + adData[line[0]]
    
    w = open(os.curdir + ADDIRECTORY, 'w')
    w.writelines(adData)
    w.close()