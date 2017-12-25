Return-Path: <SRS0=CNWA=DV=assembler.cz=r.marek@kernel.org>
Return-Path: <SRS0=CNWA=DV=assembler.cz=r.marek@kernel.org>
Subject: Re: PCI VGA 0x3b0/0x3C0 aliases handling in Linux
From: Rudolf Marek <r.marek@assembler.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, RayeR <rayer@seznam.cz>
References: <098b7b02-90f8-636e-37b8-665c32aab96e@assembler.cz>
 <20171205190755.GB23510@bhelgaas-glaptop.roam.corp.google.com>
 <0a488e5b-d954-b2bc-0089-6c0542b8c571@assembler.cz>
 <20171206184314.GK23510@bhelgaas-glaptop.roam.corp.google.com>
 <565cfb46-6327-8a18-19d2-9f884661b0eb@assembler.cz>
Message-ID: <2b1f6a44-23ff-fa66-6bea-674b70525381@assembler.cz>
Date: Mon, 25 Dec 2017 15:29:24 +0100
MIME-Version: 1.0
In-Reply-To: <565cfb46-6327-8a18-19d2-9f884661b0eb@assembler.cz>
Content-Type: text/plain; charset=iso-8859-2
List-ID: <linux-pci.vger.kernel.org>

Hi all,

Dne 9.12.2017 v 20:40 Rudolf Marek napsal(a):
> Turn on VGA_16BIT_EN if supported by the bridge

It turns out, there are at least two bridges, where this bit is broken:

PEX 8114BC PCI Express-to-PCI/PCI-X Bridge Errata Documentation
PEX 8114BA PCI Express-to-PCI/PCI-X Bridge Errata Documentation

Description
In PCI or PCI-X Forward or Reverse Transparent Bridge mode, the Bridge Control
register VGA 16-Bit Decode bit (offset 3Ch[20]) does not function correctly. PCI Address
bits [9:0] are correctly decoded; however, PCI Address bits [15:10] are not decoded,
causing the PEX 8114 to ignore these Address lines.

It seems that this feature is required by windoze server edition:

"Virtual bridges that comply with PCI Express also comply with PCI-to-PCI Bridge Architecture Specification, Revision 1.1. In addition, VGA 16-bit decode (Section 3.2.5.18, "Bridge Control Register, bit 4") and SSID and SSVID (Section 3.2.5.13) from PCI-to-PCI Bridge Architecture Specification, Revision 1.2, must also be supported."


I tried to have a look, how to implement the resources to deal with the ISA aliasing, but I definitely need some pointers how to do that.

Overall approach:

For all PCI bridges, try to enable the 16-bit I/O (older bridges have this bit RO), minus the two broken above, note the state
in say, dev->hasvga16, perhaps do this in pci/quirks.c ?

During the PCI bridge enumeration, add extra resources if dev->hasvga16 is zero. I hope that the resource allocator can fix it on its own.
We should do that regardless of state of PCI_BRIDGE_CTL_VGA as pci_set_vga_state() could switch it later.

I don't know if it would be enough to modify  pci_read_bridge_bases() in drivers/pci/probe.c and add there all the ISA aliases of 0x3b0-0x3df
(similarly it adds transparent bridge resources)

There is 48 resources to be added, I hope there is no limit, seems there is just linked list.

N= 0 - F

0xN3b0-0xN3df
0xN7b0-0xN7df
0xNfb0-0xNfdf

Thanks
Rudolf
