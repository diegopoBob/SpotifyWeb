-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-11-2024 a las 02:44:51
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
  `genero` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cancion`
--

INSERT INTO `cancion` (`id`, `direccion_archivo_de_audio`, `duracion`, `nombre`, `genero`) VALUES
(1, 'includes/musica/Village People - YMCA.mp3', 268, 'YMCA', NULL),
(2, 'includes/musica/Village People - Macho Man.mp3', 208, 'Macho Man', NULL),
(3, 'includes/musica/Village People - In the Navy - Original Version 1979.mp3', 193, 'In the Navy', NULL),
(4, 'includes/musica/Depeche Mode - Personal Jesus.mp3', NULL, 'Personal Jesus', NULL),
(5, 'includes/musica/Depeche Mode - Enjoy the Silence.mp3', NULL, 'Enjoy The Silence', NULL),
(6, 'includes/musica/Cyndi Lauper - Girls Just Want to Have Fun.mp3', 195, 'Girls Just Want To Have Fun', NULL),
(7, 'includes/musica/Cyndi Lauper - Time After Time.mp3', 312, 'Time After Time', NULL),
(8, 'includes/musica/Bruce Springsteen - Born in the U.S.A..mp3', 298, 'Born In The U.S.A.', NULL),
(9, 'includes/musica/Bruce Springsteen - Glory Days.mp3', 323, 'Glory Days', NULL),
(10, 'includes/musica/Bruce Springsteen - Dancing In the Dark.mp3', 238, 'Dancing In The Park', NULL),
(11, 'includes/musica/Tom Jones - It\'s Not Unusual.mp3', 120, 'It’s Not Unusual', NULL),
(12, 'includes/musica/Alfredo Zitarrosa - Adagio en Mi País.mp3', 290, 'Adagio De Mi País', NULL),
(13, 'includes/musica/La Ley - El Duelo.mp3', 323, 'El Duelo', NULL),
(14, 'includes/musica/La Ley - Mentira.mp3', 288, 'Mentira', NULL),
(15, 'includes/musica/Pyotr Ilyich Tchaikovsky, Inma Shara - El Lago De Los Cisnes - Op. 20, Acto II- 10. Scene (Moderato).mp3', 160, 'Acto 2, Número 10, Escena (Moderato)', NULL),
(16, 'includes/musica/Orquestra de Câmara de Blumenau - Allegro.mp3', 1318, 'Primer Movimiento (Allegro non troppo e molto maestoso – Allegro con spirito)', NULL),
(17, 'includes/musica/JAY WONDER 01 - No Quiero Estudiar.mp3', 132, 'No Quiero Estudiar', NULL),
(18, 'includes/musica/Pimpinela, Dyango - Por Ese Hombre.mp3', 285, 'Por Ese Hombre', NULL),
(19, 'includes/musica/Pimpinela, Dyango - Por Ese Hombreee.mp3', 313, 'Por Ese Hombre', NULL),
(20, 'includes/musica/Alcides - Violeta.mp3', 116, 'Violeta', 'Pop');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `nick` varchar(255) NOT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `fecSub` date DEFAULT NULL,
  `tipo` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`nick`, `estado`, `fecSub`, `tipo`) VALUES
('benKenobi', 'Cancelado', '2024-10-30', NULL),
('bob', 'Pendiente', '2024-10-30', 31),
('cbochinche', 'Vencida', '2024-10-30', NULL),
('Eleven11', 'Vencida', '2024-10-30', NULL),
('el_padrino', 'Vencida', '2024-10-30', NULL),
('Heisenberg', 'Vencida', '2024-10-30', NULL),
('lachiqui', 'Vencida', '2024-10-30', NULL),
('ppArgento', 'Vencida', '2024-10-30', NULL),
('scarlettO', 'Vencida', '2024-10-30', NULL);

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
('bob', 6),
('bob', 11),
('bob', 16),
('cbochinche', 15),
('el_padrino', 17),
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
('bob', 7),
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
('bob', 'lachiqui'),
('bob', 'nicoleneu'),
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
(651, 'PlaylistParticular', 'diego', 'playlist/......png'),
(652, 'PlaylistParticular', 'd', NULL),
(653, 'PlaylistParticular', 's', NULL),
(654, 'PlaylistParticular', 'd', NULL),
(701, 'PlaylistParticular', 'das', 'playlist/..........png');

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
(651, 1, 'bob'),
(652, 0, 'bob'),
(653, 0, 'bob'),
(654, 0, 'bob'),
(701, 0, 'bob');

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
(651, 1),
(651, 6),
(651, 13),
(651, 20),
(653, 20);

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
('SEQ_GEN', 750);

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
('bruceTheBoss', 'artista', 'Springsteen', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1949-09-23', 'includes/Usuarios/bruceTheBoss.jpeg', 'bruceTheBoss@gmail.com', 'Bruce'),
('cbochinche', 'cliente', 'Bochinche', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1937-05-08', 'includes/Usuarios/Bochinche.jpeg', 'cbochinche@vera.com.uy', 'Cacho'),
('chaiko', 'artista', 'Tchaikovsky', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1840-04-25', NULL, 'chaiko@tuta.io', 'Piotr'),
('clauper', 'artista', 'Lauper', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1953-06-22', 'includes/Usuarios/Lauper.jpeg', 'clauper@hotmail.com', 'Cyndi'),
('dmode', 'artista', 'Mode', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1980-06-14', 'includes/Usuarios/Mode.jpeg', 'dmode@tuta.io', 'Depeche'),
('dyangounchained', 'artista', NULL, '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1940-03-05', NULL, 'dyangounchained@gmail.com', 'Dyango'),
('Eleven11', 'cliente', NULL, '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1971-12-31', 'includes/Usuarios/Eleven11.jpeg', 'Eleven11@gmail.com', 'Eleven'),
('el_padrino', 'cliente', 'Corleone', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1972-03-08', 'includes/Usuarios/el_padrino.jpeg', 'el_padrino@tuta.io', 'Vito'),
('Heisenberg', 'cliente', 'White', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1956-03-07', 'includes/Usuarios/Heisenberg.jpeg', 'Heisenberg@tuta.io', 'Walter'),
('lachiqui', 'cliente', 'Legrand', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1927-02-23', 'includes/Usuarios/lachiqui.jpeg', 'lachiqui@hotmail.com.ar', 'Mirtha'),
('la_ley', 'artista', 'Ley', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1987-02-14', NULL, 'la_ley@tuta.io', 'La'),
('lospimpi', 'artista', NULL, '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1981-08-13', 'includes/Usuarios/lospimpi.jpeg', 'lospimpi@gmail.com', 'Pimpinela'),
('nicoleneu', 'artista', 'Neumann', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1980-10-31', 'includes/Usuarios/nicoleneu.jpeg', 'nicoleneu@hotmail.com', 'Nicole'),
('ppArgento', 'cliente', 'Argento', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1955-02-14', 'includes/Usuarios/ppArgento.jpeg', 'ppArgento@hotmail.com', 'Pepe'),
('scarlettO', 'cliente', 'O’Hara', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1984-11-27', 'includes/Usuarios/scarlettO.jpg', 'scarlettO@tuta.io', 'Scarlett'),
('tigerOfWales', 'artista', 'Jones', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1940-06-07', NULL, 'tigerOfWales@tuta.io', 'Tom'),
('tripleNelson', 'artista', 'Nelson', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1998-01-01', 'includes/Usuarios/tripleNelson.jpeg', 'tripleNelson@tuta.io', 'La Triple'),
('vpeople', 'artista', 'People', '$2a$10$idOxpNoD3vgGoV3HU1WnG..faz0iiXxePlFhYmUNNacG5IdGl4.U2', '1977-01-01', 'includes/Usuarios/vpeople.jpeg', 'vpeople@tuta.io', 'Village');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Album_artista` (`artista`);

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
  ADD KEY `FK_Cancion_genero` (`genero`);

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
  ADD KEY `FK_Genero_padre_nombre` (`padre_nombre`);

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
  ADD KEY `FK_PlaylistParticular_propietario` (`propietario`);

