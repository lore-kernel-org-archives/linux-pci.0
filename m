Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85E92EEE8A;
	Mon, 28 Sep 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598024; cv=none; b=N0lcq7EKmFg0AokrBytpPRoq0hOa5e6w2nYzZIx6P+Erx7jaPtXASdxl2V7eadZvIAmBSOUQiVCNMdHoPl7f4HX0E23bx3WkTxIVg8TilJoa1m7ZqBYbiUSrYQvB9PcN5ZHSgCwbmqdFjQZpIQ+F4lkPo/jopa69ylpXM0emwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598024; c=relaxed/simple;
	bh=IqVJtSxvndDoIrS4uMSlsy6uU4K9s1TyAHP1lklzmws=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TIAodcxTF8soDi8D9/a8Cxmt+yhA4M1gJgVgbHxIf6GevPOzCh+MuqlcwTXf8myauMiv068RVAsQtSECtSWEPMpwxHvvRH1QfPWfy4sqjkFSOIsUzIAGJOcZCf6DOWfX9fOn7DNDF0m9MXT9eMRW1KCdNq816XT2c6fxMXe02e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOrMg2n9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOrMg2n9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790598022; x=1822134022;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=IqVJtSxvndDoIrS4uMSlsy6uU4K9s1TyAHP1lklzmws=;
  b=WOrMg2n9tTNMnXwjWAsG7iw3c6FziQeZK9mCjVdShBFsqQKJi8Rkk6PO
   KHWji6l+N3+gFr0tzmXbMA7gdFe0ToRfiQ7MA3Ls1rAUX0lcpjgclfb+R
   2uB/0YbaRMUXWfGIVSisYn3PlmzQuW0SpuX2NLLmaC2QYH0WzKz4tGekp
   sNX5mdDOf4yBZ8esDJsDN95Rr7RHB28FYQx813VSF6lKaZdpkAKL5kyYE
   PDv+PTE8fEp5COXj0T5AaU3XX+iolblCITTo+jeUxulgBRhIsCnPupclY
   mp6uAAbKeKAH/gUuEq/8mmV7nIDAhgXESCqqjXsj6X5TRM7WiTyRN7cxM
   Q==;
X-CSE-ConnectionGUID: z6ZzJMmkR8qqGFfr0DL42A==
X-CSE-MsgGUID: 9GiUf5N6R3GSMcOuMQuqgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="102666360"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="102666360"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:20:21 -0700
X-CSE-ConnectionGUID: dHwe5PAaQiqslwYr6ibPYg==
X-CSE-MsgGUID: tTqibLsQQhmOeMZLuqZojA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278854551"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.109])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:20:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 28 Sep 2026 15:20:13 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>
cc: Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Nikolas Joshua Britton <nbritton@exabit.io>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] PCI/quirks: Avoid certain BAR 0 address with igb
In-Reply-To: <20260924202056.GA2001522@bhelgaas>
Message-ID: <447e3daa-c8a5-2b0c-2c6d-3f3eb92e94cc@linux.intel.com>
References: <20260924202056.GA2001522@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1456378754-1790282591=:1187"
Content-ID: <2c59d2a7-2d05-5890-49d7-cdf39f721eac@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1456378754-1790282591=:1187
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <9f8bebdd-4519-7111-ee8d-93c4893f67b5@linux.intel.com>

On Thu, 24 Sep 2026, Bjorn Helgaas wrote:

