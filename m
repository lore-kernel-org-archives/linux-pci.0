Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84E46A5EE;
	Fri,  2 Oct 2026 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949988; cv=none; b=uw5muzBTqhfLNwR7n67zwghTqEZhXuHp30NeuiBhoObviPUcqThW8E8qFVM3xGAnr4G0VQamFFPaebEBCI6n5hkJ4vOkdkDEk/1ugBpL9yiIu+FydtB68cRGLcUOrp9ZpM4uV33F8JsBfIvrgqeu0eOj+Q1FZJjBoNYHxNX/Haw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949988; c=relaxed/simple;
	bh=7E+UTnDs7KbPwPAENnQpyhC+aIqCnRS4w9rPWpqMfow=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d4PxXZdx6JdUt2NQU5WcT2fOL/mmW6H0e+iOH+K23d0H8xAD8P9ys6UK5DJ3nwC204QqmPoCZHzoUfeVClpGuZZblYPGcn6JamlOl2jq71UaCb0xzB4vmi1T2qG7pWrZpdVaFHb3nAg2FDXcm2Q33gffxl+bmKWT6RjhmfKiDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpPIDQE/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpPIDQE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790949986; x=1822485986;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7E+UTnDs7KbPwPAENnQpyhC+aIqCnRS4w9rPWpqMfow=;
  b=LpPIDQE/JkxWgUvsK+jHOJTzA3hVP8MfA83R2NhgZ8f0Qj2hCTk7yYBY
   5mctHlOEy50VIlDkCZxerSTaY8fV3JXYMchOztfJX3tJ1jQg6K0tQGCf4
   eBgvD6v6/O72OntNOoHdNozGjBeK0yfh38Xva9p55cAv7xr8QP0I6VEG/
   Ct3/adZm7+0PYRlD6hLbyhs12ePBdMdKlelB5qIpAutGD3cJroLynb/tc
   nZyjHiNcw+q6tbCOn5a0w1K4zHQc3MfVEUDaJtKqw3wyX97FuLtTtGEDd
   ouS2RsXWAk8GwXItZwbNdJoCy1SH8TrSOirzoSfKCfQgKPraaGPseXYaU
   Q==;
X-CSE-ConnectionGUID: NvR+txsVS0OfQunBY4bmFA==
X-CSE-MsgGUID: jxJ/G9KRT82wX7PV2FvzEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="91735794"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="91735794"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 07:06:26 -0700
X-CSE-ConnectionGUID: th9WovJwTcO9lWU0DbTGiQ==
X-CSE-MsgGUID: R/3a+cmoSF2C7v/yFGS25Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275794368"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.243])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 07:06:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 2 Oct 2026 17:06:18 +0300 (EEST)
To: Ard Biesheuvel <ardb@kernel.org>
cc: Ard Biesheuvel <ardb+git@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Allow 64-bit non-prefetchable BARs in
 prefetchable windows
In-Reply-To: <a7a847db-b9e2-a94b-540a-5cdd829dec18@linux.intel.com>
Message-ID: <c5371d2b-60aa-5658-ac57-4953705dc0b0@linux.intel.com>
References: <20260930103036.248989-4-ardb+git@google.com> <20260930103036.248989-6-ardb+git@google.com> <245de2a8-4172-b886-75d6-4d017c30672e@linux.intel.com> <734dafa4-e65a-4db5-88a8-9169453a2f5c@app.fastmail.com>
 <a7a847db-b9e2-a94b-540a-5cdd829dec18@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-993494446-1790949978=:1156"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-993494446-1790949978=:1156
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 2 Oct 2026, Ilpo J=E4rvinen wrote:

