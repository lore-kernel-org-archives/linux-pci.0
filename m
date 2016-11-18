Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 18 Nov 2016 11:54:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>
Subject: Re: [PATCH] PCI: Add information about describing PCI in ACPI
Message-ID: <20161118175404.GI25762@bhelgaas-glaptop.roam.corp.google.com>
References: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F921A88@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F921A88@lhreml507-mbx>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2016 at 05:17:34PM +0000, Gabriele Paoloni wrote:
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> > Sent: 17 November 2016 18:00

> > +Static tables like MCFG, HPET, ECDT, etc., are *not* mechanisms for
> > +reserving address space!  The static tables are for things the OS
> > +needs to know early in boot, before it can parse the ACPI namespace.
> > +If a new table is defined, an old OS needs to operate correctly even
> > +though it ignores the table.  _CRS allows that because it is generic
> > +and understood by the old OS; a static table does not.
> 
> Right so if my understanding is correct you are saying that resources
> described in the MCFG table should also be declared in PNP0C02 devices
> so that the PNP driver can reserve these resources.

Yes.

> On the other side the PCI Root bridge driver should not reserve such
> resources.
> 
> Well if my understanding is correct I think we have a problem here:
> http://lxr.free-electrons.com/source/drivers/pci/ecam.c#L74
> 
> As you can see pci_ecam_create() will conflict with the pnp driver
> as it will try to reserve the resources from the MCFG table...
> 
> Maybe we need to rework pci_ecam_create() ?

I think it's OK as it is.

The pnp/system.c driver does try to reserve PNP0C02 resources, and it
marks them as "not busy".  That way they appear in /proc/iomem and
won't be allocated for anything else, but they can still be requested
by drivers, e.g., pci/ecam.c, which will mark them "busy".

This is analogous to what the PCI core does in pci_claim_resource().
This is really a function of the ACPI/PNP *core*, which should reserve
all _CRS resources for all devices (not just PNP0C02 devices).  But
it's done by pnp/system.c, and only for PNP0C02, because there's a
bunch of historical baggage there.

You'll also notice that in this case, things are out of order:
logically the pnp/system.c reservation should happen first, but in
fact the pci/ecam.c request happens *before* the pnp/system.c one.
That means the pnp/system.c one might fail and complain "[mem ...]
could not be reserved".

Bjorn
