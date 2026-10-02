Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB5481A89;
	Fri,  2 Oct 2026 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941018; cv=none; b=NijJypxRP2oCRwT7vOYXmp6Xiqkl8+3bhjDr1dtKKOZI8MdzwbBCwK0YcUmdP/e68hYF9E7hJvYzxYjT/Pe+XSYNa/fZwVHDJh/3F4bUvMtQzVVpzxK0U5/cgUNNHJ7Wx+MPI4HHK4Ufei+8lxFI2hC8hFS0BEEuY+Pch9h9QFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941018; c=relaxed/simple;
	bh=rclxUr20u4UjzU/1Q5SclhPbV1tbb1CU6dLFgnY3N7o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n/LEZQw5kpQTe5ra07tZ3/1CQTadBAVaEGBn/5I4J+qmjsv979YwtpFgRQ5C7//HJG/pR0XwNdaMG2GvM3NsiduoSIoIh5B61yZMv9M8tlkUGb4SF7gVulSAfYmxO1I8hYav/4iZN7ciSNTyi3wFkxENnpe4iy/nO3kEfUUNXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzJJnFec; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzJJnFec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790941016; x=1822477016;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=rclxUr20u4UjzU/1Q5SclhPbV1tbb1CU6dLFgnY3N7o=;
  b=WzJJnFecHjLg/eLP7bLTjMcFHTEiqlY0Cv0T9Z4s6a+JKf5I3fKxy/1f
   8JZ/rTv2uKZt6rqY5y1FIaukDBhEZHwwV5KBNAe8TahX/wFRxepLc490q
   +LKh4xtmT6/hFAbcFrViYk9qPlHfQbcWW6dA0dGUuXl8APh2/8OLXOON2
   mWjdYEvwaLin+yzZLBt5pPCInUacL4TvSF+vpou+yYwlL4/Lhnw9pu5pv
   dqqA2DCh/2aMrRsroW37TjDgq4eMuCtu3yVQ9Cwn5wlQuiwHyoGHBoUvi
   rk18j6RAgH4+cSumwUvzU9HtzHtTeR4frACC/nFXsFvmzqBWhKH+Vl2iH
   g==;
X-CSE-ConnectionGUID: Ol2HD+hDR9ysvIbby+ugog==
X-CSE-MsgGUID: rSdFwcURTEmM+06Gx/XlcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="113489184"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="113489184"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:36:56 -0700
X-CSE-ConnectionGUID: 9zYddKwYSEikgFIAuALU2A==
X-CSE-MsgGUID: OHAwyREwQNazd7I318Lkug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275767617"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.243])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:36:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 2 Oct 2026 14:36:50 +0300 (EEST)
To: Ard Biesheuvel <ardb@kernel.org>
cc: Ard Biesheuvel <ardb+git@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Allow 64-bit non-prefetchable BARs in
 prefetchable windows
In-Reply-To: <734dafa4-e65a-4db5-88a8-9169453a2f5c@app.fastmail.com>
Message-ID: <a7a847db-b9e2-a94b-540a-5cdd829dec18@linux.intel.com>
References: <20260930103036.248989-4-ardb+git@google.com> <20260930103036.248989-6-ardb+git@google.com> <245de2a8-4172-b886-75d6-4d017c30672e@linux.intel.com> <734dafa4-e65a-4db5-88a8-9169453a2f5c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2028918354-1790937343=:1156"
Content-ID: <7a74a883-48ee-3f26-873a-085020ddcdc5@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2028918354-1790937343=:1156
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <aa3cdfd9-3816-1306-4511-8a151f189099@linux.intel.com>

On Fri, 2 Oct 2026, Ard Biesheuvel wrote:

>=20
> On Wed, 30 Sep 2026, at 20:50, Ilpo J=E4rvinen wrote:
> > On Wed, 30 Sep 2026, Ard Biesheuvel wrote:
> >
> >> From: Ard Biesheuvel <ardb@kernel.org>
> >>=20
> >> The non-prefetchable memory window of a PCI-to-PCI bridge can only
> >> decode 32-bit addresses, and so non-prefetchable BARs of devices below=
 a
