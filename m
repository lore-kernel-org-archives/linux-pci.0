Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F12D94B5;
	Tue, 13 Oct 2026 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912417; cv=none; b=sbH/1rpMSFpmwIsHQ3L+o4LljyTcF3cbUHbn2GKhNae5C/LMkiQtEOMbUo6R7obcy8A0DeTr39rdpBe2bEGcRrC+bWgunI/L23eUfmnIDm6qjRZilmgQgBdT8JQBNaE/FaPNtlOIkZyitX2KC4qEC3ZXocS5v7Y1KMcvcKMOCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912417; c=relaxed/simple;
	bh=bzOfiZ575E4TvgMwJfErqW3q9RXm8And3Sk6/Gr0Zd8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YF0Io9G1G/wx2xHh3jgei/xawsb/Jm4lZAHxOXtlJFBT+8aAhpNrIYpYAcA61VOy+8F6TIZY6We4qGKQ3CWWHCc9xsLwbXtZErrzXzHqZhfjRcgSdgohAv2mkbdn1vWThkLKLpEWvzfCArJoOYp1XQL//06me0LuULCQ6Y1pLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2BOZcsC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2BOZcsC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791912416; x=1823448416;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=bzOfiZ575E4TvgMwJfErqW3q9RXm8And3Sk6/Gr0Zd8=;
  b=a2BOZcsCpdFzxQtQktUXn+JRztk/spOP6DzbmtKeQFvm3gfS6UGpoPIO
   u6/l3Bqpq3Uqf0S/GkCTKFlLVtBvN8M8oYjS456mNGycUvxSeZl9xo8gS
   jhxM+6UwBqZIptq+10XmO+pJVBOMfaXyEqg2Tg1V/oEwjDEgKg6QgM7rc
   Ey+lcNlQkxNseTu7v4tBuNK5qnfcV9bY9XSY5M4oCgxkuR/CqwIr2yiXl
   l179f33NOaPQDQ81PkmagzwGwH2p/NIL4/Vz9ZherJbYn0J7Qa+RWodN1
   LmIfIQF16hwABQfTATA34GjEqGz7x+zOINg3kGXxQZJa0kWS+M6+T5oin
   g==;
X-CSE-ConnectionGUID: bXG4N1+FR72GL1q+uaWgCQ==
X-CSE-MsgGUID: 3UMSGxUOR2KAtZrsE7Uq2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="533640"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="533640"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 10:26:55 -0700
X-CSE-ConnectionGUID: K86+1HiET+6zIsBuUT++WQ==
X-CSE-MsgGUID: 930I2P0bQSiVu1vgGGqfCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1137991"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 10:26:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 13 Oct 2026 20:26:44 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Nikolas Joshua Britton <nbritton@exabit.io>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    LKML <linux-kernel@vger.kernel.org>, Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa
 systems
In-Reply-To: <ed19c161-9703-4967-997a-b9054e92a216@amd.com>
Message-ID: <01b571a9-06ae-076e-95f4-0851a90d0c44@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com> <20261013130948.6231-9-ilpo.jarvinen@linux.intel.com> <e3895e35-a0a2-4c32-8ebb-f726a8c8caae@amd.com> <ed19c161-9703-4967-997a-b9054e92a216@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1816090372-1791911231=:21507"
Content-ID: <e338d973-52cf-3b53-8e18-7749926388a0@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1816090372-1791911231=:21507
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <134bf6f9-3b9c-c361-0006-b02b13d129f7@linux.intel.com>

