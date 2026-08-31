Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFD286D56;
	Mon, 31 Aug 2026 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195513; cv=none; b=uVzBaI/1XocAfhu/8VPFtHkPW4hcTYSmDcVIP4I33tI7XFKzp+f1fx8F0b2k2X2uFVPkOMUkrwfbH+cRueBPGR2/ZsNMsh+8O3J7/rke2yZJN8HoYDeRC2ilVB6ZQUSJpR58AmN0nm593Ems3VqcVO1wbPnh8Q/wTu+xbTIzVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195513; c=relaxed/simple;
	bh=yLiV9g2d+owI4MlRzUHmoJ9zeQk/C2bQZRkcgCl7N5Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ihbfhj85JxW6pXGu5/rPwSKXXUxLYIToCXXExJDRuwe5VGGl6MzbY52ivsb5woNbvfVyGHg/daARcG13eDT4J4X6tiMJ4SSEdr0PD2EsX84Bnl938FlvK3f2OrXZN1YmAVmjAFWwS/tt9Rzk0AZ//GCMLV6iFR38xjXABL/2mHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jT2yVfp0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jT2yVfp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788195511; x=1819731511;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yLiV9g2d+owI4MlRzUHmoJ9zeQk/C2bQZRkcgCl7N5Q=;
  b=jT2yVfp0kEywAtNsAUiGgGv7b1/sJwD4w+/dbV26vPkO0b8z7DvCV6v7
   srAkPSdhZcgpI7X1Jkw13ZNfZCOcdi50+uKsNVqby6AdsboSeVMQtvpud
   +U6C5jsqi5Oh8HP3S84kmeHeydGriY9dauFw3aj5JDU71OpoGFYn5oHFf
   Hq6YnT7qk4ykLEHlxM04LArvjgePCiAqGSvyPuVBk/ZQ4jjDluHkdrO32
   dsABDtDMXilEtfY1OcK5gvzkTs5qtKq7yCnM/yYc7y2YhaONzn0LSr6R2
   HotlnxtSpwmlSW77MZzpxnFWRVXj/8knyIy1TL3qcFnwUfRzMBzNgGgNL
   Q==;
X-CSE-ConnectionGUID: yaqhOu9OSNq5waPe8JOzIA==
X-CSE-MsgGUID: NhkgiK8EQ0SV7cS09Dz2MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="114147135"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="114147135"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:58:30 -0700
X-CSE-ConnectionGUID: B7JG05OCSCyQlAtyVlHQOQ==
X-CSE-MsgGUID: Y6bcBF8nR42+wYZ2S4tD1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="267514551"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.121])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 09:58:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 31 Aug 2026 19:58:23 +0300 (EEST)
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
cc: Geramy Loveless <gloveless@jqluv.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
    mario.limonciello@amd.com, nra3088@gmail.com, 
    meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
In-Reply-To: <d4c3ea40-d92a-49c4-ab2c-925fc70c4bb9@amd.com>
Message-ID: <d6c56ff3-0b83-4d2e-7e6f-f3e65a284341@linux.intel.com>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com> <d4c3ea40-d92a-49c4-ab2c-925fc70c4bb9@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1603498900-1788195503=:2637"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1603498900-1788195503=:2637
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 31 Aug 2026, Christian K=C3=B6nig wrote:

