/**
 * baza-api — API Gateway для База
 * REST-обёртка над ядром, прокси и кастомные эндпоинты
 */

import express from "express";
import { createProxyMiddleware } from "http-proxy-middleware";

const app = express();
const PORT = process.env.PORT || 3000;
const BACKEND_URL = process.env.BAZA_BACKEND_URL || "http://localhost:9001";

// Health check
app.get("/health", (_req, res) => {
  res.json({ status: "ok", service: "baza-api" });
});

// API info
app.get("/api/baza/v1", (_req, res) => {
  res.json({
    name: "База API",
    version: "1.0",
    docs: "/api/baza/v1/openapi.json",
  });
});

// OpenAPI spec (минимальный)
app.get("/api/baza/v1/openapi.json", (_req, res) => {
  res.json({
    openapi: "3.0.3",
    info: { title: "База API", version: "1.0.0" },
    paths: { "/health": { get: { summary: "Health check" } } },
  });
});

// Прокси к ядру для /api/baza/v1/*
// Backend использует RPC; pathRewrite — при необходимости маппинга
app.use(
  "/api/baza/v1",
  createProxyMiddleware({
    target: BACKEND_URL,
    changeOrigin: true,
    onError: (err, req, res) => {
      console.error("Proxy error:", err.message);
      res.status(502).json({ error: "Backend unavailable" });
    },
  })
);

app.listen(PORT, () => {
  console.log(`baza-api listening on port ${PORT}`);
  console.log(`Backend: ${BACKEND_URL}`);
});
