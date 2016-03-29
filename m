Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38332 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751233AbcC2Kzc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 06:55:32 -0400
Message-ID: <1459248921.2565.15.camel@pengutronix.de>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Lucas Stach <l.stach@pengutronix.de>
To: Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Tim Harvey <tharvey@gateworks.com>,
	Fabio Estevam <festevam@gmail.com>,
	Petr =?UTF-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Date: Tue, 29 Mar 2016 12:55:21 +0200
In-Reply-To: <m3shz9in52.fsf@t19.piap.pl>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	 <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
	 <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
	 <CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
	 <CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
	 <CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
	 <CAOMZO5A2osG3=mTaCayYfMokUj-vT+Udq9ckq45b1yaUP9Tn3g@mail.gmail.com>
	 <CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
	 <1459241739.2565.9.camel@pengutronix.de> <m3shz9in52.fsf@t19.piap.pl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, den 29.03.2016, 12:39 +0200 schrieb Krzysztof Hałasa:
> Lucas Stach <l.stach@pengutronix.de> writes:
> 
> > Is this working with v4.4 and PCI_MSI enabled? I'm sure I've tested MSI
> > IRQs before enabling them in the defconfig and they have been working
> > for me for a long time before that. Tested with i210 on Gateworks
> > Ventana.
> 
> MSI never worked for me on Ventana. I have been using 4.2 extensively,
> and now I'm switching to 4.5 (which doesn't work either).
> 
> Could it be a DTS (bridge) problem(?)
> 
> On 4.5, trying to use it with TW6869 frame buffer and GW5410:
> 
> TW6869: PCI 0000:04:00.0, IRQ 336, MMIO 0x1100000
> TW686x 0000:04:00.0: enabling device (0140 -> 0142)
> 
I don't see whee the device even tries to use MSI IRQs. Even if the
infrastructure is enabled it opts to use legacy INTA.

There is no upstream driver for this chip, so I don't know where to look
to find out if the driver tries to enable MSI.

Is what you are saying that if you enable MSI support in the kernel, it
breaks legacy IRQs?

Regards,
Lucas

>            CPU0       CPU1       CPU2       CPU3
>  16:       1165       1032       1271       1591     GIC-0  29 Edge      twd
>  17:        879        387       1404        606       GPC  55 Level     i.MX Timer Tick
>  18:       6434          0          0          0       GPC  13 Level     mxs-dma
>  19:          0          0          0          0       GPC  15 Level     bch
>  21:          0          0          0          0       GPC   9 Level     130000.gpu
>  22:          0          0          0          0       GPC  10 Level     134000.gpu
>  24:          0          0          0          0       GPC 120 Level     mx6-pcie-msi
>  26:          0          0          0          0       GPC  26 Level     2020000.serial
>  30:          0          0          0          0       GPC  12 Level     2040000.vpu
> 240:          0          0          0          0  gpio-mxc   0 Edge      2198000.usdhc cd
> 280:          0          0          0          0       GPC  19 Level     rtc alarm
> 286:          0          0          0          0       GPC   2 Level     sdma
> 287:          0          0          0          0       GPC  43 Level     2184000.usb
> 288:         32          0          0          0       GPC  40 Level     2184200.usb
> 289:       2294          0          0          0     GIC-0 150 Level     2188000.ethernet
> 290:          0          0          0          0     GIC-0 151 Level     2188000.ethernet
> 291:          0          0          0          0       GPC  24 Level     mmc0
> 292:          0          0          0          0       GPC  36 Level     21a0000.i2c
> 293:          0          0          0          0       GPC  37 Level     21a4000.i2c
> 294:          0          0          0          0       GPC  38 Level     21a8000.i2c
> 296:       1422          0          0          0       GPC  27 Level     21e8000.serial
> 297:          0          0          0          0       GPC  30 Level     21f4000.serial
> 300:          0          0          0          0       GPC  39 Level     ahci-imx[2200000.sata]
> 301:          0          0          0          0       GPC  11 Level     2204000.gpu
> 304:          0          0          0          0   PCI-MSI   0 Edge      PCIe PME, aerdrv
> 336:          0          0          0          0       GPC 123 Level     TW6869
> 339:          0          0          0          0       IPU 457 Edge      (null)
> 340:          0          0          0          0       IPU 451 Edge      (null)
> 341:          0          0          0          0       IPU 457 Edge      (null)
> 342:          0          0          0          0       IPU 451 Edge      (null)
> IPI0:          0          0          0          0  CPU wakeup interrupts
> IPI1:        183        111         90         57  Timer broadcast interrupts
> IPI2:        453       2091       6539       2088  Rescheduling interrupts
> IPI3:         37         32         29         23  Function call interrupts
> IPI4:          0          0          0          0  CPU stop interrupts
> IPI5:          0          0          0          1  IRQ work interrupts
> IPI6:          0          0          0          0  completion interrupts
> Err:          0
> 
> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01)
> 01:00.0 PCI bridge: PLX Technology, Inc. PEX 8609 8-lane, 8-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA (rev ba)
> 01:00.1 System peripheral: PLX Technology, Inc. PEX 8609 8-lane, 8-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA (rev ba)
> 02:01.0 PCI bridge: PLX Technology, Inc. PEX 8609 8-lane, 8-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA (rev ba)
> 02:04.0 PCI bridge: PLX Technology, Inc. PEX 8609 8-lane, 8-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA (rev ba)
> 02:05.0 PCI bridge: PLX Technology, Inc. PEX 8609 8-lane, 8-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA (rev ba)
> 02:06.0 PCI bridge: PLX Technology, Inc. PEX 8609 8-lane, 8-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA (rev ba)
> 02:07.0 PCI bridge: PLX Technology, Inc. PEX 8609 8-lane, 8-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA (rev ba)
> 02:08.0 PCI bridge: PLX Technology, Inc. PEX 8609 8-lane, 8-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA (rev ba)
> 02:09.0 PCI bridge: PLX Technology, Inc. PEX 8609 8-lane, 8-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA (rev ba)
> 04:00.0 Multimedia controller: Techwell Inc. Device 6869 (rev 01)
> 08:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8057 PCI-E Gigabit Ethernet Controller
> 
> -[0000:00]---00.0-[01]--+-00.0-[02-09]--+-01.0-[03]--
>                         |               +-04.0-[04]----00.0
>                         |               +-05.0-[05]--
>                         |               +-06.0-[06]--
>                         |               +-07.0-[07]--
>                         |               +-08.0-[08]----00.0
>                         |               \-09.0-[09]--
>                         \-00.1
> 


