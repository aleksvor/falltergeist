/*
 * Copyright 2012-2013 Falltergeist Developers.
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
 */

#ifndef FALLTERGEIST_RESOURCEMANAGER_H
#define FALLTERGEIST_RESOURCEMANAGER_H

#include <list>
#include <string>

namespace Falltergeist
{
class DatFile;
class VirtualFile;
class FrmFileType;
class PalFileType;
class LstFileType;
class FonFileType;
class AafFileType;
class GcdFileType;
class MsgFileType;
class BioFileType;
class Surface;

const char * _t(unsigned int number, const char * filename);

class ResourceManager
{
protected:
    static std::list<DatFile *> * _datFiles;
public:
    ResourceManager();
    static VirtualFile * getDatFileItem(std::string filename);
    static FrmFileType * getFrmFileType(std::string filename);
    static PalFileType * getPalFileType(std::string filename);
    static LstFileType * getLstFileType(std::string filename);
    static FonFileType * getFonFileType(std::string filename);
    static AafFileType * getAafFileType(std::string filename);
    static GcdFileType * getGcdFileType(std::string filename);
    static MsgFileType * getMsgFileType(std::string filename);
    static BioFileType * getBioFileType(std::string filename);
    static Surface * getSurface(std::string filename, int x = 0, int y = 0);
};

}

#endif // FALLTERGEIST_RESOURCEMANAGER_H
