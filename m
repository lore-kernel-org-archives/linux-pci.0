Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 3 Apr 2018 18:37:00 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: John Garry <john.garry@huawei.com>
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org,
        lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
        hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com,
        arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net,
        dann.frazier@canonical.com, andy.shevchenko@gmail.com,
        robh@kernel.org, andriy.shevchenko@linux.intel.com,
        joe@perches.com, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com, minyard@acm.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        rdunlap@infradead.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, frowand.list@gmail.com, agraf@suse.de,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v17 01/10] LIB: Introduce a generic PIO mapping method
Message-ID: <20180403163700.GA10059@ulmo>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-2-git-send-email-john.garry@huawei.com>
 <20180403140410.GE27789@ulmo>
 <20180403143909.GA21171@ulmo>
 <ab748c97-2b55-d090-606f-5491551feff6@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
In-Reply-To: <ab748c97-2b55-d090-606f-5491551feff6@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 05:01:37PM +0100, John Garry wrote:
> > > > +int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
> > > > +{
> > > > +	struct logic_pio_hwaddr *range;
> > > > +	resource_size_t start =3D new_range->hw_start;
> > > > +	resource_size_t end =3D new_range->hw_start + new_range->size;
> > > > +	resource_size_t mmio_sz =3D 0;
> > > > +	resource_size_t iio_sz =3D MMIO_UPPER_LIMIT;
> > > > +	int ret =3D 0;
> > > > +
> > > > +	if (!new_range || !new_range->fwnode || !new_range->size)
> > > > +		return -EINVAL;
> > > > +
> > > > +	mutex_lock(&io_range_mutex);
> > > > +	list_for_each_entry_rcu(range, &io_range_list, list) {
> > > > +		if (range->fwnode =3D=3D new_range->fwnode) {
> > > > +			/* range already there */
> > > > +			ret =3D -EFAULT;
> > > > +			goto end_register;
> > > > +		}
> > >=20
>=20
> Hi Thierry,
>=20
> > > This is the -EFAULT that propagates to pci-tegra.c's ->probe() and fa=
ils
> > > to bind the driver.
> > >=20
> > > I'm not exactly sure what's causing the duplicate here because it's
> > > rather difficult to get at something useful from just the ->fwnode, b=
ut
> > > I'm fairly sure that the reason this breaks is because the Tegra driv=
er
> > > will defer probe due to some regulators that aren't available on the
> > > first try. Given the above code and the rest of this file, I can't se=
e a
> > > way to "fix" the driver and remove the I/O range on failure.
> > >=20
> > > This is doubly bad because this doesn't only leak the ranges on probe
> > > deferral, but also on driver unload, and we just added support for
> > > building the Tegra driver as a loadable module, so these are actually
> > > cases that can happen in regular uses of the driver.
> > >=20
> > > I have no idea on how to fix this. Anyone know of a quick fix to rest=
ore
> > > PCI for Tegra other than reverting all of these changes?
> > >=20
> > > I suppose an API could be added to unregister the range, but the call=
ing
> > > sequence is rather obfuscated, so removing the range will look totally
> > > asymmetric, I'm afraid.
> > >=20
> > > Here's the call stack:
> > >=20
> > > 	tegra_pcie_probe()
> > > 	tegra_pcie_parse_dt()
> > > 	of_pci_range_to_resource()
> > > 	pci_register_io_range()
> > > 	logic_pio_register_range()
> > >=20
> > > So the range here is registered as part of a resource parsing functio=
n,
> > > which is supposed to not have any side-effects. There's no equivalent=
 of
> > > that parsing routine (i.e. no "unparse" function that would undo the
> > > effects of parsing).
> > >=20
> > > Perhaps a cleaner way would be to decouple the parsing from the actual
> > > request step that has the side-effect.
>=20
> This could be added if we agreed that it would be useful.

I guess in most cases these ranges will be static at least during one
boot. But it still feels like this should be removed when the driver
goes away. While this may not depend on data by the driver, and hence
won't cause a crash or anything, it just seems wrong to leave it
around when the driver no longer isn't.

> > > Going back in history a little, it looks like even before this commit
> > > the I/O range registration was triggered by the parsing code and even
> > > the range leak was there, except that it caused pci_register_io_range=
()
> > > to return 0 rather than -EFAULT. Perhaps the quickest fix for this wo=
uld
> > > be to do the same in the new code and restore drivers that accidental=
ly
> > > depend on this behaviour.
> >=20
> > I can confirm that the following fixes the issue for me, though I don't
> > think it's a very clean fix given that the range will remain requested
> > forever, even if the driver is gone. But since that's already been the
> > case for quite a while, probably something that can be fixed separately.
> >=20
>=20
> Right, there was no way to deregister the range previously.  From looking=
 at
> the history here I see no reason to not support it.
>=20
> As for this patch, as you said, the only difference is that we fault on
> trying to register the same range again. So this solution seems reasonabl=
e.

Okay, I can turn this into a proper patch to fix this up. I suspect that
other drivers may be subject to the same regression. For the longer term
I think it'd be better to properly undo the registration on failure and
removal, but I suspect that it'd be quite a bit of work and not suitable
for v4.17 anymore.

> On another point, for the tegra driver, is it possible to defer earlier in
> the probe, before these currently irreversible steps are taken?

I'm sure it'd be possible. But it would be quite involved, I think. The
reason the code is the way it is is because parsing the DT didn't use to
have side-effects.

Also, I don't think it would buy us much because the probe can still
defer (or at least fail) as late as pci_scan_root_bus_bridge(). Even if
we work around the probe deferral by moving the DT parsing to a later
point we could easily run into a situation where the entry remains in
place and a subsequent attempt to reload the driver would then fail in
the same way as if we were deferring probe.

Thierry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrDraoACgkQ3SOs138+
s6EgOw/+Nw5fgjBNS7vqt6vFh6zbhV8LqWRt5+ZgbApcbQVJJWpVGuKLOFZD9pod
oxni04MrqZf9XJIxqWZ/TFE4Su4H5gfN/as3puVtFjuLW1zH0NcW7RlQ1OgCGgef
CXri2FP4f4RnCyM9U9es9pjj/mKU+xCtOMMu7hBdgyTN3kshFc9ZENL7rXPOf9vN
fSdo8jzuXsJy+Hj9skbddhk7jM8U3ZTLqtiuDcM14G6RokLM64APR1Nr/9RjagjS
NCLli5pRqJGO+3cjLFiFSjr4rwIjeOLEhxKEumZtuhKd6GXo3MBmFTfwIMdC4MHB
pjWQLk1MwYICA1boe3TxOHYKT/tZFPEMBgpTb/g8x3Ar+pzh857jtFxf/U2yrt+V
X/+K8JXBAif8pLAxqDsumhggcLbPNlS41zX6br/B3YkTLzsRKgoUhuyjKzwiNIR6
3lwGC8FDqpfqKBjBQvME9nby1iVlQZztHAobiuVdwQ/lOHynrqqAoXzdKu5PvF57
izP9cxu4UcN3PWrYOhpQnNyVrD9ioN8EME5xJa+Pa+flTJi21l7S5rrLYteA+kN3
Z0f2rxPKND04IgrypPdcdl7ld1SWJqSpoW2CIowzJNmMVXSUVtA+YyNzlKGNmcAB
2USpoXL0QDMAJBireg6oqe8KMT8QptxyGr4uFCKkrYE+9aEndKQ=
=z3VM
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
