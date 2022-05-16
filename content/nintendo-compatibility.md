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
homeFormats:
  - title: NES
    description: Nintendo Entertainment System Game Pak
  - title: SNES
    description: Super Nintendo Entertainment System Game Pak
  - title: "N64"
    description: Nintendo 64 Game Pak
  - title: GCN
    description: Nintendo GameCube Mini Disc
  - title: Wii
    description: Nintendo Wii Disc
  - title: Wii U
    description: Nintendo Wii U Disc
homeHardwares:
  - title: "NES"
    description: "Nintendo Entertainment System - All Models"
    compat: [true, false, false, false, false, false]
  - title: "SNES"
    description: "Super Nintendo Entertainment System - All Models"
    compat: [false, true, false, false, false, false]
  - title: "N64"
    description: "Nintendo 64 - All Models"
    compat: [false, false, true, false, false, false]
  - title: "GCN"
    description: "Gamecube - All Models"
    compat: [false, false, false, true, false, false]
  - title: "Wii v1"
    description: "Nintendo Wii (RVL-100)"
    compat: [false, false, false, true, true, false]
  - title: "Wii v2"
    description: "Nintendo Wii (RVL-101)"
    compat: [false, false, false, false, true, false]
  - title: "Wii Mini"
    description: "Nintendo Wii Mini (RVL-201)"
    compat: [false, false, false, false, true, false]
  - title: "Wii U"
    description: "Nintendo Wii U - All Models"
    compat: [false, false, false, false, true, true]

---

## Home

{{< home.inline >}}
  <table>
    <thead>
      <tr>
        <th></th>
        {{ range .Page.Params.homeFormats }}
          <th><abbr title="{{ .description }}">{{ .title }}</abbr></th>
        {{ end }}
      </tr>
    </thead>
    <tbody>
      {{ range $device := .Page.Params.homeHardwares }}
        <tr>
          <th><abbr title="{{ $device.description }}">{{ $device.title }}</abbr></th>
          {{ range $i, $status := $device.compat }}
            <td>{{ cond $status "🟢" "🔴"}}</td>
          {{ end }}
        </tr>
      {{ end }}
    </tbody>
  </table>
{{< /home.inline >}}


## Handheld

{{< handheld.inline >}}
  <table>
    <thead>
      <tr>
        <th></th>
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
{{< /handheld.inline >}}

## Notes

- There are tons of compatibility quirks. See the relevant wikipedia articles and cited references for more information.
- This page is concerned with physical media compatibility. Digital software is not in scope.
- I left out the Virtual Boy intentionally.
