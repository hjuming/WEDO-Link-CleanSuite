async function loadLatestRelease() {
    const apiURL = "https://api.github.com/repos/hjuming/WEDO-Link-CleanSuite/releases/latest";

    try {
        const res = await fetch(apiURL);
        const data = await res.json();

        if (data.tag_name) {
            document.getElementById("latestVersion").innerText =
                "Latest version: " + data.tag_name;

            if (data.assets && data.assets.length > 0) {
                document.getElementById("downloadBtn").href = data.assets[0].browser_download_url;
            }
        } else {
            document.getElementById("latestVersion").innerText =
                "No releases found.";
        }
    } catch (e) {
        document.getElementById("latestVersion").innerText = "Unable to fetch version info.";
    }
}

loadLatestRelease();