--
-- Indices de la tabla `playlistpordefecto`
--
ALTER TABLE `playlistpordefecto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_PlaylistPorDefecto_genero_nombre` (`genero_nombre`);

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
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `album`
--
ALTER TABLE `album`
  ADD CONSTRAINT `FK_Album_artista` FOREIGN KEY (`artista`) REFERENCES `usuario` (`nick`);

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
  ADD CONSTRAINT `FK_Artista_nick` FOREIGN KEY (`nick`) REFERENCES `usuario` (`nick`);

--
-- Filtros para la tabla `cancion`
--
ALTER TABLE `cancion`
  ADD CONSTRAINT `FK_Cancion_genero` FOREIGN KEY (`genero`) REFERENCES `genero` (`nombre`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `FK_Cliente_nick` FOREIGN KEY (`nick`) REFERENCES `usuario` (`nick`);

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
  ADD CONSTRAINT `FK_Genero_padre_nombre` FOREIGN KEY (`padre_nombre`) REFERENCES `genero` (`nombre`);

--
-- Filtros para la tabla `playlistparticular`
--
ALTER TABLE `playlistparticular`
  ADD CONSTRAINT `FK_PlaylistParticular_id` FOREIGN KEY (`id`) REFERENCES `playlist` (`id`),
  ADD CONSTRAINT `FK_PlaylistParticular_propietario` FOREIGN KEY (`propietario`) REFERENCES `usuario` (`nick`);

--
-- Filtros para la tabla `playlistpordefecto`
--
ALTER TABLE `playlistpordefecto`
  ADD CONSTRAINT `FK_PlaylistPorDefecto_genero_nombre` FOREIGN KEY (`genero_nombre`) REFERENCES `genero` (`nombre`),
  ADD CONSTRAINT `FK_PlaylistPorDefecto_id` FOREIGN KEY (`id`) REFERENCES `playlist` (`id`);

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
