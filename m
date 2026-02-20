Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C33D76;
	Fri, 20 Feb 2026 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771587171; cv=none; b=o2B8Cyj7ACH+SWFsq5J9NnMRZEBBGkhok+McOLEu8EojEQWJoVoKIZGm+MKa/uW3mLUKo/D/rCp0SIZwBrMgx4UokVoei1H+S21kKTu2uuRRQlL2lwHMDv/FclYpe18lHaX1Us2XtV3rj5kBZAT0iaurDEeuRLEBglsW8/0zviA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771587171; c=relaxed/simple;
	bh=6csxZNF4nKiMPjJkg065VfThiD4jVuF0L+SYHlRlA2s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h4BtyhyxYDLIIfjhQZlEMHeEuVLtJVhg8ahG5V76Qznnnw3v9bHlXqKFC82E9h66qIwCY4BQFCLRgLzm69lv9yMZt3UO2I3yq4TjZZBzp31PwDlEraMBiRuyUhmircWkYZ8Se2NJ+HNr24kU4sjoTg+Vi7ofjb96ysYpGHHiSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsiHa0Qx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsiHa0Qx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771587170; x=1803123170;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6csxZNF4nKiMPjJkg065VfThiD4jVuF0L+SYHlRlA2s=;
  b=WsiHa0QxI3fEN2apZXsArdLrSJCfU3V+w3JartlpsKvdc4OXnKxgumMF
   Ux1F2i0OkhqJXwG87ZM6XHYupU8VceNM67SbGp/fdxLD+DVJ7HLerd+T5
   Ew7CxR2uxYtZMOJwQkHNL/7AHDZt+1mwadg1sFVFKvwuYEytYhMw2rMhD
   jlLQHdDSOsbpZSsFEmI0ZP5LMwGqofrewIJ1FAOVTKEYPBmj5B44piklY
   38uRxMWTiKf7EJ/pKPr0XkurOEt/wT9bVfopMUGg6b1E3LYPYlfeddx62
   g2G0LZ3SlmwrnLAINR4mYmUjm3lWgX5qQcQ4FtZQUEKeTSPLRhjM6QebS
   Q==;
X-CSE-ConnectionGUID: xNhcOqKyR/KLe/Gn8fmc+A==
X-CSE-MsgGUID: EnZpAlXfSCqlkg9ardQHbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72854882"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72854882"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 03:32:49 -0800
X-CSE-ConnectionGUID: T1OZcxG3Qi2FJZTF48/YsA==
X-CSE-MsgGUID: mdo2IH31RhyIj+aIOhHgEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="218963381"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 03:32:47 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Feb 2026 13:32:43 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Steve Oswald <stevepeter.oswald@gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: Prevent shrinking bridge window from its
 required size
In-Reply-To: <20260219231645.GA3503276@bhelgaas>
Message-ID: <0a425bb6-f08b-0aee-c494-843e42150a2f@linux.intel.com>
References: <20260219231645.GA3503276@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1033658142-1771587163=:974"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1033658142-1771587163=:974
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 19 Feb 2026, Bjorn Helgaas wrote:

> On Thu, Feb 19, 2026 at 05:39:51PM +0200, Ilpo J=C3=A4rvinen wrote:
> > pci_bridge_distribute_available_resources() -> ... ->
> > adjust_bridge_window() is called in between __pci_bus_size_bridges()
> > and assigning the resources. Since the commit 948675736a77 ("PCI: Allow
> > adjust_bridge_window() to shrink resource if necessary")
> > adjust_bridge_window() can also shrink the bridge window to force it to
> > a smaller size. The shrunken size, however, conflicts what
> > __pci_bus_size_bridges() -> pbus_size_mem() calculated as the required
> > bridge window size. By shrinking the resource size,
> > adjust_bridge_window() prevents rest of the resource fitting algorithm
> > working as intended. Resource fitting logic is expecting assignment
> > failures when bridge windows need resizing, but there are cases where
> > failures are no longer happening after the commit 948675736a77 ("PCI:
> > Allow adjust_bridge_window() to shrink resource if necessary").
> >=20
> > The commit 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink
> > resource if necessary") justifies the change by the extra reservation
> > made due to hpmemsize parameter, however, the kernel code contradicts
> > with that statement. (For simplicity, finer-grained hpmmiosize and
> > hpmmiopref parameters that can be used to the same effect as hpmemsize
> > are ignored in this description.)
> >=20
> > pbus_size_mem() calls calculate_memsize() twice. First with add_size=3D=
0
> > to find out the minimal required resource size. The second call occurs
> > with add_size=3Dhpmemsize (effectively) but the result does not directl=
y
> > affect the resource size only resulting in an entry on the realloc_head
> > list (a.k.a. add_list). Yet, adjust_bridge_window() directly changes
> > the resource size which does not include what is reserved due to
> > hpmemsize. Also, if the required size for the bridge window exceeds
> > hpmemsize, the parameter does not have any effect even on the second
> > size calculcation made by pbus_size_mem(); from calculate_memsize():
> >=20
> >   size =3D max(size, add_size) + children_add_size;
> >=20
> > The commit ae4611f1d7e9 ("PCI: Set resource size directly in
> > adjust_bridge_window()") that precedes the commit 948675736a77 ("PCI:
> > Allow adjust_bridge_window() to shrink resource if necessary") is also
> > related to causing this problem. Its changelog explicitly states
> > adjust_bridge_window() wants to "guarantee" allocation success.
> > Guaranteed allocations, however, are incompatible with how the other
> > parts of the resource fitting algorithm work. The given justification
> > fails to explain why guaranteed allocations at this stage are required
> > nor why forcing window to a smaller value than what was calculated by
> > pbus_size_mem() is correct. While the change might have worked by chanc=
e
> > in some test scenario, too small bridge window does not "guarantee"
> > success from the point of view of the endpoint device resource
> > assignments. No issue is mentioned within the changelog so it's unclear
> > if the change was made to fix some observed issue nor and what that
> > issue was.
> >=20
> > The unwanted shrinking of a bridge window occurs, e.g., when a device
> > with large BARs such as eGPU is attached using Thunderbolt and the Root
> > Port holds less than enough resource space for the eGPU. The GPU
> > resources are in order of GBs and the default hotplug allocation is
> > mere 2M (DEFAULT_HOTPLUG_MMIO_PREF_SIZE). The problem is illustrated by
> > this log (filtered to the relevant content only):
> >=20
> > pci 0000:00:07.0: PCI bridge to [bus 03-2c]
> > pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit =
pref]
> > pci 0000:03:00.0: PCI bridge to [bus 00]
> > pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref=
]
> > pci 0000:03:00.0: bridge configuration invalid ([bus 00-00]), reconfigu=
ring
> > pci 0000:03:00.0: PCI bridge to [bus 04-2c]
> > pcieport 0000:00:07.0: Assigned bridge window [mem 0x6000000000-0x601bf=
fffff 64bit pref] to [bus 03-2c] cannot fit 0xc00000000 required for 0000:0=
3:00.0 bridging to [bus 04-2c]
> > pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pre=
f] to [bus 04-2c] add_size 100000 add_align 100000
> > pcieport 0000:00:07.0: distributing available resources
> > pci 0000:03:00.0: bridge window [mem 0x800000000-0x10003fffff 64bit pre=
f] shrunken by 0x00000007e4400000
> > pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601bffffff 64bit pr=
ef]: assigned
> >=20
> > The initial size of the Root Port's window is 448MB (0x601bffffff -
> > 0x6000000000). __pci_bus_size_bridges() -> pbus_size_mem() calculates
> > the required size to be 32772 MB (0x10003fffff - 0x800000000) which
> > would fit the eGPU resources. adjust_bridge_window() then shrinks the
> > bridge window down to what is guaranteed to fit into the Root Port's
> > bridge window. The bridge window for 03:00.0 is also eliminated from
> > the add_list (a.k.a. realloc_head) list by adjust_bridge_window().
> >=20
> > After adjustment, the resources are assigned and as the bridge window
> > for 03:00.0 is assigned successfully, no failure is recorded. Without a
> > failure, no attempt to resize the window of the Root Port is required.
> > The end result is eGPU not having large enough resources to work.
> >=20
> > The commit 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink
> > resource if necessary") also claims nested bridge windows are sized the
> > same, which is false. pbus_size_mem() calculates the size for the
> > parent bridge window by summing all the downstream resources so the
> > resource fitting calculates larger bridge window for the parent to
> > accomodate the childen. That is, hpmemsize does not result the same
> > size for the case where there are nested bridge windows.
> >=20
> > In order to fix the most immediate problem, don't shrink the resource
> > size in adjust_bridge_window() as hpmemsize had nothing to do with it.
> > When considering add_size, only reduce it up to what is added due to
> > hpmemsize (if required size is larger than hpmemsize, the parameter has
> > no impact, see calculate_memsize()). Unfortunately, if the tail of the
> > bridge window was aligned in calculate_memsize() from below hpmemsize
> > to above it, the size check will falsely match but the check at least
> > errs to the side of caution. There's not enough information available
> > in adjust_bridge_window() to know the calculated size precisely.
> >=20
> > This is not exactly a revert of the commits e4611f1d7e9 ("PCI: Set
> > resource size directly in adjust_bridge_window()") and 948675736a77
> > ("PCI: Allow adjust_bridge_window() to shrink resource if necessary")
> > as shrinking still remains in place but is implemented differently,
> > and the end result behaves very differently.
> >=20
> > It is possible that those two commits fixed some other issue that is
> > not described with enough detail in the changelog and undoing parts of
> > them results in another regression due to behavioral change.
> > Nonetheless, as described above, the solution by those two commits was
> > flawed and the issue, if one exists, should be solved in a way that is
> > compatible with the rest of the resource fitting algorithm instead of
> > working against it.
> >=20
> > Besides shrinking, the case where adjust_bridge_window() expands the
> > bridge window is likely somewhat wrong as well because it removes the
> > entry from add_list (a.k.a. realloc_head), but it is less damaging as
> > that only impacts optional resources and may have no impact if
> > expanding by hpmemsize is larger than what add_size was. Fixing it is
> > left as further work.
> >=20
> > Fixes: 948675736a77 ("PCI: Allow adjust_bridge_window() to shrink resou=
rce if necessary")
> > Fixes: ae4611f1d7e9 ("PCI: Set resource size directly in adjust_bridge_=
window()")
>=20
> These both date back to v5.10 (Dec 2020), but Steve's report below is
> only from Aug 2025, so I'm sort of assuming this is v7.1 material?

It's an old problem yes and impacts limited set of configurations
(a device with big BARs attached to TB).

v7.1 is okay for me, this could cause some not immediately obvious problem=
=20
in some other case so it gives more time for us to hear about them=20
(hopefully).

> If we want it for v7.0, I'm going to need a CliffsNotes summary of the
> commit log to justify it :)

Even if it's not going to be needed in this cases, what's "CliffsNotes=20
summary" ??

--=20
 i.

> > Reported-by: Steve Oswald <stevepeter.oswald@gmail.com>
> > Closes: https://lore.kernel.org/linux-pci/CAN95MYEaO8QYYL=3D5cN19nv_qDG=
uuP5QOD17pD_ed6a7UqFVZ-g@mail.gmail.com/
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >=20
> > v2:
> > - Rebased
> > - Adjust to pci_dev_res_remove_from_list() rename
> >=20
> >=20
> > Hi Bjorn,
> >=20
> > v1 of this seems to have fallen through cracks. I might have accidently
> > marked it "superceded" myself in Patchwork when I moved most of my fix
> > patches into the large series to avoid conflicts but not this one.
> >=20
> >  drivers/pci/setup-bus.c | 42 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 40 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 32aa72456a44..1b94ed55aa7a 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1827,6 +1827,7 @@ static void adjust_bridge_window(struct pci_dev *=
bridge, struct resource *res,
> >  =09=09=09=09 resource_size_t new_size)
> >  {
> >  =09resource_size_t add_size, size =3D resource_size(res);
> > +=09struct pci_dev_resource *dev_res;
> > =20
> >  =09if (resource_assigned(res))
> >  =09=09return;
> > @@ -1839,9 +1840,46 @@ static void adjust_bridge_window(struct pci_dev =
*bridge, struct resource *res,
> >  =09=09pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> >  =09=09=09&add_size);
> >  =09} else if (new_size < size) {
> > +=09=09int idx =3D pci_resource_num(bridge, res);
> > +
> > +=09=09/*
> > +=09=09 * hpio/mmio/mmioprefsize hasn't been included at all? See the
> > +=09=09 * add_size param at the callsites of calculate_memsize().
> > +=09=09 */
> > +=09=09if (!add_list)
> > +=09=09=09return;
> > +
> > +=09=09/* Only shrink if the hotplug extra relates to window size. */
> > +=09=09switch (idx) {
> > +=09=09=09case PCI_BRIDGE_IO_WINDOW:
> > +=09=09=09=09if (size > pci_hotplug_io_size)
> > +=09=09=09=09=09return;
> > +=09=09=09=09break;
> > +=09=09=09case PCI_BRIDGE_MEM_WINDOW:
> > +=09=09=09=09if (size > pci_hotplug_mmio_size)
> > +=09=09=09=09=09return;
> > +=09=09=09=09break;
> > +=09=09=09case PCI_BRIDGE_PREF_MEM_WINDOW:
> > +=09=09=09=09if (size > pci_hotplug_mmio_pref_size)
> > +=09=09=09=09=09return;
> > +=09=09=09=09break;
> > +=09=09=09default:
> > +=09=09=09=09break;
> > +=09=09}
> > +
> > +=09=09dev_res =3D res_to_dev_res(add_list, res);
> >  =09=09add_size =3D size - new_size;
> > -=09=09pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
> > -=09=09=09&add_size);
> > +=09=09if (add_size < dev_res->add_size) {
> > +=09=09=09dev_res->add_size -=3D add_size;
> > +=09=09=09pci_dbg(bridge, "bridge window %pR optional size shrunken by =
%pa\n",
> > +=09=09=09=09res, &add_size);
> > +=09=09} else {
> > +=09=09=09pci_dbg(bridge, "bridge window %pR optional size removed\n",
> > +=09=09=09=09res);
> > +=09=09=09pci_dev_res_remove_from_list(add_list, res);
> > +=09=09}
> > +=09=09return;
> > +
> >  =09} else {
> >  =09=09return;
> >  =09}
> >=20
> > base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
> > --=20
> > 2.39.5
> >=20
>=20
--8323328-1033658142-1771587163=:974--
