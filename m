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
Date: Mon, 21 Nov 2016 17:23:11 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F929566@lhreml507-mbx>
References: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F921A88@lhreml507-mbx>
 <20161118175404.GI25762@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F927053@lhreml507-mbx>
 <20161121164700.GL25762@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161121164700.GL25762@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: 21 November 2016 16:47
> To: Gabriele Paoloni
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linaro-acpi@lists.linaro.org
> Subject: Re: [PATCH] PCI: Add information about describing PCI in ACPI
>=20
> On Mon, Nov 21, 2016 at 08:52:52AM +0000, Gabriele Paoloni wrote:
> > Hi Bjorn
> >
> > > -----Original Message-----
> > > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > > Sent: 18 November 2016 17:54
> > > To: Gabriele Paoloni
> > > Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> > > acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; linaro-acpi@lists.linaro.org
> > > Subject: Re: [PATCH] PCI: Add information about describing PCI in
> ACPI
> > >
> > > On Fri, Nov 18, 2016 at 05:17:34PM +0000, Gabriele Paoloni wrote:
> > > > > -----Original Message-----
> > > > > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > > > > owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> > > > > Sent: 17 November 2016 18:00
> > >
> > > > > +Static tables like MCFG, HPET, ECDT, etc., are *not*
> mechanisms
> > > for
> > > > > +reserving address space!  The static tables are for things the
> OS
> > > > > +needs to know early in boot, before it can parse the ACPI
> > > namespace.
> > > > > +If a new table is defined, an old OS needs to operate
> correctly
> > > even
> > > > > +though it ignores the table.  _CRS allows that because it is
> > > generic
> > > > > +and understood by the old OS; a static table does not.
> > > >
> > > > Right so if my understanding is correct you are saying that
> resources
> > > > described in the MCFG table should also be declared in PNP0C02
> > > devices
> > > > so that the PNP driver can reserve these resources.
> > >
> > > Yes.
> > >
> > > > On the other side the PCI Root bridge driver should not reserve
> such
> > > > resources.
> > > >
> > > > Well if my understanding is correct I think we have a problem
> here:
> > > > http://lxr.free-electrons.com/source/drivers/pci/ecam.c#L74
> > > >
> > > > As you can see pci_ecam_create() will conflict with the pnp
> driver
> > > > as it will try to reserve the resources from the MCFG table...
> > > >
> > > > Maybe we need to rework pci_ecam_create() ?
> > >
> > > I think it's OK as it is.
> > >
> > > The pnp/system.c driver does try to reserve PNP0C02 resources, and
> it
> > > marks them as "not busy".  That way they appear in /proc/iomem and
> > > won't be allocated for anything else, but they can still be
> requested
> > > by drivers, e.g., pci/ecam.c, which will mark them "busy".
> > >
> > > This is analogous to what the PCI core does in
> pci_claim_resource().
> > > This is really a function of the ACPI/PNP *core*, which should
> reserve
> > > all _CRS resources for all devices (not just PNP0C02 devices).  But
> > > it's done by pnp/system.c, and only for PNP0C02, because there's a
> > > bunch of historical baggage there.
> > >
> > > You'll also notice that in this case, things are out of order:
> > > logically the pnp/system.c reservation should happen first, but in
> > > fact the pci/ecam.c request happens *before* the pnp/system.c one.
> > > That means the pnp/system.c one might fail and complain "[mem ...]
> > > could not be reserved".
> >
> > Correct me if I am wrong...
> >
> > So currently we are relying on the fact that pci_ecam_create() is
> called
> > before the pnp driver.
> > If the pnp driver came first we would end up in pci_ecam_create()
> failing
> > here:
> > http://lxr.free-electrons.com/source/drivers/pci/ecam.c#L76
> >
> > I am not sure but it seems to me like a bit weak condition to rely
> on...
> > what about removing the error condition in pci_ecam_create() and
> logging
> > just a dev_info()?
>=20
> Huh.  I'm confused.  I *thought* it would be safe to reverse the
> order, which would effectively be this:
>=20
>   system_pnp_probe
>     reserve_resources_of_dev
>       reserve_range
>         request_mem_region([mem 0xb0000000-0xb1ffffff])
>   ...
>   pci_ecam_create
>     request_resource_conflict([mem 0xb0000000-0xb1ffffff])
>=20
>=20
> but I experimented with the patch below on qemu, and it failed as you
> predicted:
>=20
>   ** res test **
>   requested [mem 0xa0000000-0xafffffff]
>   can't claim ECAM area [mem 0xa0000000-0xafffffff]: conflict with ECAM
> PNP [mem 0xa0000000-0xafffffff]
>=20
> I expected the request_resource_conflict() to succeed since it's
> completely contained in the "ECAM PNP" region.  But I guess I don't
> understand kernel/resource.c well enough.