> On 8/28/26 23:37, Geramy Loveless wrote:
> > Firmware typically sizes prefetchable bridge windows for the boot-time
> > BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is the=
n
> > no room for a driver to grow a Resizable BAR afterwards: every window
> > from the leaf up to the root is sized for the small BAR, so
> > pci_resize_resource() fails with -ENOSPC.=20
> >=20
> > Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharing =
a=20
> > bridge's single prefetchable window with a much larger one (e.g., a 32 =
GiB=20
> > VRAM BAR) pushes the required window size past the large BAR's alignmen=
t.=20
> > Because bridge windows round up to a power of two, this forces a massiv=
e=20
> > alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window,=20
> > wasting ~32 GiB per GPU).
> >=20
> > This patch solves both issues to enable ReBAR on cascaded switch fabric=
s:
> >=20
> > 1. Reserve Headroom:=20
> > Reserve prefetchable window headroom for the maximum size of each=20
> > downstream Resizable BAR during the bridge sizing pass. The device BAR=
=20
> > and hardware ReBAR are left at their boot size to prevent tearing down=
=20
> > firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.
>=20
> Yeah that was suggested before but that is clearly not something you can=
=20
> do in common code.
>=20
> The ReBAR fields often doesn't reflect the actual needed space but=20
> rather the maximum the HW address logic can resolve.
>=20
> So what you end up with is allocating multiple TiB for a window which=20
> just needs few GiB, sometimes even completely overflowing the 64bit=20
> address space made available by the root complex.

Yes. A naive approach to (only) go to the max ReBAR allows just doesn't=20
work well enough to be usable in general case.

A general algorithm to pick the largests fitting sizes for ReBARs is still=
=20
under works, a few steps away still, and more if I discover more=20
challenges I need address before I can take that final step.

> > 2. Pack Oversized Windows (BAR Demotion):=20
> > The PCI-to-PCI Bridge spec (r1.2, sec 3.2.5) permits a prefetchable BAR=
=20
> > to be assigned from the non-prefetchable window. By clearing the PREFET=
CH=20
> > flag on small control BARs during enumeration, they are placed below 4 =
GiB.=20
> > The prefetchable window is then cleanly sized to the large BAR alone.
>=20
> Interesting hack, shouldn't really matter for AMD GPUs but that is=20
> something more on the heuristic side.=20
>=20
> A perfectly valid trick which is done by BIOS implementations but what=20
> the Linux PCI subsystem still hasn't learned are back to back=20
> allocations, e.g. something like this:
>=20
> BAR0 32 GiB of GPU #1
> BAR1 2=09MiB of GPU #1
>=20
> BAR1 2=09MiB of GPU #2
> BAR0 32 GiB of GPU #2

Assuming you're oversimplifying the layout above, this was added by the com=
mit=20
9036bd0efcb6 ("PCI: Align head space better").

--
 i.

