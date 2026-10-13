Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B6552954;
	Tue, 13 Oct 2026 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931214; cv=none; b=dSHIcKPiANp8ohSxLp/yXzObyq++8qzZ/PNLo92mB/mKM9caxNNl9VljzVIL1eh27T+Dz60Fw3TQPH+hKyjACIppGkVAYYKXevJM+NGJyebObW2tvBX8GbexXz1NXH9TXXvGTpjstRS6EOtZEgEvQtzjDfQIIfeo26EHlJ/3dfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931214; c=relaxed/simple;
	bh=c3bclkdaYAYkik2XSAJu9dks+ranFhZpfgiw0csncl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E0Smq0dsO1Vq8xEipzsTzqUHKVBZyloTZuQqaXzdVx24/CQ7+Qna3B0zYa4FNSaly/atGtYTk2aeDaMpSaeloSzE0CRjP/ipSYngQrZPYxgGN2jc9eJ8M1w7Ni59LEaDc7mok2inPVo4MzMdiagCaR4GbFYaIICBk/L5Dm/OL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXDw300I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXDw300I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0AB1F000FF;
	Tue, 13 Oct 2026 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931212;
	bh=tLbx/Zh/eFasPZiwnMW0AQj+NwF4tqUAGt+hA0quLV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=gXDw300IKDgYVOZWsBn+PpBQRDOWf4dQ7NdhtIVJ++NPMzjDG9wMNzxcSsSKMQAqj
	 NAM/M6zc/+S592Yxpo+cu5duwReyGWQ+3IU/hykAzqRloudPov0T7q1SvtyQjfMa+7
	 oF8Y29gc5uyIoQrYMEPNJZB/dbwLvfxAEqNuyBnKnawUJjgcliMVG9nRr6EE4NovpI
	 AoUnPTmkxmfILoFvW+sSjM2VLI9qMsbIiTfYSmH0iomw0Jh5NKGeWze+XxsDR1zFF8
	 Qw5Tuk82BAKTKs/cUTB6aP+Qrj5b+0UEWkWkeTdANDWW4ElcMCvBXsuvC7hQ4nbeHa
	 +ZlqAKcX0cgZQ==
Date: Tue, 13 Oct 2026 17:40:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
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
	Hans de Goede <hansg@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Message-ID: <20261013224010.GA1589480@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81b4f4bf-b721-4b5b-8ddf-d040865f02b2@amd.com>

[+cc Hans, Kai-Heng, Andy, linux-acpi]

