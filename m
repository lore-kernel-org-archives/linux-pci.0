Return-Path: <SRS0=6fbU=LF=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=6fbU=LF=linutronix.de=tglx@kernel.org>
Date: Wed, 22 Aug 2018 13:44:44 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
cc: David Miller <davem@davemloft.net>, helgaas@kernel.org,
    jian-hong@endlessm.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux@endlessm.com,
    linux-pci@vger.kernel.org, marc.zyngier@arm.com, hch@lst.de
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
In-Reply-To: <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com>
Message-ID: <alpine.DEB.2.21.1808221222260.2514@nanos.tec.linutronix.de>
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com> <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com> <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com> <20180821.123108.89921430801253333.davem@davemloft.net>
 <da97e198-7683-e0ff-92a9-3b1b22da3757@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 21 Aug 2018, Heiner Kallweit wrote:
> On 21.08.2018 21:31, David Miller wrote:
> > From: Heiner Kallweit <hkallweit1@gmail.com>
> > Date: Mon, 20 Aug 2018 22:46:48 +0200
> > 
> >> I'm in contact with Realtek and according to them few chip versions
> >> seem to clear MSI-X table entries on resume from suspend. Checking
> >> with them how this could be fixed / worked around.
> >> Worst case we may have to disable MSI-X in general.
> > 
> > I worry that if the chip does this, and somehow MSI-X is enabled and
> > an interrupt is generated, the chip will write to the cleared out
> > MSI-X address.  This will either write garbage into memory or cause
> > a bus error and require PCI error recovery.
> > 
> > It also looks like your test patch doesn't fix things for people who
> > have tested it.
> > 
> The test patch was based on the first info from Realtek which made me
> think that the base address of the MSI-X table is cleared, what
> obviously is not the case.
> 
> After some further tests it seems that the solution isn't as simple
> as storing the MSI-X table entries on suspend and restore them on
> resume. On my system (where MSI-X works fine) MSI-X table entries
> on resume are partially different from the ones on suspend.

Which is not a surprise. Please don't try to fiddle with that at the driver
level. The irq and PCI core code are the ones in charge and if you'd
restore at the wrong point then hell breaks lose.

Can you please do the following:

 1) Store the PCI config space at suspend time
 2) Compare the PCI config space at resume time and print the difference

Do that on a working and a non-working version of Realtek NICs.

Thanks,

	tglx