I think it fails because effectively the PNP driver is populating the
iomem_resource resource tree and therefore pci_ecam_create() finds that
it cannot add the cfg resource to the same hierarchy as it is already
there...=20

>=20
> I'm not sure we need to fix anything yet, since we currently do the
> ecam.c request before the system.c one, and any change there would be
> a long ways off.  If/when that *does* change, I think the correct fix
> would be to change ecam.c so its request succeeds (by changing the way
> it does the request, fixing kernel/resource.c, or whatever) rather
> than to reduce the log level and ignore the failure.

Well in my mind I didn't want just to make the error disappear...
If all the resources should be reserved by the PNP driver then ideally
we could take away request_resource_conflict() from pci_ecam_create(),
but this would make buggy some systems with an already shipped BIOS
that relied on pci_ecam_create() reservation rather than PNP reservation.

Just removing the error condition and converting dev_err() into
dev_info() seems to me like accommodating already shipped BIOS images
and flagging a reservation that is already done by somebody else
without compromising the functionality of the PCI Root bridge driver
(so far the only reason why I can see the error condition there is
to catch a buggy MCFG with overlapping addresses; so if this is the
case maybe we need to have a different diagnostic check to make sure
that the MCFG table is alright)

BTW if you think that so far we can keep this as it is I am ok.

Many Thanks

Gab

>=20
> Bjorn
>=20
>=20
> diff --git a/arch/x86/pci/init.c b/arch/x86/pci/init.c
> index adb62aa..5a35638 100644
> --- a/arch/x86/pci/init.c
> +++ b/arch/x86/pci/init.c
> @@ -7,6 +7,8 @@
>     in the right sequence from here. */
>  static __init int pci_arch_init(void)
>  {
> +	struct resource *res, *conflict;
> +	static struct resource cfg;
>  #ifdef CONFIG_PCI_DIRECT
>  	int type =3D 0;
>=20
> @@ -39,6 +41,26 @@ static __init int pci_arch_init(void)
>=20
>  	dmi_check_skip_isa_align();
>=20
> +	printk("\n** res test **\n");
> +
> +	res =3D request_mem_region(0xa0000000, 0x10000000, "ECAM PNP");
> +	printk("requested %pR\n", res);
> +	if (!res)
> +		return 0;
> +	res->flags &=3D ~IORESOURCE_BUSY;
> +
> +	cfg.start =3D 0xa0000000;
> +	cfg.end =3D 0xafffffff;
> +	cfg.flags =3D IORESOURCE_MEM | IORESOURCE_BUSY;
> +	cfg.name =3D "PCI ECAM";
> +
> +	conflict =3D request_resource_conflict(&iomem_resource, &cfg);
> +	if (conflict)
> +		printk("can't claim ECAM area %pR: conflict with %s %pR\n",
> +		    &cfg, conflict->name, conflict);
> +
> +	printk("\n");
> +
>  	return 0;
>  }
>  arch_initcall(pci_arch_init);
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
