import glob
import errno
import json

path = 'json_folder/*.json'
files = glob.glob(path)
for name in files:
    try:
        with open(name) as f:
            data=f.read()
            obj = json.loads(data)
            if(obj['status'] != 'passed'): 
                print(obj['name'])
                with open("failed.txt", "a+") as f_failed:
                    f_failed.write(obj['name'] + "\n")

    except IOError as exc:
        if exc.errno != errno.EISDIR:
            raise