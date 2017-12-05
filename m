Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.medvecky.net ([85.118.132.146]:33669 "EHLO
        mail.medvecky.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdLEQvn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Dec 2017 11:51:43 -0500
To: linux-pci@vger.kernel.org
Cc: RayeR <rayer@seznam.cz>
From: Rudolf Marek <r.marek@assembler.cz>
Subject: PCI VGA 0x3b0/0x3C0 aliases handling in Linux
Message-ID: <098b7b02-90f8-636e-37b8-665c32aab96e@assembler.cz>
Date: Tue, 5 Dec 2017 17:43:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

Please CC us we are not subscribed. My friend  (on CC) ran into strange problems with his 
old PCI sound card under Linux. The very same card works fine in Windoze. 

It turned out that silly BIOS assigned the I/O BAR to an address which is positively decoded 
by some other PCIe bridge. The unlucky region collides with the legacy VGA
mirror region which is decoded by other PCI/PCIe bridge because bit 3 (PCI_BRIDGE_CTL_VGA) is set.

Here is a quote from random datasheet of PCI/PCIe bridge:

VGA_EN:

*  Memory accesses in the range 0x000A_0000 to 
000B_FFFF
*  I/O addresses in the first 64 Kbytes of the I/O address 
space (Address[31:16] for PCIe are 0x0000) and where 
Address[9:0] is in the range of 0x3B0 to 0x3BB or 0x3C0 
to 0x3DF (inclusive of ISA address aliases - 
Address[15:10] may possess any value and is not used in 
the decoding)

So, as you can see, it effectively forces the VGA I/O region to be mirrored all over the 64K I/O space.

What is interesting  is that the PCI bridge specs version 1.2?, added a new bit 4 (which is previously RO 0) which 
allows to decode only the full address for the 0x3b0/0x3c0 :

VGA_16BIT_EN:

This bit enables the bridge to provide 16-bit decoding of 
VGA I/O address precluding the decoding of alias addresses 
every 1 KB. This bit has meaning only if VGA Enable bit is 
set

There is not even a define in the Linux which would describe this bit. The "fix" for the problem is to simply
turn off the aliasing.

I would like to ask:

1) If there is some code already which would check this PCI resources collisions (at least issue an warning)

2) Do you think that Linux should try to fix this? (Yes the BIOS messed it up, but hey, the Windoze figured it out)

I suspect it will fix couple of problems people were seeing with old PCI cards as they tend to have the I/O regions
(I stumbled upon various reports when was suspecting the PCIe to PCI ITE chip and interrupt routing problems)

Thanks
Rudolf