On Tue, 13 Oct 2026, Mario Limonciello wrote:
> On 10/13/26 12:00, Mario Limonciello wrote:
> > On 10/13/26 08:09, Ilpo J=E4rvinen wrote:
> > > While testing the resource placement changes, tests hit a case where
> > > igb fails to probe when BAR 0 is placed at 0x9c000000:
> > >=20
> > > =A0=A0=A0 90000000-9cffffff : PCI Bus 0000:a0
> > > =A0=A0 -=A0 90000000-902fffff : PCI Bus 0000:a1
> > > =A0=A0 -=A0=A0=A0 90000000-900fffff : 0000:a1:00.0
> > > =A0=A0 -=A0=A0=A0=A0=A0 90000000-900fffff : igb
> > > =A0=A0 -=A0=A0=A0 90100000-901fffff : 0000:a1:00.0
> > > =A0=A0 -=A0=A0=A0 90200000-90203fff : 0000:a1:00.0
> > > =A0=A0 -=A0=A0=A0=A0=A0 90200000-90203fff : igb
> > > =A0=A0 +=A0 9be00000-9c0fffff : PCI Bus 0000:a1
> > > =A0=A0 +=A0=A0=A0 9be00000-9befffff : 0000:a1:00.0
> > > =A0=A0 +=A0=A0=A0 9bf00000-9bf03fff : 0000:a1:00.0
> > > =A0=A0 +=A0=A0=A0 9c000000-9c0fffff : 0000:a1:00.0
> > > =A0=A0=A0=A0=A0 9c100000-9c17ffff : amd_iommu
> > > =A0=A0=A0=A0=A0 9c180000-9c1803ff : IOAPIC 8
> > >=20
> > > =A0=A0 -=A0=A0=A0=A0=A0=A0 Region 0: Memory at 90000000 (32-bit, non-=
prefetchable)
> > > [size=3D1M]
> > > =A0=A0 -=A0=A0=A0=A0=A0=A0 Region 3: Memory at 90200000 (32-bit, non-=
prefetchable)
> > > [size=3D16K]
> > > =A0=A0 -=A0=A0=A0=A0=A0=A0 Expansion ROM at 90100000 [disabled] [size=
=3D1M]
> > > =A0=A0 +=A0=A0=A0=A0=A0=A0 Region 0: Memory at 9c000000 (32-bit, non-=
prefetchable)
> > > [size=3D1M]
> > > =A0=A0 +=A0=A0=A0=A0=A0=A0 Region 3: Memory at 9bf00000 (32-bit, non-=
prefetchable)
> > > [size=3D16K]
> > > =A0=A0 +=A0=A0=A0=A0=A0=A0 Expansion ROM at 9be00000 [disabled] [size=
=3D1M]
> > >=20
> > > igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> > > ------------[ cut here ]------------
> > > igb: Failed to read reg 0x18!
> > > WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at
> > > igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> > > ...
> > > =A0 igb_get_invariants_82575+0xff/0xf00 [igb]
> > > =A0 igb_probe+0x3c8/0x1190 [igb]
> > > =A0 local_pci_probe+0x3b/0x80
> > >=20
> > > It turns out there is a 64kB iomem black hole at 9c000000 that return=
s
> > > ~0 and this is where igb's BAR 0 resides. If another BAR of the same
> > > card is placed into that address, it is similarly black holed.
> > >=20
> > > Mark the problematic 64kB range reserved using a quirk bound to the
> > > bridge found in the problematic system.
> > >=20
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222074
> > > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > > Cc: Borislav Petkov <bp@alien8.de>
> > >=20
> > > As an alternative to this, I've also tested reverting the commit
> > > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") and
> > > that also resolves the issue by retaining "9c000000-9cffffff : Reserv=
ed"
> > > entry in the resource tree.
> > >=20
> > > ---
> > > =A0 arch/x86/pci/fixup.c | 36 ++++++++++++++++++++++++++++++++++++
> > > =A0 1 file changed, 36 insertions(+)
> > >=20
> > > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > > index b301c6c8df75..cc463bf492b6 100644
> > > --- a/arch/x86/pci/fixup.c
> > > +++ b/arch/x86/pci/fixup.c
> > > @@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15=
71,
> > > pci_amd_enable_64bit_bar);
> > > =A0 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1,
> > > pci_amd_enable_64bit_bar);
> > > =A0 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601,
> > > pci_amd_enable_64bit_bar);
> > > +/*
> > > + * TODO: Remove when/if root cause is found.
> > > + *
> > > + * Genoa appears to have a 64kB iomem black hole starting at 0x9c000=
000
> > > + * address for which all reads return ~0 blocking an overlapping BAR=
 from
> > > + * working.
> > > + *
> > > + * Work around the problem by reserving the space prior to making an=
y
> > > iomem
> > > + * allocations that could overlap with the black hole.
> > > + */
> > > +static struct resource genoa_black_hole =3D
> > > DEFINE_RES_MEM_NAMED(0x9c000000,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SZ_64K,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "reserved");
> > > +
> > > +static void genoa_iomem_black_hole(struct pci_dev *dev)
> > > +{
> > > +=A0=A0=A0 struct resource *r;
> > > +
> > > +=A0=A0=A0 pci_bus_for_each_resource(dev->bus, r) {
> > > +=A0=A0=A0=A0=A0=A0=A0 if (!r || !r->flags || !resource_assigned(r))
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 if (!__resource_contains_unbound(r, &genoa_bla=
ck_hole))
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 if (resource_assigned(&genoa_black_hole))
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_dbg(dev, "iomem black hole wor=
karound already
> > > applied\n");
> > > +=A0=A0=A0=A0=A0=A0=A0 else if (!insert_resource(r, &genoa_black_hole=
))
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_info(dev, "iomem black hole wo=
rkaround enabled\n");
> > > +=A0=A0=A0=A0=A0=A0=A0 else
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_dbg(dev, "iomem black hole wor=
karound add failed\n");
> > > +=A0=A0=A0=A0=A0=A0=A0 return;
> > > +=A0=A0=A0 }
> > > +}
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab,
> > > genoa_iomem_black_hole);
> > > +
> > > =A0 #define RS690_LOWER_TOP_OF_DRAM2=A0=A0=A0 0x30
> > > =A0 #define RS690_LOWER_TOP_OF_DRAM2_VALID=A0=A0=A0 0x1
> > > =A0 #define RS690_UPPER_TOP_OF_DRAM2=A0=A0=A0 0x31
> >=20
> > I guess it's good we know the root cause is 07eab0901ede. If we're goin=
g
> > down the path of making holes in that we may well put the hole in
> > efi_remove_e820_mmio() like this (attached).
>=20
> I don't really like that though.  If Genoa is affected I would expect ple=
nty
> of other machines are too they just haven't been found yet.

That's what I'm worried as well. My own testing can only cover very little=
=20
ground here.

> Can we roll back 07eab0901ede and add quirks for the busted machines inst=
ead?


--=20
 i.
--8323328-1816090372-1791911231=:21507--
