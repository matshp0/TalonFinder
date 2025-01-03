export class RedirectException extends Error {
  constructor(message) {
    super(message);
    this.name = 'RedirectException';
  }
}
