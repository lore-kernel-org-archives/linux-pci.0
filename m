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
Date: Tue, 22 Nov 2016 13:13:50 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F92C09D@lhreml507-mbx>
References: <20161117175938.17465.45820.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F921A88@lhreml507-mbx>
 <20161118175404.GI25762@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F927053@lhreml507-mbx>
 <20161121164700.GL25762@bhelgaas-glaptop.roam.corp.google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F929566@lhreml507-mbx>
 <20161121201001.GA4832@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161121201001.GA4832@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 21 November 2016 20:10
> To: Gabriele Paoloni
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linaro-acpi@lists.linaro.org
> Subject: Re: [PATCH] PCI: Add information about describing PCI in ACPI
>=20
> On Mon, Nov 21, 2016 at 05:23:11PM +0000, Gabriele Paoloni wrote:
> > Hi Bjorn
> >
> > > -----Original Message-----
> > > From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> > > owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> > > Sent: 21 November 2016 16:47
> > > To: Gabriele Paoloni
> > > Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> > > acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; linaro-acpi@lists.linaro.org
> > > Subject: Re: [PATCH] PCI: Add information about describing PCI in
> ACPI
> > >
> > > On Mon, Nov 21, 2016 at 08:52:52AM +0000, Gabriele Paoloni wrote:
> > > > Hi Bjorn
> > > >
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > > > > Sent: 18 November 2016 17:54
> > > > > To: Gabriele Paoloni
> > > > > Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> > > > > acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > > > > kernel@lists.infradead.org; linaro-acpi@lists.linaro.org
> > > > > Subject: Re: [PATCH] PCI: Add information about describing PCI
> in
> > > ACPI
> > > > >
> > > > > On Fri, Nov 18, 2016 at 05:17:34PM +0000, Gabriele Paoloni
> wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: linux-kernel-owner@vger.kernel.org [mailto:linux-
> kernel-
> > > > > > > owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> > > > > > > Sent: 17 November 2016 18:00
> > > > >
> > > > > > > +Static tables like MCFG, HPET, ECDT, etc., are *not*
> > > mechanisms
> > > > > for
> > > > > > > +reserving address space!  The static tables are for things
> the
> > > OS
> > > > > > > +needs to know early in boot, before it can parse the ACPI
> > > > > namespace.
> > > > > > > +If a new table is defined, an old OS needs to operate
> > > correctly
> > > > > even
> > > > > > > +though it ignores the table.  _CRS allows that because it
> is
> > > > > generic
> > > > > > > +and understood by the old OS; a static table does not.
> > > > > >
> > > > > > Right so if my understanding is correct you are saying that
> > > resources
> > > > > > described in the MCFG table should also be declared in
> PNP0C02
> > > > > devices
> > > > > > so that the PNP driver can reserve these resources.
> > > > >
> > > > > Yes.
> > > > >
> > > > > > On the other side the PCI Root bridge driver should not
> reserve
> > > such
> > > > > > resources.
> > > > > >
> > > > > > Well if my understanding is correct I think we have a problem
> > > here:
> > > > > > http://lxr.free-electrons.com/source/drivers/pci/ecam.c#L74
> > > > > >
> > > > > > As you can see pci_ecam_create() will conflict with the pnp
> > > driver
> > > > > > as it will try to reserve the resources from the MCFG
> table...
> > > > > >
> > > > > > Maybe we need to rework pci_ecam_create() ?
> > > > >
> > > > > I think it's OK as it is.
> > > > >
> > > > > The pnp/system.c driver does try to reserve PNP0C02 resources,
> and
> > > it
> > > > > marks them as "not busy".  That way they appear in /proc/iomem
> and
> > > > > won't be allocated for anything else, but they can still be
> > > requested
> > > > > by drivers, e.g., pci/ecam.c, which will mark them "busy".
> > > > >
> > > > > This is analogous to what the PCI core does in
> > > pci_claim_resource().
> > > > > This is really a function of the ACPI/PNP *core*, which should
> > > reserve
> > > > > all _CRS resources for all devices (not just PNP0C02 devices).
> But
> > > > > it's done by pnp/system.c, and only for PNP0C02, because
> there's a
> > > > > bunch of historical baggage there.
> > > > >
> > > > > You'll also notice that in this case, things are out of order:
> > > > > logically the pnp/system.c reservation should happen first, but
> in
> > > > > fact the pci/ecam.c request happens *before* the pnp/system.c
> one.
> > > > > That means the pnp/system.c one might fail and complain "[mem
> ...]
> > > > > could not be reserved".
> > > >
> > > > Correct me if I am wrong...
> > > >
> > > > So currently we are relying on the fact that pci_ecam_create() is
> > > called
> > > > before the pnp driver.
> > > > If the pnp driver came first we would end up in pci_ecam_create()
> > > failing
> > > > here:
> > > > http://lxr.free-electrons.com/source/drivers/pci/ecam.c#L76
> > > >
> > > > I am not sure but it seems to me like a bit weak condition to
> rely
> > > on...
> > > > what about removing the error condition in pci_ecam_create() and
> > > logging
> > > > just a dev_info()?
> > >
> > > Huh.  I'm confused.  I *thought* it would be safe to reverse the
> > > order, which would effectively be this:
> > >
> > >   system_pnp_probe
> > >     reserve_resources_of_dev
> > >       reserve_range
> > >         request_mem_region([mem 0xb0000000-0xb1ffffff])
> > >   ...
> > >   pci_ecam_create
> > >     request_resource_conflict([mem 0xb0000000-0xb1ffffff])
> > >
> > >
> > > but I experimented with the patch below on qemu, and it failed as
> you
> > > predicted:
> > >
> > >   ** res test **
> > >   requested [mem 0xa0000000-0xafffffff]
> > >   can't claim ECAM area [mem 0xa0000000-0xafffffff]: conflict with
> ECAM
> > > PNP [mem 0xa0000000-0xafffffff]
> > >
> > > I expected the request_resource_conflict() to succeed since it's
> > > completely contained in the "ECAM PNP" region.  But I guess I don't
> > > understand kernel/resource.c well enough.
> >
> > I think it fails because effectively the PNP driver is populating the
> > iomem_resource resource tree and therefore pci_ecam_create() finds
> that
> > it cannot add the cfg resource to the same hierarchy as it is already
> > there...
>=20
> Right.  I'm just surprised because the PNP reservation is marked
> "not busy", and a driver (e.g., ECAM) should still be able to request
> the resource.

