document.addEventListener("DOMContentLoaded", () => {
    highlightNav();
    fetchVersion();
    initDarkMode();

    // Only fetch changelog if we are on the changelog page
    if (window.location.pathname.includes("/changelog/")) {
        fetchChangelog();
    }
});

// --- Navigation Highlighter ---
function highlightNav() {
    const path = window.location.pathname;
    const links = document.querySelectorAll("nav a");

    links.forEach(link => {
        const href = link.getAttribute("href");
        if (!href || href === "/" || href === "../" || href === "../../") return;

        const cleanHref = href.replace(/\.\.\//g, "").replace(/\/$/, "");
        if (path.includes(cleanHref) && cleanHref !== "") {
            link.classList.add("text-blue-600", "font-bold", "dark:text-blue-400");
        }
    });
}

// --- Language Switcher ---
function switchLanguage() {
    const path = window.location.pathname;
    let newPath;

    if (path.includes("/en/")) {
        newPath = path.replace("/en/", "/");
    } else {
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
    menu.classList.toggle("hidden");
}

// --- Dark Mode ---
function initDarkMode() {
    const savedTheme = localStorage.getItem("theme");
    const systemDark = window.matchMedia("(prefers-color-scheme: dark)").matches;

    if (savedTheme === "dark" || (!savedTheme && systemDark)) {
        document.documentElement.classList.add("dark");
    } else {
        document.documentElement.classList.remove("dark");
    }
    updateThemeIcon();
}

function toggleDarkMode() {
    const html = document.documentElement;
    if (html.classList.contains("dark")) {
        html.classList.remove("dark");
        localStorage.setItem("theme", "light");
    } else {
        html.classList.add("dark");
        localStorage.setItem("theme", "dark");
    }
    updateThemeIcon();
}

function updateThemeIcon() {
    const isDark = document.documentElement.classList.contains("dark");
    const icons = document.querySelectorAll(".theme-toggle-icon");
    icons.forEach(icon => {
        icon.textContent = isDark ? "☀️" : "🌙";
    });
}

// --- Fetch Latest GitHub Release Version (For Download Button) ---
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

// --- Fetch Changelog (For Changelog Page) ---
async function fetchChangelog() {
    const container = document.getElementById("changelog-container");
    if (!container) return;

    try {
        const res = await fetch("https://api.github.com/repos/hjuming/WEDO-Link-CleanSuite/releases/latest");
        if (!res.ok) throw new Error("Failed to fetch");

        const data = await res.json();
        const date = new Date(data.published_at).toISOString().split('T')[0];
        const body = data.body.replace(/\r\n/g, "<br>"); // Simple formatting

        const html = `
      <div class="bg-white dark:bg-gray-800 p-8 shadow-sm rounded-2xl border-l-4 border-blue-500 mb-8">
        <div class="flex justify-between items-start mb-4">
          <div>
            <h2 class="text-2xl font-bold text-gray-800 dark:text-white">${data.tag_name}</h2>
            <p class="text-gray-500 dark:text-gray-400 text-sm mt-1">${date}</p>
          </div>
          <span class="bg-blue-100 text-blue-800 text-xs font-semibold px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300">Latest Release</span>
        </div>
        <div class="text-gray-700 dark:text-gray-300 space-y-2">
          ${body}
        </div>
      </div>
    `;

        // Insert at the beginning
        container.insertAdjacentHTML('afterbegin', html);

    } catch (e) {
        console.log("Using fallback changelog");
    }
}
