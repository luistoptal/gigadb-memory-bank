- this issue reported in staging - i suspect it is unrelated

Refused to load data:,
(function t() {
    "undefined" == typeof globalThis && (window.globalThis = window);
    const e = globalThis.document,
          t = globalThis.CustomEvent,
          n = globalThis.FileReader,
          r = globalThis.Blob,
          a = {
              family: "font-family",
              style: "font-style",
              weight: "font-weight",
              stretch: "font-stretch",
              unicodeRange: "unicode-range",
              variant: "font-variant",
              featureSettings: "font-feature-settings"
          };

    if (globalThis.FontFace) {
        const n = globalThis.FontFace;
        globalThis.FontFace = function() {
            return o(...arguments).then((n => e.dispatchEvent(new t("single-file-new-fon...de] }")));
        };

        const a = e.fonts.clear;
        e.fonts.clear = function() {
            return e.dispatchEvent(new t("single-file-clear-fonts")), a.call(e.fonts)
        };
        e.fonts.clear.toString = function() {
            return "function clear() { [native code] }"
        }
    }

    async function o(e, t, o) {
        const s = {};
        return s["font-family"] = e,
        s.src = t,
        o && Object.keys(o).forEach((e => {
            a[e] && (s[a[e]] = o[e])
        })),
        new Promise((e => {
            if (s.src instanceof ArrayBuffer) {
                const t = new n;
                t.readAsDataURL(new r([s.src])),
                t.addEventListener("load", (() => {
                    s.src = "url(" + t.result + ")",
                    e(s)
                }))
            } else e(s)
        }))
    }
})() because it does not appear in the script-src directive of the Content Security Policy.


- create a project with a logo, then edit the project and replace the logo by a different one. The updated logo is not being added to the file system, and the old logo remains in the file system. Then when the project is being deleted, the old logo is not deleted