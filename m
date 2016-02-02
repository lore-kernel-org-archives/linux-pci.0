Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mcc.vniiem.ru ([78.107.120.166]:57204 "EHLO mx.svc.vniiem.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbcBBFEx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2016 00:04:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx.svc.vniiem.ru (Postfix) with ESMTP id 96DFC820AA
	for <linux-pci@vger.kernel.org>; Tue,  2 Feb 2016 08:04:51 +0300 (MSK)
Received: from mx.svc.vniiem.ru ([127.0.0.1])
	by localhost (mx.svc.vniiem.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LYQ1k4XdK6JH for <linux-pci@vger.kernel.org>;
	Tue,  2 Feb 2016 08:04:51 +0300 (MSK)
From: =?utf-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: PCI device driver broken between 4.2 and 4.3
Date: Tue, 02 Feb 2016 08:04:39 +0300
Message-ID: <2117097.QTAl1GFxjP@debian802>
In-Reply-To: <20160201210823.GC4861@localhost>
References: <20160128192951.CC6AF820DC@mx.svc.vniiem.ru> <2025502.hfirZrb1Qq@debian802> <20160201210823.GC4861@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

it looks much better with pci=routeirq

[  100.896723] *Before pci_enable_device IRQ 20* 
[  100.896735] *After pci_enable_device IRQ 20* 
[  100.896745] *Before pci_enable_device IRQ 21* 
[  100.896752] *After pci_enable_device IRQ 21*


On Monday 01 of February 2016 15:08:23 Bjorn Helgaas wrote:
> [+cc Yinghai]
> 
> On Mon, Feb 01, 2016 at 08:18:35AM +0300, Олег Мороз wrote:
> > Okay. I've started from driver level printk
> > results are:
> > 
> > On 4.2
> > 
> > [414006.575989] Before pci_enable_device IRQ 20
> > 
> > [414006.575991] After pci_enable_device IRQ 20
> > 
> > [414006.575997] Before pci_enable_device IRQ 21
> > 
> > [414006.575999] After pci_enable_device IRQ 21
> > 
> > on 4.3
> > 
> > [  114.862289] Before pci_enable_device IRQ 5
> > 
> > [  114.862303] After pci_enable_device IRQ 5
> > 
> > [  114.862316] Before pci_enable_device IRQ 5
> > 
> > [  114.862326] After pci_enable_device IRQ 5
> > 
> > I've got two cards, because of that pci_enable_device() calls twice.
> 
> Did you try booting with pci=routeirq as Yinghai suggested?  That's
> not a fix, but if it does make things work, it may give us an idea for
> how to fix it correctly.
> 
> > On Friday 29 of January 2016 10:31:59 Bjorn Helgaas wrote:
> > > On Thu, Jan 28, 2016 at 10:28:14PM +0300, Мороз Олег wrote:
> > > > What i need to print out at first order?
> > > 
> > > Jiang, can you chime in here?
> > > 
> > > 991de2e59090 is related to IRQs, so I'd start by printing dev->irq in
> > > your
> > > driver before and after you call pci_enable_device().  Add some printks
> > > in
> > > pcibios_alloc_irq() and pcibios_enable_device() just to confirm that we
> > > got
> > > 
> > > there and when, e.g., add lines like this:
> > >   dev_info(&dev->dev, "%s\n", __func__);
> > > 
> > > Bjorn
> > > 
> > > > 27 янв. 2016 г. 16:22 пользователь Bjorn Helgaas <helgaas@kernel.org>
> > 
> > написал:
> > > > > On Wed, Jan 27, 2016 at 12:38:06PM +0300, Мороз Олег wrote:
> > > > > > Also, my drive has no
> > > > > > 
> > > > > > pcibios_enable_device()
> > > > > > pcibios_alloc_irq()
> > > > > > 
> > > > > > calls.
> > > > > 
> > > > > Those are internal interfaces used by the PCI core.  Drivers
> > > > > shouldn't
> > > > > call them directly.  Drivers normally call pci_enable_device(), and
> > > > > those internal interfaces are used in that path.
> > > > > 
> > > > > > 26.01.2016 22:05, Олег Мороз пишет:
> > > > > > >I confirmed it works in
> > > > > > >
> > > > > > >890e4847587f
> > > > > > >
> > > > > > >and do not works in
> > > > > > >
> > > > > > >991de2e59090
> > > > > > >
> > > > > > >26.01.2016 18:32, Bjorn Helgaas пишет:
> > > > > > >>[+cc Jiang]
> > > > > > >>
> > > > > > >>On Mon, Jan 25, 2016 at 03:52:51PM -0600, Bjorn Helgaas wrote:
> > > > > > >>>Hi Олег,
> > > > > > >>>
> > > > > > >>>On Sun, Jan 24, 2016 at 04:50:08PM +0300, Олег Мороз wrote:
> > > > > > >>>>Okay. I've sent logs (dmesg and lspci) from both 4.2 and 4.3
> > > > > > >>>>to bugzilla
> > > > > > >>>
> > > > > > >>>I don't see anything wrong in either log.  Both v4.2 and v4.3
> > > > > > >>>enumerate the device the same way, and the driver seems to
> > > > > > >>>claim it
> > > > > > >>>
> > > > > > >>>the same way:
> > > > > > >>>   pci 0000:0d:00.0: [10b5:9030] type 00 class 0x078000
> > > > > > >>>   pci 0000:0d:00.0: reg 0x14: [io  0x2100-0x217f]
> > > > > > >>>   pci 0000:0d:00.0: reg 0x18: [io  0x2380-0x239f]
> > > > > > >>>   pci 0000:0d:00.0: PME# supported from D0 D3hot
> > > > > > >>>   pci 0000:0d:01.0: [10b5:9030] type 00 class 0x078000
> > > > > > >>>   pci 0000:0d:01.0: reg 0x14: [io  0x2180-0x21ff]
> > > > > > >>>   pci 0000:0d:01.0: reg 0x18: [io  0x23a0-0x23bf]
> > > > > > >>>   pci 0000:0d:01.0: PME# supported from D0 D3hot
> > > > > > >>>   pci 0000:0d:02.0: [10b5:9030] type 00 class 0x078000
> > > > > > >>>   pci 0000:0d:02.0: reg 0x14: [io  0x2200-0x227f]
> > > > > > >>>   pci 0000:0d:02.0: reg 0x18: [io  0x2280-0x22ff]
> > > > > > >>>   pci 0000:0d:02.0: reg 0x1c: [io  0x2300-0x237f]
> > > > > > >>>   pci 0000:0d:02.0: PME# supported from D0 D3hot
> > > > > > >>>   
> > > > > > >>>   sja1000_plx_pci 0000:0d:02.0: Detected "Eclus CAN-200-PCI"
> > > > > > >>>
> > > > > > >>>card at slot #2
> > > > > > >>>
> > > > > > >>>   sja1000_plx_pci 0000:0d:02.0: Channel #1 at
> > > > > > >>>
> > > > > > >>>0x0000000000012280, irq 22 registered as can0
> > > > > > >>>
> > > > > > >>>   sja1000_plx_pci 0000:0d:02.0: Channel #2 at
> > > > > > >>>
> > > > > > >>>0x0000000000012300, irq 22 registered as can1
> > > > > > >>>
> > > > > > >>>   sja1000_plx_pci 0000:0d:02.0 can0: setting BTR0=0x03
> > > > > > >>>   BTR1=0x37
> > > > > > >>>
> > > > > > >>>One option is always to bisect between v4.2 and v4.3 to see
> > > > > > >>>which
> > > > > > >>>commit made it stop working.  See
> > > > > > >>>https://git-scm.com/docs/git-bisect
> > > > > > >>
> > > > > > >>Jiang, Олег bisected this to 991de2e59090 ("PCI, x86: Implement
> > > > > > >>pcibios_alloc_irq() and pcibios_free_irq()").
> > > > > > >>
> > > > > > >>Олег, please double-check and confirm that 890e4847587f works
> > > > > > >>and
> > > > > > >>991de2e59090 fails.
> > > > > > >>
> > > > > > >>Then please add some printks in the pcibios_enable_device() and
> > > > > > >>pcibios_alloc_irq() paths and in your driver to see exactly what
> > > > > > >>changed
> > > > > > >>between 890e4847587f and 991de2e59090
> > > > > > >>
> > > > > > >>Bjorn
> > > > > > >>
> > > > > > >>>>23.01.2016 17:54, Bjorn Helgaas пишет:
> > > > > > >>>>>[+cc linux-kernel]
> > > > > > >>>>>
> > > > > > >>>>>Hi Олег,
> > > > > > >>>>>
> > > > > > >>>>>On Sat, Jan 23, 2016 at 1:08 AM, Олег Мороз
> > > > > > >>>>>
> > > > > > >>>>><oleg.moroz@mcc.vniiem.ru> wrote:
> > > > > > >>>>>>Hello. I've got a device driver for MIL-1553b card
> > > > > > >>>>>>called TA1-PCI, which
> > > > > > >>>>>>could be found at
> > > > > > >>>>>>https://github.com/qmor/elcus-1553-driver-linux
> > > > > > >>>>>>Card is using PLX_PCI9030 PCI controller.
> > > > > > >>>>>>Today i've found that this driver compiles, installes,
> > > > > > >>>>>>but is not working as
> > > > > > >>>>>>it should.
> > > > > > >>>>>>Looks like it not receives any interrupts from PCI. I've
> > > > > > >>>>>>test it again with
> > > > > > >>>>>>kernel
> > > > > > >>>>>>4.2 and it works okay. What changes was made in PCI
> > > > > > >>>>>>subsystem from 4.2 to
> > > > > > >>>>>>4.3
> > > > > > >>>>>>which could have impact this driver work.
> > > > > > >>>>>
> > > > > > >>>>>Thank you very much for this problem report.  There were many
> > > > > > >>>>>PCI
> > > > > > >>>>>changes between v4.2 and v4.3, and without more information,
> > > > > > >>>>>I
> > > > > > >>>>>can't
> > > > > > >>>>>guess what might be causing this problem.
> > > > > > >>>>>
> > > > > > >>>>>I opened a bug report at
> > > > > > >>>>>https://bugzilla.kernel.org/show_bug.cgi?id=111211
> > > > > > >>>>>
> > > > > > >>>>>Please attach complete dmesg logs for both v4.2 and v4.3 to
> > > > > > >>>>>that
> > > > > > >>>>>bug
> > > > > > >>>>>report.  Also, please attach the complete "lspci -vv" output
> > > > > > >>>>>(as
> > > > > > >>>>>root).
> > > > > > >>>>>
> > > > > > >>>>>Thanks!
> > > > > > >>>>>
> > > > > > >>>>>Bjorn
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
С уважением,
Олег Мороз
Заместитель начальника отдела разработки ПО БВС КА
