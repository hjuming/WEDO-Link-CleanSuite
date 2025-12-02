document.addEventListener("DOMContentLoaded", () => {
    highlightNav();
    fetchVersion();
});

// --- Navigation Highlighter ---
function highlightNav() {
    const path = window.location.pathname;
    const links = document.querySelectorAll("nav a");

    links.forEach(link => {
        const href = link.getAttribute("href");
        // Simple check: if path contains the href (ignoring relative parts like ../)
        // Adjust logic based on your specific URL structure
        if (href === "/" || href === "../" || href === "../../") return; // Skip home link for now, handle separately if needed

        const cleanHref = href.replace(/\.\.\//g, "").replace(/\/$/, "");
        if (path.includes(cleanHref) && cleanHref !== "") {
            link.classList.add("text-blue-600", "font-bold");
        }
    });
}

// --- Language Switcher ---
function switchLanguage() {
    const path = window.location.pathname;
    let newPath;

    // Check if currently in an 'en' directory
    if (path.includes("/en/")) {
        // Switch to Chinese (Parent directory)
        // Example: /WEDO-Link-CleanSuite/en/ -> /WEDO-Link-CleanSuite/
        // Example: /WEDO-Link-CleanSuite/tutorial/en/ -> /WEDO-Link-CleanSuite/tutorial/
        newPath = path.replace("/en/", "/");
    } else {
        // Switch to English (Sub directory)
        // Example: /WEDO-Link-CleanSuite/ -> /WEDO-Link-CleanSuite/en/
        // Example: /WEDO-Link-CleanSuite/tutorial/ -> /WEDO-Link-CleanSuite/tutorial/en/

        // Need to handle trailing slash
        if (path.endsWith("/")) {
            newPath = path + "en/";
        } else if (path.endsWith("index.html")) {
            newPath = path.replace("index.html", "en/index.html");
        } else {
            newPath = path + "/en/";
        }
    }

    window.location.href = newPath;
}

// --- Mobile Menu Toggle ---
function toggleMenu() {
    const menu = document.getElementById("mobile-menu");
    if (menu.classList.contains("hidden")) {
        menu.classList.remove("hidden");
    } else {
        menu.classList.add("hidden");
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
