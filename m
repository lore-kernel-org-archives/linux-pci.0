Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587382;
	b=Jk0xqB4yvP3nL2G+m0KfoJ107/U61yZeUkV7mZukx2xFnQXWYTMwJe1OnMoXM3hiQwuI
	 HqMJ3F4ECQrDd6driiJWNCl8rZ1jFnSo0Ys5yTPf/zPUpgXMqkekR5aEFlYiKAQ92pW6h
	 ujMvJxJZMfV/z6dxRoMy7QZ8Drbctzx9cAILvDD+DtE1pmoX+7vW6bwHwlWaDGHDGTsJL
	 rbpB0I3WnsnTH2bufRM8riWh4rJH2tlKZYxprWYfiSDOsY75H7LJraSjRRvVQjl8oHo1Y
	 J4Dy3NATrfNq/LgJBCDXrkgIlopViTb+0KL0efph02bmhXHBhGKHMJsohhho7CGW2yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587382;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=zE0wPrOhPgdDBuZiyfrszzR2mLBGoUO+vXgswwY1qW4=;
	b=vvS8jMh5d9L1uwtFAXE/7/tm48TkB+EFOjfK5bruEndqmYME5Ee99bgTKGpzS9oGgFY2
	 nXcXSgdpkEMdFAL5sthG64K/QgyO+pgs9TSU8Ycq0xZjUQuTGTkXLsv/DvDldXerWJzub
	 o3C68EHsU9JnT6bFLT0WjVIB0pXEOw1MGS3KXkedJ+VbMtVuRnwAJPTlZRw4ODH7ftZ/r
	 bkefgf+bEKd1+zB6izz0cZPBF9TnOSzt8qZkfblUdiAMveValVcDGhqHMkrLsr89nA71E
	 Cs9v8qXPZFitr5RRuaq0EpbIeAyNttmm3EwCO7iyoiGV4+DSZN1FWeXBvwD5JlcCQ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H93b7reb;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1286606A319;
	Wed, 21 Oct 2026 12:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1286606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H93b7reb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792587382; x=1824123382;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UwleBUfevokjeMBFYNGacuzxhYWtpsd+7UaNr3cdTfI=;
  b=H93b7rebWBf90uxi7mP/ZFSXyAS1tYyrhWv6y+Bdq7Sr24At0hoRXYMa
   7fRHvFg18n24k8FnA2r0VsvNe6p7Cf4z+l8Ghn8jK/nzT/gvJrrNMiVrr
   CQwvD5R1QawWgqv0/FnecwdQ6YG5Z2y6sujjNO2J0tNHhG3OL+NpD83hx
   P2Hjhi/nIWkwf+od10r7S7KwAPpnHqqVZXtC/wDLuLZpiXXdR3NGXWvWz
   tbvQGu1bySGglrAwJQ+fhTytrytbANyDd4QF5bj+DZ0a0hFIxcsT2b6nq
   w1OeZWM21kcLznayTseIbYfLxbGhBOO2roMhhePkpGpE/v2aQAhIffOqp
   w==;
X-CSE-ConnectionGUID: 6k7iS0ZcQQ+acBT5oNMU6w==
X-CSE-MsgGUID: SR4Zi5ziSJuVZyOsiR7R1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1342780"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1342780"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:56:21 -0700
X-CSE-ConnectionGUID: d9GQnnMIQWO72CuJQ1KxSw==
X-CSE-MsgGUID: mBatNI4bS72ngTVJhbnyiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="4845032"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:56:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Oct 2026 15:56:08 +0300 (EEST)
To: linux-pci@vger.kernel.org
cc: Hans de Goede <hansg@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Nikolas Joshua Britton <nbritton@exabit.io>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    LKML <linux-kernel@vger.kernel.org>, Bradley Morgan <brads@mainlining.org>, 
    Kai-Heng Feng <kaihengf@nvidia.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa
 systems
In-Reply-To: <b9f0ac77-079c-2383-a572-73ad649af0c8@linux.intel.com>
Message-ID: <69e5be12-b107-bd7c-8cd0-1db29319bf6b@linux.intel.com>
References: <20261013224010.GA1589480@bhelgaas> <f823d264-8b9d-422e-bfaf-388957fbc2fa@kernel.org> <b9f0ac77-079c-2383-a572-73ad649af0c8@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1302103120-1792587368=:1258"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1302103120-1792587368=:1258
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi all,

