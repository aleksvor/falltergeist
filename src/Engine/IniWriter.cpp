/*
 * Copyright 2012-2014 Falltergeist Developers.
 *
 * This file is part of Falltergeist.
 *
 * Falltergeist is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Falltergeist is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Falltergeist.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

// C++ standard includes

// Falltergeist includes

#include "../Engine/IniFile.h"
#include "../Engine/IniWriter.h"

// Third party includes

namespace Falltergeist
{

IniWriter::IniWriter(const IniFile &ini) : _ini(ini)
{
}

IniWriter::~IniWriter()
{
}

void IniWriter::write(std::ostream &stream)
{
    stream << "# This file contains default configuration for the falltergeist engine." << std::endl;
    stream << "# It was autogenerated for you with love by falltergeist." << std::endl << std::endl;

    for (auto &section : _ini)
    {
        stream << "[" << section.first << "]" << std::endl;

        for (auto &properties : *section.second)
        {
            stream << properties.first <<  "=" << properties.second << std::endl;
        }

        stream << std::endl;
    }
}
}