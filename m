Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC93214A84;
	Wed, 14 Oct 2026 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984794; cv=none; b=UjSnOIP/fbuCrsaPwwZHeZxqeCD9+K0CVFnAigmQLDIGw6jeFJGwgKYuXR4q+snE0U/l/Yn6+YN/AAQ055a5SsptfJnoPGxBwrpcAxyExcebGOEOKjEJq6tZfZgRJP+jfCPV535ObZbijKctfYNhL1xf4rzk2Hwq6ONhsbJxNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984794; c=relaxed/simple;
	bh=vkpl7Pfj4hHNm30sUMoHv41uQE31BXc+c1uPmB91SDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gau7WTnqcQr8xdriMBezf/Z9poQ8jnI4pJiwqlWYqphHrAB3KlE8CuPMJtBmAkPOYJC1WSlu7dbKpHG+rfOAY6rZMBL33zeS2MvxboUZCOAvcAjlb/kuMDuxokiCrWhFqV6to4tN9xYwZPB1Nz8IQhcQ/O+RtASpY6pq5ly7ye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6bayUBB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6bayUBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791984779; x=1823520779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vkpl7Pfj4hHNm30sUMoHv41uQE31BXc+c1uPmB91SDY=;
  b=E6bayUBBvnXLjojt3vXXXhHZMkkDokghRlMf+WuCyg5dztvARpHPsIBf
   9ZUkpz63cYfTKelopFXQhu5zwewoPvRy2jFe+2uwxOH0B5craBjSQQf9P
   tMXZn3vYQWZwfR4V6njP2Pf7Brn1/6Ws8jnIfZmyqDAd9XKZWlhlZT/di
   cWHYCDFeqJCElglhmCe2pRJ+lBe9YCpVvrYnZXWi6Z1ZdxSGHV11sm+iE
   OSI4yAJyGIIeyJCoQFYCdZrryYSe9c1Q40RI/USFTwJA5UVyn6HLT/MHt
   CtYWvsR9iKSi41A0eioERrWiatmYaZ0yxJ9DZjKo9GIVbRIF+QXoqTXsF
   A==;
X-CSE-ConnectionGUID: VCDLDMPLShmAvJbj9QJz8w==
X-CSE-MsgGUID: mxtbH+0uQxSDaqaJGzekyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="720955"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="720955"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 06:32:58 -0700
X-CSE-ConnectionGUID: Hd7qV+eRRNm9cEZcWaZZHw==
X-CSE-MsgGUID: +mWI3I5hTBu1BnrIFFD5Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1505167"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 06:32:53 -0700
Date: Wed, 14 Oct 2026 16:32:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Message-ID: <as-EghzVdmmbMGPI@ashevche-desk.local>
References: <20261013224010.GA1589480@bhelgaas>
 <f823d264-8b9d-422e-bfaf-388957fbc2fa@kernel.org>
 <as9eqFRuiMgG-fhG@ashevche-desk.local>
 <92d10658-15af-c9b0-5e4a-69992920fd1b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92d10658-15af-c9b0-5e4a-69992920fd1b@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 14, 2026 at 02:17:36PM +0300, Ilpo Järvinen wrote:
> On Wed, 14 Oct 2026, Andy Shevchenko wrote:
> > On Wed, Oct 14, 2026 at 11:34:44AM +0200, Hans de Goede wrote:
> > > On 14-Oct-26 00:40, Bjorn Helgaas wrote:
> > > > On Tue, Oct 13, 2026 at 01:59:23PM -0500, Mario Limonciello wrote:
> > > >> On 10/13/26 12:26, Ilpo Järvinen wrote:
> > > >>> On Tue, 13 Oct 2026, Mario Limonciello wrote:
> > > >>>> On 10/13/26 12:00, Mario Limonciello wrote:
> > > >>>>> On 10/13/26 08:09, Ilpo Järvinen wrote:
> > > >>>>>> While testing the resource placement changes, tests hit a case where
> > > >>>>>> igb fails to probe when BAR 0 is placed at 0x9c000000:
> > > >>>>>>
> > > >>>>>>      90000000-9cffffff : PCI Bus 0000:a0
> > > >>>>>>     -  90000000-902fffff : PCI Bus 0000:a1
> > > >>>>>>     -    90000000-900fffff : 0000:a1:00.0
> > > >>>>>>     -      90000000-900fffff : igb
> > > >>>>>>     -    90100000-901fffff : 0000:a1:00.0
> > > >>>>>>     -    90200000-90203fff : 0000:a1:00.0
> > > >>>>>>     -      90200000-90203fff : igb
> > > >>>>>>     +  9be00000-9c0fffff : PCI Bus 0000:a1
> > > >>>>>>     +    9be00000-9befffff : 0000:a1:00.0
> > > >>>>>>     +    9bf00000-9bf03fff : 0000:a1:00.0
> > > >>>>>>     +    9c000000-9c0fffff : 0000:a1:00.0
> > > >>>>>>        9c100000-9c17ffff : amd_iommu
> > > >>>>>>        9c180000-9c1803ff : IOAPIC 8
> > > >>>>>>
> > > >>>>>>     -       Region 0: Memory at 90000000 (32-bit, non-prefetchable)
> > > >>>>>> [size=1M]
> > > >>>>>>     -       Region 3: Memory at 90200000 (32-bit, non-prefetchable)
> > > >>>>>> [size=16K]
> > > >>>>>>     -       Expansion ROM at 90100000 [disabled] [size=1M]
> > > >>>>>>     +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable)
> > > >>>>>> [size=1M]
> > > >>>>>>     +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable)
> > > >>>>>> [size=16K]
> > > >>>>>>     +       Expansion ROM at 9be00000 [disabled] [size=1M]
> > > >>>>>>
> > > >>>>>> igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> > > >>>>>> ------------[ cut here ]------------
> > > >>>>>> igb: Failed to read reg 0x18!
> > > >>>>>> WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at
> > > >>>>>> igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> > > >>>>>> ...
> > > >>>>>>    igb_get_invariants_82575+0xff/0xf00 [igb]
> > > >>>>>>    igb_probe+0x3c8/0x1190 [igb]
> > > >>>>>>    local_pci_probe+0x3b/0x80
> > > >>>>>>
> > > >>>>>> It turns out there is a 64kB iomem black hole at 9c000000 that returns
> > > >>>>>> ~0 and this is where igb's BAR 0 resides. If another BAR of the same
> > > >>>>>> card is placed into that address, it is similarly black holed.
> > > >>>>>>
> > > >>>>>> Mark the problematic 64kB range reserved using a quirk bound to the
> > > >>>>>> bridge found in the problematic system.
> > > >>>>>>
> > > >>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222074
> > > >>>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > > >>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > >>>>>> ---
> > > >>>>>> Cc: Borislav Petkov <bp@alien8.de>
> > > >>>>>>
> > > >>>>>> As an alternative to this, I've also tested reverting the commit
> > > >>>>>> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") and
> > > >>>>>> that also resolves the issue by retaining "9c000000-9cffffff : Reserved"
> > > >>>>>> entry in the resource tree.
> > > >>>>>>
> > > >>>>>> ---
> > > >>>>>>    arch/x86/pci/fixup.c | 36 ++++++++++++++++++++++++++++++++++++
> > > >>>>>>    1 file changed, 36 insertions(+)
> > > >>>>>>
> > > >>>>>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > > >>>>>> index b301c6c8df75..cc463bf492b6 100644
> > > >>>>>> --- a/arch/x86/pci/fixup.c
> > > >>>>>> +++ b/arch/x86/pci/fixup.c
> > > >>>>>> @@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1571,
> > > >>>>>> pci_amd_enable_64bit_bar);
> > > >>>>>>    DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1,
> > > >>>>>> pci_amd_enable_64bit_bar);
> > > >>>>>>    DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601,
> > > >>>>>> pci_amd_enable_64bit_bar);
> > > >>>>>> +/*
> > > >>>>>> + * TODO: Remove when/if root cause is found.
> > > >>>>>> + *
> > > >>>>>> + * Genoa appears to have a 64kB iomem black hole starting at 0x9c000000
> > > >>>>>> + * address for which all reads return ~0 blocking an overlapping BAR from
> > > >>>>>> + * working.
> > > >>>>>> + *
> > > >>>>>> + * Work around the problem by reserving the space prior to making any
> > > >>>>>> iomem
> > > >>>>>> + * allocations that could overlap with the black hole.
> > > >>>>>> + */
> > > >>>>>> +static struct resource genoa_black_hole =
> > > >>>>>> DEFINE_RES_MEM_NAMED(0x9c000000,
> > > >>>>>> +                                   SZ_64K,
> > > >>>>>> +                                   "reserved");
> > > >>>>>> +
> > > >>>>>> +static void genoa_iomem_black_hole(struct pci_dev *dev)
> > > >>>>>> +{
> > > >>>>>> +    struct resource *r;
> > > >>>>>> +
> > > >>>>>> +    pci_bus_for_each_resource(dev->bus, r) {
> > > >>>>>> +        if (!r || !r->flags || !resource_assigned(r))
> > > >>>>>> +            continue;
> > > >>>>>> +
> > > >>>>>> +        if (!__resource_contains_unbound(r, &genoa_black_hole))
> > > >>>>>> +            continue;
> > > >>>>>> +
> > > >>>>>> +        if (resource_assigned(&genoa_black_hole))
> > > >>>>>> +            pci_dbg(dev, "iomem black hole workaround already
> > > >>>>>> applied\n");
> > > >>>>>> +        else if (!insert_resource(r, &genoa_black_hole))
> > > >>>>>> +            pci_info(dev, "iomem black hole workaround enabled\n");
> > > >>>>>> +        else
> > > >>>>>> +            pci_dbg(dev, "iomem black hole workaround add failed\n");
> > > >>>>>> +        return;
> > > >>>>>> +    }
> > > >>>>>> +}
> > > >>>>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab,
> > > >>>>>> genoa_iomem_black_hole);
> > > >>>>>> +
> > > >>>>>>    #define RS690_LOWER_TOP_OF_DRAM2    0x30
> > > >>>>>>    #define RS690_LOWER_TOP_OF_DRAM2_VALID    0x1
> > > >>>>>>    #define RS690_UPPER_TOP_OF_DRAM2    0x31
> > > >>>>>
> > > >>>>> I guess it's good we know the root cause is 07eab0901ede. If we're going
> > > >>>>> down the path of making holes in that we may well put the hole in
> > > >>>>> efi_remove_e820_mmio() like this (attached).
> > > >>>>
> > > >>>> I don't really like that though.  If Genoa is affected I would expect plenty
> > > >>>> of other machines are too they just haven't been found yet.
> > > >>>
> > > >>> That's what I'm worried as well. My own testing can only cover very little
> > > >>> ground here.
> > > >>>
> > > >>>> Can we roll back 07eab0901ede and add quirks for the busted machines instead?
> > > >>
> > > >> I had an agent dig through all the reports linked in 07eab0901ede and
> > > >> drafted up what should be the remaining quirks for a revert.
> > > >>
> > > >> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/genoa-mess
> > > >>
> > > >> Bjorn, thoughts on this?  I'll send it out if that's the way we want
> > > >> to go (or Ilpo feel free to subsume into your series as it's only
> > > >> really exposed by your series at the moment)
> > > > 
> > > > I would LOVE it if we can use those patches because it's way less
> > > > magic than 07eab0901ede is.
> > > > 
> > > > But I'm frankly terrified to touch it because I'm skeptical that two
> > > > more quirks are enough.  I just expect that whatever strategy BIOS
> > > > uses to build these maps is likely to be used on many models.  I do
> > > > hate 07eab0901ede though, so I would love to see it gone.
> > > 
> > > It has been about 4 years since we came up with 07eab0901ede IIRC we
> > > had a huge email thread with a whole bunch of attempts at fixing
> > > the issue in a generic manner.
> > > 
> > > IIRC some of those attempts tried to identify the exact problematic
> > > issue the quirks try to fix where there is an EFI MMIO reservation
> > > covering the entire bridge window.
> > > 
> > > Maybe we can dig through the old thread and see if with the knowledge
> > > we have now one of the previous attempts of fixing it from the thread
> > > is better?
> > > 
> > > I agree that needing to go back to quirks is likely going to be painful
> > > and break a whole bunch of other systems. IIRC 07eab0901ede fixed
> > > a whole bunch of laptops having issues around the time not just
> > > the Clevo NL4XLU and Lenovo Yoga C940. But this info might be spread
> > > over various bugzilla entries, etc. + some models where likely never
> > > reported but just fixed in time for users to not report things.
> > > 
> > > I also wonder if given we only have this magic black-hole on geneo/zen4
> > > if it would not be better to go with Mario's original approach here ?
> > > Esp. since Mario's quirk is chipset based where as the other problems
> > > seem to be model/product based so that is 1 quirk vs many quirks.
> > 
> > Can we simply change the algo of allocating resources to follow what Windows
> > does?
> 
> I've no idea what it does.
> 
> You seem to simplify things to just being about direction of allocation 
> but there are other constraints, most importantly alignment ones.
> 
> There are many cases where there simply isn't any extra room to play with
> so the algorithm must produce as tight packing as possible.
> 
> The assignment step is greedy that could easily lead us into dead ends 
> where not all resources can be assigned because something was placed such 
> that it is on the way. This series of mine tries to make placement such 
> that it maximizes success possibility of subsequent assignments (leaving 
> the best free space candidate for future assignments). Side-effect of 
> these changes is that more allocations do happen at the tail (to maximize 
> the alignment order of the free space, that is usually larger at the left 
> edge/start of the window). So maybe you actually end up getting what you
> wish in many cases.
> 
> Retrying anything in controlled manner is also challenging. This might be 
> fixable on medium term by holding some setup structure across algorithm 
> "tries" but currently we hold nothing else than what's in the struct 
> resource and in/not-in-resource-tree information.
> 
> Changing anything in this area hasn't been easy at all because almost 
> everything seems to break something (in part it's my own bugs but there 
> are also many cases I just could not foresee nor encounter in my tests).
> 
> So I'm sorry don't think any large scale rewrite would be viable.

I understand. Thanks for providing the explanation for the reason behind
your series.

-- 
With Best Regards,
Andy Shevchenko


