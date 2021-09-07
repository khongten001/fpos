// Copyright (C) 2010-2021 Yacine REZGUI
// 
// This file is part of fpos.
// 
// fpos is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 2 of the License, or
// (at your option) any later version.
// 
// fpos is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with fpos.  If not, see <http://www.gnu.org/licenses/>.

unit floppy;

interface

procedure InitDMA;
procedure ReadDMA;
procedure WriteDMA;
procedure Install;

implementation

uses
  x86;

// initialize DMA to use phys addr 1k-64k
procedure InitDMA;
begin
  WritePortB($0a, $06);  // mask dma channel 2
  WritePortB($d8, $ff);  // reset master flip-flop
  WritePortB($04, 0);    // address=$1000
  WritePortB($04, $10);
  WritePortB($d8, $ff);  // reset master flip-flop
  WritePortB($05, $ff);
  // count to $23ff (number of bytes in a 3.5" floppy disk track)
  WritePortB($05, $23);
  WritePortB($80, 0);    // external page register = 0
  WritePortB($0a, $02);  // unmask dma channel 2
end;

// prepare the DMA for read transfer
procedure ReadDMA;
begin
  WritePortB($0a, $06); // mask dma channel 2
  WritePortB($0b, $56);
  // single transfer, address increment, autoinit, read, channel 2
  WritePortB($0a, $02); // unmask dma channel 2
end;

// prepare the DMA for write transfer
procedure WriteDMA;
begin
  WritePortB($0a, $06); // mask dma channel 2
  WritePortB($0b, $5a);
  // single transfer, address increment, autoinit, write, channel 2
  WritePortB($0a, $02); // unmask dma channel 2
end;

procedure InstallFloppy;
begin

end;

end.

