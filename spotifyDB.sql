-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-01-2025 a las 18:24:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `spotify`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `album`
--

CREATE TABLE `album` (
  `id` int(11) NOT NULL,
  `anioo` int(11) DEFAULT NULL,
  `direccion_imagen` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `artista` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `album`
--

INSERT INTO `album` (`id`, `anioo`, `direccion_imagen`, `nombre`, `artista`) VALUES
(1, 1980, 'includes/albumes/Village.jpeg', 'Village People Live and Sleazy', 'vpeople'),
(2, 1990, 'includes/albumes/Violator.jpeg', 'Violator', 'dmode'),
(3, 1983, 'includes/albumes/She.jpeg', 'She’s So Unusual', 'clauper'),
(4, 1984, 'includes/albumes/Born.jpeg', 'Born In The U.S.A.', 'bruceTheBoss'),
(5, 1965, 'includes/albumes/It’sNot.jpeg', 'It’s Not Unusual', 'tigerOfWales'),
(6, 2012, 'includes/albumes/AguaYSal.jpeg', 'Agua Y Sal', 'tripleNelson'),
(7, 2001, 'includes/albumes/MTV.jpeg', 'MTV Unplugged', 'la_ley'),
(8, 1875, 'includes/albumes/ElLago.jpeg', 'El Lago De Los Cisnes', 'chaiko'),
(9, 1875, 'includes/albumes/Concierto.jpeg', 'Concierto Para Piano No. 1 En Si Menor, Opus 2', 'chaiko'),
(10, 1994, 'includes/albumes/Primer.jpeg', 'Primer Amor', 'nicoleneu'),
(11, 1993, 'includes/albumes/HayAmores.jpeg', 'Hay Amores Que Matan', 'lospimpi'),
(12, 1993, 'includes/albumes/UnLoco.jpeg', 'Un Loco Como Yo', 'dyangounchained'),
(13, 1989, 'includes/albumes/20Grandes.jpeg', '20 Grandes Éxitos', 'alcides');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `album_canciones`
--

CREATE TABLE `album_canciones` (
  `album_id` int(11) NOT NULL,
  `cancion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `album_canciones`
--

INSERT INTO `album_canciones` (`album_id`, `cancion_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(4, 8),
(4, 9),
(4, 10),
(5, 11),
(6, 12),
(7, 13),
(7, 14),
(8, 15),
(9, 16),
(10, 17),
(11, 18),
(12, 19),
(13, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `album_genero`
--

CREATE TABLE `album_genero` (
  `album_id` int(11) NOT NULL,
  `generos_nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `album_genero`
--

INSERT INTO `album_genero` (`album_id`, `generos_nombre`) VALUES
(1, 'Dance-pop'),
(1, 'Disco'),
(1, 'Pop Clásico'),
(2, 'Electropop'),
(3, 'Dance-pop'),
(3, 'Pop Clásico'),
(4, 'Pop Clásico'),
(4, 'Rock & Roll'),
(4, 'Rock Clásico'),
(5, 'Pop Clásico'),
(5, 'Rock Clásico'),
(6, 'Rock Latino'),
(7, 'Pop Clásico'),
(7, 'Rock Latino'),
(8, 'Clásica'),
(9, 'Clásica'),
(10, 'Electropop'),
(11, 'Balada'),
(11, 'Pop Clásico'),
(12, 'Balada'),
(12, 'Pop Clásico'),
(13, 'Cumbia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `artista`
--

CREATE TABLE `artista` (
  `nick` varchar(255) NOT NULL,
  `DireccionWeb` varchar(255) DEFAULT NULL,
  `biografia` varchar(1200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `artista`
--

INSERT INTO `artista` (`nick`, `DireccionWeb`, `biografia`) VALUES
('alcides', NULL, 'Alcides es un cantante argentino que comenzó su carrera en 1976 con la banda Los Playeros. Su éxito se consolidó en los años 1990 con el lanzamiento de varios álbumes populares.'),
('boba', 'https://google.com', 'Escriba una breve biografía.'),
('bruceTheBoss', 'brucespringsteen.net', ''),
('chaiko', NULL, 'Piotr Ilich Chaikovski fue un compositor ruso del período del Romanticismo. Sus obras abarcan una variedad de géneros, incluyendo sinfonías, óperas y ballets.'),
('clauper', 'cyndilauper.com', 'Cynthia Ann Stephanie Lauper, conocida simplemente como Cyndi Lauper, es una cantautora, actriz y empresaria estadounidense. Después de participar en el grupo musical, Blue Angel, en 1983 firmó con Portrait Records y lanzó su exitoso álbum debut She\'s So '),
('dmode', 'www.depechemode.com', ''),
('dyangounchained', NULL, 'Dyango es un cantante español conocido por su música romántica y sus baladas sentimentales.'),
('la_ley', NULL, ''),
('lospimpi', 'www.pimpinela.net', ''),
('nicoleneu', 'bit.ly/nicoleneu', ''),
('tigerOfWales', 'www.tomjones.com', 'Tom Jones es un cantante británico conocido por su potente voz y sus éxitos en los géneros del pop y del soul. Ha vendido más de 100 millones de discos en todo el mundo.'),
('tripleNelson', NULL, 'La Triple Nelson es un grupo de rock uruguayo formado en enero de 1998. Su música se caracteriza por su estilo rockero y letras profundas.'),
('vpeople', 'www.officialvillagepeople.com', 'Village People es una innovadora formación musical de estilo disco de finales de los años 70. Fue famosa tanto por sus peculiares disfraces, como por sus canciones pegadizas, con letras sugerentes y llenas de dobles sentidos.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cancion`
--

CREATE TABLE `cancion` (
  `id` int(11) NOT NULL,
  `direccion_archivo_de_audio` varchar(255) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `genero` varchar(255) DEFAULT NULL,
  `reproducciones` int(11) NOT NULL,
  `descargas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cancion`
--

INSERT INTO `cancion` (`id`, `direccion_archivo_de_audio`, `duracion`, `nombre`, `genero`, `reproducciones`, `descargas`) VALUES
(1, 'includes/musica/Village People - YMCA.mp3', 202, 'YMCA', NULL, 17, 0),
(2, 'includes/musica/Village People - Macho Man.mp3', 208, 'Macho Man', NULL, 3, 0),
(3, 'includes/musica/Village People - In the Navy - Original Version 1979.mp3', 193, 'In the Navy', NULL, 3, 0),
(4, 'includes/musica/Depeche Mode - Personal Jesus.mp3', 295, 'Personal Jesus', NULL, 11, 1),
(5, 'includes/musica/Depeche Mode - Enjoy the Silence.mp3', 372, 'Enjoy The Silence', NULL, 1, 1),
(6, 'includes/musica/Cyndi Lauper - Girls Just Want to Have Fun.mp3', 195, 'Girls Just Want To Have Fun', NULL, 6, 0),
(7, 'includes/musica/Cyndi Lauper - Time After Time.mp3', 312, 'Time After Time', NULL, 5, 0),
(8, 'includes/musica/Bruce Springsteen - Born in the U.S.A..mp3', 298, 'Born In The U.S.A.', NULL, 3, 1),
(9, 'includes/musica/Bruce Springsteen - Glory Days.mp3', 323, 'Glory Days', NULL, 1, 0),
(10, 'includes/musica/Bruce Springsteen - Dancing In the Dark.mp3', 238, 'Dancing In The Park', NULL, 1, 0),
(11, 'includes/musica/Tom Jones - Its Not Unusual.mp3', 120, 'It’s Not Unusual', NULL, 1, 2),
(12, 'includes/musica/Alfredo Zitarrosa - Adagio en Mi País.mp3', 290, 'Adagio De Mi País', NULL, 5, 0),
(13, 'includes/musica/La Ley - El Duelo.mp3', 323, 'El Duelo', NULL, 0, 0),
(14, 'includes/musica/La Ley - Mentira.mp3', 288, 'Mentira', NULL, 0, 0),
(15, 'includes/musica/Pyotr Ilyich Tchaikovsky, Inma Shara - El Lago De Los Cisnes - Op. 20, Acto II- 10. Scene (Moderato).mp3', 186, 'Acto 2, Número 10, Escena (Moderato)', NULL, 15, 0),
(16, 'includes/musica/Orquestra de Câmara de Blumenau - Allegro.mp3', 1318, 'Primer Movimiento (Allegro non troppo e molto maestoso – Allegro con spirito)', NULL, 6, 1),
(17, 'includes/musica/JAY WONDER 01 - No Quiero Estudiar.mp3', 132, 'No Quiero Estudiar', NULL, 0, 0),
(18, 'includes/musica/Pimpinela, Dyango - Por Ese Hombre.mp3', 270, 'Por Ese Hombre', NULL, 121, 0),
(19, 'includes/musica/Pimpinela, Dyango - Por Ese Hombreee.mp3', 270, 'Por Ese Hombre', NULL, 0, 0),
(20, 'includes/musica/Alcides - Violeta.mp3', 190, 'Violeta', 'Pop', 56, 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `nick` varchar(255) NOT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `fecSub` date DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`nick`, `estado`, `fecSub`, `tipo`) VALUES
('benKenobi', 'Cancelado', NULL, NULL),
('bob', 'Vigente', '2024-10-08', 12),
('cbochinche', 'Cancelado', '2024-12-17', 0),
('Eleven11', 'Cancelado', NULL, NULL),
('el_padrino', 'Cancelado', NULL, NULL),
('Heisenberg', 'Cancelado', NULL, NULL),
('lachiqui', 'Vigente', '2024-11-25', 365),
('ppArgento', 'Cancelado', NULL, NULL),
('scarlettO', 'Cancelado', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_albumesfavoritos`
--

CREATE TABLE `cliente_albumesfavoritos` (
  `cliente_id` varchar(255) NOT NULL,
  `album_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente_albumesfavoritos`
--

INSERT INTO `cliente_albumesfavoritos` (`cliente_id`, `album_id`) VALUES
('bob', 3),
('cbochinche', 12),
('ppArgento', 8),
('ppArgento', 9),
('vpeople', 2),
('vpeople', 8),
('vpeople', 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_cancionesfavoritas`
--

CREATE TABLE `cliente_cancionesfavoritas` (
  `cliente_id` varchar(255) NOT NULL,
  `cancion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente_cancionesfavoritas`
--

INSERT INTO `cliente_cancionesfavoritas` (`cliente_id`, `cancion_id`) VALUES
('bob', 2),
('bob', 4),
('bob', 15),
('cbochinche', 15),
('el_padrino', 17),
('lachiqui', 12),
('ppArgento', 6),
('vpeople', 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_playlistfavoritas`
--

CREATE TABLE `cliente_playlistfavoritas` (
  `cliente_id` varchar(255) NOT NULL,
  `playlist_particular_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente_playlistfavoritas`
--

INSERT INTO `cliente_playlistfavoritas` (`cliente_id`, `playlist_particular_id`) VALUES
('bob', 4),
('cbochinche', 1),
('cbochinche', 2),
('Heisenberg', 4),
('ppArgento', 1),
('ppArgento', 2),
('scarlettO', 3),
('vpeople', 1),
('vpeople', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_usuariosseguidos`
--

CREATE TABLE `cliente_usuariosseguidos` (
  `cliente_id` varchar(255) NOT NULL,
  `usuario_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente_usuariosseguidos`
--

INSERT INTO `cliente_usuariosseguidos` (`cliente_id`, `usuario_id`) VALUES
('benKenobi', 'alcides'),
('benKenobi', 'bruceTheBoss'),
('benKenobi', 'cbochinche'),
('benKenobi', 'chaiko'),
('benKenobi', 'dmode'),
('benKenobi', 'Eleven11'),
('benKenobi', 'el_padrino'),
('benKenobi', 'lachiqui'),
('benKenobi', 'la_ley'),
('benKenobi', 'lospimpi'),
('benKenobi', 'nicoleneu'),
('benKenobi', 'ppArgento'),
('bob', 'clauper'),
('bob', 'lachiqui'),
('cbochinche', 'alcides'),
('cbochinche', 'dyangounchained'),
('cbochinche', 'la_ley'),
('cbochinche', 'lospimpi'),
('cbochinche', 'ppArgento'),
('Eleven11', 'el_padrino'),
('Eleven11', 'la_ley'),
('Eleven11', 'ppArgento'),
('Eleven11', 'scarlettO'),
('el_padrino', 'benKenobi'),
('el_padrino', 'cbochinche'),
('el_padrino', 'clauper'),
('el_padrino', 'dmode'),
('el_padrino', 'Eleven11'),
('el_padrino', 'lachiqui'),
('el_padrino', 'vpeople'),
('Heisenberg', 'alcides'),
('Heisenberg', 'benKenobi'),
('Heisenberg', 'bruceTheBoss'),
('Heisenberg', 'dmode'),
('Heisenberg', 'dyangounchained'),
('Heisenberg', 'Eleven11'),
('Heisenberg', 'el_padrino'),
('Heisenberg', 'lachiqui'),
('Heisenberg', 'lospimpi'),
('Heisenberg', 'ppArgento'),
('Heisenberg', 'scarlettO'),
('Heisenberg', 'tigerOfWales'),
('Heisenberg', 'tripleNelson'),
('lachiqui', 'alcides'),
('lachiqui', 'bruceTheBoss'),
('lachiqui', 'el_padrino'),
('lachiqui', 'la_ley'),
('lachiqui', 'lospimpi'),
('lachiqui', 'ppArgento'),
('lachiqui', 'scarlettO'),
('ppArgento', 'benKenobi'),
('ppArgento', 'bruceTheBoss'),
('ppArgento', 'cbochinche'),
('ppArgento', 'dmode'),
('ppArgento', 'Eleven11'),
('ppArgento', 'lachiqui'),
('ppArgento', 'tripleNelson'),
('scarlettO', 'benKenobi'),
('scarlettO', 'bruceTheBoss'),
('scarlettO', 'dmode'),
('scarlettO', 'Heisenberg'),
('scarlettO', 'lachiqui'),
('scarlettO', 'tigerOfWales'),
('scarlettO', 'tripleNelson');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `nombre` varchar(255) NOT NULL,
  `padre_nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`nombre`, `padre_nombre`) VALUES
('Balada', NULL),
('Clásica', NULL),
('Cumbia', NULL),
('Disco', NULL),
('Pop', NULL),
('Rock', NULL),
('Dance-pop', 'Pop'),
('Electropop', 'Pop'),
('Pop Clásico', 'Pop'),
('Rock & Roll', 'Rock'),
('Rock Clásico', 'Rock'),
('Rock Latino', 'Rock');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_sesion`
--

CREATE TABLE `log_sesion` (
  `ID` bigint(20) NOT NULL,
  `ip_usuario` varchar(255) NOT NULL,
  `navegador` varchar(255) NOT NULL,
  `sistema_operativo` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `log_sesion`
--

INSERT INTO `log_sesion` (`ID`, `ip_usuario`, `navegador`, `sistema_operativo`, `url`) VALUES
(1, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(2, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(3, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(4, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(5, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(6, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(7, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(8, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(9, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(10, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(11, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(12, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(13, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(14, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(15, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(16, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/rankingUsuarios.jsp'),
(17, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(18, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarFavoritos.jsp'),
(19, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(20, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarFavoritos.jsp'),
(21, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(22, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarFavoritos.jsp'),
(23, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(24, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarFavoritos.jsp'),
(25, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(26, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(27, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=alcides&user=13'),
(28, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=alcides&user=13'),
(29, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(30, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(31, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=alcides&user=13'),
(32, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(33, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/rankingUsuarios.jsp'),
(34, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(35, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(36, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(37, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=tigerOfWales&user=5'),
(38, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(39, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(40, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(41, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(42, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/register.jsp'),
(43, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?'),
(44, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(45, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(46, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(47, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(48, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(49, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/AltaAlbum.jsp'),
(50, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(51, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(52, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(53, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(54, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(55, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(56, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(57, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(58, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(59, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(60, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(61, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(62, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(63, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(64, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(65, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(66, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(67, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(68, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(69, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(70, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(71, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(72, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(73, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(74, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(75, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(76, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(77, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(78, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(79, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp'),
(80, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(81, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(82, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(83, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(84, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(85, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(86, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(87, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(88, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(89, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(90, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(91, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(92, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(93, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(94, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(95, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/register.jsp'),
(96, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?'),
(97, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(98, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(99, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/AltaAlbum.jsp'),
(100, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(101, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(102, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(103, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=701'),
(104, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(105, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=701'),
(106, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(107, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(108, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(109, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(110, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(111, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(112, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(113, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(114, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(115, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(116, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(117, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(118, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(119, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(120, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(121, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(122, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(123, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(124, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/register.jsp'),
(125, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?'),
(126, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(127, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(128, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(129, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(130, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(131, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(132, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(133, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(134, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(135, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(136, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp'),
(137, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(138, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(139, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(140, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(141, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(142, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(143, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(144, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(145, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(146, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(147, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(148, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(149, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(150, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(151, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(152, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(153, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(154, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(155, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(156, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(157, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(158, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(159, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(160, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(161, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(162, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(163, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/register.jsp'),
(164, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?'),
(165, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(166, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(167, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(168, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(169, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(170, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(171, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(172, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/register.jsp'),
(173, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/register.jsp'),
(174, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?'),
(175, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(176, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(177, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(178, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(179, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(180, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(181, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(182, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(183, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(184, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(185, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(186, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(187, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(188, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(189, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/AltaAlbum.jsp'),
(190, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(191, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(192, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(193, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=751'),
(194, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(195, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(196, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(197, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(198, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(199, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(200, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(201, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(202, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(203, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(204, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(205, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(206, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(207, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(208, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(209, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(210, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(211, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(212, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(213, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(214, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(215, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(216, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(217, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(218, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(219, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(220, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(221, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(222, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(223, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(224, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(225, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(226, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(227, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(228, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(229, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=751'),
(230, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(231, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(232, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(233, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(234, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(235, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(236, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(237, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(238, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(239, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(240, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(241, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(242, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(243, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(244, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(245, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(246, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=751'),
(247, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(248, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(249, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(250, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(251, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(252, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(253, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(254, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(255, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(256, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(257, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(258, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/AltaAlbum.jsp'),
(259, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(260, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(261, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(262, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=801'),
(263, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(264, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=801'),
(265, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=801'),
(266, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(267, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(268, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/AltaAlbum.jsp'),
(269, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(270, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(271, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/AltaAlbum.jsp'),
(272, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(273, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(274, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(275, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=804'),
(276, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(277, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=802'),
(278, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(279, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/AltaAlbum.jsp'),
(280, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(281, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(282, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(283, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=804'),
(284, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=806'),
(285, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=804'),
(286, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=806'),
(287, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=802'),
(288, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=806'),
(289, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(290, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(291, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(292, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(293, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(294, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=806'),
(295, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=boba&user=806'),
(296, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(297, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(298, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(299, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(300, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(301, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(302, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(303, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(304, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(305, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(306, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(307, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(308, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(309, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(310, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(311, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(312, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(313, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(314, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(315, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(316, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(317, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(318, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(319, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(320, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(321, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(322, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(323, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(324, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(325, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(326, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(327, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(328, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(329, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(330, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(331, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(332, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(333, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(334, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(335, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(336, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(337, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(338, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(339, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(340, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(341, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(342, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(343, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(344, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(345, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(346, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(347, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(348, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(349, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(350, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(351, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(352, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(353, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(354, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(355, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(356, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(357, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(358, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(359, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(360, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(361, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(362, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(363, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(364, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(365, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(366, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(367, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(368, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(369, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(370, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(371, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(372, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(373, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(374, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(375, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(376, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(377, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(378, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(379, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(380, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(381, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(382, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(383, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(384, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(385, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(386, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(387, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(388, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylistVisitante.jsp?user=4'),
(389, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(390, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(391, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylistVisitante.jsp?user=4'),
(392, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(393, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(394, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylistVisitante.jsp?user=4'),
(395, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(396, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(397, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylistVisitante.jsp?user=4'),
(398, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(399, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(400, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylistVisitante.jsp?user=4'),
(401, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(402, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(403, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylistVisitante.jsp?user=4'),
(404, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(405, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(406, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylistVisitante.jsp?user=4'),
(407, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(408, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(409, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(410, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=1'),
(411, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(412, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(413, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=8'),
(414, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(415, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(416, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=1'),
(417, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(418, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(419, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=1'),
(420, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(421, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(422, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(423, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(424, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(425, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(426, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(427, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(428, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(429, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(430, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(431, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(432, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(433, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(434, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(435, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(436, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(437, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(438, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(439, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(440, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(441, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(442, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(443, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(444, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(445, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(446, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(447, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(448, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(449, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(450, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(451, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(452, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(453, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(454, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(455, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(456, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(457, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(458, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(459, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(460, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(461, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(462, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(463, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(464, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4');
INSERT INTO `log_sesion` (`ID`, `ip_usuario`, `navegador`, `sistema_operativo`, `url`) VALUES
(465, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(466, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(467, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=15'),
(468, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(469, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(470, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(471, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(472, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=16'),
(473, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(474, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?&user=16'),
(475, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(476, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=15'),
(477, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=16'),
(478, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=15'),
(479, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(480, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(481, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(482, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(483, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(484, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(485, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(486, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(487, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(488, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(489, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/welcome.jsp'),
(490, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/welcome.jsp'),
(491, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principalWelcome.jsp'),
(492, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principalWelcome.jsp'),
(493, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/login.jsp'),
(494, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(495, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(496, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=1'),
(497, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(498, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(499, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(500, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(501, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=1'),
(502, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(503, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(504, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=2'),
(505, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(506, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(507, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=2'),
(508, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/login.jsp'),
(509, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp'),
(510, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(511, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=1'),
(512, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp'),
(513, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(514, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=1'),
(515, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp'),
(516, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(517, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=1'),
(518, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(519, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(520, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(521, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp'),
(522, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/welcome.jsp'),
(523, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principalWelcome.jsp'),
(524, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/welcome.jsp'),
(525, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principalWelcome.jsp'),
(526, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/welcome.jsp'),
(527, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principalWelcome.jsp'),
(528, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/welcome.jsp'),
(529, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principalWelcome.jsp'),
(530, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(531, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(532, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/login.jsp'),
(533, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(534, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(535, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(536, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(537, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(538, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(539, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(540, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(541, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(542, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(543, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(544, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(545, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(546, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(547, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(548, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(549, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(550, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(551, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(552, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(553, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(554, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(555, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(556, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(557, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(558, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(559, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(560, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(561, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(562, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(563, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(564, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(565, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(566, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(567, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(568, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(569, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(570, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(571, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(572, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(573, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(574, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(575, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(576, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(577, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(578, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(579, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(580, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(581, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(582, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(583, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(584, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(585, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(586, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(587, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(588, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(589, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(590, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(591, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(592, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(593, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(594, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(595, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(596, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(597, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(598, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(599, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(600, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(601, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(602, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(603, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(604, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(605, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(606, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(607, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(608, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarFavoritos.jsp'),
(609, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(610, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(611, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(612, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarFavoritos.jsp'),
(613, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(614, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(615, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(616, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarFavoritos.jsp'),
(617, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(618, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarFavoritos.jsp'),
(619, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(620, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=15'),
(621, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=15'),
(622, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(623, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(624, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(625, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=16'),
(626, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=16'),
(627, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(628, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(629, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(630, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(631, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(632, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(633, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarUsuario.jsp?&user=bob'),
(634, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(635, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=alcides&user=13'),
(636, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(637, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=dyangounchained&user=12'),
(638, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=dyangounchained&user=12'),
(639, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=dyangounchained&user=12'),
(640, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=vpeople&user=1'),
(641, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=dyangounchained&user=12'),
(642, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=dyangounchained&user=12'),
(643, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=dyangounchained&user=12'),
(644, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=dyangounchained&user=12'),
(645, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(646, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(647, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(648, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(649, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(650, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=la_ley&user=7'),
(651, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=machi&user=651'),
(652, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=nicoleneu&user=10'),
(653, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=la_ley&user=7'),
(654, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=machi&user=651'),
(655, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=machi&user=651'),
(656, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=machi&user=651'),
(657, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=machi&user=651'),
(658, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=la_ley&user=7'),
(659, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=machi&user=651'),
(660, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=nicoleneu&user=10'),
(661, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=la_ley&user=7'),
(662, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(663, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=dmode&user=2'),
(664, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(665, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(666, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=tripleNelson&user=6'),
(667, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(668, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(669, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(670, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/register.jsp'),
(671, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?'),
(672, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(673, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(674, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=alcides&user=13'),
(675, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(676, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=alcides&user=13'),
(677, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=boba'),
(678, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(679, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(680, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(681, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(682, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=bruceTheBoss&user=4'),
(683, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(684, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(685, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(686, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(687, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=3'),
(688, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=chaiko&user=8'),
(689, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Rock%20&%20Roll'),
(690, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Rock%20Cl%C3%A1sico'),
(691, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Rock%20Latino'),
(692, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Rock%20&%20Roll'),
(693, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Pop%20Cl%C3%A1sico'),
(694, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Electropop'),
(695, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Dance-pop'),
(696, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Pop'),
(697, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Disco'),
(698, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Cumbia'),
(699, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Cl%C3%A1sica'),
(700, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Balada'),
(701, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Balada&user=11'),
(702, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Balada&user=11'),
(703, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Balada&user=12'),
(704, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Balada&user=11'),
(705, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Balada&user=12'),
(706, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=genero&nombre=Balada&user=12'),
(707, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(708, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(709, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(710, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=alcides&user=13'),
(711, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(712, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(713, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=machi&user=651'),
(714, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=651'),
(715, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=651'),
(716, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=16'),
(717, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=16'),
(718, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=16'),
(719, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(720, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=machi&user=651'),
(721, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=651'),
(722, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=16'),
(723, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=16'),
(724, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=16'),
(725, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(726, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(727, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/welcome.jsp'),
(728, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principalWelcome.jsp'),
(729, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/login.jsp'),
(730, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(731, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(732, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=alcides&user=13'),
(733, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(734, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(735, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(736, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(737, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(738, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(739, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(740, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(741, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(742, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(743, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(744, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(745, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(746, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(747, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(748, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(749, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(750, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(751, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(752, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(753, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=boba'),
(754, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(755, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(756, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(757, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(758, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(759, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(760, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=machi'),
(761, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(762, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(763, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(764, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(765, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(766, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(767, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(768, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(769, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?&user=bob'),
(770, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(771, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=17'),
(772, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(773, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(774, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(775, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(776, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=3'),
(777, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=tripleNelson&user=6'),
(778, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(779, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(780, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(781, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=el_padrino'),
(782, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=clauper'),
(783, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=clauper'),
(784, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/rankingUsuarios.jsp'),
(785, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(786, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=17'),
(787, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(788, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=lospimpi'),
(789, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=lospimpi'),
(790, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=lospimpi'),
(791, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=lospimpi&user=11'),
(792, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/rankingUsuarios.jsp'),
(793, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(794, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(795, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=17'),
(796, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(797, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=17'),
(798, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(799, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(800, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=18'),
(801, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(802, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?&user=18'),
(803, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=18'),
(804, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=18'),
(805, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(806, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(807, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=bruceTheBoss&user=4'),
(808, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(809, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(810, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(811, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(812, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(813, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(814, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(815, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(816, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(817, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(818, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(819, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(820, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(821, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(822, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(823, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(824, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(825, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(826, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=17'),
(827, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=18'),
(828, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(829, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=18'),
(830, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=17'),
(831, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(832, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(833, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/welcome.jsp'),
(834, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principalWelcome.jsp'),
(835, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/login.jsp'),
(836, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/index.jsp?'),
(837, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/principal.jsp'),
(838, '26.230.170.200', 'Apple Safari', 'Mac OS', 'http://192.168.1.2:8080/SpotifyWeb/consultarUsuario.jsp?user=chaiko'),
(839, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=tripleNelson&user=6'),
(840, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=tigerOfWales'),
(841, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(842, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=17'),
(843, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=18'),
(844, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(845, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(846, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(847, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(848, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/register.jsp'),
(849, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp'),
(850, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(851, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(852, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(853, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(854, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(855, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=lospimpi'),
(856, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(857, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(858, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(859, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(860, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(861, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(862, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(863, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(864, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(865, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(866, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(867, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(868, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(869, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(870, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(871, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(872, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(873, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(874, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/rankingUsuarios.jsp'),
(875, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(876, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(877, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=1'),
(878, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=17'),
(879, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(880, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=19'),
(881, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=19'),
(882, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(883, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(884, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(885, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=alcides'),
(886, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bruceTheBoss'),
(887, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=clauper'),
(888, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=clauper'),
(889, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(890, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=clauper'),
(891, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(892, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=tripleNelson'),
(893, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(894, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(895, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(896, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=clauper'),
(897, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(898, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=clauper'),
(899, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(900, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(901, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(902, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(903, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(904, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(905, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp?credencialesInvalidas=1'),
(906, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp'),
(907, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(908, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(909, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(910, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(911, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?');
INSERT INTO `log_sesion` (`ID`, `ip_usuario`, `navegador`, `sistema_operativo`, `url`) VALUES
(912, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(913, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(914, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(915, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(916, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(917, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(918, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(919, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(920, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(921, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(922, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(923, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=4'),
(924, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(925, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarPlaylist.jsp?user=3'),
(926, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/ConsultarAlbum.jsp?tipo=artista&nombre=clauper&user=3'),
(927, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(928, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/rankingUsuarios.jsp'),
(929, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=bob'),
(930, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(931, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarFavoritos.jsp'),
(932, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=bob'),
(933, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp'),
(934, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp?'),
(935, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(936, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp'),
(937, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(938, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=cbochinche'),
(939, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=cbochinche'),
(940, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=cbochinche'),
(941, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=cbochinche'),
(942, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=cbochinche'),
(943, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=cbochinche'),
(944, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/consultarUsuario.jsp?user=el_padrino'),
(945, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp?user=cbochinche'),
(946, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/index.jsp'),
(947, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principal.jsp'),
(948, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/'),
(949, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/welcome.jsp'),
(950, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/principalWelcome.jsp'),
(951, '26.230.170.200', 'Google Chrome', 'Windows', 'http://localhost:8080/SpotifyWeb/login.jsp');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlist`
--

CREATE TABLE `playlist` (
  `id` int(11) NOT NULL,
  `DTYPE` varchar(31) DEFAULT NULL,
  `Nombre` varchar(255) DEFAULT NULL,
  `rutaImagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `playlist`
--

INSERT INTO `playlist` (`id`, `DTYPE`, `Nombre`, `rutaImagen`) VALUES
(1, 'PlaylistPorDefecto', 'Noche De La Nostalgia', 'includes/playlist/nostalgia.jpeg'),
(2, 'PlaylistPorDefecto', 'Rock En Español', NULL),
(3, 'PlaylistPorDefecto', 'Música Clásica', 'includes/playlist/musicaCla.jpeg'),
(4, 'PlaylistParticular', 'Música Inspiradora', 'includes/playlist/musicInspi.jpeg'),
(5, 'PlaylistParticular', 'De Todo Un Poco', NULL),
(6, 'PlaylistParticular', 'Para Cocinar', 'includes/playlist/ParaCocinar.jpeg'),
(7, 'PlaylistParticular', 'Para Las Chicas', NULL),
(8, 'PlaylistParticular', 'Fiesteras', 'includes/playlist/fiestaFiesta.jpeg'),
(9, 'PlaylistParticular', 'Mis Favoritas', NULL),
(17, 'PlaylistParticular', 'dsadasd', NULL),
(18, 'PlaylistParticular', 'sddsa', NULL),
(19, 'PlaylistParticular', 'sad mix', 'playlist/Imagen de WhatsApp 2023-04-20 a las 17.51.04.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlistparticular`
--

CREATE TABLE `playlistparticular` (
  `id` int(11) NOT NULL,
  `privada` tinyint(1) DEFAULT 0,
  `propietario` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `playlistparticular`
--

INSERT INTO `playlistparticular` (`id`, `privada`, `propietario`) VALUES
(4, 0, 'el_padrino'),
(5, 0, 'el_padrino'),
(6, 1, 'Heisenberg'),
(7, 0, 'lachiqui'),
(8, 0, 'cbochinche'),
(9, 1, 'cbochinche'),
(17, 0, 'bob'),
(18, 0, 'bob'),
(19, 1, 'bob');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlistpordefecto`
--

CREATE TABLE `playlistpordefecto` (
  `id` int(11) NOT NULL,
  `genero_nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `playlistpordefecto`
--

INSERT INTO `playlistpordefecto` (`id`, `genero_nombre`) VALUES
(3, 'Clásica'),
(1, 'Pop Clásico'),
(2, 'Rock Latino');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `playlist_cancion`
--

CREATE TABLE `playlist_cancion` (
  `playlist_id` int(11) NOT NULL,
  `canciones_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `playlist_cancion`
--

INSERT INTO `playlist_cancion` (`playlist_id`, `canciones_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(2, 12),
(2, 13),
(2, 14),
(3, 15),
(3, 16),
(4, 4),
(4, 15),
(4, 16),
(5, 6),
(5, 7),
(5, 11),
(5, 15),
(6, 4),
(6, 5),
(6, 8),
(6, 9),
(7, 6),
(7, 11),
(7, 16),
(7, 17),
(7, 18),
(8, 1),
(8, 2),
(8, 3),
(8, 9),
(8, 20),
(9, 12),
(9, 16),
(9, 18),
(17, 6),
(17, 7),
(18, 5),
(18, 9),
(19, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sequence`
--

CREATE TABLE `sequence` (
  `SEQ_NAME` varchar(50) NOT NULL,
  `SEQ_COUNT` decimal(38,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sequence`
--

INSERT INTO `sequence` (`SEQ_NAME`, `SEQ_COUNT`) VALUES
('SEQ_GEN', 850);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `nick` varchar(255) NOT NULL,
  `tipo_usuario` varchar(31) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `fecNac` date DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`nick`, `tipo_usuario`, `apellido`, `password`, `fecNac`, `imagen`, `mail`, `nombre`) VALUES
('alcides', 'artista', NULL, '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1952-07-17', NULL, 'alcides@tuta.io', 'Alcides'),
('benKenobi', 'cliente', 'Kenobi', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1914-04-02', 'includes/Usuarios/benKenobi.jpeg', 'benKenobi@gmail.com', 'Obi-Wan'),
('bob', 'cliente', 'bob', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '2005-10-03', 'includes/Usuarios/Heisenberg.jpeg', 'bob', 'bob'),
('boba', 'artista', 'pozzi', '$2a$10$bIvfr2euUNrf2/dtD8o.XuXKekxTk3FB43e8HD3cpRMHMxwsUOtQy', '2024-11-13', NULL, 'bob@bob.com', 'diego'),
('bruceTheBoss', 'artista', 'Springsteen', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1949-09-23', 'includes/Usuarios/bruceTheBoss.jpeg', 'bruceTheBoss@gmail.com', 'Bruce'),
('cbochinche', 'cliente', 'Bochinche', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1937-05-08', 'includes/Usuarios/Bochinche.jpeg', 'cbochinche@vera.com.uy', 'Cacho'),
('chaiko', 'artista', 'Tchaikovsky', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1840-04-25', NULL, 'chaiko@tuta.io', 'Piotr'),
('clauper', 'artista', 'Lauper', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1953-06-22', 'includes/Usuarios/Lauper.jpeg', 'clauper@hotmail.com', 'Cyndi'),
('dmode', 'artista', 'Mode', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1980-06-14', 'includes/Usuarios/Mode.jpeg', 'dmode@tuta.io', 'Depeche'),
('dyangounchained', 'artista', NULL, '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1940-03-05', NULL, 'dyangounchained@gmail.com', 'Dyango'),
('Eleven11', 'cliente', NULL, '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1971-12-31', 'includes/Usuarios/Eleven11.jpeg', 'Eleven11@gmail.com', 'Eleven'),
('el_padrino', 'cliente', 'Corleone', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1972-03-08', 'includes/Usuarios/el_padrino.jpeg', 'el_padrino@tuta.io', 'Vito'),
('Heisenberg', 'cliente', 'White', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1956-03-07', 'includes/Usuarios/Heisenberg.jpeg', 'Heisenberg@tuta.io', 'Walter'),
('lachiqui', 'cliente', 'Legrand', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1927-02-23', 'includes/Usuarios/lachiqui.jpeg', 'rmatias088@gmail.com', 'Mirtha'),
('la_ley', 'artista', 'Ley', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1987-02-14', NULL, 'la_ley@tuta.io', 'La'),
('lospimpi', 'artista', NULL, '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1981-08-13', 'includes/Usuarios/lospimpi.jpeg', 'lospimpi@gmail.com', 'Pimpinela'),
('nicoleneu', 'artista', 'Neumann', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1980-10-31', 'includes/Usuarios/nicoleneu.jpeg', 'nicoleneu@hotmail.com', 'Nicole'),
('ppArgento', 'cliente', 'Argento', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1955-02-14', 'includes/Usuarios/ppArgento.jpeg', 'ppArgento@hotmail.com', 'Pepe'),
('scarlettO', 'cliente', 'O’Hara', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1984-11-27', 'includes/Usuarios/scarlettO.jpg', 'scarlettO@tuta.io', 'Scarlett'),
('tigerOfWales', 'artista', 'Jones', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1940-06-07', NULL, 'tigerOfWales@tuta.io', 'Tom'),
('tripleNelson', 'artista', 'Nelson', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1998-01-01', 'includes/Usuarios/Heisenberg.jpeg', 'tripleNelson@tuta.io', 'La Triple'),
('vpeople', 'artista', 'People', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1977-01-01', 'includes/Usuarios/vpeople.jpeg', 'vpeople@tuta.io', 'Village');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_album_artista` (`artista`);

--
-- Indices de la tabla `album_canciones`
--
ALTER TABLE `album_canciones`
  ADD PRIMARY KEY (`album_id`,`cancion_id`),
  ADD KEY `FK_album_canciones_cancion_id` (`cancion_id`);

--
-- Indices de la tabla `album_genero`
--
ALTER TABLE `album_genero`
  ADD PRIMARY KEY (`album_id`,`generos_nombre`),
  ADD KEY `FK_album_genero_generos_nombre` (`generos_nombre`);

--
-- Indices de la tabla `artista`
--
ALTER TABLE `artista`
  ADD PRIMARY KEY (`nick`);

--
-- Indices de la tabla `cancion`
--
ALTER TABLE `cancion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_cancion_genero` (`genero`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`nick`);

--
-- Indices de la tabla `cliente_albumesfavoritos`
--
ALTER TABLE `cliente_albumesfavoritos`
  ADD PRIMARY KEY (`cliente_id`,`album_id`),
  ADD KEY `FK_cliente_albumesFavoritos_album_id` (`album_id`);

--
-- Indices de la tabla `cliente_cancionesfavoritas`
--
ALTER TABLE `cliente_cancionesfavoritas`
  ADD PRIMARY KEY (`cliente_id`,`cancion_id`),
  ADD KEY `FK_cliente_cancionesFavoritas_cancion_id` (`cancion_id`);

--
-- Indices de la tabla `cliente_playlistfavoritas`
--
ALTER TABLE `cliente_playlistfavoritas`
  ADD PRIMARY KEY (`cliente_id`,`playlist_particular_id`),
  ADD KEY `cliente_playlistFavoritas_playlist_particular_id` (`playlist_particular_id`);

--
-- Indices de la tabla `cliente_usuariosseguidos`
--
ALTER TABLE `cliente_usuariosseguidos`
  ADD PRIMARY KEY (`cliente_id`,`usuario_id`),
  ADD KEY `FK_cliente_usuariosSeguidos_usuario_id` (`usuario_id`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`nombre`),
  ADD KEY `FK_genero_padre_nombre` (`padre_nombre`);

--
-- Indices de la tabla `log_sesion`
--
ALTER TABLE `log_sesion`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `playlistparticular`
--
ALTER TABLE `playlistparticular`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_playlistparticular_propietario` (`propietario`);

--
-- Indices de la tabla `playlistpordefecto`
--
ALTER TABLE `playlistpordefecto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_playlistpordefecto_genero_nombre` (`genero_nombre`);

--
-- Indices de la tabla `playlist_cancion`
--
ALTER TABLE `playlist_cancion`
  ADD PRIMARY KEY (`playlist_id`,`canciones_id`),
  ADD KEY `FK_playlist_cancion_canciones_id` (`canciones_id`);

--
-- Indices de la tabla `sequence`
--
ALTER TABLE `sequence`
  ADD PRIMARY KEY (`SEQ_NAME`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`nick`),
  ADD UNIQUE KEY `mail` (`mail`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `album`
--
ALTER TABLE `album`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=807;

--
-- AUTO_INCREMENT de la tabla `cancion`
--
ALTER TABLE `cancion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=809;

--
-- AUTO_INCREMENT de la tabla `log_sesion`
--
ALTER TABLE `log_sesion`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=952;

--
-- AUTO_INCREMENT de la tabla `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `album`
--
ALTER TABLE `album`
  ADD CONSTRAINT `FK_album_artista` FOREIGN KEY (`artista`) REFERENCES `usuario` (`nick`);

--
-- Filtros para la tabla `album_canciones`
--
ALTER TABLE `album_canciones`
  ADD CONSTRAINT `FK_album_canciones_album_id` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
  ADD CONSTRAINT `FK_album_canciones_cancion_id` FOREIGN KEY (`cancion_id`) REFERENCES `cancion` (`id`);

--
-- Filtros para la tabla `album_genero`
--
ALTER TABLE `album_genero`
  ADD CONSTRAINT `FK_album_genero_album_id` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
  ADD CONSTRAINT `FK_album_genero_generos_nombre` FOREIGN KEY (`generos_nombre`) REFERENCES `genero` (`nombre`);

--
-- Filtros para la tabla `artista`
--
ALTER TABLE `artista`
  ADD CONSTRAINT `FK_artista_nick` FOREIGN KEY (`nick`) REFERENCES `usuario` (`nick`);

--
-- Filtros para la tabla `cancion`
--
ALTER TABLE `cancion`
  ADD CONSTRAINT `FK_cancion_genero` FOREIGN KEY (`genero`) REFERENCES `genero` (`nombre`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `FK_cliente_nick` FOREIGN KEY (`nick`) REFERENCES `usuario` (`nick`);

--
-- Filtros para la tabla `cliente_albumesfavoritos`
--
ALTER TABLE `cliente_albumesfavoritos`
  ADD CONSTRAINT `FK_cliente_albumesFavoritos_album_id` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
  ADD CONSTRAINT `FK_cliente_albumesFavoritos_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `usuario` (`nick`);

--
-- Filtros para la tabla `cliente_cancionesfavoritas`
--
ALTER TABLE `cliente_cancionesfavoritas`
  ADD CONSTRAINT `FK_cliente_cancionesFavoritas_cancion_id` FOREIGN KEY (`cancion_id`) REFERENCES `cancion` (`id`),
  ADD CONSTRAINT `FK_cliente_cancionesFavoritas_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `usuario` (`nick`);

--
-- Filtros para la tabla `cliente_playlistfavoritas`
--
ALTER TABLE `cliente_playlistfavoritas`
  ADD CONSTRAINT `FK_cliente_playlistFavoritas_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `usuario` (`nick`),
  ADD CONSTRAINT `cliente_playlistFavoritas_playlist_particular_id` FOREIGN KEY (`playlist_particular_id`) REFERENCES `playlist` (`id`);

--
-- Filtros para la tabla `cliente_usuariosseguidos`
--
ALTER TABLE `cliente_usuariosseguidos`
  ADD CONSTRAINT `FK_cliente_usuariosSeguidos_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `usuario` (`nick`),
  ADD CONSTRAINT `FK_cliente_usuariosSeguidos_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`nick`);

--
-- Filtros para la tabla `genero`
--
ALTER TABLE `genero`
  ADD CONSTRAINT `FK_genero_padre_nombre` FOREIGN KEY (`padre_nombre`) REFERENCES `genero` (`nombre`);

--
-- Filtros para la tabla `playlistparticular`
--
ALTER TABLE `playlistparticular`
  ADD CONSTRAINT `FK_playlistparticular_id` FOREIGN KEY (`id`) REFERENCES `playlist` (`id`),
  ADD CONSTRAINT `FK_playlistparticular_propietario` FOREIGN KEY (`propietario`) REFERENCES `usuario` (`nick`);

--
-- Filtros para la tabla `playlistpordefecto`
--
ALTER TABLE `playlistpordefecto`
  ADD CONSTRAINT `FK_playlistpordefecto_genero_nombre` FOREIGN KEY (`genero_nombre`) REFERENCES `genero` (`nombre`),
  ADD CONSTRAINT `FK_playlistpordefecto_id` FOREIGN KEY (`id`) REFERENCES `playlist` (`id`);

--
-- Filtros para la tabla `playlist_cancion`
--
ALTER TABLE `playlist_cancion`
  ADD CONSTRAINT `FK_playlist_cancion_canciones_id` FOREIGN KEY (`canciones_id`) REFERENCES `cancion` (`id`),
  ADD CONSTRAINT `FK_playlist_cancion_playlist_id` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`);

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `actualizar_vencimiento_clientes` ON SCHEDULE EVERY 60 SECOND STARTS '2024-10-30 22:21:54' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE cliente
    SET estado = 'Vencida',
        fecSub = NOW()
    WHERE estado = 'Vigente'
      AND DATE_ADD(fecSub, INTERVAL tipo DAY) < NOW()$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
