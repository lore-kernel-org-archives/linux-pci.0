Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 3 Apr 2018 16:39:09 +0200
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
Message-ID: <20180403143909.GA21171@ulmo>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-2-git-send-email-john.garry@huawei.com>
 <20180403140410.GE27789@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <20180403140410.GE27789@ulmo>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 04:04:10PM +0200, Thierry Reding wrote:
> On Thu, Mar 15, 2018 at 02:15:50AM +0800, John Garry wrote:
> > From: Zhichang Yuan <yuanzhichang@hisilicon.com>
> >=20
> > In commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
> > pci_pio_to_address()"), a new I/O space management was supported. With
> > that driver, the I/O ranges configured for PCI/PCIe hosts on some
> > architectures can be mapped to logical PIO, converted easily between
> > CPU address and the corresponding logicial PIO. Based on this, PCI
> > I/O devices can be accessed in a memory read/write way through the
> > unified in/out accessors.
> >=20
> > But on some archs/platforms, there are bus hosts which access I/O
> > peripherals with host-local I/O port addresses rather than memory
> > addresses after memory-mapped.
> >=20
> > To support those devices, a more generic I/O mapping method is introduc=
ed
> > here. Through this patch, both the CPU addresses and the host-local port
> > can be mapped into the logical PIO space with different logical/fake PI=
Os.
> > After this, all the I/O accesses to either PCI MMIO devices or host-loc=
al
> > I/O peripherals can be unified into the existing I/O accessors defined =
in
> > asm-generic/io.h and be redirected to the right device-specific hooks
> > based on the input logical PIO.
> >=20
> > Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Tested-by: dann frazier <dann.frazier@canonical.com>
> > ---
> >  include/asm-generic/io.h  |   2 +
> >  include/linux/logic_pio.h | 124 ++++++++++++++++++++
> >  lib/Kconfig               |  15 +++
> >  lib/Makefile              |   2 +
> >  lib/logic_pio.c           | 282 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 425 insertions(+)
> >  create mode 100644 include/linux/logic_pio.h
> >  create mode 100644 lib/logic_pio.c
> >=20
> [...]
> > diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> > new file mode 100644
> > index 0000000..8394c2d
> > --- /dev/null
> > +++ b/lib/logic_pio.c
> > @@ -0,0 +1,282 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
> > + * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
> > + *
> > + */
> > +
> > +#define pr_fmt(fmt)	"LOGIC PIO: " fmt
> > +
> > +#include <linux/of.h>
> > +#include <linux/io.h>
> > +#include <linux/logic_pio.h>
> > +#include <linux/mm.h>
> > +#include <linux/rculist.h>
> > +#include <linux/sizes.h>
> > +#include <linux/slab.h>
> > +
> > +/* The unique hardware address list. */
> > +static LIST_HEAD(io_range_list);
> > +static DEFINE_MUTEX(io_range_mutex);
> > +
> > +/* Consider a kernel general helper for this */
> > +#define in_range(b, first, len)        ((b) >=3D (first) && (b) < (fir=
st) + (len))
> > +
> > +/**
> > + * logic_pio_register_range - register logical PIO range for a host
> > + * @new_range: pointer to the io range to be registered.
> > + *
> > + * returns 0 on success, the error code in case of failure
> > + *
> > + * Register a new io range node in the io range list.
> > + */
> > +int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
> > +{
> > +	struct logic_pio_hwaddr *range;
> > +	resource_size_t start =3D new_range->hw_start;
> > +	resource_size_t end =3D new_range->hw_start + new_range->size;
> > +	resource_size_t mmio_sz =3D 0;
> > +	resource_size_t iio_sz =3D MMIO_UPPER_LIMIT;
> > +	int ret =3D 0;
> > +
> > +	if (!new_range || !new_range->fwnode || !new_range->size)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&io_range_mutex);
> > +	list_for_each_entry_rcu(range, &io_range_list, list) {
> > +		if (range->fwnode =3D=3D new_range->fwnode) {
> > +			/* range already there */
> > +			ret =3D -EFAULT;
> > +			goto end_register;
> > +		}
>=20
> This is the -EFAULT that propagates to pci-tegra.c's ->probe() and fails
> to bind the driver.
>=20
> I'm not exactly sure what's causing the duplicate here because it's
> rather difficult to get at something useful from just the ->fwnode, but
> I'm fairly sure that the reason this breaks is because the Tegra driver
> will defer probe due to some regulators that aren't available on the
> first try. Given the above code and the rest of this file, I can't see a
> way to "fix" the driver and remove the I/O range on failure.
>=20
> This is doubly bad because this doesn't only leak the ranges on probe
> deferral, but also on driver unload, and we just added support for
> building the Tegra driver as a loadable module, so these are actually
> cases that can happen in regular uses of the driver.
>=20
> I have no idea on how to fix this. Anyone know of a quick fix to restore
> PCI for Tegra other than reverting all of these changes?
>=20
> I suppose an API could be added to unregister the range, but the calling
> sequence is rather obfuscated, so removing the range will look totally
> asymmetric, I'm afraid.
>=20
> Here's the call stack:
>=20
> 	tegra_pcie_probe()
> 	tegra_pcie_parse_dt()
> 	of_pci_range_to_resource()
> 	pci_register_io_range()
> 	logic_pio_register_range()
>=20
> So the range here is registered as part of a resource parsing function,
> which is supposed to not have any side-effects. There's no equivalent of
> that parsing routine (i.e. no "unparse" function that would undo the
> effects of parsing).
>=20
> Perhaps a cleaner way would be to decouple the parsing from the actual
> request step that has the side-effect.
>=20
> Going back in history a little, it looks like even before this commit
> the I/O range registration was triggered by the parsing code and even
> the range leak was there, except that it caused pci_register_io_range()
> to return 0 rather than -EFAULT. Perhaps the quickest fix for this would
> be to do the same in the new code and restore drivers that accidentally
> depend on this behaviour.

I can confirm that the following fixes the issue for me, though I don't
think it's a very clean fix given that the range will remain requested
forever, even if the driver is gone. But since that's already been the
case for quite a while, probably something that can be fixed separately.

Cc'ing linux-tegra for visibility.

Thierry

--- >8 ---
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 29cedeadb397..4664b87e1c5f 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -46,7 +46,6 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new=
_range)
 	list_for_each_entry_rcu(range, &io_range_list, list) {
 		if (range->fwnode =3D=3D new_range->fwnode) {
 			/* range already there */
-			ret =3D -EFAULT;
 			goto end_register;
 		}
 		if (range->flags =3D=3D LOGIC_PIO_CPU_MMIO &&

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrDkgoACgkQ3SOs138+
s6FdvQ//UP5e2NbsiNCzF8UxnE6I2I9V/WRg5LfeBP3xx2Vhzxbgmp3JaiU3MqF8
j1S4JSKJ8jBGDrdCZYzgVboJgC+QZ3b4WKR+ZP31x8bhsdZUZNkg66bgA7hVUzcI
xeqD/Is5w+cJPE96Kk9tL8ntE83h541CM05E8h9pukubuOeeS+Y3w17CJB6xp+Ny
bvsmV+ZVvDh/9TaZrFw8e/BQR734LUq1aDhibeJSP1HEshX7PPVER07UZVNR4pkw
MMYhcOo58zJ5qPxlrpir7wFC6gN5kAeEF3vmc40gyxrOzU/j9La1CEmzTsC9gThw
mBspssabK120drd3Nc4v1J3Fs3LK1qioqMs108835SXJg9U03QR4sEYlBDnA5C3y
wLQDUsAkxbXwtPMmdz7p2piCb/mSMMe5f8UOrOpcMQGRtI5ZggQx5nbagWAjStfk
qV8f4SUnEUidkOES01EQWJ7bt0j5FbG6Yj0NPIkjjGr/glvGyMUIpXqJyu9Hmtyf
X6Bq9fn3njxM+P2cEJoxrwQvk26wMnSBoc/CpiVwTyZLN4eTtRSctttPgXa2U1w/
nCtwt+q6TiIpZgYoCgR5GLwBb53iZNRH7pRLsDjEtEEaDoAGbCy97b7cS8ma+wDj
Y8MNLaMUPrgyAh1F6XUbIrtEoeYHQWtcZUEYk084SH6eKguPt3Y=
=aklt
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
