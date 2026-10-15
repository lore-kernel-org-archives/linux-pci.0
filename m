Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42791522F19;
	Thu, 15 Oct 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071266; cv=none; b=IC/p+kl8c23d27UJaXHO90cCr3Lzm64ry56pGXRZRlyNDehznVhRs9o7Y/Exy3Wq7ncXGFUzgK/m3npm1ma7Yfrulm/5uBcrLOzJNIkYbQdcwOMXDy6QDY4ToYSdUN1A1JfJJ4ZkNDBKCrKdvhdpdTGll/o0KePiFkaKzZ9pLbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071266; c=relaxed/simple;
	bh=GFfwlXk4dK3b3zxTl0gUpnujRtIFeHA2uJP4ogyNGqg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rWme5fzdPKqAMT1lFStAwLDMONCOEk68LoBmr6cBcqSGsEBOwmVrfAUh2+Ogj2MvzI9r2QaGL03oLzvg7REH2PABskOIEeJTRza3cVe9b1TlNuW/m8ODNf4abtNboPEt2lYwPYbLQpBmpfm8dylj3jxxV3rZz1nnK7dvl0xg/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T55uzyI0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T55uzyI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792071264; x=1823607264;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=GFfwlXk4dK3b3zxTl0gUpnujRtIFeHA2uJP4ogyNGqg=;
  b=T55uzyI0+/h/z++RL+eVJzPuNAy1oyaatzILqw29F8LhdIS0E2GuEPkx
   CS01VFYFrL/F15gxkm75nJH9VYiBElvdu2Wi/EF3DOyeLmS+hX7Gd2OzF
   FEPQ4Vyzow+3GObJWxCXRPsIn4x4zApn1CEQpvFrBNZV1hn0vicRP9daB
   iZFQ3xwFINoCjWfl0nQWspcKOZUzF0ylJMPdIm66CBNub2j7UpLyK7q0R
   eJjslDASrekfXvPx3Z+DCHbu6ErxN0MKdKYXa6pn3P57oAik04nK1KvnZ
   SczBFUg7eXq0ToBXi/S3kYZY+NxIVq0NDNON1jqOfdp35k9qC68R3WTbc
   g==;
X-CSE-ConnectionGUID: q/niEKjlT4qzxDsxyOvWkw==
X-CSE-MsgGUID: utqCps9cSLGAwhhjI6KPQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="738984"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="738984"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 06:34:23 -0700
X-CSE-ConnectionGUID: 3BNuJ+tSTBaigfDREZfYYg==
X-CSE-MsgGUID: vcmlCdv0R1Cs57luYtqUjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1789473"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 06:34:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 15 Oct 2026 16:34:11 +0300 (EEST)
To: Hans de Goede <hansg@kernel.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Maciej Grochowski <Maciej.Grochowski@sony.com>, 
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
    LKML <linux-kernel@vger.kernel.org>, Bradley Morgan <brads@mainlining.org>, 
    Kai-Heng Feng <kaihengf@nvidia.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa
 systems
In-Reply-To: <f823d264-8b9d-422e-bfaf-388957fbc2fa@kernel.org>
Message-ID: <b9f0ac77-079c-2383-a572-73ad649af0c8@linux.intel.com>
References: <20261013224010.GA1589480@bhelgaas> <f823d264-8b9d-422e-bfaf-388957fbc2fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1009683489-1791971108=:1157"
Content-ID: <f1b47b45-53df-7840-9868-ec0f6f8832f2@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1009683489-1791971108=:1157
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <2da465da-08ff-cbd0-6327-f2f05bbc3e4c@linux.intel.com>

On Wed, 14 Oct 2026, Hans de Goede wrote:

