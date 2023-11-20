const axios = require("axios");
const cheerio = require("cheerio");
const fs = require("fs");

const url = "https://spisnickou.cz/pisnicky-podle-nazvu";

const songModel = {
  title: "",
  artist: "",
  url: "",
  tags: [],
  content: {},
};

function getAllSongs(url) {
  axios
    .get(url)
    .then((response) => {
      const $ = cheerio.load(response.data);
      const songs = [];

      $(".table-responsive-md tbody tr").each((i, element) => {
        const song = { ...songModel };

        song.title = $(element).find("td:first-child").text();
        song.artist = $(element).find("td:nth-child(3)").text();
        song.url = $(element).find("td:first-child a").attr("href");
        song.tags = [];
        $(element)
          .find("td:nth-child(2) a span")
          .each((i, element) => {
            song.tags.push($(element).text());
          });

        songs.push(song);
      });
      console.log(songs);
      fs.writeFileSync("songs.json", JSON.stringify(songs, null, 2), "utf-8");
      return songs;
    })
    .catch((error) => {
      console.error(error);
    });
}

function parseSong(html) {
  const $ = cheerio.load(html);

  const ultimateGuitarFormat = [];
  const initPart = {
    verse: "",
    content: "",
  };
  let part = { ...initPart };
  $(".song-part").each((i, element) => {
    const partType = $(element).attr("class").split(" ")[1];
    console.log(partType);
    switch (partType) {
      case "vers":
        if (part.verse.length > 0) {
          ultimateGuitarFormat.push(part);
        }
        part = { ...initPart };
        part.verse = $(element).text().trim();
        break;
      case "empty":
        break;
      case "cont":
        const chords = [];

        $(element)
          .children("a")
          .each((i, element) => {
            chords.push($(element).text().trim());
            $(element).replaceWith("#");
          });

        chordText = $(element).text();
        console.log(chordText.replace(/\n/g, "").replace(/\s\s+  /g, " "));
        console.log(chords);
        chordTemplate =
          chordText
            .replace(/\n/g, "")
            .replace(/\s\s+/g, " ")
            .trim()
            .replace(/(?!#)[^\s]/g, " ") + "\n";

        console.log(chordTemplate);
        chords.forEach((chord) => {
          chordTemplate = chordTemplate.replace(
            new RegExp(`#${" ".repeat(chord.length)}?`),
            chord
          );
        });
        part.content += chordTemplate;

        part.content +=
          chordText
            .replace(/\n/g, "")
            .replace(/#/g, "")
            .trim()
            .replace(/\s\s+/g, " ") + "\n";

        break;
      default:
        console.log("Unknown part type: ", partType);
    }
  });

  if (part.verse.length > 0) {
    ultimateGuitarFormat.push(part);
  }

  return ultimateGuitarFormat;
}

function getSong(url) {
  axios.get(url).then((response) => {
    parseSong(response.data);

}

const html = fs.readFileSync("sample.html", "utf-8");

const ultimateGuitarFormat = parseSong(html);
fs.writeFileSync(
  "output.json",
  JSON.stringify(ultimateGuitarFormat, null, 2),
  "utf-8"
);

console.log("Conversion complete. Output saved to output.json");

const songs = getAllSongs(url);
