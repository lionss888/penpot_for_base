#!/usr/bin/env node
/**
 * Генерация favicon.ico и og-image.png из logo.svg
 * Запуск: npm run generate
 */
import sharp from "sharp";
import { createRequire } from "module";
import { readFileSync, writeFileSync } from "fs";
const toIco = createRequire(import.meta.url)("to-ico");
import { dirname, join } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const logoPath = join(__dirname, "logo.svg");

async function generate() {
  const svg = readFileSync(logoPath);

  // favicon — PNG и ICO
  const png32 = await sharp(svg).resize(32, 32).png().toBuffer();
  const png16 = await sharp(svg).resize(16, 16).png().toBuffer();
  await sharp(svg).resize(32, 32).png().toFile(join(__dirname, "favicon-32.png"));
  await sharp(svg).resize(16, 16).png().toFile(join(__dirname, "favicon-16.png"));

  const ico = await toIco([png16, png32]);
  writeFileSync(join(__dirname, "favicon.ico"), ico);

  // og-image.png — 1200x630 для соцсетей (Open Graph)
  const logoResized = await sharp(svg).resize(400, 134).toBuffer();
  await sharp({
    create: {
      width: 1200,
      height: 630,
      channels: 4,
      background: { r: 37, g: 99, b: 235, alpha: 1 },
    },
  })
    .composite([{ input: logoResized, left: 400, top: 248 }])
    .png()
    .toFile(join(__dirname, "og-image.png"));

  console.log("Generated: favicon.ico, favicon-32.png, favicon-16.png, og-image.png");
}

generate().catch((e) => {
  console.error(e);
  process.exit(1);
});