> On Fri, 2 Oct 2026, Ard Biesheuvel wrote:
>=20
> >=20
> > On Wed, 30 Sep 2026, at 20:50, Ilpo J=E4rvinen wrote:
> > > On Wed, 30 Sep 2026, Ard Biesheuvel wrote:
> > >
> > >> From: Ard Biesheuvel <ardb@kernel.org>
> > >>=20
> > >> The non-prefetchable memory window of a PCI-to-PCI bridge can only
> > >> decode 32-bit addresses, and so non-prefetchable BARs of devices bel=
ow a
> > >> bridge can only be allocated from the part of the host bridge memory
> > >> space below 4 GB. This is the case even for 64-bit BARs, which could
> > >> easily be placed above 4 GB if there was a bridge window to put them=
 in,
> > >> and on many platforms, 32-bit addressable MMIO space is scarce.
> > >>=20
> > >> The PCIe spec addresses this in the implementation note "Additional
> > >> Guidance on the Prefetchable Bit in Memory Space BARs" (PCIe r7.0, s=
ec
> > >> 7.5.1.2.1): on PCIe, setting the Prefetchable bit of a BAR still per=
mits
> > >> correct operation even if the range has read side effects or cannot
> > >> tolerate write merging, as long as the entire path from the host to =
the
> > >> device is PCIe, given that PCIe Memory Reads always carry an explici=
t
> > >> length, and PCIe Switches never prefetch or merge writes. The same
> > >> reasoning applies when it is the OS that places a non-prefetchable B=
AR
> > >> in a prefetchable bridge window: PCIe Root Ports and Switch Ports
> > >> forward requests that hit either window in exactly the same way. Hen=
ce,
> > >> the prefetchable window of a PCIe Root Port or Switch Port, which ma=
y be
> > >> 64-bit, can serve as a 64-bit window for non-prefetchable BARs too. =
[0]
> > >>=20
> > >> So add pci_bus_placement_flags(), which returns the flags of a resou=
rce
> > >> on a given bus with IORESOURCE_PREFETCH set if it is a 64-bit
> > >> non-prefetchable memory resource, the bus is not a root bus, all bri=
dges
> > >> between the bus and the root bus are PCIe Root Ports or PCIe Switch
> > >> Ports, and the host bridge has no prefetchable memory window, but do=
es
> > >> have one that extends above 4 GB in PCI bus address space. [1]
> > >>=20
> > >> Evaluate the conditions on the bridges and the host bridge only once
> > >> per bus, when it is added, and record the result in a new bus flag,
> > >> PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS: pci_register_host_bridge() se=
ts
> > >> it on the root bus if the host bridge does not qualify, child buses
> > >> inherit it, and pci_alloc_child_bus() sets it on the secondary bus o=
f
> > >> any bridge that is not a PCIe Root Port or Switch Port.
> > >>=20
> > >> Use pci_bus_placement_flags() wherever the resource allocator decide=
s
> > >> which bridge window a device resource (including an SR-IOV VF BAR)
> > >> belongs in:
> > >>=20
> > >> - in pbus_select_window_for_type(), which is used when sizing bridge
> > >>   windows, and when releasing them to retry failed assignments or to
> > >>   resize a BAR;
> > >> - when allocating the resource in __pci_assign_resource(), by passin=
g
> > >>   its result to __pci_bus_alloc_resource();
> > >> - when claiming a resource assigned by firmware, in
> > >>   pci_find_parent_resource();
> > >> - when deciding which assigned resources to release after a failed
> > >>   assignment, and which failures are relevant to a resized BAR.
> > >>=20
> > >> As a result, an eligible 64-bit non-prefetchable BAR is handled exac=
tly
> > >> like a 64-bit prefetchable BAR: it is placed in the prefetchable win=
dow
> > >> of the upstream bridge, which may be above 4 GB, and allocation fall=
s
> > >> back to the non-prefetchable window if the prefetchable one has no
> > >> space. [2]
> > >>=20
> > >> 32-bit BARs are not affected, and neither are bridge windows, as onl=
y
> > >> prefetchable bridge windows can be 64-bit. Devices below conventiona=
l
> > >> PCI or CardBus bridges, below PCIe to PCI/PCI-X bridges (in either
> > >> direction), or below host bridges that have a prefetchable window or=
 no