Yes unfortunately pci_ecam_create() is not flexible on the conflict as=20
pci_request_regions():
http://lxr.free-electrons.com/source/kernel/resource.c#L1155
if the conflict resource is not busy pci_request_regions() will create
a child resource under the conflict sibling and mark it as busy...

or at least this is my understanding...

>=20
> > > I'm not sure we need to fix anything yet, since we currently do the
> > > ecam.c request before the system.c one, and any change there would
> be
> > > a long ways off.  If/when that *does* change, I think the correct
> fix
> > > would be to change ecam.c so its request succeeds (by changing the
> way
> > > it does the request, fixing kernel/resource.c, or whatever) rather
> > > than to reduce the log level and ignore the failure.
> >
> > Well in my mind I didn't want just to make the error disappear...
> > If all the resources should be reserved by the PNP driver then
> ideally
> > we could take away request_resource_conflict() from
> pci_ecam_create(),
> > but this would make buggy some systems with an already shipped BIOS
> > that relied on pci_ecam_create() reservation rather than PNP
> reservation.
>=20
> I don't want remove the request from ecam.c.  Ideally, there should be
> TWO lines in /proc/iomem: one from system.c for "pnp 00:01" or
> whatever it is, and a second from ecam.c.  The first is the generic
> one saying "this region is consumed by a piece of hardware, so don't
> put anything else here."  The second is the driver-specific one saying
> "PCI ECAM owns this region, nobody else can use it."
>=20
> This is the same way we handle PCI BAR resources.  Here are two
> examples from my laptop.  The first (00:08.0) only has one line:
> it has a BAR that consumes address space, but I don't have a driver
> for it loaded.  The second (00:16.0) does have a driver loaded, so it
> has a second line showing that the driver owns the space:
>=20
>   f124a000-f124afff : 0000:00:08.0         # from PCI core
>=20
>   f124d000-f124dfff : 0000:00:16.0         # from PCI core
>     f124d000-f124dfff : mei_me             # from mei_me driver
>=20
> > Just removing the error condition and converting dev_err() into
> > dev_info() seems to me like accommodating already shipped BIOS images
> > and flagging a reservation that is already done by somebody else
> > without compromising the functionality of the PCI Root bridge driver
> > (so far the only reason why I can see the error condition there is
> > to catch a buggy MCFG with overlapping addresses; so if this is the
> > case maybe we need to have a different diagnostic check to make sure
> > that the MCFG table is alright)
>=20
> Ideally I think we should end up with this:
>=20
>   a0000000-afffffff : pnp 00:01
>     a0000000-afffffff : PCI ECAM

