Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB5450917;
	Thu, 24 Sep 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281261; cv=none; b=YHzfzR0kGyJ8/Me12qupIbGtaomYCGpd8Cb0I9E2zuIhdkIsfmjbVSpJwz18LrbNt5FY1S/Cq065dMexbFjmJ+DdOc5HGrAW/xtlecYghycU7pOmQrcEYMEdukQJkCLzwDo66aHA/I96qGQ8Go3p1arEmL6lfN4S8qD/C/oXVLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281261; c=relaxed/simple;
	bh=l2vtykl3aoKE+pW5zbclqLHP7ZLcrfk00vV5h006+cY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K86NAW5NuA23GUvGrmtNdXVZNYPvHw1aoMoPvz/q/Gtq4Uvcdm/lKhQRrkebe4TsOCXSqGgA/Q27zfGyHvE6i51A7ZJlrYyUIxe9ITzQ/u50uroeA7NZpfrAt+S1hIRLBdKF+0ssKvdpN7/ytUby6qRVEj9zBX0g+78r01pjzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuzOAFvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuzOAFvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D35C1F00893;
	Thu, 24 Sep 2026 20:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790281258;
	bh=yNBfd0VIQTvDvHVYOxbz0XHLadGwVlUtcbPe8QuCPrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fuzOAFvq+PtxAppUyNp/Es6gSCaUeyyCZ+KGHxcMOsDTX1flrvVSpJEN4pSjRaXNJ
	 mqPMC06UYVEwlGMgFa4wNhlGlFasDozTys2J4P+kIv7zEOaGJ+jzHg9aeIVt+Sa+FS
	 fq6lS8KALmBBqsqLtDimRW3giD9J+G+Fq+of0WHlgveifOIKFe0sO4bXeS397QwRMl
	 uRNWF6Vk7ps68cY/jUDFhSyXODWw0sTXd33DM0UUeFYaKX4O0TvrGyRkxK5eZmeyWF
	 Q9hlGxLfkju33jpLUZj3P7wcpiE3XKH09FjrP9Ss/1T2Lklwxr6Ud86P57m8Q3mwQl
	 nEgr98M2bOlyg==
Date: Thu, 24 Sep 2026 15:20:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/5] PCI/quirks: Avoid certain BAR 0 address with igb
Message-ID: <20260924202056.GA2001522@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923131757.7792-6-ilpo.jarvinen@linux.intel.com>

[+cc Rafael, ACPI resource question]

On Wed, Sep 23, 2026 at 04:17:55PM +0300, Ilpo Järvinen wrote:
> While testing the resource placement changes, my tests hit a case where
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
> Apparently, the igb driver bails out, after its initial sanity check
> detects an unexpected ~0 read. Hacking around the sanity check just
> results in more failures down the road so the sanity check itself is not
> the cause for the failure.
> 
> The resource placement looks valid so the actual placement patches seem
> to work normally.
> 
> All other possible 1M address I could test (with a hack patch) did work.

Super weird.  Is it possible there's some other device there?  It's
conceivable ACPI might have a _CRS method describing it.  I think
there are ACPI devices for which we don't reserve space mentioned in
_CRS.  Maybe Rafael knows a debug option to log everything in _CRS?

Does igb seem sensitive about this exact address on a variety of
machines?  If so I would expect some kind of igb hardware erratum for
it.

Do other non-igb devices work at that address?

> Add quirk to reshuffle igb resources, use BAR 3 to block the problematic
> address.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> I know this is ugly and I don't like it either but do not know better
> way to avoid the regression.
> 
> I've tried with iommu=off and that did not resolve the issue.
> 
> I also managed to prove igb works with the same resource layout in
> another system. So identifying the case should probably be tightened
> by matching with more devices than the one used by igb. This is open
> to discussion.

I guess this answers one of my questions above.

> ---
>  drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21f..e6f3e2ab1fd4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6288,6 +6288,62 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
>  
> +/*
> + * The igb driver probe (due to reads returning ~0 unexpected) when BAR 0
> + * appears at 0x9c000000. The cause is unknown.

I suppose this is missing "fails"?  "igb driver probe fails"?

> + * Use BAR 3 to block 0x9c000000 address.
> + */
> +static void bar0_address_breakage(struct pci_dev *dev)
> +{
> +	struct resource *bar0 = pci_resource_n(dev, 0);
> +	struct resource *bar3 = pci_resource_n(dev, 3);
> +	resource_size_t broken_addr = 0x9c000000;
> +	struct resource *res;
> +	int i, ret;
> +
> +	if (bar0->start != broken_addr)
> +		return;
> +
> +	/*
> +	 * HW BAR sizes seems to vary. Exclude non-1M BAR 0 case and
> +	 * sanity check BAR 0 & 3 before attempting this quirk.
> +	 */
> +	if (resource_type(bar0) != IORESOURCE_MEM ||
> +	    resource_size(bar0) != SZ_1M ||
> +	    resource_type(bar3) != IORESOURCE_MEM)
> +		return;
> +
> +	pci_info(dev, "%pR: relocating BAR\n", bar0);
> +
> +	pci_dev_for_each_resource(dev, res, i) {
> +		if (!resource_assigned(res) ||
> +		    resource_type(res) != IORESOURCE_MEM)
> +			continue;
> +
> +		pci_release_resource(dev, i);
> +	}
> +
> +	resource_set_range(bar3, broken_addr, resource_size(bar3));
> +	bar3->flags &= ~IORESOURCE_UNSET;
> +	pci_claim_resource(dev, 3);
> +	if (!resource_assigned(bar3)) {
> +		bar3->flags |= IORESOURCE_UNSET;
> +		pci_warn(dev, "resource relocation failed\n");
> +	}
> +
> +	pci_dev_for_each_resource(dev, res, i) {
> +		if (resource_assigned(res) ||
> +		    resource_type(res) != IORESOURCE_MEM)
> +			continue;
> +
> +		ret = pci_assign_resource(dev, i);
> +		if (ret)
> +			pci_warn(dev, "resource relocation failed\n");
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1533, bar0_address_breakage);
> +
>  #ifdef CONFIG_PCIEASPM
>  /*
>   * Several Intel DG2 graphics devices advertise that they can only tolerate
> -- 
> 2.47.3
> 
