Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33216 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbbG2BXA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2015 21:23:00 -0400
Received: by ioii16 with SMTP id i16so6077692ioi.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2015 18:22:59 -0700 (PDT)
Date: Tue, 28 Jul 2015 20:22:55 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Duc Dang <dhdang@apm.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in
 pci_generic_config_read32
Message-ID: <20150729012255.GA18606@google.com>
References: <20150724224258.GA23990@google.com>
 <CADaLNDmYZ=8XQt82W_H74QaOiX3UwkVxkE1_EWRgzhkG1boebw@mail.gmail.com>
 <CAErSpo549xfAnx62quCqGHh3DNay5Lfb6EhEG+4EXooEuueQFQ@mail.gmail.com>
 <CADaLNDn95H=g73DKWRsrB4SuWcf+-8mkepbwb_DC-sFsVkrk6g@mail.gmail.com>
 <20150728212944.GA12958@google.com>
 <CADaLNDkOLiyPmVC3VwpnbrfAKFmNwSVJKdChjQFdQqs7XP-Ddg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADaLNDkOLiyPmVC3VwpnbrfAKFmNwSVJKdChjQFdQqs7XP-Ddg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28, 2015 at 02:50:39PM -0700, Duc Dang wrote:
> On Tue, Jul 28, 2015 at 2:29 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Tue, Jul 28, 2015 at 10:45:26AM -0700, Duc Dang wrote:
> >> On Tue, Jul 28, 2015 at 9:43 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> > On Fri, Jul 24, 2015 at 7:05 PM, Duc Dang <dhdang@apm.com> wrote:
> >> >> Hi Bjorn,
> >> >>
> >> >> On Fri, Jul 24, 2015 at 3:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> >>>
> >> >>> I regularly see faults like this on an APM X-Gene:
> >> >>>
> >> >>>   U-Boot 2013.04-mustang_sw_1.14.14 (Dec 16 2014 - 15:59:33)
> >> >>>   CPU0: APM ARM 64-bit Potenza Rev B0 2400MHz PCP 2400MHz
> >> >>>        32 KB ICACHE, 32 KB DCACHE
> >> >>>        SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
> >> >>>   ...
> >> >>>   Unhandled fault: synchronous external abort (0x96000010) at 0xffffff8000110034
> >> >>>   Internal error: : 96000010 [#1] SMP
> >> >>>   Modules linked in:
> >> >>>   CPU: 0 PID: 3723 Comm: ... 4.1.0-smp-DEV #3
> >> >>>   Hardware name: APM X-Gene Mustang board (DT)
> >> >>>   task: ffffffc7dc1a4140 ti: ffffffc7dc118000 task.ti: ffffffc7dc118000
> >> >>>   PC is at pci_generic_config_read32+0x4c/0xb8
> >> >>>   LR is at pci_generic_config_read32+0x40/0xb8
> >> >>>   pc : [<ffffffc00033b90c>] lr : [<ffffffc00033b900>] pstate: 600001c5
> >> >>>   ...
> >> >>>   Call trace:
> >> >>>   [<ffffffc00033b90c>] pci_generic_config_read32+0x4c/0xb8
> >> >>>   [<ffffffc00033bf58>] pci_user_read_config_byte+0x60/0xc4
> >> >>>   [<ffffffc0003496a8>] pci_read_config+0x15c/0x238
> >> >>>   [<ffffffc0002393b4>] sysfs_kf_bin_read+0x68/0xa0
> >> >>>   [<ffffffc00023896c>] kernfs_fop_read+0x9c/0x1ac
> >> >>>   [<ffffffc0001c361c>] __vfs_read+0x44/0x128
> >> >>>   [<ffffffc0001c3e28>] vfs_read+0x84/0x144
> >> >>>   [<ffffffc0001c4764>] SyS_read+0x50/0xb0
> >> >>
> >> >> The log shows kernel gets an exception when trying to access Mellanox
> >> >> card configuration space. This is usually due to suboptimal PCIe
> >> >> SerDes parameters are using in your board, which will cause bad link
> >> >> quality.
> >> >> The PCIe SerDes programming is done in U-Boot, so I suggest you do a
> >> >> U-Boot upgrade to our latest X-Gene U-Boot release.
> >> >
> >> > I installed U-Boot 1.15.12, which I thought was the latest.  I'm still
> >> > seeing this issue regularly, approx once/hour.
> >>
> >> Our latest U-Boot is 1.15.15, but U-Boot 1.15.12 is already a good
> >> version to use. Are you running any PCIe traffic test when the error
> >> happens?
> >
> > Nope, the machine was either idle or running a reboot test; no PCIe stress
> > test or anything.
> >
> >> And it will be useful if you can share your "lspci -vvv" output when
> >> the board is running, we can check to see if there is any error status
> >> reported.
> >
> > Here's some lspci output and info about the firmware I'm running.
> > Obviously this lspci output was collected before a crash.  I have also
> > seen lspci output where "CESta: RxErr+" was set on the 00:00.0 Root Port.
> >
> > U-Boot 2013.04-mustang_sw_1.15.12 (May 20 2015 - 10:03:33)
> >
> > CPU0: APM ARM 64-bit Potenza Rev B0 2400MHz PCP 2400MHz
> >      32 KB ICACHE, 32 KB DCACHE
> >      SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
> > Boot from SPI-NOR
> > Slimpro FW:
> >         Ver: 2.4 (build 01.15.12.00 2015/05/20)
> >         PMD: 970 mV
> >         SOC: 950 mV
> > Board: Mustang - AppliedMicro APM883208-xNA24SPT Reference Board
> > I2C:   ready
> > DRAM:  ECC 32 GiB @ 1600MHz
> > SF: Detected N25Q256 with page size 256 Bytes, total 32 MiB
> > MMC:   X-Gene SD/SDIO/eMMC: 0
> > PCIE0: (RC) X8 GEN-3 link up
> >   00:00.0     - 10e8:e004 - Bridge device
> >    01:00.0    - 15b3:1007 - Network controller
> >
> > # lspci -vvv
> > 00:00.0 PCI bridge: Applied Micro Circuits Corp. Device e004 (rev 04) (prog-if 00 [Normal decode])

> >                 LnkCtl2: Target Link Speed: Unknown, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
> 
> Target Link Speed unknown is really strange. I also saw the same "Link
> speed unknown" for Mellanox card below.

I think this is because I have a really old lspci.  Here's the -xxx output:

    00: e8 10 04 e0 07 00 10 00 04 00 04 06 00 00 01 00
    10: 00 00 00 00 00 00 00 00 00 01 01 00 f1 01 00 00
    20: 00 80 f0 82 01 83 01 83 00 00 00 00 00 00 00 00
    30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
    40: 10 80 42 01 02 8f 00 00 36 28 21 00 83 fc 7b 00
    50: 40 00 83 70 00 05 08 00 c0 03 00 01 00 00 01 00
    60: 00 00 00 00 10 00 00 00 00 00 00 00 0e 01 00 00
    70: 43 00 1e 00 00 00 00 00 00 00 00 00 00 00 00 00
    80: 01 00 03 06 08 00 00 00 00 00 00 00 00 00 00 00
    90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

LnkCtl2 is at offset 0x30 in the PCIe capability, which starts at 0x40,
so LnkCtl2 = 0x0043.  I think that means Target Link Speed is 0x3, or
"Supported Link Speeds Vector field bit 2".  The Supported Link Speeds
Vector in LnkCap2 (which isn't decoded even by current upstream lspci)
is 0x7, so 2.5GT/s, 5.0GT/s, and 8.0GT/s are all supported, with bit 2
being 8.0GT/s.  So I think a modern lspci would show "8.0GT/s".

> > 01:00.0 Ethernet controller: Mellanox Technologies MT27520 Family
> >         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 
> Mem and BusMaster are disabled. So this card is not functional?

I don't know whether it's functional; I haven't tried to use it yet.

I typically don't even load the mlx4 driver, so most of the failures I'm
seeing are when the driver isn't loaded.  User-space code is doing config
reads via /sys.

> >         Capabilities: [148 v1] Device Serial Number xx-xx-xx-xx-xx-xx-xx-xx
> 
> The serial number here seems invalid. I have a Mellanox card but
> different model (ConnectX-3 15b3:1003) that shows meaningful serial
> number:
> Capabilities: [148 v1] Device Serial Number f4-52-14-03-00-0b-c2-30.

My fault, lspci actually showed a meaningful serial number; I removed
it in a misguided attempt to avoid exposing anything proprietary.

> Do you have another PCIe card to try on the same reboot test on this board?

I've seen this on at least two Mellanox cards.  I'm running similar tests
on a different type of card now.

Bjorn