> [+cc Rafael, ACPI resource question]
>=20
> On Wed, Sep 23, 2026 at 04:17:55PM +0300, Ilpo J=E4rvinen wrote:
> > While testing the resource placement changes, my tests hit a case where
> > igb fails to probe when BAR 0 is placed at 0x9c000000:
> >=20
> >    90000000-9cffffff : PCI Bus 0000:a0
> >   -  90000000-902fffff : PCI Bus 0000:a1
> >   -    90000000-900fffff : 0000:a1:00.0
> >   -      90000000-900fffff : igb
> >   -    90100000-901fffff : 0000:a1:00.0
> >   -    90200000-90203fff : 0000:a1:00.0
> >   -      90200000-90203fff : igb
> >   +  9be00000-9c0fffff : PCI Bus 0000:a1
> >   +    9be00000-9befffff : 0000:a1:00.0
> >   +    9bf00000-9bf03fff : 0000:a1:00.0
> >   +    9c000000-9c0fffff : 0000:a1:00.0
> >      9c100000-9c17ffff : amd_iommu
> >      9c180000-9c1803ff : IOAPIC 8
> >=20
> >   -       Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=
=3D1M]
> >   -       Region 3: Memory at 90200000 (32-bit, non-prefetchable) [size=
=3D16K]
> >   -       Expansion ROM at 90100000 [disabled] [size=3D1M]
> >   +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable) [size=
=3D1M]
> >   +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable) [size=
=3D16K]
> >   +       Expansion ROM at 9be00000 [disabled] [size=3D1M]
> >=20
> > igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> > ------------[ cut here ]------------
> > igb: Failed to read reg 0x18!
> > WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at igb_rd32.cold=
+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> > ...
> >  igb_get_invariants_82575+0xff/0xf00 [igb]
> >  igb_probe+0x3c8/0x1190 [igb]
> >  local_pci_probe+0x3b/0x80
> >=20
> > Apparently, the igb driver bails out, after its initial sanity check
> > detects an unexpected ~0 read. Hacking around the sanity check just
> > results in more failures down the road so the sanity check itself is no=
t
> > the cause for the failure.
> >=20
> > The resource placement looks valid so the actual placement patches seem
> > to work normally.
> >=20
> > All other possible 1M address I could test (with a hack patch) did work=
=2E
>=20
> Super weird.  Is it possible there's some other device there?  It's
> conceivable ACPI might have a _CRS method describing it.  I think
> there are ACPI devices for which we don't reserve space mentioned in
> _CRS.  Maybe Rafael knows a debug option to log everything in _CRS?

Now that you mentioned it, there certainly something going on with=20
that address:

[    0.000000] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff]  devi=
ce reserved
[    0.000000] BIOS-e820: [gap 0x0000000090000000-0x000000009bffffff]
[    0.000000] BIOS-e820: [mem 0x000000009c000000-0x000000009cffffff]  devi=
ce reserved
[    0.000000] BIOS-e820: [gap 0x000000009d000000-0x00000000a8ffffff]
[    0.000000] BIOS-e820: [mem 0x00000000a9000000-0x00000000a9ffffff]  devi=
ce reserved
=2E..
[    0.000000] efi: Remove mem48: MMIO range=3D[0x80000000-0x8fffffff] (256=
MB) from e820 map
[    0.000000] e820: remove [mem 0x80000000-0x8fffffff] device reserved
[    0.000000] efi: Remove mem49: MMIO range=3D[0x9c000000-0x9cffffff] (16M=
B) from e820 map
[    0.000000] e820: remove [mem 0x9c000000-0x9cffffff] device reserved
[    0.000000] efi: Remove mem50: MMIO range=3D[0xa9000000-0xa9ffffff] (16M=
B) from e820 map
[    0.000000] e820: remove [mem 0xa9000000-0xa9ffffff] device reserved

But given the comment above efi_remove_e820_mmio() it sounds like this is=
=20
a red herring.

In any case, the address is inside the provided root bus resource:

[    4.854840] ACPI: PCI Root Bridge [PC05] (domain 0000 [bus a0-bf])
=2E..
[    4.854848] PCI host bridge to bus 0000:a0
[    4.854848] pci_bus 0000:a0: root bus resource [io  0x6000-0x6fff window=
]
[    4.854848] pci_bus 0000:a0: root bus resource [mem 0x90000000-0x9cfffff=
f window]
[    4.854848] pci_bus 0000:a0: root bus resource [mem 0x71d60000000-0x7fcf=
fffffff window]
[    4.854848] pci_bus 0000:a0: root bus resource [bus a0-bf]

> Does igb seem sensitive about this exact address on a variety of
> machines?  If so I would expect some kind of igb hardware erratum for
> it.

I've not heard anything to that effect.

But existance of the sanity check itself in the igb driver looks almost=20
like a smoking gun so I don't know what to think of it.

