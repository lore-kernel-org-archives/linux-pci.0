Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: lspci not showing motherboard ethernet controller after PCIe card
 firmware update change from 32-bit to 64-bit BAR
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
References: <2cc60cd1-bab1-a086-2326-7ce161b8f083@ou.edu>
 <efdbf332-841c-7617-efd1-facf785472fd@ou.edu>
 <20160926155018.GL14311@csclub.uwaterloo.ca>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        yinghai Lu <yinghai@kernel.org>,
        "Blackmagic Developer Support" <developer@blackmagicdesign.com>
From: Steve Kenton <skenton@ou.edu>
Message-ID: <68936975-5496-0e0d-5137-d48575e8ec0d@ou.edu>
Date: Wed, 28 Sep 2016 09:05:44 -0500
MIME-Version: 1.0
In-Reply-To: <20160926155018.GL14311@csclub.uwaterloo.ca>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 09/26/2016 10:50 AM, Lennart Sorensen wrote:
<snip>

> Well pci=bios is 32 bit only, so that doesn't work, pci=bfs was probably
> supposed to be pci=bfsort.  It sure looks like the bios fails to allocate
> the network device when the other device is 64 bit.  Sure looks like
> a bios bug.  I see nothing indicating that the address space ran out.
> It looks fine.
> 
> You could try:
> 
> pci=realloc
> pci=assign-busses
> pci=bfsort (the one I think you were trying to do).
> 
> I certainly wouldn't be surprised if the only thing ever tested in that
> board was a graphics card.
> 
> Of course your network card is also 64 bit bar (when seen), so the system
> can work with such.  Makes one wonder if the bios has a bus, or the H81
> has a limit that only one of the ethernet and the add in card can use
> 64 bit bar at a time.  That would seem weird of course.
> 
I decided to experiment with /sys/bus/pci and the BIOS settings to try
and understand things better.

The BIOS has a settings to enable/disable the on-board LAN. When the
Blackmagic card firmware is upgraded
bus[03] and hence the on-board LAN disappears, but the apparently unused
bus[02] is still visible and
the BIOS setting is still enabled. When the BIOS LAN settings is
disabled busses[02][03] and the on-board
LAN disappear. In both cases, the "disappeared" resources are not
restored by echo to /sys/.../rescan

Why? What can the BIOS be doing to the chipset/busses[02][03] to make
them invisible to /sys manipulation?

There is apparently something I do not understand about the H81 chipset
PCIe configuration. I have
been reading the Intel Series 8 / Series C220 Chipset documentation but
so far have come up empty.

Anybody have cluebat for me?

Steve Kenton

=====================================================================================================================================

Here is the lspci tree output as configured by the BIOS with the
on-board LAN enabled
Using echo to various /sys files successfully removes and
restores(rescan) the Blackmagic card, the Realtek LAN as well as
busses[01][02][03]

-[0000:00]-+-00.0  Intel Corporation 4th Gen Core Processor DRAM
Controller [8086:0c00]
           +-01.0-[01]----00.0  Blackmagic Design Intensity Pro 4K
[bdbd:a139]
           +-02.0  Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor Integrated Graphics Controller [8086:0412]
           +-03.0  Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor HD Audio Controller [8086:0c0c]
           +-14.0  Intel Corporation 8 Series/C220 Series Chipset Family
USB xHCI [8086:8c31]
           +-16.0  Intel Corporation 8 Series/C220 Series Chipset Family
MEI Controller #1 [8086:8c3a]
           +-1a.0  Intel Corporation 8 Series/C220 Series Chipset Family
USB EHCI #2 [8086:8c2d]
           +-1b.0  Intel Corporation 8 Series/C220 Series Chipset High
Definition Audio Controller [8086:8c20]
           +-1c.0-[02]--
           +-1c.5-[03]----00.0  Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
           +-1d.0  Intel Corporation 8 Series/C220 Series Chipset Family
USB EHCI #1 [8086:8c26]
           +-1f.0  Intel Corporation C220 Series Chipset Family H81
Express LPC Controller [8086:8c5c]
           +-1f.2  Intel Corporation 8 Series/C220 Series Chipset Family
6-port SATA Controller 1 [AHCI mode] [8086:8c02]
           \-1f.3  Intel Corporation 8 Series/C220 Series Chipset Family
SMBus Controller [8086:8c22]

=====================================================================================================================================

Here is the lspci tree output as configured by the BIOS with the
on-board LAN disabled
Using echo to various /sys files I am unable to restore busses[02][03]
so I cannot even attempt to restore the Realtek LAN

-[0000:00]-+-00.0  Intel Corporation 4th Gen Core Processor DRAM
Controller [8086:0c00]
           +-01.0-[01]----00.0  Blackmagic Design Intensity Pro 4K
[bdbd:a139]
           +-02.0  Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor Integrated Graphics Controller [8086:0412]
           +-03.0  Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor HD Audio Controller [8086:0c0c]
           +-14.0  Intel Corporation 8 Series/C220 Series Chipset Family
USB xHCI [8086:8c31]
           +-16.0  Intel Corporation 8 Series/C220 Series Chipset Family
MEI Controller #1 [8086:8c3a]
           +-1a.0  Intel Corporation 8 Series/C220 Series Chipset Family
USB EHCI #2 [8086:8c2d]
           +-1b.0  Intel Corporation 8 Series/C220 Series Chipset High
Definition Audio Controller [8086:8c20]
           +-1d.0  Intel Corporation 8 Series/C220 Series Chipset Family
USB EHCI #1 [8086:8c26]
           +-1f.0  Intel Corporation C220 Series Chipset Family H81
Express LPC Controller [8086:8c5c]
           +-1f.2  Intel Corporation 8 Series/C220 Series Chipset Family
6-port SATA Controller 1 [AHCI mode] [8086:8c02]
           \-1f.3  Intel Corporation 8 Series/C220 Series Chipset Family
SMBus Controller [8086:8c22]

I'm guessing that bus[02] is reserved for a dual LAN option and is not
used in this case but may toggle with the BIOS LAN setting