> > >> window above 4 GB are not affected either, and neither are devices o=
n a
> > >> root bus, as there is no prefetchable window for their BARs to go to=
=2E
> > >>=20
> > >> [0] This reasoning does not extend to the host bridge, though: how i=
t
> > >>     treats the windows that firmware describes as prefetchable is
> > >>     platform specific. For instance, the V3 Semiconductor V360EPC
> > >>     (pci-v3-semi) enables prefetching for its prefetchable window, t=
he
> > >>     MPC52xx uses Memory Read Multiple for it, and Freescale PCI/PCIe
> > >>     host bridges (fsl_pci) enable relaxed ordering for it. However, =
if
> > >>     the host bridge has no prefetchable windows at all (as appears t=
o be
> > >>     the case on many x86 PCs), all prefetchable bridge windows are
> > >>     carved out of its non-prefetchable windows, and so the host brid=
ge
> > >>     does not treat them any differently.
> > >>=20
> > >> [1] Placing non-prefetchable BARs in prefetchable bridge windows onl=
y
> > >>     helps if one of those non-prefetchable host bridge windows exten=
ds
> > >>     above 4 GB. Otherwise, the prefetchable bridge windows end up be=
low
> > >>     4 GB as well, and BARs would merely move between two bridge wind=
ows
> > >>     that are carved out of the same 32-bit space.
> > >>=20
> > >> [2] Note that this only concerns where a BAR is placed. How it is ma=
pped
> > >>     is decided by the driver and by the attributes of the BAR itself
> > >>     (e.g., pci_iomap_wc() and the sysfs resource<N>_wc files only ho=
nour
> > >>     IORESOURCE_PREFETCH on the BAR), and this change does not modify=
 the
> > >>     flags of any BAR.)
> > >>=20
> > >> Assisted-by: LLM
> > >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >> ---
> > >> Tested on QEMU arm64 'virt' (DT, all resources assigned by Linux) wi=
th
> > >> a qemu-xhci below a Root Port, an NVMe below a Switch, a qemu-xhci
> > >> below a PCIe-to-PCI bridge and another qemu-xhci on the root bus: th=
e
> > >> 64-bit non-prefetchable BARs of the first two (and of the PCIe-to-PC=
I
> > >> bridge itself) move from the 32-bit non-prefetchable windows into th=
e
> > >> 64-bit prefetchable windows above 4 GB, while the others stay where
> > >> they were. When the 64-bit host bridge window is marked prefetchable
> > >> in the DT, or removed from it, all resources are assigned exactly as
> > >> without this patch. Both drivers work, also after hot removal and
> > >> rescan of the endpoints and of the Switch. Also tested on QEMU x86_6=
4
> > >> q35 with SeaBIOS, which assigns all resources itself: the firmware
> > >> assignment is claimed as before, and after hot removal and rescan, t=
he
> > >> eligible BARs are placed in the prefetchable windows.
> > >> ---
> > >>  drivers/pci/pci.c       | 43 +++++++++++++++++++-
> > >>  drivers/pci/pci.h       |  1 +
> > >>  drivers/pci/probe.c     | 35 ++++++++++++++++
> > >>  drivers/pci/setup-bus.c | 23 ++++++++---
> > >>  drivers/pci/setup-res.c | 30 +++++++++-----
> > >>  include/linux/pci.h     |  1 +
> > >>  6 files changed, 115 insertions(+), 18 deletions(-)
> > >>=20
> > >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > >> index b2879a6be5f8..51e96611d734 100644
> > >> --- a/drivers/pci/pci.c
> > >> +++ b/drivers/pci/pci.c
> > >> @@ -736,6 +736,43 @@ static bool pci_dev_config_accessible(struct pc=
i_dev *dev, char *msg)
> > >>  =09return true;
> > >>  }
> > >> =20
> > >> +/**
> > >> + * pci_bus_placement_flags - Get the flags to use for placing a res=
ource
> > >> + * @bus: PCI bus of the device that owns the resource
> > >> + * @flags: Resource flags
> > >> + *
> > >> + * The non-prefetchable window of a PCI-to-PCI bridge can only deco=
de 32-bit
> > >> + * addresses, so 64-bit non-prefetchable BARs of devices below a br=
idge have to
> > >> + * compete for space below 4GB. However, the PCIe spec notes that s=
etting the
> > >> + * Prefetchable bit of a BAR permits correct operation even if the =
range has
> > >> + * read side effects or cannot tolerate write merging, as long as t=
he entire
> > >> + * path from the host to the device is PCIe: PCIe Memory Reads alwa=
ys carry an
> > >> + * explicit length, and PCIe Switches never prefetch or merge write=
s (PCIe
> > >> + * r7.0, sec 7.5.1.2.1, Implementation Note "Additional Guidance on=
 the
> > >> + * Prefetchable Bit in Memory Space BARs").
> > >> + *
> > >> + * So if all bridges between @bus and the root bus are PCIe Root Po=
rts or PCIe
> > >> + * Switch Ports, handle 64-bit non-prefetchable resources on @bus l=
ike 64-bit
> > >> + * prefetchable ones, so that they can be placed in the prefetchabl=
e window of
> > >> + * the bridge above @bus, which may be above 4GB. Other bridges, su=
ch as
> > >> + * conventional PCI bridges, may prefetch from their prefetchable w=
indow.
> > >> + *
> > >> + * Return: @flags, with IORESOURCE_PREFETCH set if a resource with =
@flags on
> > >> + * @bus may be placed in a prefetchable bridge window.
> > >> + */
> > >> +unsigned long pci_bus_placement_flags(struct pci_bus *bus, unsigned=
 long flags)
