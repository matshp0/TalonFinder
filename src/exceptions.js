export class ExpiredException extends Error {
  constructor(message) {
    super(message);
    this.name = 'ExpiredException';
  }
}
