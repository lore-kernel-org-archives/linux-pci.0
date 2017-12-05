Return-Path: <SRS0=tYxu=DB=seznam.cz=rayer@kernel.org>
Return-Path: <SRS0=tYxu=DB=seznam.cz=rayer@kernel.org>
Subject: Re: PCI VGA 0x3b0/0x3C0 aliases handling in Linux
To: Bjorn Helgaas <helgaas@kernel.org>, Rudolf Marek <r.marek@assembler.cz>
Cc: linux-pci@vger.kernel.org
References: <098b7b02-90f8-636e-37b8-665c32aab96e@assembler.cz>
 <20171205190755.GB23510@bhelgaas-glaptop.roam.corp.google.com>
From: rayer <rayer@seznam.cz>
Message-ID: <5A26F4E3.9030901@seznam.cz>
Date: Tue, 5 Dec 2017 20:34:59 +0100
MIME-Version: 1.0
In-Reply-To: <20171205190755.GB23510@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas wrote:
> So if I understand correctly, you have
>    - A bridge with PCI_BRIDGE_CTL_VGA set but VGA_16BIT_EN is clear
>    - A peer of the bridge with an I/O BAR set to some alias of
>      0x3c0-0x3df
Yes. The tested card is SB Audigy that was assigned to IO base address 
CFC0h with 32 Bytes window by PnP BIOS mechanism. The VGA registers are 
aliasing every 400h over enite 16bit IO space and come into colision 
with SB registers. It may shoot down any other PCI card that got mapped 
to "wrong" IO base. This may then result to bugs that tlookl like IRQ 
was not assigned properly but the primary issue is IO colision.
> In this case I think both the bridge and the peer device will claim
> accesses to 0x3c0-0x3df, which is a bad thing.
>
> And your proposal is that Linux should either
>
>    - Turn on VGA_16BIT_EN (if supported by the bridge), or
>
>    - If VGA_16BIT_EN is not supported by the bridge, try to reassign
>      the peer I/O BAR so it doesn't conflict with the 0x3c0-0x3df
>      aliases
Yes, it's a question if is safe to do as implicit action or do it only 
if specific kernel parameter is given. I belive it is safe to enable 
VGA_16BIT_EN when supported.
> To help understand and document this better, it would be nice to see a
> complete dmesg log and "lspci -vv" output (as root) showing the
> problem.  A kernel.org bugzilla would be a good place to store this.
OK, I have a lot of logs, I'll send later.
> It would also be great to collect up the other reports you've found
> and see if we can definitively tie them to this issue and potentially
> test a fix.
I guess this problem is fixed on most of current motherboards but there 
still may be people running old PCH 6x with preUEFI BIOS. I observed 
this behavior on Gigabyte GA-P67-DS3-B3 MB with latest official BIOS F5.
There are also other PCI issues esp. on intel motherboards with smae ITE 
PCIe2PCI bridge but different manner - I saw they had some wrong ACPI 
table but it had similar symptoms - a PCI card worked in Windows but 
observed IRQ error mapping under Linux. So that are very different kind 
of bug that needs to be separated from this case.

RayeR