On Tue, Oct 13, 2026 at 01:59:23PM -0500, Mario Limonciello wrote:
> On 10/13/26 12:26, Ilpo Järvinen wrote:
> > On Tue, 13 Oct 2026, Mario Limonciello wrote:
> > > On 10/13/26 12:00, Mario Limonciello wrote:
> > > > On 10/13/26 08:09, Ilpo Järvinen wrote:
> > > > > While testing the resource placement changes, tests hit a case where
> > > > > igb fails to probe when BAR 0 is placed at 0x9c000000:
> > > > > 
> > > > >      90000000-9cffffff : PCI Bus 0000:a0
> > > > >     -  90000000-902fffff : PCI Bus 0000:a1
> > > > >     -    90000000-900fffff : 0000:a1:00.0
> > > > >     -      90000000-900fffff : igb
> > > > >     -    90100000-901fffff : 0000:a1:00.0
> > > > >     -    90200000-90203fff : 0000:a1:00.0
> > > > >     -      90200000-90203fff : igb
> > > > >     +  9be00000-9c0fffff : PCI Bus 0000:a1
> > > > >     +    9be00000-9befffff : 0000:a1:00.0
> > > > >     +    9bf00000-9bf03fff : 0000:a1:00.0
> > > > >     +    9c000000-9c0fffff : 0000:a1:00.0
> > > > >        9c100000-9c17ffff : amd_iommu
> > > > >        9c180000-9c1803ff : IOAPIC 8
> > > > > 
> > > > >     -       Region 0: Memory at 90000000 (32-bit, non-prefetchable)
> > > > > [size=1M]
> > > > >     -       Region 3: Memory at 90200000 (32-bit, non-prefetchable)
> > > > > [size=16K]
> > > > >     -       Expansion ROM at 90100000 [disabled] [size=1M]
> > > > >     +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable)
> > > > > [size=1M]
> > > > >     +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable)
> > > > > [size=16K]
> > > > >     +       Expansion ROM at 9be00000 [disabled] [size=1M]
> > > > > 
> > > > > igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> > > > > ------------[ cut here ]------------
> > > > > igb: Failed to read reg 0x18!
> > > > > WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at
> > > > > igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> > > > > ...
> > > > >    igb_get_invariants_82575+0xff/0xf00 [igb]
> > > > >    igb_probe+0x3c8/0x1190 [igb]
> > > > >    local_pci_probe+0x3b/0x80
> > > > > 
> > > > > It turns out there is a 64kB iomem black hole at 9c000000 that returns
> > > > > ~0 and this is where igb's BAR 0 resides. If another BAR of the same
> > > > > card is placed into that address, it is similarly black holed.
> > > > > 
> > > > > Mark the problematic 64kB range reserved using a quirk bound to the
> > > > > bridge found in the problematic system.
> > > > > 
> > > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222074
> > > > > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > ---
> > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > 
> > > > > As an alternative to this, I've also tested reverting the commit
> > > > > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") and
> > > > > that also resolves the issue by retaining "9c000000-9cffffff : Reserved"
> > > > > entry in the resource tree.
> > > > > 
> > > > > ---
> > > > >    arch/x86/pci/fixup.c | 36 ++++++++++++++++++++++++++++++++++++
> > > > >    1 file changed, 36 insertions(+)
> > > > > 
> > > > > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > > > > index b301c6c8df75..cc463bf492b6 100644
> > > > > --- a/arch/x86/pci/fixup.c
> > > > > +++ b/arch/x86/pci/fixup.c
> > > > > @@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1571,
> > > > > pci_amd_enable_64bit_bar);
> > > > >    DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1,
> > > > > pci_amd_enable_64bit_bar);
> > > > >    DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601,
> > > > > pci_amd_enable_64bit_bar);
> > > > > +/*
> > > > > + * TODO: Remove when/if root cause is found.
> > > > > + *
> > > > > + * Genoa appears to have a 64kB iomem black hole starting at 0x9c000000
> > > > > + * address for which all reads return ~0 blocking an overlapping BAR from
> > > > > + * working.
> > > > > + *
> > > > > + * Work around the problem by reserving the space prior to making any
> > > > > iomem
> > > > > + * allocations that could overlap with the black hole.
> > > > > + */
> > > > > +static struct resource genoa_black_hole =
> > > > > DEFINE_RES_MEM_NAMED(0x9c000000,
> > > > > +                                   SZ_64K,
> > > > > +                                   "reserved");
> > > > > +
> > > > > +static void genoa_iomem_black_hole(struct pci_dev *dev)
> > > > > +{
> > > > > +    struct resource *r;
> > > > > +
> > > > > +    pci_bus_for_each_resource(dev->bus, r) {
> > > > > +        if (!r || !r->flags || !resource_assigned(r))
> > > > > +            continue;
> > > > > +
> > > > > +        if (!__resource_contains_unbound(r, &genoa_black_hole))
> > > > > +            continue;
> > > > > +
> > > > > +        if (resource_assigned(&genoa_black_hole))
> > > > > +            pci_dbg(dev, "iomem black hole workaround already
> > > > > applied\n");
> > > > > +        else if (!insert_resource(r, &genoa_black_hole))
> > > > > +            pci_info(dev, "iomem black hole workaround enabled\n");
> > > > > +        else
> > > > > +            pci_dbg(dev, "iomem black hole workaround add failed\n");
> > > > > +        return;
> > > > > +    }
> > > > > +}
> > > > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab,
> > > > > genoa_iomem_black_hole);
> > > > > +
> > > > >    #define RS690_LOWER_TOP_OF_DRAM2    0x30
> > > > >    #define RS690_LOWER_TOP_OF_DRAM2_VALID    0x1
> > > > >    #define RS690_UPPER_TOP_OF_DRAM2    0x31
> > > > 
> > > > I guess it's good we know the root cause is 07eab0901ede. If we're going
> > > > down the path of making holes in that we may well put the hole in
> > > > efi_remove_e820_mmio() like this (attached).
> > > 
> > > I don't really like that though.  If Genoa is affected I would expect plenty
> > > of other machines are too they just haven't been found yet.
> > 
> > That's what I'm worried as well. My own testing can only cover very little
> > ground here.
> > 
> > > Can we roll back 07eab0901ede and add quirks for the busted machines instead?
> 
> I had an agent dig through all the reports linked in 07eab0901ede and
> drafted up what should be the remaining quirks for a revert.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/genoa-mess
> 
> Bjorn, thoughts on this?  I'll send it out if that's the way we want
> to go (or Ilpo feel free to subsume into your series as it's only
> really exposed by your series at the moment)

I would LOVE it if we can use those patches because it's way less
magic than 07eab0901ede is.

But I'm frankly terrified to touch it because I'm skeptical that two
more quirks are enough.  I just expect that whatever strategy BIOS
uses to build these maps is likely to be used on many models.  I do
hate 07eab0901ede though, so I would love to see it gone.

I do think the description [1] is overly specific because AFAIK
there's nothing that connects this to AMD EPYC 9354 or igb other than
the fact that it was seen there.  It could happen to any PCI device on
any system with similar memory maps.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?h=superm1/genoa-mess&id=0a49c704477153d6597d34b3c6e3141007ff058c