I think that for PCIe device drivers it works ok because it is guaranteed
that their own pci_request_regions() is called always after
pci_claim_resource() of the bridge that is on top of them...
I.e. pci_claim_resource() reserves the resources as not busy and
pci_request_regions() will create a child busy resource=20

>=20
> Realistically right now we'll probably end up with only the "PCI ECAM"
> line in /proc/iomem and a warning from system.c about not being able
> to reserve the space.
>=20
> If we ever change things to do the generic PNP reservation first, then
> we should fix things so ecam.c can claim the space without an error.

Maybe the patch below could be a sort of solution...effectively pci_ecam
should succeed in reserving a busy resource under the conflict resource
in case of PNP driver allocating a non BUSY resource first...

---
drivers/pci/ecam.c                  | 16 +++++-----------
 drivers/pci/host/pci-thunder-ecam.c |  2 +-
 include/linux/pci-ecam.h            |  2 +-
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 43ed08d..999b6ef 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -66,16 +66,10 @@ struct pci_config_window *pci_ecam_create(struct device=
 *dev,
 	}
 	bsz =3D 1 << ops->bus_shift;
=20
-	cfg->res.start =3D cfgres->start;
-	cfg->res.end =3D cfgres->end;
-	cfg->res.flags =3D IORESOURCE_MEM | IORESOURCE_BUSY;
-	cfg->res.name =3D "PCI ECAM";
-
-	conflict =3D request_resource_conflict(&iomem_resource, &cfg->res);
-	if (conflict) {
+	cfg->res =3D request_mem_region(cfgres->start, resource_size(cfgres), "PC=
I ECAM");
+	if (!cfg->res) {
 		err =3D -EBUSY;
-		dev_err(dev, "can't claim ECAM area %pR: address conflict with %s %pR\n"=
,
-			&cfg->res, conflict->name, conflict);
+		dev_err(dev, "can't claim ECAM area %pR\n", &cfg->res);
 		goto err_exit;
 	}
=20
@@ -126,8 +120,8 @@ void pci_ecam_free(struct pci_config_window *cfg)
 		if (cfg->win)
 			iounmap(cfg->win);
 	}
-	if (cfg->res.parent)
-		release_resource(&cfg->res);
+	if (cfg->res->parent)
+		release_region(cfg->res->start, resource_size(cfg->res));
 	kfree(cfg);
 }
=20
diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/host/pci-thu=
nder-ecam.c
index d50a3dc..2e48d9d 100644
--- a/drivers/pci/host/pci-thunder-ecam.c
+++ b/drivers/pci/host/pci-thunder-ecam.c
@@ -117,7 +117,7 @@ static int thunder_ecam_p2_config_read(struct pci_bus *=
bus, unsigned int devfn,
 	 * the config space access window.  Since we are working with
 	 * the high-order 32 bits, shift everything down by 32 bits.
 	 */
-	node_bits =3D (cfg->res.start >> 32) & (1 << 12);
+	node_bits =3D (cfg->res->start >> 32) & (1 << 12);
=20
 	v |=3D node_bits;
 	set_val(v, where, size, val);
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 7adad20..f30a4ea 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -36,7 +36,7 @@ struct pci_ecam_ops {
  * use ECAM.
  */
 struct pci_config_window {
-	struct resource			res;
+	struct resource			*res;
 	struct resource			busr;
 	void				*priv;
 	struct pci_ecam_ops		*ops;
--=20
2.7.4
