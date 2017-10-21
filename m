Return-Path: <SRS0=JRhQ=BU=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=JRhQ=BU=linutronix.de=tglx@kernel.org>
Date: Sat, 21 Oct 2017 09:19:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>,
    x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
    Marc Zyngier <marc.zyngier@arm.com>, KY Srinivasan <kys@microsoft.com>,
    Stephen Hemminger <sthemmin@microsoft.com>, linux-pci@vger.kernel.org,
    devel@linuxdriverproject.org, Josh Poulson <jopoulso@microsoft.com>,
    Haiyang Zhang <haiyangz@microsoft.com>, Simon Xiao <sixiao@microsoft.com>,
    Saeed Mahameed <saeedm@mellanox.com>,
    Mihai Costache <v-micos@microsoft.com>,
    Jork Loeser <Jork.Loeser@microsoft.com>
Subject: Re: [patch 0/3] x86/PCI/MSI: Make sure that irq reservation mode
 works everywhere
In-Reply-To: <20171020230127.GW6332@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.20.1710210918270.3428@nanos>
References: <20171017075456.694047687@linutronix.de> <20171020230127.GW6332@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Fri, 20 Oct 2017, Bjorn Helgaas wrote:
> On Tue, Oct 17, 2017 at 09:54:56AM +0200, Thomas Gleixner wrote:
> > Dexuan reported that the recent rework of the vector allocation mode in x86
> > broke HyperV PCI passtrough because the rework missed to add the
> > MSI_FLAG_MUST_REACTIVATE flag to the HyperV/PCI interrupt domain info.
> > 
> > The simple solution would be to set the flag in the HyperV/PCI driver but
> > it's better to make this generic and let the PCI/MSI core code set the flag
> > when reservation mode is enabled. That ensures that future users of this
> > wont trip over the same problem.
> > 
> > Thanks,
> > 
> > 	tglx
> > 
> > ---
> >  arch/x86/Kconfig           |    2 +-
> >  arch/x86/kernel/apic/msi.c |    5 ++---
> >  drivers/pci/msi.c          |    2 ++
> >  kernel/irq/Kconfig         |    3 +++
> >  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> This mentions 4900be83602b ("x86/vector/msi: Switch to global reservation
> mode"), which I don't have, so I assume it's an x86 thing.  So I guess
> you'll probably merge this via the same tree?

Yes, it's in tip/x86/apic branch and the fixups are applied there now as well.

Thanks,

	tglx
