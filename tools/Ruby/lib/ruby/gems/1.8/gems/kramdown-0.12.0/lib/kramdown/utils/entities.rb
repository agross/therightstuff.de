# -*- coding: utf-8 -*-
#
#--
# Copyright (C) 2009-2010 Thomas Leitner <t_leitner@gmx.at>
#
# This file is part of kramdown.
#
# kramdown is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++
#

module Kramdown

  module Utils

    # Provides convenience methods for handling named and numeric entities.
    module Entities

      # Represents an entity that has a +code_point+ and +name+.
      class Entity < Struct.new(:code_point, :name)

        # Return the UTF8 representation of the entity.
        def char
          [code_point].pack('U*') rescue nil
        end

      end

      # Array of arrays. Each sub-array specifies a code point and the associated name.
      #
      # This table is not used directly -- Entity objects are automatically created from it and put
      # into a Hash map when this file is loaded.
      ENTITY_TABLE = [
                      [913, 'Alpha'],
                      [914, 'Beta'],
                      [915, 'Gamma'],
                      [916, 'Delta'],
                      [917, 'Epsilon'],
                      [918, 'Zeta'],
                      [919, 'Eta'],
                      [920, 'Theta'],
                      [921, 'Iota'],
                      [922, 'Kappa'],
                      [923, 'Lambda'],
                      [924, 'Mu'],
                      [925, 'Nu'],
                      [926, 'Xi'],
                      [927, 'Omicron'],
                      [928, 'Pi'],
                      [929, 'Rho'],
                      [931, 'Sigma'],
                      [932, 'Tau'],
                      [933, 'Upsilon'],
                      [934, 'Phi'],
                      [935, 'Chi'],
                      [936, 'Psi'],
                      [937, 'Omega'],
                      [945, 'alpha'],
                      [946, 'beta'],
                      [947, 'gamma'],
                      [948, 'delta'],
                      [949, 'epsilon'],
                      [950, 'zeta'],
                      [951, 'eta'],
                      [952, 'theta'],
                      [953, 'iota'],
                      [954, 'kappa'],
                      [955, 'lambda'],
                      [956, 'mu'],
                      [957, 'nu'],
                      [958, 'xi'],
                      [959, 'omicron'],
                      [960, 'pi'],
                      [961, 'rho'],
                      [963, 'sigma'],
                      [964, 'tau'],
                      [965, 'upsilon'],
                      [966, 'phi'],
                      [967, 'chi'],
                      [968, 'psi'],
                      [969, 'omega'],
                      [962, 'sigmaf'],
                      [977, 'thetasym'],
                      [982, 'piv'],
                      [8230, 'hellip'],
                      [8242, 'prime'],
                      [8254, 'oline'],
                      [8260, 'frasl'],
                      [8472, 'weierp'],
                      [8465, 'image'],
                      [8476, 'real'],
                      [8501, 'alefsym'],
                      [8226, 'bull'],
                      [8482, 'trade'],
                      [8592, 'larr'],
                      [8594, 'rarr'],
                      [8593, 'uarr'],
                      [8595, 'darr'],
                      [8596, 'harr'],
                      [8629, 'crarr'],
                      [8657, 'uArr'],
                      [8659, 'dArr'],
                      [8656, 'lArr'],
                      [8658, 'rArr'],
                      [8660, 'hArr'],
                      [8704, 'forall'],
                      [8706, 'part'],
                      [8707, 'exist'],
                      [8709, 'empty'],
                      [8711, 'nabla'],
                      [8712, 'isin'],
                      [8715, 'ni'],
                      [8713, 'notin'],
                      [8721, 'sum'],
                      [8719, 'prod'],
                      [8722, 'minus'],
                      [8727, 'lowast'],
                      [8730, 'radic'],
                      [8733, 'prop'],
                      [8734, 'infin'],
                      [8736, 'ang'],
                      [8743, 'and'],
                      [8744, 'or'],
                      [8745, 'cup'],
                      [8746, 'cap'],
                      [8747, 'int'],
                      [8756, 'there4'],
                      [8764, 'sim'],
                      [8776, 'asymp'],
                      [8773, 'cong'],
                      [8800, 'ne'],
                      [8801, 'equiv'],
                      [8804, 'le'],
                      [8805, 'ge'],
                      [8834, 'sub'],
                      [8835, 'sup'],
                      [8838, 'sube'],
                      [8839, 'supe'],
                      [8836, 'nsub'],
                      [8853, 'oplus'],
                      [8855, 'otimes'],
                      [8869, 'perp'],
                      [8901, 'sdot'],
                      [8968, 'rceil'],
                      [8969, 'lceil'],
                      [8970, 'lfloor'],
                      [8971, 'rfloor'],
                      [9001, 'rang'],
                      [9002, 'lang'],
                      [9674, 'loz'],
                      [9824, 'spades'],
                      [9827, 'clubs'],
                      [9829, 'hearts'],
                      [9830, 'diams'],
                      [38, 'amp'],
                      [34, 'quot'],
                      [39, 'apos'],
                      [169, 'copy'],
                      [60, 'lt'],
                      [62, 'gt'],
                      [338, 'OElig'],
                      [339, 'oelig'],
                      [352, 'Scaron'],
                      [353, 'scaron'],
                      [376, 'Yuml'],
                      [710, 'circ'],
                      [732, 'tilde'],
                      [8211, 'ndash'],
                      [8212, 'mdash'],
                      [8216, 'lsquo'],
                      [8217, 'rsquo'],
                      [8220, 'ldquo'],
                      [8221, 'rdquo'],
                      [8224, 'dagger'],
                      [8225, 'Dagger'],
                      [8240, 'permil'],
                      [8364, 'euro'],
                      [8249, 'lsaquo'],
                      [8250, 'rsaquo'],
                      [160, 'nbsp'],
                      [161, 'iexcl'],
                      [163, 'pound'],
                      [164, 'curren'],
                      [165, 'yen'],
                      [166, 'brvbar'],
                      [167, 'sect'],
                      [171, 'laquo'],
                      [187, 'raquo'],
                      [174, 'reg'],
                      [170, 'ordf'],
                      [172, 'not'],
                      [176, 'deg'],
                      [177, 'plusmn'],
                      [180, 'acute'],
                      [181, 'micro'],
                      [182, 'para'],
                      [183, 'middot'],
                      [186, 'ordm'],
                      [162, 'cent'],
                      [185, 'sup1'],
                      [178, 'sup2'],
                      [179, 'sup3'],
                      [189, 'frac12'],
                      [188, 'frac14'],
                      [190, 'frac34'],
                      [192, 'Agrave'],
                      [193, 'Aacute'],
                      [194, 'Acirc'],
                      [195, 'Atilde'],
                      [196, 'Auml'],
                      [197, 'Aring'],
                      [198, 'AElig'],
                      [199, 'Ccedil'],
                      [200, 'Egrave'],
                      [201, 'Eacute'],
                      [202, 'Ecirc'],
                      [203, 'Euml'],
                      [204, 'Igrave'],
                      [205, 'Iacute'],
                      [206, 'Icirc'],
                      [207, 'Iuml'],
                      [208, 'ETH'],
                      [209, 'Ntilde'],
                      [210, 'Ograve'],
                      [211, 'Oacute'],
                      [212, 'Ocirc'],
                      [213, 'Otilde'],
                      [214, 'Ouml'],
                      [215, 'times'],
                      [216, 'Oslash'],
                      [217, 'Ugrave'],
                      [218, 'Uacute'],
                      [219, 'Ucirc'],
                      [220, 'Uuml'],
                      [221, 'Yacute'],
                      [222, 'THORN'],
                      [223, 'szlig'],
                      [224, 'agrave'],
                      [225, 'aacute'],
                      [226, 'acirc'],
                      [227, 'atilde'],
                      [228, 'auml'],
                      [229, 'aring'],
                      [230, 'aelig'],
                      [231, 'ccedil'],
                      [232, 'egrave'],
                      [233, 'eacute'],
                      [234, 'ecirc'],
                      [235, 'euml'],
                      [236, 'igrave'],
                      [237, 'iacute'],
                      [238, 'icirc'],
                      [239, 'iuml'],
                      [240, 'eth'],
                      [241, 'ntilde'],
                      [242, 'ograve'],
                      [243, 'oacute'],
                      [244, 'ocirc'],
                      [245, 'otilde'],
                      [246, 'ouml'],
                      [247, 'divide'],
                      [248, 'oslash'],
                      [249, 'ugrave'],
                      [250, 'uacute'],
                      [251, 'ucirc'],
                      [252, 'uuml'],
                      [253, 'yacute'],
                      [254, 'thorn'],
                      [255, 'yuml'],

                      [8218, 'sbquo'],
                      [402, 'fnof'],
                      [8222, 'bdquo'],

                      [128, 8364],
                      [130, 8218],
                      [131, 402],
                      [132, 8222],
                      [133, 8230],
                      [134, 8224],
                      [135, 8225],
                      [136, 710],
                      [137, 8240],
                      [138, 352],
                      [139, 8249],
                      [140, 338],
                      [142, 381],
                      [145, 8216],
                      [146, 8217],
                      [147, 8220],
                      [148, 8221],
                      [149, 8226],
                      [150, 8211],
                      [151, 8212],
                      [152, 732],
                      [153, 8482],
                      [154, 353],
                      [155, 8250],
                      [156, 339],
                      [158, 382],
                      [159, 376],
                     ]

      # Contains the mapping of code point (or name) to the actual Entity object.
      ENTITY_MAP = Hash.new do |h,k|
        if k.kind_of?(Integer)
          h[k] = Entity.new(k, nil)
        else
          raise Kramdown::Error, "Can't handle generic non-integer character reference '#{k}'"
        end
      end

      ENTITY_TABLE.each do |code_point, data|
        if data.kind_of?(String)
          ENTITY_MAP[code_point] = ENTITY_MAP[data] = Entity.new(code_point, data)
        else
          ENTITY_MAP[code_point] = ENTITY_MAP[data]
        end
      end

      # Return the entity for the given code point or name +point_or_name+.
      def entity(point_or_name)
        ENTITY_MAP[point_or_name]
      end

      module_function :entity

    end

  end

end

