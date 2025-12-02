// --- Automatic Language Redirect on First Visit ---
(function () {
    const saved = localStorage.getItem("cleansuite_lang");
    const isEnglish = navigator.language.startsWith("en");

    // If first time visit (no saved preference)
    if (!saved) {
        if (isEnglish && !location.pathname.includes("/en/")) {
            localStorage.setItem("cleansuite_lang", "en");
            location.href = "./en/";
        } else if (!isEnglish && location.pathname.includes("/en/")) {
            localStorage.setItem("cleansuite_lang", "zh");
            location.href = "../";
        }
    }
})();

// --- Language Switcher ---
function switchLanguage(lang) {
    localStorage.setItem("cleansuite_lang", lang);
    if (lang === "en") {
        // Assuming called from root
        window.location.href = "en/";
    } else {
        // Assuming called from en/
        window.location.href = "../";
    }
}

// --- Fetch Latest GitHub Release Version ---
async function fetchVersion() {
    try {
        const res = await fetch("https://api.github.com/repos/hjuming/WEDO-Link-CleanSuite/releases/latest");
        const data = await res.json();

        if (data && data.tag_name) {
            const version = data.tag_name;
            document.querySelectorAll(".latest-version").forEach(el => {
                el.textContent = version;
            });

            const downloadBtn = document.getElementById("download-btn");
            if (downloadBtn && data.assets && data.assets.length > 0) {
                downloadBtn.href = data.assets[0].browser_download_url;
            }
        }
    } catch (e) {
        console.error("Version fetch failed:", e);
    }
}

fetchVersion();
