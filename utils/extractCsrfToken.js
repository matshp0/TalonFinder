export function extractCsrfToken(inputString) {
  const regex = /cfsr_token\s*:\s*"([a-f0-9]{32})"/;
  const match = inputString.match(regex);

  return match ? match[1] : null;
}
