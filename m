Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFF2561A7;
	Tue,  6 Oct 2026 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288180; cv=none; b=hzQRDwM7TFj4vleUCPY9YgCTg+ALawcyTW9pcdsK9pGh55OQKYg9vqzPLiWLg6KZVO6oy+VBiMUr0DGJst+tuvh2Jn/GQNpHfSnxyBFTzzeky0gJJMGwSqCBUXxMQNQPrpf35yIiISdI+LgVjCT28pqftHcef+Vt0cfJAWVYtxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288180; c=relaxed/simple;
	bh=eUaOasu6t9ib5+QWj44pJK0cMFgKzJ/1G2hNboXBodU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ok0yMFOGvPcjDcx+dYYjBJNrOyK8CykgsAgw+UD2Hz9cUrMobn5RMnkPQxe8DRq0gHHBYW+uDAK1PmT2PsYKGn4Tqik4j7m4W4fxcPo2jwL9w9h9dZSVl3jgW+qzvS41E6eB3cykrfHJvS7acktoN0SAyxh3cauFaHQFTY+TXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdMawOxP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdMawOxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791288177; x=1822824177;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eUaOasu6t9ib5+QWj44pJK0cMFgKzJ/1G2hNboXBodU=;
  b=mdMawOxPFVQeY92mtqYRWxfUf+5eg6+eYP5G3OD+hucAVfkxLQw7xUir
   aNZKu8boTXNS3wxM7rbVNQAbad9lUHC24EAVtVA0o6bN0h1cCeOavO/4+
   bXQBDjmzz2l3Mu2vruZ59UBBvDN7SE35YSzZSe50uDAhWKop2YAx0qLow
   /OQHPRWGfHz8revYjNL7NOHQ0sQFoVE44AO6fJHW20K798jzUuCC5fPzM
   /PiUW0Q8Pq8gvQMcJuUfcYs3VowuY8uK7Qv9vXEROMSpDcJSkzdDR3GT9
   nziKVP3KZGwy0xbtnoPvV2RbwA+PnFx7CUZEbzFxgR4Cj61YCXrGqAdtl
   g==;
X-CSE-ConnectionGUID: +VYnDU8vSoKnVMDNkwZd3Q==
X-CSE-MsgGUID: lRjH8zZiR6+Z3Vtk4yJFdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102551689"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="102551689"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 05:02:56 -0700
X-CSE-ConnectionGUID: no+8FWOtS6Gm525seaFiMw==
X-CSE-MsgGUID: 9hw1/uMQT/uJWHZwJhXzow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="276663535"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 05:02:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Oct 2026 15:02:48 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Nikolas Joshua Britton <nbritton@exabit.io>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, Bradley Morgan <brads@mainlining.org>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 7/7] PCI/quirks: Avoid certain address on Genoa
 systems
In-Reply-To: <20261005184738.GA585498@bhelgaas>
Message-ID: <15b6bfd8-922a-719a-e09b-8c972386bdca@linux.intel.com>
References: <20261005184738.GA585498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1074721721-1791288168=:3116"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1074721721-1791288168=:3116
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 5 Oct 2026, Bjorn Helgaas wrote:

