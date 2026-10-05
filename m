Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28036F429;
	Mon,  5 Oct 2026 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226061; cv=none; b=F2sMM4TD6P62toY27rYcNW/TE278rf+TBNAvaNwZ5PQlpNe9bKQXYPcoTRIrgOF4IBZbInZwrgf4yt2jGgeRmepCH6iWLLfLOoifMR9yVhiokZUnDdVKGedMWfvajBkLVAK/tsOiwMIKOsiWlDU7hXU5BDiXuoFK/PxNHQ0Yy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226061; c=relaxed/simple;
	bh=JUpDVe4jtYSwy3TAdZ9ZBsId4WkpsPKdPqIPOquQ7bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Fx5sPI2M4dS7FdG81fcojpPSI/83Dp/+tJtoyUrVH5dC9c2V4n+7pGJ3KQhOO/d6RUd6jhNT0AGnCTCRoFul3GsiC9AxnoGmDySO+Xc15ww/yK6mXtptlJG8DHPAq3TKnHrazHDRzhFcBqph2kWG2oX+YC+N6u+V10BpWrYhXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBh3yv0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBh3yv0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46DF1F00893;
	Mon,  5 Oct 2026 18:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791226059;
	bh=LY9clA3d6BIa1hGpy8fB/s486ZnuYpX4F4oJ47Qj8+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=HBh3yv0Ffq5r9iIfRZ3+FcKXuNRPzbKN/OUiWxHz97tKYSeG2UHsZTxbwJKICo6/r
	 aVhMT6pEpkv7ttH/4KLJ8F9JAXIvkZbWDowgY8pHIJWgvZYtjhTuwCoH5SW9lzQvw3
	 HifRIeMO+L25UraAqZVjpHtpAAvbYUrpg1+lDh5AflcDsBjwd0HrKl4pwepZn2VF3q
	 kn6bKhWr3wSq97WDZXsygW0yHKFbl9wtz++895Q3uUMC6k1GZ4payTGmL5OmuiCN0V
	 El18u1e9MEDcsNWbg2pG0qOyFpnfzlnsN0Pr4UTRSA++dvcUySN4ogpVe7zeR9iwVm
	 xpvot7WFDw/0A==
Date: Mon, 5 Oct 2026 13:47:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 7/7] PCI/quirks: Avoid certain address on Genoa systems
Message-ID: <20261005184738.GA585498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002113319.6652-8-ilpo.jarvinen@linux.intel.com>

[+cc Boris]

On Fri, Oct 02, 2026 at 02:33:15PM +0300, Ilpo Järvinen wrote:
> While testing the resource placement changes, tests hit a case where
> igb fails to probe when BAR 0 is placed at 0x9c000000:
> 
>    90000000-9cffffff : PCI Bus 0000:a0
>   -  90000000-902fffff : PCI Bus 0000:a1
>   -    90000000-900fffff : 0000:a1:00.0
>   -      90000000-900fffff : igb
>   -    90100000-901fffff : 0000:a1:00.0
>   -    90200000-90203fff : 0000:a1:00.0
>   -      90200000-90203fff : igb
>   +  9be00000-9c0fffff : PCI Bus 0000:a1
>   +    9be00000-9befffff : 0000:a1:00.0
>   +    9bf00000-9bf03fff : 0000:a1:00.0
>   +    9c000000-9c0fffff : 0000:a1:00.0
>      9c100000-9c17ffff : amd_iommu
>      9c180000-9c1803ff : IOAPIC 8
> 
>   -       Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=1M]
>   -       Region 3: Memory at 90200000 (32-bit, non-prefetchable) [size=16K]
>   -       Expansion ROM at 90100000 [disabled] [size=1M]
>   +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable) [size=1M]
>   +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable) [size=16K]
>   +       Expansion ROM at 9be00000 [disabled] [size=1M]
> 
> igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> ------------[ cut here ]------------
> igb: Failed to read reg 0x18!
> WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> ...
>  igb_get_invariants_82575+0xff/0xf00 [igb]
>  igb_probe+0x3c8/0x1190 [igb]
>  local_pci_probe+0x3b/0x80
> 
> It turns out there is a 64kB iomem black hole at 9c000000 that returns
> ~0 and this is where igb's BAR 0 resides. If another BAR of the same
> card is placed into that address, it is similarly black holed.
> 
> Mark the problematic 64kB range reserved using a quirk bound to the
> bridge found in the problematic system.