> BAR0 32 GiB of GPU #3
> ...
>=20
> I strongly suggest to implement that one first and see if it helps with y=
our use case.
>=20
> Regards,
> Christian.
>=20
> >=20
> > Why this is safe for 32-bit (< 4G) MMIO space:
> > To prevent exhausting legacy < 4G space, demotion is strictly bounded. =
It=20
> > only triggers beside a massive prefetchable BAR (>=3D 64 MiB), and the =
demoted=20
> > BAR is strictly capped at 16 MiB (PCI_BAR_PACK_CAP). Even on an 8x GPU=
=20
> > system, this consumes at most 128 MiB of < 4G space.=20
> >=20
> > Fallback / Alignment logic:
> > If the 32-bit space is exhausted, small BARs remain in the prefetchable=
=20
> > window. The alignment logic gracefully handles this by rounding the bri=
dge=20
> > window up to the next power of two (e.g., growing to 64 GiB to fit a 32=
 GiB=20
> > BAR + BAR2) to maintain PCIe compatibility, ensuring sibling GPUs land =
in=20
> > properly aligned slots.
> >=20
> > Reserving is safe by default: __assign_resources_sorted() satisfies all
> > required resources first. Use pci=3Dno_rebar_reserve and pci=3Dno_bar_d=
emote=20
> > to restore previous behaviours.
> >=20
> > Testing Context:
> > - ASUS K14PG-D24
> > - 2x EPYC 9354
> > - 8x Radeon AI PRO R9700 (Navi 48, 1002:7551)
> > - Broadcom PEX890xx switches
> > - Kernel base: 45c13f3f9e3b (tested with SEV-SNP passthrough=3D1)
> >=20
> > Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   8 ++
> >  drivers/pci/pci.c                             |  10 ++
> >  drivers/pci/pci.h                             |   1 +
> >  drivers/pci/setup-bus.c                       | 118 ++++++++++++++++++
> >  4 files changed, 137 insertions(+)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > b/Documentation/admin-guide/kernel-parameters.txt
> > index 37006fc3eac3..82d2b340fb98 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5246,6 +5246,14 @@ Kernel parameters
> >  =09=09hpbussize=3Dnn=09The minimum amount of additional bus numbers
> >  =09=09=09=09reserved for buses below a hotplug bridge.
> >  =09=09=09=09Default is 1.
> > +=09=09no_rebar_reserve=09Do not reserve prefetchable bridge-window
> > +=09=09=09=09space for the maximum size of downstream Resizable
> > +=09=09=09=09BARs. By default such space is reserved so a driver
> > +=09=09=09=09can grow a BAR later (e.g. GPU VRAM BAR) even behind
> > +=09=09=09=09fixed PCIe switch fabrics that firmware sized for the
> > +=09=09=09=09boot-time BAR; the device BAR is left at its boot size
> > +=09=09=09=09for the driver to resize and only bridge windows are
> > +=09=09=09=09enlarged. Use this to restore the old behaviour.
> >  =09=09realloc=3D=09Enable/disable reallocating PCI bridge resources
> >  =09=09=09=09if allocations done by BIOS are too small to
> >  =09=09=09=09accommodate resources required by all child
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b2879a6be5f8..c9901b15432a 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -120,6 +120,14 @@ unsigned long pci_hotplug_mmio_pref_size =3D
> > DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
> >  #define DEFAULT_HOTPLUG_BUS_SIZE=091
> >  unsigned long pci_hotplug_bus_size =3D DEFAULT_HOTPLUG_BUS_SIZE;
> >=20
> > +/*
> > + * Prefetchable bridge-window headroom is reserved for the maximum siz=
e of
> > + * downstream Resizable BARs by default, so a driver can grow one late=
r
> > + * (e.g. amdgpu VRAM BAR) even behind fixed PCIe switch fabrics.
> > + * pci=3Dno_rebar_reserve disables this.
> > + */
> > +bool pci_rebar_no_reserve;
> > +
> >=20
> >  /* PCIe MPS/MRRS strategy; can be overridden by kernel command-line
> > param */
> >  enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_DEFAULT;
> > @@ -6840,6 +6848,8 @@ static int __init pci_setup(char *str)
> >  =09=09=09=09=09simple_strtoul(str + 10, &str, 0);
> >  =09=09=09=09if (pci_hotplug_bus_size > 0xff)
> >  =09=09=09=09=09pci_hotplug_bus_size =3D DEFAULT_HOTPLUG_BUS_SIZE;
> > +=09=09=09} else if (!strncmp(str, "no_rebar_reserve", 16)) {
> > +=09=09=09=09pci_rebar_no_reserve =3D true;
> >  =09=09=09} else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
> >  =09=09=09=09pcie_bus_config =3D PCIE_BUS_TUNE_OFF;
> >  =09=09=09} else if (!strncmp(str, "pcie_bus_safe", 13)) {
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index ba3c3fddddc2..6eddcb492425 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -409,6 +409,7 @@ extern unsigned long pci_hotplug_io_size;
> >  extern unsigned long pci_hotplug_mmio_size;
> >  extern unsigned long pci_hotplug_mmio_pref_size;
> >  extern unsigned long pci_hotplug_bus_size;
> > +extern bool pci_rebar_no_reserve;
> >=20
> >  static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
> >  {
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index e8c94aa1d3c1..aa02b8454269 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/bug.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> > +#include <linux/log2.h>
> >  #include <linux/minmax.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > @@ -1258,6 +1259,53 @@ static bool pbus_size_mem_optional(struct pci_de=
v
> > *dev, int resno,
> >  =09return true;
> >  }
> >=20
> > +/*
> > + * pci_rebar_reserve_size - prefetchable window headroom to reserve fo=
r
> > a BAR
> > + *
> > + * Reserve enough prefetchable window space to later grow @resno of @d=
ev to
> > + * its maximum Resizable BAR size. This is done for every ReBAR-capabl=
e
> > device
> > + * by default (disable with pci=3Dno_rebar_reserve). Only the optional
> > (add_size)
> > + * part of the enclosing window is inflated here; the device BAR
> > resource and
> > + * the hardware ReBAR are left at their boot size, so the driver still
> > performs
> > + * the actual resize into the reserved window. Reserving the window up
> > front
> > + * avoids -ENOSPC in pci_resize_resource() on fixed switch fabrics, wh=
ere a
> > + * window shared with a sibling's still-assigned BAR cannot be release=
d and
> > + * regrown at resize time.
> > + *
> > + * The reservation is strictly optional: __assign_resources_sorted()
> > satisfies
> > + * all required resources first and only then places add_size on lefto=
ver
> > + * space, so reserving by default cannot make a required BAR or window
> > fail.
> > + *
> > + * Return the extra bytes to reserve and raise *add_align to the BAR's
> > + * alignment so the reserved space can actually hold the grown BAR.
> > + */
> > +static resource_size_t pci_rebar_reserve_size(struct pci_dev *dev, int
> > resno,
> > +=09=09=09=09=09      resource_size_t *add_align)
> > +{
> > +=09struct resource *res =3D pci_resource_n(dev, resno);
> > +=09resource_size_t max_size, cur_size;
> > +=09int max;
> > +
> > +=09if (pci_rebar_no_reserve || resno >=3D PCI_STD_NUM_BARS)
> > +=09=09return 0;
> > +
> > +=09if ((res->flags & (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH)) !=3D
> > +=09    (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH))
> > +=09=09return 0;
> > +
> > +=09max =3D pci_rebar_get_max_size(dev, resno);
> > +=09if (max < 0)
> > +=09=09return 0;
> > +
> > +=09max_size =3D pci_rebar_size_to_bytes(max);
> > +=09cur_size =3D resource_size(res);
> > +=09if (max_size <=3D cur_size)
> > +=09=09return 0;
> > +
> > +=09*add_align =3D max(*add_align, max_size);
> > +=09return max_size - cur_size;
> > +}
> > +
> >  /**
> >   * pbus_size_mem() - Size the memory window of a given bus
> >   *
> > @@ -1285,6 +1333,7 @@ static void pbus_size_mem(struct pci_bus *bus,
> > struct resource *b_res,
> >  =09int order, max_order;
> >  =09resource_size_t children_add_size =3D 0;
> >  =09resource_size_t add_align =3D 0;
> > +=09resource_size_t rebar_align =3D 0;
> >=20
> >  =09if (!b_res)
> >  =09=09return;
> > @@ -1343,15 +1392,29 @@ static void pbus_size_mem(struct pci_bus *bus,
> > struct resource *b_res,
> >  =09=09=09=09aligns[order] +=3D align;
> >  =09=09=09if (order > max_order)
> >  =09=09=09=09max_order =3D order;
> > +
> > +=09=09=09size +=3D pci_rebar_reserve_size(dev, i, &rebar_align);
> >  =09=09}
> >  =09}
> >=20
> >  =09win_align =3D pci_min_window_alignment(bus, b_res->flags);
> >  =09min_align =3D calculate_head_align(aligns, max_order);
> >  =09min_align =3D max(min_align, win_align);
> > +=09min_align =3D max(min_align, rebar_align);
> >  =09size0 =3D calculate_memsize(size, realloc_head ? 0 : add_size,
> >  =09=09=09=09  0, win_align);
> >=20
> > +=09/*
> > +=09 * A window that reserves ReBAR headroom is larger than its own
> > +=09 * alignment (e.g. 32 GiB BAR + doorbell =3D> 33 GiB > 32 GiB). The
> > +=09 * parent only reserves alignment padding for a child window when
> > +=09 * its size <=3D its alignment, so round such a window's alignment =
up
> > +=09 * to a power of two >=3D its size; sibling 32 GiB BARs behind one
> > +=09 * switch then each land in a properly aligned slot.
> > +=09 */
> > +=09if (rebar_align && size0)
> > +=09=09min_align =3D max(min_align, roundup_pow_of_two(size0));
> > +
> >  =09if (size0) {
> >  =09=09resource_set_range(b_res, min_align, size0);
> >  =09=09b_res->flags &=3D ~IORESOURCE_DISABLED;
> > @@ -2179,6 +2242,52 @@ static void pci_prepare_next_assign_round(struct
> > list_head *fail_head,
> >   * Second and later try will clear small leaf bridge res.
> >   * Will stop till to the max depth if can not find good one.
> >   */
> > +/*
> > + * Release the 64-bit prefetchable BARs of resizable-BAR display
> > devices so the
> > + * windows enclosing them empty out and can be re-sized. The BAR *size=
*
> > is left
> > + * untouched (only released and re-placed), so the hardware ReBAR is n=
ever
> > + * programmed here - the driver still owns the actual resize.
> > + */
> > +static int pci_release_rebar_bars_cb(struct pci_dev *dev, void *data)
> > +{
> > +=09struct resource *r;
> > +=09unsigned int i;
> > +
> > +=09if ((dev->class >> 16) !=3D PCI_BASE_CLASS_DISPLAY)
> > +=09=09return 0;
> > +=09if (pci_rebar_get_max_size(dev, 0) <=3D pci_rebar_get_current_size(=
dev, 0))
> > +=09=09return 0;
> > +=09pci_dev_for_each_resource(dev, r, i) {
> > +=09=09if (i >=3D PCI_BRIDGE_RESOURCES)
> > +=09=09=09break;
> > +=09=09if (r->parent && (r->flags & IORESOURCE_MEM_64) &&
> > +=09=09    (r->flags & IORESOURCE_PREFETCH))
> > +=09=09=09pci_release_resource(dev, i);
> > +=09}
> > +=09return 0;
> > +}
> > +
> > +/*
> > + * Release the now-empty prefetchable bridge windows bottom-up so the
> > sizing
> > + * pass re-sizes them (with pci_rebar_pref_reserve() reservation) to
> > fit the
> > + * BARs a driver will later grow.
> > + */
> > +static void pci_release_rebar_windows(struct pci_bus *bus)
> > +{
> > +=09struct pci_dev *dev;
> > +=09struct resource *w;
> > +
> > +=09list_for_each_entry(dev, &bus->devices, bus_list)
> > +=09=09if (dev->subordinate)
> > +=09=09=09pci_release_rebar_windows(dev->subordinate);
> > +
> > +=09if (!bus->self)
> > +=09=09return;
> > +=09w =3D &bus->self->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> > +=09if (w->parent && (w->flags & IORESOURCE_MEM_64) && !w->child)
> > +=09=09pci_release_resource(bus->self, PCI_BRIDGE_PREF_MEM_WINDOW);
> > +}
> > +
> >  void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
> >  {
> >  =09LIST_HEAD(realloc_head);
> > @@ -2190,6 +2299,15 @@ void
> > pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
> >  =09int pci_try_num =3D 1;
> >  =09enum enable_type enable_local;
> >=20
> > +=09/*
> > +=09 * Release resizable device BARs and their prefetchable windows so =
the
> > +=09 * sizing pass re-sizes those windows large enough
> > (pci_rebar_pref_reserve)
> > +=09 * for the BARs a driver will later grow. Only released and re-plac=
ed
> > - the
> > +=09 * BAR size is left untouched, so the hardware ReBAR is never progr=
ammed.
> > +=09 */
> > +=09pci_walk_bus(bus, pci_release_rebar_bars_cb, NULL);
> > +=09pci_release_rebar_windows(bus);
> > +
> >  =09/* Don't realloc if asked to do so */
> >  =09enable_local =3D pci_realloc_detect(bus, pci_realloc_enable);
> >  =09if (pci_realloc_enabled(enable_local)) {
> >=20
> > base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
>=20
--8323328-1603498900-1788195503=:2637--