> [+cc Boris]
>=20
> On Fri, Oct 02, 2026 at 02:33:15PM +0300, Ilpo J=C3=A4rvinen wrote:
> > While testing the resource placement changes, tests hit a case where
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
> > It turns out there is a 64kB iomem black hole at 9c000000 that returns
> > ~0 and this is where igb's BAR 0 resides. If another BAR of the same
> > card is placed into that address, it is similarly black holed.
> >=20
> > Mark the problematic 64kB range reserved using a quirk bound to the
> > bridge found in the problematic system.
>=20
> I think this is my fault, or at least it looks like it's related to
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").
>=20
> This platform describes the [0x9c000000-0x9cffffff] range as
> E820_TYPE_RESERVED in the E820 table and as EFI_MEMORY_MAPPED_IO in
> the EFI memory map (from the dmesg at
> https://bugzilla.kernel.org/show_bug.cgi?id=3D222074):
>=20
>   BIOS-e820: [gap 0x0000000090000000-0x000000009bffffff]
>   BIOS-e820: [mem 0x000000009c000000-0x000000009cffffff]  device reserved
>   efi: Remove mem49: MMIO range=3D[0x9c000000-0x9cffffff] (16MB) from e82=
0 map
>   e820: remove [mem 0x9c000000-0x9cffffff] device reserved
>   pci_bus 0000:a0: root bus resource [mem 0x90000000-0x9cffffff window]
>=20
> /proc/iomem:
>=20
>   90000000-9cffffff : PCI Bus 0000:a0
>     9c100000-9c17ffff : amd_iommu
>     9c180000-9c1803ff : IOAPIC 8
>=20
> I haven't worked out all the details, but I bet that if 07eab0901ede
> had not removed [0x9c000000-0x9cffffff] from the E820 table, it would
> show up in /proc/iomem as "Reserved" and would not be available for
> use by a BAR.  amd_iommu and IOAPIC 8 occupy some of that space, and I
> suspect there are other devices in there that we don't know about.
>=20
> It looks like the last 16MB of every 32-bit PCI host bridge window is
> EFI_MEMORY_MAPPED_IO, so if you can move the igb device to a different
> host bridge, I suspect the same problem would happen if you put the
> BAR at 16MB below the end.

Perhaps things could break but even in this range I've found addresses=20
above 9c000000 that do work. And the problem at 9c000000 is a black hole=20
(returning ~0), not something that seems a meaningful device.


With 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")=20
reverted, I get this:

90000000-9cffffff : PCI Bus 0000:a0
  9bd00000-9bffffff : PCI Bus 0000:a1
    9bd00000-9bdfffff : 0000:a1:00.0
      9bd00000-9bdfffff : igb
    9befc000-9befffff : 0000:a1:00.0
      9befc000-9befffff : igb
    9bf00000-9bffffff : 0000:a1:00.0
  9c000000-9cffffff : Reserved
    9c100000-9c17ffff : amd_iommu
    9c180000-9c1803ff : IOAPIC 8

--=20
 i.

> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222074
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >=20
> > Mario suggested the quirk to be based on the bridge instead of the=20
> > endpoint device which certainly looks better and cleaner than the
> > approach used in v1.
> >=20
> > The current plan is to try a different card in the same slot but it is
> > a bit hard for me to predictable on what timescale that can be done.
> >=20
> > ---
> >  drivers/pci/quirks.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index de9bbccda21f..5483b47d8d54 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6288,6 +6288,41 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1=
536, rom_bar_overlap_defect);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_d=
efect);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_d=
efect);
> > =20
> > +/*
> > + * TODO: Remove when/if root cause is found.
> > + *
> > + * Genoa appears to have a 64kB iomem black hole starting at 0x9c00000=
0
> > + * address for which all reads return ~0 blocking an overlapping BAR f=
rom
> > + * working.
> > + *
> > + * Work around the problem by reserving the space prior to making any =
iomem
> > + * allocations that could overlap with the black hole.
> > + */
> > +static struct resource black_hole_res =3D DEFINE_RES_MEM_NAMED(0x9c000=
000, SZ_64K,
> > +=09=09=09=09=09=09=09     "reserved");
> > +
> > +static void genoa_iomem_black_hole(struct pci_dev *dev)
> > +{
> > +=09struct resource *r;
> > +
> > +=09pci_bus_for_each_resource(dev->bus, r) {
> > +=09=09if (!r || !r->flags || !resource_assigned(r))
> > +=09=09=09continue;
> > +
> > +=09=09if (!__resource_contains_unbound(r, &black_hole_res))
> > +=09=09=09continue;
> > +
> > +=09=09if (resource_assigned(&black_hole_res))
> > +=09=09=09pci_dbg(dev, "iomem black hole workaround already applied\n")=
;
> > +=09=09else if (!insert_resource(r, &black_hole_res))
> > +=09=09=09pci_info(dev, "iomem black hole workaround enabled\n");
> > +=09=09else
> > +=09=09=09pci_dbg(dev, "iomem black hole workaround add failed\n");
> > +=09=09return;
> > +=09}
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab, genoa_iomem_black_=
hole);
> > +
> >  #ifdef CONFIG_PCIEASPM
> >  /*
> >   * Several Intel DG2 graphics devices advertise that they can only tol=
erate
> > --=20
> > 2.47.3
> >=20
>=20

--=20
 i.

--8323328-1074721721-1791288168=:3116--