I've sent v4 of this series to address a few comments sashiko had for=20
b3 [1]. v4 does not contain my version of the quirk as it seemed least=20
likely to be selected among the proposed solutions and the decision is=20
largely independent from rest of the resource placement series.

[1] https://lore.kernel.org/linux-pci/20261021124956.4250-1-ilpo.jarvinen@l=
inux.intel.com/

--=20
 i.

On Thu, 15 Oct 2026, Ilpo J=E4rvinen wrote:

> On Wed, 14 Oct 2026, Hans de Goede wrote:
>=20
> > Hi,
> >=20
> > On 14-Oct-26 00:40, Bjorn Helgaas wrote:
> > > [+cc Hans, Kai-Heng, Andy, linux-acpi]
> > >=20
> > > On Tue, Oct 13, 2026 at 01:59:23PM -0500, Mario Limonciello wrote:
> > >> On 10/13/26 12:26, Ilpo J=E4rvinen wrote:
> > >>> On Tue, 13 Oct 2026, Mario Limonciello wrote:
> > >>>> On 10/13/26 12:00, Mario Limonciello wrote:
> > >>>>> On 10/13/26 08:09, Ilpo J=E4rvinen wrote:
> > >>>>>> While testing the resource placement changes, tests hit a case w=
here
> > >>>>>> igb fails to probe when BAR 0 is placed at 0x9c000000:
> > >>>>>>
> > >>>>>>  =A0=A0=A0 90000000-9cffffff : PCI Bus 0000:a0
> > >>>>>>  =A0=A0 -=A0 90000000-902fffff : PCI Bus 0000:a1
> > >>>>>>  =A0=A0 -=A0=A0=A0 90000000-900fffff : 0000:a1:00.0
> > >>>>>>  =A0=A0 -=A0=A0=A0=A0=A0 90000000-900fffff : igb
> > >>>>>>  =A0=A0 -=A0=A0=A0 90100000-901fffff : 0000:a1:00.0
> > >>>>>>  =A0=A0 -=A0=A0=A0 90200000-90203fff : 0000:a1:00.0
> > >>>>>>  =A0=A0 -=A0=A0=A0=A0=A0 90200000-90203fff : igb
> > >>>>>>  =A0=A0 +=A0 9be00000-9c0fffff : PCI Bus 0000:a1
> > >>>>>>  =A0=A0 +=A0=A0=A0 9be00000-9befffff : 0000:a1:00.0
> > >>>>>>  =A0=A0 +=A0=A0=A0 9bf00000-9bf03fff : 0000:a1:00.0
> > >>>>>>  =A0=A0 +=A0=A0=A0 9c000000-9c0fffff : 0000:a1:00.0
> > >>>>>>  =A0=A0=A0=A0=A0 9c100000-9c17ffff : amd_iommu
> > >>>>>>  =A0=A0=A0=A0=A0 9c180000-9c1803ff : IOAPIC 8
> > >>>>>>
> > >>>>>>  =A0=A0 -=A0=A0=A0=A0=A0=A0 Region 0: Memory at 90000000 (32-bit=
, non-prefetchable)
> > >>>>>> [size=3D1M]
> > >>>>>>  =A0=A0 -=A0=A0=A0=A0=A0=A0 Region 3: Memory at 90200000 (32-bit=
, non-prefetchable)
> > >>>>>> [size=3D16K]
> > >>>>>>  =A0=A0 -=A0=A0=A0=A0=A0=A0 Expansion ROM at 90100000 [disabled]=
 [size=3D1M]
> > >>>>>>  =A0=A0 +=A0=A0=A0=A0=A0=A0 Region 0: Memory at 9c000000 (32-bit=
, non-prefetchable)
> > >>>>>> [size=3D1M]
> > >>>>>>  =A0=A0 +=A0=A0=A0=A0=A0=A0 Region 3: Memory at 9bf00000 (32-bit=
, non-prefetchable)
> > >>>>>> [size=3D16K]
> > >>>>>>  =A0=A0 +=A0=A0=A0=A0=A0=A0 Expansion ROM at 9be00000 [disabled]=
 [size=3D1M]
