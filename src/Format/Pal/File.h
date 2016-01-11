/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2012-2015 Falltergeist developers
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#ifndef FALLTERGEIST_FORMAT_PAL_FILE_H
#define FALLTERGEIST_FORMAT_PAL_FILE_H

// C++ standard includes
#include <vector>

// Falltergeist includes
#include "../Dat/Item.h"

// Third party includes

namespace Falltergeist
{
namespace Format
{
namespace Pal
{

class Color;

class File : public Dat::Item
{

public:
    File(Dat::Entry* datFileEntry);
    File(std::ifstream* stream);
    ~File();

    std::vector<Color*>* colors();

    Color* color(unsigned index) const;

protected:
    std::vector<Color*> _colors;
    virtual void _initialize();

};

}
}
}
#endif // FALLTERGEIST_FORMAT_PAL_FILE_H
