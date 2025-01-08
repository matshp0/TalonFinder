import dotenv from 'dotenv';

try {
  dotenv.config({ path: '.env' });
} catch (e) {
  console.log(e);
}
