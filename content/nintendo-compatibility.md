---
title: Nintendo Hardware Compatibility 1985-2016
handheldFormats:
  - title: "GB"
    description: "Game Boy (Class A) Game Pak"
  - title: "GBC - Dual"
    description: "Game Boy Color - Dual Mode (Class B) Game Pak"
  - title: "GBC"
    description: "Game Boy Color (Class C) Game Pak"
  - title: "GBA"
    description: "Game Boy Advance (Class D) Game Pak"
  - title: "DS"
    description: "Nintendo DS Game Card"
  - title: "3DS"
    description: "Nintendo 3DS Game Card"
handheldHardwares:
  - title: "Game Boy"
    description: "Game Boy / Game Boy Pocket / Super Game Boy"
    compat: [true, true, false, false, false, false]
  - title: "GB Color"
    description: "Game Boy Color"
    compat: [true, true, true, false, false, false]
  - title: "GB Advance"
    description: "Game Boy Advance / GBA SP (AGS-001, AGS-101) / Game Boy Player"
    compat: [true, true, true, true, false, false]
  - title: "GB Micro"
    description: "Game Boy Micro"
    compat: [false, false, false, true, false, false]
  - title: "DS"
    description: "Nintendo DS / DS Lite"
    compat: [false, false, false, true, true, false]
  - title: "DSi"
    description: "Nintendo DSi / DSi XL"
    compat: [false, false, false, false, true, false]
  - title: "3DS"
    description: "Nintendo 3DS / 3DS XL / Nintendo 2DS / New Nintendo 3DS / New Nintendo 3DS XL / New Nintendo 2DS XL"
    compat: [false, false, false, false, true, true]
home:
  - title: "Nintendo"
  - title: "Super Nintendo"
  - title: "Nintendo 64"
  - title: "Gamecube"
  - title: "Wii (RVL-100)"
  - title: "Wii (RVL-101)"
  - title: "Wii Mini (RVL-201)"
  - title: "Wii U"

---

{{< compat.inline >}}
  <table>
    <thead>
      <tr>
        <th>Hardware</th>
        {{ range .Page.Params.handheldFormats }}
          <th><abbr title="{{ .description }}">{{ .title }}</abbr></th>
        {{ end }}
      </tr>
    </thead>
    <tbody>
      {{ range $device := .Page.Params.handheldHardwares }}
        <tr>
          <th><abbr title="{{ $device.description }}">{{ $device.title }}</abbr></th>
          {{ range $i, $status := $device.compat }}
            <td>{{ cond $status "🟢" "🔴"}}</td>
          {{ end }}
        </tr>
      {{ end }}
    </tbody>
  </table>
{{< /compat.inline >}}