> > >>>>>>
> > >>>>>> igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> > >>>>>> ------------[ cut here ]------------
> > >>>>>> igb: Failed to read reg 0x18!
> > >>>>>> WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at
> > >>>>>> igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> > >>>>>> ...
> > >>>>>>  =A0 igb_get_invariants_82575+0xff/0xf00 [igb]
> > >>>>>>  =A0 igb_probe+0x3c8/0x1190 [igb]
> > >>>>>>  =A0 local_pci_probe+0x3b/0x80
> > >>>>>>
> > >>>>>> It turns out there is a 64kB iomem black hole at 9c000000 that r=
eturns
> > >>>>>> ~0 and this is where igb's BAR 0 resides. If another BAR of the =
same
> > >>>>>> card is placed into that address, it is similarly black holed.
> > >>>>>>
> > >>>>>> Mark the problematic 64kB range reserved using a quirk bound to =
the
> > >>>>>> bridge found in the problematic system.
> > >>>>>>
> > >>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222074
> > >>>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > >>>>>> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > >>>>>> ---
> > >>>>>> Cc: Borislav Petkov <bp@alien8.de>
> > >>>>>>
> > >>>>>> As an alternative to this, I've also tested reverting the commit
> > >>>>>> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")=
 and
> > >>>>>> that also resolves the issue by retaining "9c000000-9cffffff : R=
eserved"
> > >>>>>> entry in the resource tree.
> > >>>>>>
> > >>>>>> ---
> > >>>>>>  =A0 arch/x86/pci/fixup.c | 36 +++++++++++++++++++++++++++++++++=
+++
> > >>>>>>  =A0 1 file changed, 36 insertions(+)
> > >>>>>>
> > >>>>>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > >>>>>> index b301c6c8df75..cc463bf492b6 100644
> > >>>>>> --- a/arch/x86/pci/fixup.c
> > >>>>>> +++ b/arch/x86/pci/fixup.c
> > >>>>>> @@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD,=
 0x1571,