I think this is my fault, or at least it looks like it's related to
07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").

This platform describes the [0x9c000000-0x9cffffff] range as
E820_TYPE_RESERVED in the E820 table and as EFI_MEMORY_MAPPED_IO in
the EFI memory map (from the dmesg at
https://bugzilla.kernel.org/show_bug.cgi?id=222074):

  BIOS-e820: [gap 0x0000000090000000-0x000000009bffffff]
  BIOS-e820: [mem 0x000000009c000000-0x000000009cffffff]  device reserved
  efi: Remove mem49: MMIO range=[0x9c000000-0x9cffffff] (16MB) from e820 map
  e820: remove [mem 0x9c000000-0x9cffffff] device reserved
  pci_bus 0000:a0: root bus resource [mem 0x90000000-0x9cffffff window]

/proc/iomem:

  90000000-9cffffff : PCI Bus 0000:a0
    9c100000-9c17ffff : amd_iommu
    9c180000-9c1803ff : IOAPIC 8

I haven't worked out all the details, but I bet that if 07eab0901ede
had not removed [0x9c000000-0x9cffffff] from the E820 table, it would
show up in /proc/iomem as "Reserved" and would not be available for
use by a BAR.  amd_iommu and IOAPIC 8 occupy some of that space, and I
suspect there are other devices in there that we don't know about.

It looks like the last 16MB of every 32-bit PCI host bridge window is
EFI_MEMORY_MAPPED_IO, so if you can move the igb device to a different
host bridge, I suspect the same problem would happen if you put the
BAR at 16MB below the end.

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222074
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> Mario suggested the quirk to be based on the bridge instead of the 
> endpoint device which certainly looks better and cleaner than the
> approach used in v1.
> 
> The current plan is to try a different card in the same slot but it is
> a bit hard for me to predictable on what timescale that can be done.
> 
> ---
>  drivers/pci/quirks.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21f..5483b47d8d54 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6288,6 +6288,41 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
>  
> +/*
> + * TODO: Remove when/if root cause is found.
> + *
> + * Genoa appears to have a 64kB iomem black hole starting at 0x9c000000
> + * address for which all reads return ~0 blocking an overlapping BAR from
> + * working.
> + *
> + * Work around the problem by reserving the space prior to making any iomem
> + * allocations that could overlap with the black hole.
> + */
> +static struct resource black_hole_res = DEFINE_RES_MEM_NAMED(0x9c000000, SZ_64K,
> +							     "reserved");
> +
> +static void genoa_iomem_black_hole(struct pci_dev *dev)
> +{
> +	struct resource *r;
> +
> +	pci_bus_for_each_resource(dev->bus, r) {
> +		if (!r || !r->flags || !resource_assigned(r))
> +			continue;
> +
> +		if (!__resource_contains_unbound(r, &black_hole_res))
> +			continue;
> +
> +		if (resource_assigned(&black_hole_res))
> +			pci_dbg(dev, "iomem black hole workaround already applied\n");
> +		else if (!insert_resource(r, &black_hole_res))
> +			pci_info(dev, "iomem black hole workaround enabled\n");
> +		else
> +			pci_dbg(dev, "iomem black hole workaround add failed\n");
> +		return;
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab, genoa_iomem_black_hole);
> +
>  #ifdef CONFIG_PCIEASPM
>  /*
>   * Several Intel DG2 graphics devices advertise that they can only tolerate
> -- 
> 2.47.3
> 
