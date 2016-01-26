Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 26 Jan 2016 09:32:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: PCI device driver broken between 4.2 and 4.3
Message-ID: <20160126153210.GA11375@localhost>
References: <56A32702.7080909@mcc.vniiem.ru>
 <CAErSpo6MtFSxnH8uSqeLiJVR3P-R5DUX2Furw3yw8JiMN29H0A@mail.gmail.com>
 <56A4D690.1020804@mcc.vniiem.ru>
 <20160125215251.GB10272@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160125215251.GB10272@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jiang]

On Mon, Jan 25, 2016 at 03:52:51PM -0600, Bjorn Helgaas wrote:
> Hi Олег,
> 
> On Sun, Jan 24, 2016 at 04:50:08PM +0300, Олег Мороз wrote:
> > Okay. I've sent logs (dmesg and lspci) from both 4.2 and 4.3 to bugzilla
> 
> I don't see anything wrong in either log.  Both v4.2 and v4.3
> enumerate the device the same way, and the driver seems to claim it
> the same way:
> 
>   pci 0000:0d:00.0: [10b5:9030] type 00 class 0x078000
>   pci 0000:0d:00.0: reg 0x14: [io  0x2100-0x217f]
>   pci 0000:0d:00.0: reg 0x18: [io  0x2380-0x239f]
>   pci 0000:0d:00.0: PME# supported from D0 D3hot
>   pci 0000:0d:01.0: [10b5:9030] type 00 class 0x078000
>   pci 0000:0d:01.0: reg 0x14: [io  0x2180-0x21ff]
>   pci 0000:0d:01.0: reg 0x18: [io  0x23a0-0x23bf]
>   pci 0000:0d:01.0: PME# supported from D0 D3hot
>   pci 0000:0d:02.0: [10b5:9030] type 00 class 0x078000
>   pci 0000:0d:02.0: reg 0x14: [io  0x2200-0x227f]
>   pci 0000:0d:02.0: reg 0x18: [io  0x2280-0x22ff]
>   pci 0000:0d:02.0: reg 0x1c: [io  0x2300-0x237f]
>   pci 0000:0d:02.0: PME# supported from D0 D3hot
> 
>   sja1000_plx_pci 0000:0d:02.0: Detected "Eclus CAN-200-PCI" card at slot #2
>   sja1000_plx_pci 0000:0d:02.0: Channel #1 at 0x0000000000012280, irq 22 registered as can0
>   sja1000_plx_pci 0000:0d:02.0: Channel #2 at 0x0000000000012300, irq 22 registered as can1
>   sja1000_plx_pci 0000:0d:02.0 can0: setting BTR0=0x03 BTR1=0x37
> 
> One option is always to bisect between v4.2 and v4.3 to see which
> commit made it stop working.  See https://git-scm.com/docs/git-bisect

Jiang, Олег bisected this to 991de2e59090 ("PCI, x86: Implement
pcibios_alloc_irq() and pcibios_free_irq()").

Олег, please double-check and confirm that 890e4847587f works and
991de2e59090 fails.

Then please add some printks in the pcibios_enable_device() and
pcibios_alloc_irq() paths and in your driver to see exactly what changed
between 890e4847587f and 991de2e59090

Bjorn

> > 23.01.2016 17:54, Bjorn Helgaas пишет:
> > >[+cc linux-kernel]
> > >
> > >Hi Олег,
> > >
> > >On Sat, Jan 23, 2016 at 1:08 AM, Олег Мороз <oleg.moroz@mcc.vniiem.ru> wrote:
> > >>Hello. I've got a device driver for MIL-1553b card called TA1-PCI, which
> > >>could be found at
> > >>https://github.com/qmor/elcus-1553-driver-linux
> > >>Card is using PLX_PCI9030 PCI controller.
> > >>Today i've found that this driver compiles, installes, but is not working as
> > >>it should.
> > >>Looks like it not receives any interrupts from PCI. I've test it again with
> > >>kernel
> > >>4.2 and it works okay. What changes was made in PCI subsystem from 4.2 to
> > >>4.3
> > >>which could have impact this driver work.
> > >Thank you very much for this problem report.  There were many PCI
> > >changes between v4.2 and v4.3, and without more information, I can't
> > >guess what might be causing this problem.
> > >
> > >I opened a bug report at https://bugzilla.kernel.org/show_bug.cgi?id=111211
> > >
> > >Please attach complete dmesg logs for both v4.2 and v4.3 to that bug
> > >report.  Also, please attach the complete "lspci -vv" output (as
> > >root).
> > >
> > >Thanks!
> > >
> > >Bjorn
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