> >> bridge can only be allocated from the part of the host bridge memory
> >> space below 4 GB. This is the case even for 64-bit BARs, which could
> >> easily be placed above 4 GB if there was a bridge window to put them i=
n,
> >> and on many platforms, 32-bit addressable MMIO space is scarce.
> >>=20
> >> The PCIe spec addresses this in the implementation note "Additional
> >> Guidance on the Prefetchable Bit in Memory Space BARs" (PCIe r7.0, sec
> >> 7.5.1.2.1): on PCIe, setting the Prefetchable bit of a BAR still permi=
ts
> >> correct operation even if the range has read side effects or cannot
> >> tolerate write merging, as long as the entire path from the host to th=
e
> >> device is PCIe, given that PCIe Memory Reads always carry an explicit
> >> length, and PCIe Switches never prefetch or merge writes. The same
> >> reasoning applies when it is the OS that places a non-prefetchable BAR
> >> in a prefetchable bridge window: PCIe Root Ports and Switch Ports
> >> forward requests that hit either window in exactly the same way. Hence=
,
> >> the prefetchable window of a PCIe Root Port or Switch Port, which may =
be
> >> 64-bit, can serve as a 64-bit window for non-prefetchable BARs too. [0=
]
> >>=20
> >> So add pci_bus_placement_flags(), which returns the flags of a resourc=
e
> >> on a given bus with IORESOURCE_PREFETCH set if it is a 64-bit
> >> non-prefetchable memory resource, the bus is not a root bus, all bridg=
es
> >> between the bus and the root bus are PCIe Root Ports or PCIe Switch
> >> Ports, and the host bridge has no prefetchable memory window, but does
> >> have one that extends above 4 GB in PCI bus address space. [1]
> >>=20
> >> Evaluate the conditions on the bridges and the host bridge only once
> >> per bus, when it is added, and record the result in a new bus flag,
> >> PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS: pci_register_host_bridge() sets
> >> it on the root bus if the host bridge does not qualify, child buses
> >> inherit it, and pci_alloc_child_bus() sets it on the secondary bus of
> >> any bridge that is not a PCIe Root Port or Switch Port.
> >>=20
> >> Use pci_bus_placement_flags() wherever the resource allocator decides
> >> which bridge window a device resource (including an SR-IOV VF BAR)
> >> belongs in:
> >>=20
> >> - in pbus_select_window_for_type(), which is used when sizing bridge
> >>   windows, and when releasing them to retry failed assignments or to
> >>   resize a BAR;
> >> - when allocating the resource in __pci_assign_resource(), by passing
> >>   its result to __pci_bus_alloc_resource();
> >> - when claiming a resource assigned by firmware, in
> >>   pci_find_parent_resource();
> >> - when deciding which assigned resources to release after a failed
> >>   assignment, and which failures are relevant to a resized BAR.
> >>=20
> >> As a result, an eligible 64-bit non-prefetchable BAR is handled exactl=
y
> >> like a 64-bit prefetchable BAR: it is placed in the prefetchable windo=
w
> >> of the upstream bridge, which may be above 4 GB, and allocation falls
> >> back to the non-prefetchable window if the prefetchable one has no
> >> space. [2]
> >>=20
> >> 32-bit BARs are not affected, and neither are bridge windows, as only
> >> prefetchable bridge windows can be 64-bit. Devices below conventional
> >> PCI or CardBus bridges, below PCIe to PCI/PCI-X bridges (in either
> >> direction), or below host bridges that have a prefetchable window or n=
o
> >> window above 4 GB are not affected either, and neither are devices on =
a
> >> root bus, as there is no prefetchable window for their BARs to go to.
> >>=20
> >> [0] This reasoning does not extend to the host bridge, though: how it
> >>     treats the windows that firmware describes as prefetchable is
> >>     platform specific. For instance, the V3 Semiconductor V360EPC
> >>     (pci-v3-semi) enables prefetching for its prefetchable window, the
> >>     MPC52xx uses Memory Read Multiple for it, and Freescale PCI/PCIe
> >>     host bridges (fsl_pci) enable relaxed ordering for it. However, if
> >>     the host bridge has no prefetchable windows at all (as appears to =
be
> >>     the case on many x86 PCs), all prefetchable bridge windows are
> >>     carved out of its non-prefetchable windows, and so the host bridge
> >>     does not treat them any differently.
> >>=20
> >> [1] Placing non-prefetchable BARs in prefetchable bridge windows only
> >>     helps if one of those non-prefetchable host bridge windows extends
> >>     above 4 GB. Otherwise, the prefetchable bridge windows end up belo=
w
> >>     4 GB as well, and BARs would merely move between two bridge window=
s
> >>     that are carved out of the same 32-bit space.
> >>=20
> >> [2] Note that this only concerns where a BAR is placed. How it is mapp=
ed
> >>     is decided by the driver and by the attributes of the BAR itself
> >>     (e.g., pci_iomap_wc() and the sysfs resource<N>_wc files only hono=
ur
> >>     IORESOURCE_PREFETCH on the BAR), and this change does not modify t=
he
> >>     flags of any BAR.)
> >>=20
> >> Assisted-by: LLM
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> ---
> >> Tested on QEMU arm64 'virt' (DT, all resources assigned by Linux) with
> >> a qemu-xhci below a Root Port, an NVMe below a Switch, a qemu-xhci
> >> below a PCIe-to-PCI bridge and another qemu-xhci on the root bus: the
> >> 64-bit non-prefetchable BARs of the first two (and of the PCIe-to-PCI
> >> bridge itself) move from the 32-bit non-prefetchable windows into the
> >> 64-bit prefetchable windows above 4 GB, while the others stay where
> >> they were. When the 64-bit host bridge window is marked prefetchable
> >> in the DT, or removed from it, all resources are assigned exactly as
> >> without this patch. Both drivers work, also after hot removal and
> >> rescan of the endpoints and of the Switch. Also tested on QEMU x86_64
> >> q35 with SeaBIOS, which assigns all resources itself: the firmware
> >> assignment is claimed as before, and after hot removal and rescan, the
> >> eligible BARs are placed in the prefetchable windows.
> >> ---
> >>  drivers/pci/pci.c       | 43 +++++++++++++++++++-
> >>  drivers/pci/pci.h       |  1 +
> >>  drivers/pci/probe.c     | 35 ++++++++++++++++
> >>  drivers/pci/setup-bus.c | 23 ++++++++---
> >>  drivers/pci/setup-res.c | 30 +++++++++-----
> >>  include/linux/pci.h     |  1 +
> >>  6 files changed, 115 insertions(+), 18 deletions(-)
> >>=20
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index b2879a6be5f8..51e96611d734 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -736,6 +736,43 @@ static bool pci_dev_config_accessible(struct pci_=
dev *dev, char *msg)
> >>  =09return true;
> >>  }
> >> =20
> >> +/**
> >> + * pci_bus_placement_flags - Get the flags to use for placing a resou=
rce
> >> + * @bus: PCI bus of the device that owns the resource
> >> + * @flags: Resource flags
> >> + *
> >> + * The non-prefetchable window of a PCI-to-PCI bridge can only decode=
 32-bit
> >> + * addresses, so 64-bit non-prefetchable BARs of devices below a brid=
ge have to
> >> + * compete for space below 4GB. However, the PCIe spec notes that set=
ting the
> >> + * Prefetchable bit of a BAR permits correct operation even if the ra=
nge has
> >> + * read side effects or cannot tolerate write merging, as long as the=
 entire
> >> + * path from the host to the device is PCIe: PCIe Memory Reads always=
 carry an
> >> + * explicit length, and PCIe Switches never prefetch or merge writes =
(PCIe
> >> + * r7.0, sec 7.5.1.2.1, Implementation Note "Additional Guidance on t=
he
> >> + * Prefetchable Bit in Memory Space BARs").
> >> + *
> >> + * So if all bridges between @bus and the root bus are PCIe Root Port=
s or PCIe
> >> + * Switch Ports, handle 64-bit non-prefetchable resources on @bus lik=
e 64-bit
> >> + * prefetchable ones, so that they can be placed in the prefetchable =
window of
> >> + * the bridge above @bus, which may be above 4GB. Other bridges, such=
 as
> >> + * conventional PCI bridges, may prefetch from their prefetchable win=
dow.
> >> + *
> >> + * Return: @flags, with IORESOURCE_PREFETCH set if a resource with @f=
lags on
> >> + * @bus may be placed in a prefetchable bridge window.
> >> + */
> >> +unsigned long pci_bus_placement_flags(struct pci_bus *bus, unsigned l=
ong flags)
> >> +{
> >> +=09if ((flags & (IORESOURCE_TYPE_BITS | IORESOURCE_PREFETCH |
> >> +=09=09      IORESOURCE_MEM_64)) !=3D (IORESOURCE_MEM | IORESOURCE_MEM=
_64))
> >
> > PCI_RES_TYPE_MASK
> >
>=20
> OK. Its definition will need to move, though, but I guess that's fine.

Yes. If you want to have it in a consistent place with my work, here's=20
where I put it:

https://lore.kernel.org/linux-pci/20261002113319.6652-6-ilpo.jarvinen@linux=
=2Eintel.com/

> >> +=09=09return flags;
> >> +
> >> +=09if (pci_is_root_bus(bus) ||
> >> +=09    (bus->bus_flags & PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS))
> >> +=09=09return flags;
> >> +
> >> +=09return flags | IORESOURCE_PREFETCH;
> >> +}
> >> +
> >>  /**
> >>   * pci_find_parent_resource - return resource region of parent bus of=
 given
> >>   *=09=09=09      region
> >> @@ -749,6 +786,7 @@ struct resource *pci_find_parent_resource(const st=
ruct pci_dev *dev,
> >>  =09=09=09=09=09  struct resource *res)
> >>  {
> >>  =09const struct pci_bus *bus =3D dev->bus;
> >> +=09unsigned long flags =3D pci_bus_placement_flags(dev->bus, res->fla=
gs);
> >>  =09struct resource *r;
> >> =20
> >>  =09pci_bus_for_each_resource(bus, r) {
> >> @@ -758,10 +796,11 @@ struct resource *pci_find_parent_resource(const =
struct pci_dev *dev,
> >> =20
> >>  =09=09=09/*
> >>  =09=09=09 * If the window is prefetchable but the BAR is
> >> -=09=09=09 * not, the allocator made a mistake.
> >> +=09=09=09 * not (and may not be treated as such), the
> >> +=09=09=09 * allocator made a mistake.
> >>  =09=09=09 */
> >>  =09=09=09if (r->flags & IORESOURCE_PREFETCH &&
> >> -=09=09=09    !(res->flags & IORESOURCE_PREFETCH))
> >> +=09=09=09    !(flags & IORESOURCE_PREFETCH))
> >>  =09=09=09=09return NULL;
> >> =20
> >>  =09=09=09/*
> >> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >> index 8297cfb5dcd5..989b9c1f1580 100644
> >> --- a/drivers/pci/pci.h
> >> +++ b/drivers/pci/pci.h
> >> @@ -567,6 +567,7 @@ static inline int pci_resource_num(const struct pc=
i_dev *dev,
> >>  =09return resno;
> >>  }
> >> =20
> >> +unsigned long pci_bus_placement_flags(struct pci_bus *bus, unsigned l=
ong flags);
> >>  int __pci_bus_alloc_resource(struct pci_bus *bus, struct resource *re=
s,
> >>  =09=09=09     unsigned long flags, resource_size_t size,
> >>  =09=09=09     resource_size_t align, resource_size_t min,
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 27008e2ea5af..8f00ea3321c0 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -990,6 +990,32 @@ static bool pci_preserve_config(struct pci_host_b=
ridge *host_bridge)
> >>  =09return false;
> >>  }
> >> =20
> >> +/*
> >> + * Return true if all memory windows of @bridge are non-prefetchable,=
 and at
> >> + * least one of them extends above 4GB in PCI bus address space (see
> >> + * pci_bus_placement_flags()).
> >> + */
> >> +static bool pci_host_np_only_with_high_window(struct pci_host_bridge =
*bridge)
> >> +{
> >> +=09struct resource_entry *window;
> >> +=09bool high =3D false;
> >> +
> >> +=09resource_list_for_each_entry(window, &bridge->windows) {
> >> +=09=09struct resource *res =3D window->res;
> >> +
> >> +=09=09if (resource_type(res) !=3D IORESOURCE_MEM)
> >> +=09=09=09continue;
> >> +
> >> +=09=09if (res->flags & IORESOURCE_PREFETCH)
> >> +=09=09=09return false;
> >> +
> >> +=09=09if (upper_32_bits(res->end - window->offset))
> >
> > Should this use pcibios_resource_to_bus() for consistency with the rest=
 of=20
> > the code?
> >
>=20
> We are walking the window resources of an apriori known root bus here,
> and pcibios_resource_to_bus() takes a bus, walks up to the root, iterates
> over all window resources again to find the given resource, and then
> applies the offset.
>=20
> I agree it would be better to respect the layering here, but using
> pcibios_resource_to_bus() is a bit of a kludge. Could we split it up
> perhaps?

I guess that possible but TBH, it would probably be best to just ignore=20
my comment instead as I failed to take account the complications you came=
=20
across.


FYI, I'm planning on trying this series with my pci=3Drealloc recalc=20
changes to see if they together resolve the 64-bit VF BARs not appearing=20
on 64-bit side, hopefully I get that done today.

--=20
 i.

> >> +=09=09=09high =3D true;
> >> +=09}
> >> +
> >> +=09return high;
> >> +}
> >> +
> >>  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >>  {
> >>  =09struct device *parent =3D bridge->dev.parent;
> >> @@ -1137,6 +1163,9 @@ static int pci_register_host_bridge(struct pci_h=
ost_bridge *bridge)
> >>  =09=09dev_info(&bus->dev, "root bus resource %pR%s\n", res, addr);
> >>  =09}
> >> =20
> >> +=09if (!pci_host_np_only_with_high_window(bridge))
> >> +=09=09bus->bus_flags |=3D PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS;
> >
> > Could this be simplified, e.g. to PCI_BUS_FLAGS_PREF_WIN_ANY_BAR.
> >
>=20
> Sure. That would also change the polarity, but I think that's an
> improvement actually.




--8323328-2028918354-1790937343=:1156--
