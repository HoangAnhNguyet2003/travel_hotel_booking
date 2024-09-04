const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// Đăng ký tài khoản
exports.signupUser = async (req, res) => {
    const { fullname, email, password } = req.body;
    try {
         // Kiểm tra các trường không được để trống
        if (!fullname || !email || !password) {
            return res.status(400).json({ message: 'All fields are required.' });
        }
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: 'Email already exists.' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const user = new User({ fullname, email, password: hashedPassword });
        const savedUser = await user.save();

        // Tạo token
        const token = jwt.sign({ id: savedUser._id }, process.env.JWT_SECRET, { expiresIn: '1h' });
        savedUser.token = token; 
        await savedUser.save(); 

        res.status(201).json({ token, user: savedUser });
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
};

// Đăng nhập tài khoản
exports.signinUser = async (req, res) => {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: ' Email does not exist.' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Incorrect password.' });
        }

        // Tạo token
        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });

        res.json({ token, user });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }  
};  