> > >> +{
> > >> +=09if ((flags & (IORESOURCE_TYPE_BITS | IORESOURCE_PREFETCH |
> > >> +=09=09      IORESOURCE_MEM_64)) !=3D (IORESOURCE_MEM | IORESOURCE_M=
EM_64))
> > >
> > > PCI_RES_TYPE_MASK
> > >
> >=20
> > OK. Its definition will need to move, though, but I guess that's fine.
>=20
> Yes. If you want to have it in a consistent place with my work, here's=20
> where I put it:
>=20
> https://lore.kernel.org/linux-pci/20261002113319.6652-6-ilpo.jarvinen@lin=
ux.intel.com/
>=20
> > >> +=09=09return flags;
> > >> +
> > >> +=09if (pci_is_root_bus(bus) ||
> > >> +=09    (bus->bus_flags & PCI_BUS_FLAGS_NO_NP_BARS_IN_P_WINDOWS))
> > >> +=09=09return flags;
> > >> +
> > >> +=09return flags | IORESOURCE_PREFETCH;
> > >> +}
> > >> +
> > >>  /**
> > >>   * pci_find_parent_resource - return resource region of parent bus =
of given
> > >>   *=09=09=09      region
> > >> @@ -749,6 +786,7 @@ struct resource *pci_find_parent_resource(const =
struct pci_dev *dev,
> > >>  =09=09=09=09=09  struct resource *res)
> > >>  {
> > >>  =09const struct pci_bus *bus =3D dev->bus;
> > >> +=09unsigned long flags =3D pci_bus_placement_flags(dev->bus, res->f=
lags);
> > >>  =09struct resource *r;
> > >> =20
> > >>  =09pci_bus_for_each_resource(bus, r) {
> > >> @@ -758,10 +796,11 @@ struct resource *pci_find_parent_resource(cons=
t struct pci_dev *dev,
> > >> =20
> > >>  =09=09=09/*
> > >>  =09=09=09 * If the window is prefetchable but the BAR is
> > >> -=09=09=09 * not, the allocator made a mistake.
> > >> +=09=09=09 * not (and may not be treated as such), the
> > >> +=09=09=09 * allocator made a mistake.
> > >>  =09=09=09 */
> > >>  =09=09=09if (r->flags & IORESOURCE_PREFETCH &&
> > >> -=09=09=09    !(res->flags & IORESOURCE_PREFETCH))
> > >> +=09=09=09    !(flags & IORESOURCE_PREFETCH))
> > >>  =09=09=09=09return NULL;
> > >> =20
> > >>  =09=09=09/*
> > >> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > >> index 8297cfb5dcd5..989b9c1f1580 100644
> > >> --- a/drivers/pci/pci.h
> > >> +++ b/drivers/pci/pci.h
> > >> @@ -567,6 +567,7 @@ static inline int pci_resource_num(const struct =
pci_dev *dev,
> > >>  =09return resno;
> > >>  }
> > >> =20
> > >> +unsigned long pci_bus_placement_flags(struct pci_bus *bus, unsigned=
 long flags);
> > >>  int __pci_bus_alloc_resource(struct pci_bus *bus, struct resource *=
res,
> > >>  =09=09=09     unsigned long flags, resource_size_t size,
> > >>  =09=09=09     resource_size_t align, resource_size_t min,
> > >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > >> index 27008e2ea5af..8f00ea3321c0 100644
> > >> --- a/drivers/pci/probe.c
> > >> +++ b/drivers/pci/probe.c
> > >> @@ -990,6 +990,32 @@ static bool pci_preserve_config(struct pci_host=
_bridge *host_bridge)
> > >>  =09return false;
> > >>  }
> > >> =20
> > >> +/*
> > >> + * Return true if all memory windows of @bridge are non-prefetchabl=
e, and at
> > >> + * least one of them extends above 4GB in PCI bus address space (se=
e
> > >> + * pci_bus_placement_flags()).
> > >> + */
> > >> +static bool pci_host_np_only_with_high_window(struct pci_host_bridg=
e *bridge)
> > >> +{
> > >> +=09struct resource_entry *window;
> > >> +=09bool high =3D false;
> > >> +
> > >> +=09resource_list_for_each_entry(window, &bridge->windows) {
> > >> +=09=09struct resource *res =3D window->res;
> > >> +
> > >> +=09=09if (resource_type(res) !=3D IORESOURCE_MEM)
> > >> +=09=09=09continue;
> > >> +
> > >> +=09=09if (res->flags & IORESOURCE_PREFETCH)
> > >> +=09=09=09return false;
> > >> +
> > >> +=09=09if (upper_32_bits(res->end - window->offset))
> > >
> > > Should this use pcibios_resource_to_bus() for consistency with the re=
st of=20
> > > the code?
> > >
> >=20
> > We are walking the window resources of an apriori known root bus here,
> > and pcibios_resource_to_bus() takes a bus, walks up to the root, iterat=
es
> > over all window resources again to find the given resource, and then
> > applies the offset.
> >=20
> > I agree it would be better to respect the layering here, but using
> > pcibios_resource_to_bus() is a bit of a kludge. Could we split it up
> > perhaps?
>=20
> I guess that possible but TBH, it would probably be best to just ignore=
=20
> my comment instead as I failed to take account the complications you came=
=20
> across.
>=20
>=20
> FYI, I'm planning on trying this series with my pci=3Drealloc recalc=20
> changes to see if they together resolve the 64-bit VF BARs not appearing=
=20
> on 64-bit side, hopefully I get that done today.

It seems to generally work better in pci=3Drealloc case but there are still=
=20
some disabled Expansion ROMs that do lose their upstream bridge windows=20
(win gets disabled) and some cases with mixed pref & non-pref VF BARs=20
where the latter do not appear.

norealloc case looks messy but I account that to changes made in my series=
=20
as it alters auto switch to pci=3Drealloc to happen less frequently, which=
=20
can of course cause more assignment failures but it also tries to retain=20
the original setup from FW better.

I don't know at this point if the problem is in my series or yours, I will=
=20
have to look deeper but that won't be until next week.


--=20
 i.

--8323328-993494446-1790949978=:1156--
