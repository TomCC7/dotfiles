#!/usr/bin/env python3

import requests
import clipboard
import json

if __name__ == "__main__":
    url = clipboard.paste()
    nurl = requests.get(
        f"https://tail.wtf/_next/data/ZEE-K3FpuP-tlGwPTriHO/sanitize.json?url={url}"
    ).json()["pageProps"]["text"]
    print(nurl)
    clipboard.copy(nurl)
