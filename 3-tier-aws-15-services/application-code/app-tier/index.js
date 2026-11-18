const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
const getDatabaseConfig = require('./DbConfig');

const app = express();
const port = process.env.PORT || 4000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

let pool;
let dbConnected = false;

// Initialize Database connection & auto-create table
async function initDB() {
  try {
    const config = await getDatabaseConfig();
    console.log(`Connecting to database at ${config.host}...`);

    pool = mysql.createPool({
      host: config.host,
      user: config.user,
      password: config.password,
      database: config.database,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0
    });

    // Verify connection
    const connection = await pool.getConnection();
    console.log('✅ Connected to MySQL RDS successfully!');

    // Create table if not exists
    await connection.query(`
      CREATE TABLE IF NOT EXISTS transactions (
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        amount DECIMAL(10,2) NOT NULL,
        description VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);
    console.log('✅ Table "transactions" ready.');
    connection.release();
    dbConnected = true;
  } catch (err) {
    console.error('❌ Database connection/setup error:', err.message);
    dbConnected = false;
  }
}

initDB();

// 1. Health check endpoint (for ALB Target Group)
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy',
    tier: 'app-tier',
    database: dbConnected ? 'connected' : 'connecting_or_error',
    timestamp: new Date().toISOString()
  });
});

// 2. Fetch all transactions
app.get('/transaction', async (req, res) => {
  if (!pool) {
    return res.status(503).json({ error: 'Database not initialized yet. Please retry.' });
  }
  try {
    const [rows] = await pool.query('SELECT * FROM transactions ORDER BY id DESC');
    res.status(200).json({ result: rows });
  } catch (err) {
    console.error('Error fetching transactions:', err.message);
    res.status(500).json({ error: err.message });
  }
});

// 3. Add a transaction
app.post('/transaction', async (req, res) => {
  if (!pool) {
    return res.status(503).json({ error: 'Database not initialized yet. Please retry.' });
  }
  const { amount, desc } = req.body;
  if (!amount || !desc) {
    return res.status(400).json({ error: 'Please provide both "amount" and "desc"' });
  }
  try {
    const [result] = await pool.query(
      'INSERT INTO transactions (amount, description) VALUES (?, ?)',
      [amount, desc]
    );
    res.status(200).json({
      message: 'Transaction added successfully',
      id: result.insertId,
      amount,
      desc
    });
  } catch (err) {
    console.error('Error adding transaction:', err.message);
    res.status(500).json({ error: err.message });
  }
});

// 4. Delete all transactions
app.delete('/transaction', async (req, res) => {
  if (!pool) {
    return res.status(503).json({ error: 'Database not initialized yet.' });
  }
  try {
    await pool.query('DELETE FROM transactions');
    res.status(200).json({ message: 'All transactions deleted successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(port, () => {
  console.log(`🚀 App Tier running on http://0.0.0.0:${port}`);
});
