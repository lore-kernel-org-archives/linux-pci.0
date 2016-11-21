Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linaro-acpi@lists.linaro.org"
	<linaro-acpi@lists.linaro.org>
Subject: RE: [PATCH] PCI: Add information about describing PCI in ACPI
Date: Mon, 21 Nov 2016 08:52:52 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F927053@lhreml507-mbx>
References: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F921A88@lhreml507-mbx>
 <20161118175404.GI25762@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161118175404.GI25762@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 18 November 2016 17:54
> To: Gabriele Paoloni
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linaro-acpi@lists.linaro.org
> Subject: Re: [PATCH] PCI: Add information about describing PCI in ACPI
>=20
> On Fri, Nov 18, 2016 at 05:17:34PM +0000, Gabriele Paoloni wrote:
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > > owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> > > Sent: 17 November 2016 18:00
>=20
> > > +Static tables like MCFG, HPET, ECDT, etc., are *not* mechanisms
> for
> > > +reserving address space!  The static tables are for things the OS
> > > +needs to know early in boot, before it can parse the ACPI
> namespace.
> > > +If a new table is defined, an old OS needs to operate correctly
> even
> > > +though it ignores the table.  _CRS allows that because it is
> generic
> > > +and understood by the old OS; a static table does not.
> >
> > Right so if my understanding is correct you are saying that resources
> > described in the MCFG table should also be declared in PNP0C02
> devices
> > so that the PNP driver can reserve these resources.
>=20
> Yes.
>=20
> > On the other side the PCI Root bridge driver should not reserve such
> > resources.
> >
> > Well if my understanding is correct I think we have a problem here:
> > http://lxr.free-electrons.com/source/drivers/pci/ecam.c#L74
> >
> > As you can see pci_ecam_create() will conflict with the pnp driver
> > as it will try to reserve the resources from the MCFG table...
> >
> > Maybe we need to rework pci_ecam_create() ?
>=20
> I think it's OK as it is.
>=20
> The pnp/system.c driver does try to reserve PNP0C02 resources, and it
> marks them as "not busy".  That way they appear in /proc/iomem and
> won't be allocated for anything else, but they can still be requested
> by drivers, e.g., pci/ecam.c, which will mark them "busy".
>=20
> This is analogous to what the PCI core does in pci_claim_resource().
> This is really a function of the ACPI/PNP *core*, which should reserve
> all _CRS resources for all devices (not just PNP0C02 devices).  But
> it's done by pnp/system.c, and only for PNP0C02, because there's a
> bunch of historical baggage there.
>=20
> You'll also notice that in this case, things are out of order:
> logically the pnp/system.c reservation should happen first, but in
> fact the pci/ecam.c request happens *before* the pnp/system.c one.
> That means the pnp/system.c one might fail and complain "[mem ...]
> could not be reserved".

Correct me if I am wrong...

So currently we are relying on the fact that pci_ecam_create() is called
before the pnp driver.
If the pnp driver came first we would end up in pci_ecam_create() failing
here:
http://lxr.free-electrons.com/source/drivers/pci/ecam.c#L76

I am not sure but it seems to me like a bit weak condition to rely on...
what about removing the error condition in pci_ecam_create() and logging
just a dev_info()?

Thanks

Gab


>=20
> Bjorn
