export class AsyncQueue {
  #running;
  constructor() {
    this.queue = [];
    this.minTimeout = 500;
    this.maxTimeout = 5000;
    this.onErrorTimeout = 0;
    this.batchSize = 10;
    this.#running = false;
  }

  async runTask(task) {
    const minTimeoutPromise = new Promise((resolve) => {
      setTimeout(resolve, this.minTimeout);
    });
    return new Promise((resolve, reject) => {
      const maxTimeout = setTimeout(() => reject('Async queue timeout exceeded'), this.maxTimeout);
      Promise.allSettled([task(), minTimeoutPromise])
        .then((arr) => {
          const { value, reason } = arr[0];
          if (value) resolve(value);
          else {
            clearTimeout(maxTimeout);
            if (this.onErrorTimeout) setTimeout(() => reject(reason), this.onErrorTimeout);
            else reject(reason);
          }
        });
    });
  }

  async start() {
    this.#running = true;
    const resultBatch = [];
    const length = Math.min(this.batchSize, this.queue.length);
    for (let i = 0; i < length; i++) {
      const { task, resolve, reject } = this.queue.shift();
      const resultPromise = this.runTask(task);
      resultPromise
        .then(resolve)
        .catch(reject);
      resultBatch.push(resultPromise);
    }
    await Promise.allSettled(resultBatch);
    this.#running = false;
    this.#restart();
  }

  process(f) {
    const promise = new Promise((resolve, reject) => {
      this.queue.push({ 'task': f, resolve, reject });
    });
    this.#restart();
    return promise;
  }

  #restart() {
    if (!this.#running && this.queue.length) this.start();
  }
}


