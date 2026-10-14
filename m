Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F234E56C7;
	Wed, 14 Oct 2026 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976671; cv=none; b=mK/x9KgD7yFhPiXDzTJSORPSVZPcu8KoIAN0ZDXT6x3D1FQntlMzQ/Z/x+7xFDKJEdXJNa4JyrAIQVDOmXu5o6E7pXaJZPRFF5GOzJG6zJusiARCp/54m8Sy4xFEgxZOlkdrqL/q3yAfD30nG3qxEmYDGLHZ5DdUoSjum/jG5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976671; c=relaxed/simple;
	bh=jKzvrMQb8fcJtzsXXo6b2N++4ORBB6v8siIDd/Spit8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rxRTfE7/J7TkNTGl/VCKMjY6N2gf9bu9TnVusMZ3JJLqxt0K8tjioaJhYN16G6D9dcVzPR2FlMVAFOmweJ2AnQzDYSzdLRoCo0ro/AiODLPeuiZpCK2ZweOqriDdGmeiQjet+TOglEERir2/9cy3Jw2BnLA8ecqcYfFqYRmyIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agem/QK/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agem/QK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791976669; x=1823512669;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=jKzvrMQb8fcJtzsXXo6b2N++4ORBB6v8siIDd/Spit8=;
  b=agem/QK/6qdty9FopPfzUTSdFGoUKSiwuzzNFGFoib47qKjxTKEr787Q
   z9YspYzePGWrpgEKvvmQ5C2w9J4L0R+mgo4TuTpkxQoWVdybJihn7MeT5
   w7Mk4qGv3/DxvTZJheTeztseflVTMvDpCIDeIQjpcn2GI7vv6/RrPC4z8
   gK5JTu9YIHkXMoCoF5Q3q4K0wLToIUfoAjwHRnt0Y2x8KThFIyBYHuNxq
   sWRFSbd1EsaKmidUFNlzcN2fAOd8OH/GkM4qEEkMhadJzcSL+LEr1DOM/
   8aS4hGiCtiaejt5D7WJdNXAqpOnlsF63jQAsTZ7CjiIwqRc4Z7jg+Z3VJ
   A==;
X-CSE-ConnectionGUID: 4uYLt0LHTbOq1/kiDjVfxA==
X-CSE-MsgGUID: lzXVuBz5TJCyRjv/iDjYnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="618155"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="618155"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 04:17:48 -0700
X-CSE-ConnectionGUID: RuuQcvQOQgirFpngs2Pb9w==
X-CSE-MsgGUID: uigPoF/HRuykzyNVvUqbiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1373871"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 04:17:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 Oct 2026 14:17:36 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@intel.com>
cc: Hans de Goede <hansg@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
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
    Kai-Heng Feng <kaihengf@nvidia.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa
 systems
In-Reply-To: <as9eqFRuiMgG-fhG@ashevche-desk.local>
Message-ID: <92d10658-15af-c9b0-5e4a-69992920fd1b@linux.intel.com>
References: <20261013224010.GA1589480@bhelgaas> <f823d264-8b9d-422e-bfaf-388957fbc2fa@kernel.org> <as9eqFRuiMgG-fhG@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-144690059-1791975600=:1157"
Content-ID: <f1725a40-8d19-d25e-202b-73cff4232d3e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-144690059-1791975600=:1157
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <8cc767ad-c482-9a3f-0da5-2e1663e53154@linux.intel.com>

On Wed, 14 Oct 2026, Andy Shevchenko wrote:

> On Wed, Oct 14, 2026 at 11:34:44AM +0200, Hans de Goede wrote:
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
> > if it would not be better to go with Mario's original approach here ?
> > Esp. since Mario's quirk is chipset based where as the other problems
> > seem to be model/product based so that is 1 quirk vs many quirks.
>=20
> Can we simply change the algo of allocating resources to follow what Wind=
ows
> does?

I've no idea what it does.

You seem to simplify things to just being about direction of allocation=20
but there are other constraints, most importantly alignment ones.

There are many cases where there simply isn't any extra room to play with
so the algorithm must produce as tight packing as possible.

The assignment step is greedy that could easily lead us into dead ends=20
where not all resources can be assigned because something was placed such=
=20
that it is on the way. This series of mine tries to make placement such=20
that it maximizes success possibility of subsequent assignments (leaving=20
the best free space candidate for future assignments). Side-effect of=20
these changes is that more allocations do happen at the tail (to maximize=
=20
the alignment order of the free space, that is usually larger at the left=
=20
edge/start of the window). So maybe you actually end up getting what you
wish in many cases.

Retrying anything in controlled manner is also challenging. This might be=
=20
fixable on medium term by holding some setup structure across algorithm=20
"tries" but currently we hold nothing else than what's in the struct=20
resource and in/not-in-resource-tree information.

Changing anything in this area hasn't been easy at all because almost=20
everything seems to break something (in part it's my own bugs but there=20
are also many cases I just could not foresee nor encounter in my tests).

So I'm sorry don't think any large scale rewrite would be viable.

--=20
 i.
--8323328-144690059-1791975600=:1157--