> > >>>>>> pci_amd_enable_64bit_bar);
> > >>>>>>  =A0 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1,
> > >>>>>> pci_amd_enable_64bit_bar);
> > >>>>>>  =A0 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601,
> > >>>>>> pci_amd_enable_64bit_bar);
> > >>>>>> +/*
> > >>>>>> + * TODO: Remove when/if root cause is found.
> > >>>>>> + *
> > >>>>>> + * Genoa appears to have a 64kB iomem black hole starting at 0x=
9c000000
> > >>>>>> + * address for which all reads return ~0 blocking an overlappin=
g BAR from
> > >>>>>> + * working.
> > >>>>>> + *
> > >>>>>> + * Work around the problem by reserving the space prior to maki=
ng any
> > >>>>>> iomem
> > >>>>>> + * allocations that could overlap with the black hole.
> > >>>>>> + */
> > >>>>>> +static struct resource genoa_black_hole =3D
> > >>>>>> DEFINE_RES_MEM_NAMED(0x9c000000,
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SZ_64K,
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "reserved");
> > >>>>>> +
> > >>>>>> +static void genoa_iomem_black_hole(struct pci_dev *dev)
> > >>>>>> +{
> > >>>>>> +=A0=A0=A0 struct resource *r;
> > >>>>>> +
> > >>>>>> +=A0=A0=A0 pci_bus_for_each_resource(dev->bus, r) {
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (!r || !r->flags || !resource_assigned=
(r))
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > >>>>>> +
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (!__resource_contains_unbound(r, &geno=
a_black_hole))
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > >>>>>> +
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (resource_assigned(&genoa_black_hole))
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_dbg(dev, "iomem black hol=
e workaround already
> > >>>>>> applied\n");
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0 else if (!insert_resource(r, &genoa_black=
_hole))
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_info(dev, "iomem black ho=
le workaround enabled\n");
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0 else
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_dbg(dev, "iomem black hol=
e workaround add failed\n");
> > >>>>>> +=A0=A0=A0=A0=A0=A0=A0 return;
> > >>>>>> +=A0=A0=A0 }
> > >>>>>> +}
> > >>>>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab,
> > >>>>>> genoa_iomem_black_hole);
> > >>>>>> +
> > >>>>>>  =A0 #define RS690_LOWER_TOP_OF_DRAM2=A0=A0=A0 0x30
> > >>>>>>  =A0 #define RS690_LOWER_TOP_OF_DRAM2_VALID=A0=A0=A0 0x1
> > >>>>>>  =A0 #define RS690_UPPER_TOP_OF_DRAM2=A0=A0=A0 0x31
> > >>>>>
> > >>>>> I guess it's good we know the root cause is 07eab0901ede. If we'r=
e going
> > >>>>> down the path of making holes in that we may well put the hole in
> > >>>>> efi_remove_e820_mmio() like this (attached).
> > >>>>
> > >>>> I don't really like that though.  If Genoa is affected I would exp=
ect plenty
> > >>>> of other machines are too they just haven't been found yet.
> > >>>
> > >>> That's what I'm worried as well. My own testing can only cover very=
 little
> > >>> ground here.
> > >>>
> > >>>> Can we roll back 07eab0901ede and add quirks for the busted machin=
es instead?
> > >>
> > >> I had an agent dig through all the reports linked in 07eab0901ede an=
d
> > >> drafted up what should be the remaining quirks for a revert.
> > >>
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/lo=
g/?h=3Dsuperm1/genoa-mess
> > >>
> > >> Bjorn, thoughts on this?  I'll send it out if that's the way we want
> > >> to go (or Ilpo feel free to subsume into your series as it's only
> > >> really exposed by your series at the moment)
> > >=20
> > > I would LOVE it if we can use those patches because it's way less
> > > magic than 07eab0901ede is.
> > >=20
> > > But I'm frankly terrified to touch it because I'm skeptical that two
> > > more quirks are enough.  I just expect that whatever strategy BIOS
> > > uses to build these maps is likely to be used on many models.  I do
> > > hate 07eab0901ede though, so I would love to see it gone.
> >=20
> > It has been about 4 years since we came up with 07eab0901ede IIRC we
> > had a huge email thread with a whole bunch of attempts at fixing
> > the issue in a generic manner.
> >=20
> > IIRC some of those attempts tried to identify the exact problematic
> > issue the quirks try to fix where there is an EFI MMIO reservation
> > covering the entire bridge window.
> >=20
> > Maybe we can dig through the old thread and see if with the knowledge
> > we have now one of the previous attempts of fixing it from the thread
> > is better?
> >=20
> > I agree that needing to go back to quirks is likely going to be painful
> > and break a whole bunch of other systems. IIRC 07eab0901ede fixed
> > a whole bunch of laptops having issues around the time not just
> > the Clevo NL4XLU and Lenovo Yoga C940. But this info might be spread
> > over various bugzilla entries, etc. + some models where likely never
> > reported but just fixed in time for users to not report things.
> >=20
> > I also wonder if given we only have this magic black-hole on geneo/zen4
>=20
> That might be because my PCI resource placement series has not (yet) been=
=20
> tested on that many systems.
>=20
> I think it's the other way around. While my testing is quite extensive, i=
t=20
> can only cover relatively little ground, but already that was enough to=
=20
> find one issue. Why should we assume I managed to hit the "only" problem?=
!=20
> More likely explanation is there are many problematic addresses, enough=
=20
> for me to stumble on one of them.
>=20
> The new generalized resource placement does have a tendencity to place=20
> resources at the right edge of the window (to keep the left edge availabl=
e=20
> as it typically provides higher aligning order for the remaining free=20
> space). I expected that to lead us to largely uncharted territory though
> Andy seemed to suggest Windows might actually be using top-down ordering
> for its allocations so it could be that it's better charted than I've
> assumed.
>=20
> > if it would not be better to go with Mario's original approach here ?
> > Esp. since Mario's quirk is chipset based where as the other problems
> > seem to be model/product based so that is 1 quirk vs many quirks.
>=20
> I'm somewhat skeptical it will be the only problematic case but it's hard=
=20
> to guess which case would require more quirks in the end.


--8323328-1302103120-1792587368=:1258--