I'm also inclined to think that the placement approaches out there so far=
=20
might not have covered that many addresses but used the left edge of the=20
window. So this series, when it often moves resources to right edge of the=
=20
window, goes to what might not be on well-charted territory.

> Do other non-igb devices work at that address?

Unfortunately there are not other devices underneath the RP so I might not=
=20
be able to test this.

> > Add quirk to reshuffle igb resources, use BAR 3 to block the problemati=
c
> > address.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >=20
> > I know this is ugly and I don't like it either but do not know better
> > way to avoid the regression.
> >=20
> > I've tried with iommu=3Doff and that did not resolve the issue.
> >=20
> > I also managed to prove igb works with the same resource layout in
> > another system. So identifying the case should probably be tightened
> > by matching with more devices than the one used by igb. This is open
> > to discussion.
>=20
> I guess this answers one of my questions above.

Yeah.

But then there's the sanity check in igb which hints otherwise.

> > ---
> >  drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index de9bbccda21f..e6f3e2ab1fd4 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6288,6 +6288,62 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1=
536, rom_bar_overlap_defect);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_d=
efect);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_d=
efect);
> > =20
> > +/*
> > + * The igb driver probe (due to reads returning ~0 unexpected) when BA=
R 0
> > + * appears at 0x9c000000. The cause is unknown.
>=20
> I suppose this is missing "fails"?  "igb driver probe fails"?

Obviously, thanks.

--=20
 i.
=20
> > + * Use BAR 3 to block 0x9c000000 address.
> > + */
> > +static void bar0_address_breakage(struct pci_dev *dev)
> > +{
> > +=09struct resource *bar0 =3D pci_resource_n(dev, 0);
> > +=09struct resource *bar3 =3D pci_resource_n(dev, 3);
> > +=09resource_size_t broken_addr =3D 0x9c000000;
> > +=09struct resource *res;
> > +=09int i, ret;
> > +
> > +=09if (bar0->start !=3D broken_addr)
> > +=09=09return;
> > +
> > +=09/*
> > +=09 * HW BAR sizes seems to vary. Exclude non-1M BAR 0 case and
> > +=09 * sanity check BAR 0 & 3 before attempting this quirk.
> > +=09 */
> > +=09if (resource_type(bar0) !=3D IORESOURCE_MEM ||
> > +=09    resource_size(bar0) !=3D SZ_1M ||
> > +=09    resource_type(bar3) !=3D IORESOURCE_MEM)
> > +=09=09return;
> > +
> > +=09pci_info(dev, "%pR: relocating BAR\n", bar0);
> > +
> > +=09pci_dev_for_each_resource(dev, res, i) {
> > +=09=09if (!resource_assigned(res) ||
> > +=09=09    resource_type(res) !=3D IORESOURCE_MEM)
> > +=09=09=09continue;
> > +
> > +=09=09pci_release_resource(dev, i);
> > +=09}
> > +
> > +=09resource_set_range(bar3, broken_addr, resource_size(bar3));
> > +=09bar3->flags &=3D ~IORESOURCE_UNSET;
> > +=09pci_claim_resource(dev, 3);
> > +=09if (!resource_assigned(bar3)) {
> > +=09=09bar3->flags |=3D IORESOURCE_UNSET;
> > +=09=09pci_warn(dev, "resource relocation failed\n");
> > +=09}
> > +
> > +=09pci_dev_for_each_resource(dev, res, i) {
> > +=09=09if (resource_assigned(res) ||
> > +=09=09    resource_type(res) !=3D IORESOURCE_MEM)
> > +=09=09=09continue;
> > +
> > +=09=09ret =3D pci_assign_resource(dev, i);
> > +=09=09if (ret)
> > +=09=09=09pci_warn(dev, "resource relocation failed\n");
> > +=09}
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1533, bar0_address_brea=
kage);
> > +
> >  #ifdef CONFIG_PCIEASPM
> >  /*
> >   * Several Intel DG2 graphics devices advertise that they can only tol=
erate
> > --=20
> > 2.47.3
> >=20
>=20
--8323328-1456378754-1790282591=:1187--