> Hi,
>=20
> On 14-Oct-26 00:40, Bjorn Helgaas wrote:
> > [+cc Hans, Kai-Heng, Andy, linux-acpi]
> >=20
> > On Tue, Oct 13, 2026 at 01:59:23PM -0500, Mario Limonciello wrote:
> >> On 10/13/26 12:26, Ilpo J=E4rvinen wrote:
> >>> On Tue, 13 Oct 2026, Mario Limonciello wrote:
> >>>> On 10/13/26 12:00, Mario Limonciello wrote:
> >>>>> On 10/13/26 08:09, Ilpo J=E4rvinen wrote:
> >>>>>> While testing the resource placement changes, tests hit a case whe=
re
> >>>>>> igb fails to probe when BAR 0 is placed at 0x9c000000:
> >>>>>>
> >>>>>>  =A0=A0=A0 90000000-9cffffff : PCI Bus 0000:a0
> >>>>>>  =A0=A0 -=A0 90000000-902fffff : PCI Bus 0000:a1
> >>>>>>  =A0=A0 -=A0=A0=A0 90000000-900fffff : 0000:a1:00.0
> >>>>>>  =A0=A0 -=A0=A0=A0=A0=A0 90000000-900fffff : igb
> >>>>>>  =A0=A0 -=A0=A0=A0 90100000-901fffff : 0000:a1:00.0
> >>>>>>  =A0=A0 -=A0=A0=A0 90200000-90203fff : 0000:a1:00.0
> >>>>>>  =A0=A0 -=A0=A0=A0=A0=A0 90200000-90203fff : igb
> >>>>>>  =A0=A0 +=A0 9be00000-9c0fffff : PCI Bus 0000:a1
> >>>>>>  =A0=A0 +=A0=A0=A0 9be00000-9befffff : 0000:a1:00.0
> >>>>>>  =A0=A0 +=A0=A0=A0 9bf00000-9bf03fff : 0000:a1:00.0
> >>>>>>  =A0=A0 +=A0=A0=A0 9c000000-9c0fffff : 0000:a1:00.0
> >>>>>>  =A0=A0=A0=A0=A0 9c100000-9c17ffff : amd_iommu
> >>>>>>  =A0=A0=A0=A0=A0 9c180000-9c1803ff : IOAPIC 8
> >>>>>>
> >>>>>>  =A0=A0 -=A0=A0=A0=A0=A0=A0 Region 0: Memory at 90000000 (32-bit, =
non-prefetchable)
> >>>>>> [size=3D1M]
> >>>>>>  =A0=A0 -=A0=A0=A0=A0=A0=A0 Region 3: Memory at 90200000 (32-bit, =
non-prefetchable)
> >>>>>> [size=3D16K]
> >>>>>>  =A0=A0 -=A0=A0=A0=A0=A0=A0 Expansion ROM at 90100000 [disabled] [=
size=3D1M]
> >>>>>>  =A0=A0 +=A0=A0=A0=A0=A0=A0 Region 0: Memory at 9c000000 (32-bit, =
non-prefetchable)
> >>>>>> [size=3D1M]
> >>>>>>  =A0=A0 +=A0=A0=A0=A0=A0=A0 Region 3: Memory at 9bf00000 (32-bit, =
non-prefetchable)
> >>>>>> [size=3D16K]
> >>>>>>  =A0=A0 +=A0=A0=A0=A0=A0=A0 Expansion ROM at 9be00000 [disabled] [=
size=3D1M]
> >>>>>>
> >>>>>> igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> >>>>>> ------------[ cut here ]------------
> >>>>>> igb: Failed to read reg 0x18!
> >>>>>> WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at
> >>>>>> igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> >>>>>> ...
> >>>>>>  =A0 igb_get_invariants_82575+0xff/0xf00 [igb]
> >>>>>>  =A0 igb_probe+0x3c8/0x1190 [igb]
> >>>>>>  =A0 local_pci_probe+0x3b/0x80
> >>>>>>
> >>>>>> It turns out there is a 64kB iomem black hole at 9c000000 that ret=
urns
> >>>>>> ~0 and this is where igb's BAR 0 resides. If another BAR of the sa=
me
> >>>>>> card is placed into that address, it is similarly black holed.
> >>>>>>
> >>>>>> Mark the problematic 64kB range reserved using a quirk bound to th=
e
> >>>>>> bridge found in the problematic system.
> >>>>>>
> >>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222074
> >>>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> >>>>>> ---
> >>>>>> Cc: Borislav Petkov <bp@alien8.de>
> >>>>>>
> >>>>>> As an alternative to this, I've also tested reverting the commit
> >>>>>> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") a=
nd
> >>>>>> that also resolves the issue by retaining "9c000000-9cffffff : Res=
erved"
> >>>>>> entry in the resource tree.
> >>>>>>
> >>>>>> ---
> >>>>>>  =A0 arch/x86/pci/fixup.c | 36 +++++++++++++++++++++++++++++++++++=
+
> >>>>>>  =A0 1 file changed, 36 insertions(+)
> >>>>>>
> >>>>>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> >>>>>> index b301c6c8df75..cc463bf492b6 100644
> >>>>>> --- a/arch/x86/pci/fixup.c
> >>>>>> +++ b/arch/x86/pci/fixup.c
> >>>>>> @@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0=
x1571,
> >>>>>> pci_amd_enable_64bit_bar);
> >>>>>>  =A0 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1,
> >>>>>> pci_amd_enable_64bit_bar);
> >>>>>>  =A0 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601,
> >>>>>> pci_amd_enable_64bit_bar);
> >>>>>> +/*
> >>>>>> + * TODO: Remove when/if root cause is found.
> >>>>>> + *
> >>>>>> + * Genoa appears to have a 64kB iomem black hole starting at 0x9c=
000000
> >>>>>> + * address for which all reads return ~0 blocking an overlapping =
BAR from
> >>>>>> + * working.
> >>>>>> + *
> >>>>>> + * Work around the problem by reserving the space prior to making=
 any
> >>>>>> iomem
> >>>>>> + * allocations that could overlap with the black hole.
> >>>>>> + */
> >>>>>> +static struct resource genoa_black_hole =3D
> >>>>>> DEFINE_RES_MEM_NAMED(0x9c000000,
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SZ_64K,
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "reserved");
> >>>>>> +
> >>>>>> +static void genoa_iomem_black_hole(struct pci_dev *dev)
> >>>>>> +{
> >>>>>> +=A0=A0=A0 struct resource *r;
> >>>>>> +
> >>>>>> +=A0=A0=A0 pci_bus_for_each_resource(dev->bus, r) {
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (!r || !r->flags || !resource_assigned(r=
))
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> >>>>>> +
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (!__resource_contains_unbound(r, &genoa_=
black_hole))
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> >>>>>> +
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (resource_assigned(&genoa_black_hole))
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_dbg(dev, "iomem black hole =
workaround already
> >>>>>> applied\n");
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0 else if (!insert_resource(r, &genoa_black_h=
ole))
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_info(dev, "iomem black hole=
 workaround enabled\n");
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0 else
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_dbg(dev, "iomem black hole =
workaround add failed\n");
> >>>>>> +=A0=A0=A0=A0=A0=A0=A0 return;
> >>>>>> +=A0=A0=A0 }
> >>>>>> +}
> >>>>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab,
> >>>>>> genoa_iomem_black_hole);
> >>>>>> +
> >>>>>>  =A0 #define RS690_LOWER_TOP_OF_DRAM2=A0=A0=A0 0x30
> >>>>>>  =A0 #define RS690_LOWER_TOP_OF_DRAM2_VALID=A0=A0=A0 0x1
> >>>>>>  =A0 #define RS690_UPPER_TOP_OF_DRAM2=A0=A0=A0 0x31
> >>>>>
> >>>>> I guess it's good we know the root cause is 07eab0901ede. If we're =
going
> >>>>> down the path of making holes in that we may well put the hole in
> >>>>> efi_remove_e820_mmio() like this (attached).
> >>>>
> >>>> I don't really like that though.  If Genoa is affected I would expec=
t plenty
> >>>> of other machines are too they just haven't been found yet.
> >>>
> >>> That's what I'm worried as well. My own testing can only cover very l=
ittle
> >>> ground here.
> >>>
> >>>> Can we roll back 07eab0901ede and add quirks for the busted machines=
 instead?
> >>
> >> I had an agent dig through all the reports linked in 07eab0901ede and
> >> drafted up what should be the remaining quirks for a revert.
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/=
?h=3Dsuperm1/genoa-mess
> >>
> >> Bjorn, thoughts on this?  I'll send it out if that's the way we want
> >> to go (or Ilpo feel free to subsume into your series as it's only
> >> really exposed by your series at the moment)
> >=20
> > I would LOVE it if we can use those patches because it's way less
> > magic than 07eab0901ede is.
> >=20
> > But I'm frankly terrified to touch it because I'm skeptical that two
> > more quirks are enough.  I just expect that whatever strategy BIOS
> > uses to build these maps is likely to be used on many models.  I do
> > hate 07eab0901ede though, so I would love to see it gone.
>=20
> It has been about 4 years since we came up with 07eab0901ede IIRC we
> had a huge email thread with a whole bunch of attempts at fixing
> the issue in a generic manner.
>=20
> IIRC some of those attempts tried to identify the exact problematic
> issue the quirks try to fix where there is an EFI MMIO reservation
> covering the entire bridge window.
>=20
> Maybe we can dig through the old thread and see if with the knowledge
> we have now one of the previous attempts of fixing it from the thread
> is better?
>=20
> I agree that needing to go back to quirks is likely going to be painful
> and break a whole bunch of other systems. IIRC 07eab0901ede fixed
> a whole bunch of laptops having issues around the time not just
> the Clevo NL4XLU and Lenovo Yoga C940. But this info might be spread
> over various bugzilla entries, etc. + some models where likely never
> reported but just fixed in time for users to not report things.
>=20
> I also wonder if given we only have this magic black-hole on geneo/zen4

That might be because my PCI resource placement series has not (yet) been=
=20
tested on that many systems.

I think it's the other way around. While my testing is quite extensive, it=
=20
can only cover relatively little ground, but already that was enough to=20
find one issue. Why should we assume I managed to hit the "only" problem?!=
=20
More likely explanation is there are many problematic addresses, enough=20
for me to stumble on one of them.

The new generalized resource placement does have a tendencity to place=20
resources at the right edge of the window (to keep the left edge available=
=20
as it typically provides higher aligning order for the remaining free=20
space). I expected that to lead us to largely uncharted territory though
Andy seemed to suggest Windows might actually be using top-down ordering
for its allocations so it could be that it's better charted than I've
assumed.

> if it would not be better to go with Mario's original approach here ?
> Esp. since Mario's quirk is chipset based where as the other problems
> seem to be model/product based so that is 1 quirk vs many quirks.

I'm somewhat skeptical it will be the only problematic case but it's hard=
=20
to guess which case would require more quirks in the end.

--=20
 i.
--8323328-1009683489-1791971108=:1157--
