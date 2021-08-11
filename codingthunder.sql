-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 11, 2021 at 08:32 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.4.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `phone_num` varchar(12) NOT NULL,
  `email` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phone_num`, `email`, `msg`, `date`) VALUES
(1, 'firstpost', '123456789', 'firstpost@gmail.com', 'firstpost', '2021-07-25 17:10:59'),
(2, 'Kiran ', '123456789', 'allis@gmail.com', 'All is well', '2021-07-25 22:38:18'),
(3, 'Sahil', '6767676767', 'sahil@gmail.com', 'All is well', '2021-08-02 20:24:08'),
(4, 'Sanju', '7878787878', 'allis@gmail.com', 'All is well Sanju', '2021-08-03 22:31:44'),
(5, 'Sanju', '7878787878', 'allis@gmail.com', 'All is well Sanju', '2021-08-03 22:46:30'),
(6, 'Sanju', '7878787878', 'allis@gmail.com', 'All is well Sanju', '2021-08-03 22:54:23'),
(7, 'Sanju', '7878787878', 'allis@gmail.com', 'All is well Sanju', '2021-08-03 22:54:44'),
(8, 'Sanju', '7878787878', 'allis@gmail.com', 'All is well Sanju', '2021-08-03 22:55:43'),
(9, 'Sanju', '7878787878', 'allis@gmail.com', 'All is well Sanju', '2021-08-03 22:59:28'),
(10, 'Sanju', '7878787878', 'allis@gmail.com', 'All is well Man', '2021-08-03 23:05:16'),
(11, 'kalia', '1212121212', 'kalia@gmail.com', 'Kalia he jagabandhu.', '2021-08-03 23:10:29');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` varchar(50) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(20) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'This is my first blog post.', 'This is first post edited', 'first-post', 'This is my first blog post and I am very excited to learn about flask micro framework.', 'post-bg.jpg', '2021-08-11 11:46:15'),
(2, 'This is my second post.', 'This is second post', 'second-post', 'A Jinja template is simply a text file. Jinja can generate any text-based format (HTML, XML, CSV, LaTeX, etc.). A Jinja template doesn’t need to have a specific extension: .html, .xml, or any other extension is just fine.\r\n\r\nA template contains variables and/or expressions, which get replaced with values when a template is rendered; and tags, which control the logic of the template. The template syntax is heavily inspired by Django and Python.\r\n\r\nBelow is a minimal template that illustrates a few basics using the default Jinja configuration. We will cover the details later in this document:', 'post-bg.jpg', '2021-08-11 11:51:57'),
(3, 'This is third post', 'Third post', 'third-post', 'As stated above, any file can be loaded as a template, regardless of file extension. Adding a .jinja extension, like user.html.jinja may make it easier for some IDEs or editor plugins, but is not required. Autoescaping, introduced later, can be applied based on file extension, so you’ll need to take the extra suffix into account in that case.\r\n\r\nAnother good heuristic for identifying templates is that they are in a templates folder, regardless of extension. This is a common layout for projects.', 'post-bg.jpg', '2021-08-11 11:52:10'),
(4, 'This is fourth post', 'fourth post', 'fourth-post', 'Template variables are defined by the context dictionary passed to the template.\r\n\r\nYou can mess around with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.\r\n\r\nYou can use a dot (.) to access attributes of a variable in addition to the standard Python __getitem__ “subscript” syntax ([]).\r\n\r\nThe following lines do the same thing:\r\n\r\n{{ foo.bar }}\r\n{{ foo[\'bar\'] }}\r\n\r\nIt’s important to know that the outer double-curly braces are not part of the variable, but the print statement. If you access variables inside tags don’t put the braces around them.\r\n\r\nIf a variable or attribute does not exist, you will get back an undefined value. What you can do with that kind of value depends on the application configuration: the default behavior is to evaluate to an empty string if printed or iterated over, and to fail for every other operation.', 'post-bg.jpg', '2021-08-11 11:52:29'),
(5, 'This is fifth post ', 'fifth post', 'fifth-post', 'Variables can be modified by filters. Filters are separated from the variable by a pipe symbol (|) and may have optional arguments in parentheses. Multiple filters can be chained. The output of one filter is applied to the next.\r\n\r\nFor example, {{ name|striptags|title }} will remove all HTML Tags from variable name and title-case the output (title(striptags(name))).\r\n\r\nFilters that accept arguments have parentheses around the arguments, just like a function call. For example: {{ listx|join(\', \') }} will join a list with commas (str.join(\', \', listx)).\r\n\r\nThe List of Builtin Filters below describes all the builtin filters.', 'post-bg.jpg', '2021-08-11 11:52:46'),
(6, 'This is sixth post.', 'sixth post', 'sixth-post', 'Beside filters, there are also so-called “tests” available. Tests can be used to test a variable against a common expression. To test a variable or expression, you add is plus the name of the test after the variable. For example, to find out if a variable is defined, you can do name is defined, which will then return true or false depending on whether name is defined in the current template context.\r\n\r\nTests can accept arguments, too. If the test only takes one argument, you can leave out the parentheses. For example, the following two expressions do the same thing:\r\n\r\n{% if loop.index is divisibleby 3 %}\r\n{% if loop.index is divisibleby(3) %}\r\n\r\nThe List of Builtin Tests below describes all the builtin tests.', 'post-bg.jpg', '2021-08-11 11:52:57'),
(7, 'latest', 'latest-tagline', 'new-slug', 'something', 'post-bg.jpg', '2021-08-11 11:53:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
