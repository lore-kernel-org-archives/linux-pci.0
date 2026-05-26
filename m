Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E973B3C0E
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824591; cv=none; b=KP6t5ZZGdu7DiXWAZORh+6LJwYlanUpLae9W4XiM9/Fcz7EFxBt5pZCHpt/uJaAcuAX7jpE0fTPOWDG27XNjOD0nYmeMsesfiMDFY3ia1K8FxzmiCJe86wV/GpzBS93sKIqW+DuFxyvMmYTqNHbOoGl+4ej6qufXhwVWd/hgGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824591; c=relaxed/simple;
	bh=vUbl+l65vaCC+fQwq6eNcgFFZmtt5ylGpmr3NGrXO90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4Lpn14bcMl5WlXx9FcCoabN107TOmOX0oAhcfmxPtnTur3D6gUFjbDcRfv0llc6/UnTJdWByXlmtgMQakYnWUSba+Wy6q36iCMdBSoYZ9eyeaAC2Pt9suhKXC79NPTizpDT6Dy6tVIeaPm/JofgYjrCwYCk70D7DFZG06mIPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5V43k+p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5V43k+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779824589; x=1811360589;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vUbl+l65vaCC+fQwq6eNcgFFZmtt5ylGpmr3NGrXO90=;
  b=T5V43k+pnLHWRGPenT7fYsclBQ90KiwmSdmB6TWd3RqjOS6oa+Ono+rG
   b1LfhbHNnbyYK1XcE18LkUFHeyiReG9u0fC/bMLYlBgcMh0J0Co4cNHRk
   c1A3mURFJVMgVRpO/bnUJxJna9flIfWbd0EvGijd6tBeKSB0LlbZGxF8j
   6odYxWDZB/D3MqqfdMl5W5rSxdFjJokgi2JitkcNNBhqPBLGumtgcGdLb
   rHqmiUasEhKBkZ3TAjr44KAAitvReAbIZR5mgfCV94yBC/o7H8t+I3Wd4
   ZMsrvYZUMPdqPYFE+HqaBFgdvLbLRnUIEBTVzxH4/1BPEEs3qrh9uM7vl
   w==;
X-CSE-ConnectionGUID: zfd1d/f5R2qNoo/Yp8Oy9g==
X-CSE-MsgGUID: M4TNs8ACS0iTL8RRf8ALcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="83228435"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="83228435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 12:43:09 -0700
X-CSE-ConnectionGUID: si8NqsnERIi4TkKCwI7zTg==
X-CSE-MsgGUID: SuT22OihRx2sjXz7Tuxsrw==
X-ExtLoop1: 1
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 12:43:08 -0700
Date: Tue, 26 May 2026 12:43:07 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Message-ID: <20260526124307.00005a70@linux.intel.com>
In-Reply-To: <20260522154216.AA0D61F000E9@smtp.kernel.org>
References: <20260522150829.5246-1-nirmal.patel@linux.intel.com>
	<20260522154216.AA0D61F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 15:42:16 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider:
> 
> New issues:
> - [High] The driver unconditionally reads from fixed offsets in BAR4
> without verifying that the BAR size is sufficiently large.
> - [High] The PCI bus resource `.end` is unconditionally hardcoded to
> `0xff`, breaking legacy devices with smaller configuration BARs.
> 
> Pre-existing issues:
> - [High] Allocated IRQ vectors are leaked in multiple error paths and
> during device teardown.
> - [High] Per-CPU memory allocated for SRCU structures is leaked on
> error paths.
> - [High] SRCU lock structures are destroyed before the IRQ handlers
> are unregistered, allowing a use-after-free.
> - [High] Subtracting a fixed offset from the resource bounds of
> MEMBAR2 without verifying the actual BAR length causes an integer
> underflow. --
> 
Pre-existing issues are not in scope of the feature in this patch
series.

> commit 0653c66e9c93e9c62213a329c19bf93e4499969f
> Author: Nirmal Patel <nirmal.patel@linux.intel.com>
> Subject: PCI: vmd: Add feature to scan BIOS enumerated devices.
> 
> This commit introduces the VMD_FEAT_USE_BIOS_INFO feature flag for
> device 0x28c1. It parses configuration parameters, bus start ranges,
> and shadow registers directly from the BIOS-populated BAR4/BAR5 MMIO
> space rather than enumerating the tree dynamically.
> 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index d4ae250d4bc6d..7c90243b5ff0c
> > 100644 --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c  
> [ ... ]
> > @@ -661,6 +686,46 @@ static int vmd_get_bus_number_start(struct
> > vmd_dev *vmd) return 0;
> >  }
> >  
> > +static int vmd_get_bus_info_from_bar4(struct vmd_dev *vmd,
> > +				       resource_size_t *offset1,
> > +				       resource_size_t *offset2)
> > +{
> > +	u64 phys1, phys2, bar4_2840;
> > +	void __iomem *bar4;
> > +	u32 base_id;
> > +	u8 base_bus;
> > +
> > +
> > +	bar4 = pci_ioremap_bar(vmd->dev, 4);
> > +	if (!bar4)
> > +		return -ENOMEM;
> > +
> > +	/* Read shadow registers for MEMBAR1 and MEMBAR2 physical
> > addresses. */
> > +	phys1 = readq(bar4 + SHADOW_MEMBAR1_28C1);  
> 
> [Severity: High]
> Does this code read out-of-bounds if the hardware presents a smaller
> BAR4?
> 
> pci_ioremap_bar() maps the available resource, but there doesn't
> appear to be a check verifying that the BAR length is at least large
> enough to cover the fixed offsets being read, such as 0x2840
> (BASE_ID_REG_28C1).
> 
> Could a misconfigured or malicious device trigger an out-of-bounds
> MMIO read here?
I dont think so. vmd_get_bus_info_from_bar4 gets called for only device
ID specific flag  VMD_FEAT_USE_BIOS_INFO. BASE_ID_REG_28C is set to
0x2840 which is just 10KB of space and is much lesser than standard
membar2 resource size 2MB. Besides we are doing the same thing in
vmd_get_phys_offsets.
> 
> > +	phys2 = readq(bar4 + SHADOW_MEMBAR2_28C1);  
> [ ... ]
> > @@ -711,6 +776,53 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
> >  	return 0;
> >  }
> >  
> > +static int vmd_prepare_offsets_and_bus(struct vmd_dev *vmd,
> > +					unsigned long features,
> > +					resource_size_t
> > *membar2_offset,
> > +					resource_size_t *offset1,
> > +					resource_size_t *offset2)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * Shadow registers may exist in certain VMD device ids
> > which allow
> > +	 * guests to correctly assign host physical addresses to
> > the root ports
> > +	 * and child devices. These registers will either return
> > the host value
> > +	 * or 0, depending on an enable bit in the VMD device.
> > +	 */
> > +	/*
> > +	 * For certain VMD devices (i.e. 0x28C1), BIOS places
> > device info
> > +	 * in BAR4 shadow registers to determine the base bus
> > number and memory
> > +	 * offsets.
> > +	 */
> > +	if (features & VMD_FEAT_USE_BIOS_INFO) {
> > +		*membar2_offset = MEMBAR2_OFFSET_28C1;  
> 
> [Severity: High]
> This is a pre-existing issue, but can setting this offset cause an
> integer underflow later?
> 
> In vmd_enable_domain(), the resource start is calculated as:
> 
> 	vmd->resources[2] = (struct resource) {
> 		.name  = "VMD MEMBAR2",
> 		.start = res->start + membar2_offset,
> 		.end   = res->end,
> 		...
> 	};
> 
> If the physical MEMBAR2 length provided by the hardware is smaller
> than membar2_offset, start becomes greater than end, which could cause
> resource_size() to underflow and yield a massively inflated memory
> window.
membar2_offset is 0x2000 and it is required to leave such space to
successfully map other VMD hardware registers including MSI-X. So
resource_size() will never be less than 0x2000 for any vmd device since
the minimum possible membar2 size is 2MB set in BIOS.
> 
> > +		ret = vmd_get_bus_info_from_bar4(vmd, offset1,
> > offset2);
> > +		if (ret)
> > +			return ret;
> > +	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {  
> [ ... ]
> > @@ -784,38 +896,16 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features) struct pci_dev *dev;
> >  	int ret;
> >  
> > -	/*
> > -	 * Shadow registers may exist in certain VMD device ids
> > which allow  
> [ ... ]
> > -	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
> > -		ret = vmd_get_bus_number_start(vmd);
> > -		if (ret)
> > -			return ret;
> > -	}
> > +	ret = vmd_prepare_offsets_and_bus(vmd, features,
> > &membar2_offset,
> > +					  &offset[0], &offset[1]);
> > +	if (ret)
> > +		return ret;
> >  
> >  	res = &vmd->dev->resource[VMD_CFGBAR];
> >  	vmd->resources[0] = (struct resource) {
> >  		.name  = "VMD CFGBAR",
> >  		.start = vmd->busn_start,
> > -		.end   = vmd->busn_start + (resource_size(res) >>
> > 20) - 1,
> > +		.end   = 0xff,  
> 
> [Severity: High]
> Does unconditionally setting the end to 0xff cause a regression for
> legacy VMD devices with smaller configuration BARs?
> 
> Older devices on client platforms might have smaller CFGBARs.
> Claiming buses up to 255 might cause the PCI subsystem to erroneously
> assign bus numbers that fall outside the hardware's actual ECAM
> capabilities.
If i keep existing implementation (like v1), the .end value can go
out-of-bound (i.e. 478).
Keeping just .end = (resource_size(res) >> 20) - 1 will result in a
crash when busn_start is a high value like 128 and .end is set to 32.
So like other places in pci code-base (i.e. pci/probe.c), it is better
to hard code it to 0xff.
> 
> >  		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> >  	};
> >  
> > @@ -868,19 +958,21 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features)
> >  	 * acceptable because the guest is usually CPU-limited and
> > MSI
> >  	 * remapping doesn't become a performance bottleneck.
> >  	 */
> > -	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> > -	    offset[0] || offset[1]) {
> > -		ret = vmd_alloc_irqs(vmd);
> > -		if (ret)
> > -			return ret;
> > +	if (!(features & VMD_FEAT_USE_BIOS_INFO)) {
> > +		if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> > +		    offset[0] || offset[1]) {
> > +			ret = vmd_alloc_irqs(vmd);
> > +			if (ret)
> > +				return ret;
> >  
> > -		vmd_set_msi_remapping(vmd, true);
> > +			vmd_set_msi_remapping(vmd, true);
> >  
> > -		ret = vmd_create_irq_domain(vmd);
> > -		if (ret)
> > -			return ret;
> > +			ret = vmd_create_irq_domain(vmd);
> > +			if (ret)
> > +				return ret;  
> 
> [Severity: High]
> This is a pre-existing issue, but are IRQ vectors leaked when errors
> occur here?
No changes are being done here as part of this feature patch series.
The existing issue needs to be reproduced and if needed, then to be
fixed in separate patches.
> 
> The PCI subsystem guidelines mandate calling pci_free_irq_vectors()
> in error paths after a successful pci_alloc_irq_vectors(). If
> vmd_create_irq_domain() fails, we return directly without freeing the
> vectors allocated in vmd_alloc_irqs(). This same cleanup omission
> appears to exist in vmd_remove() as well, potentially leading to
> system IRQ capacity exhaustion.
> 
> Additionally, if vmd_alloc_irqs() fails midway through
> devm_request_irq(), does it return without cleaning up the
> successfully initialized SRCU structures from previous loop
> iterations? The per-CPU memory allocated by init_srcu_struct() might
> be leaked.
> 
> [Severity: High]
> Also a pre-existing issue, but does using devm_request_irq() for the
> handlers cause a use-after-free during device teardown?
The issue has not be reported or seen in any vmd generations.
No changes are being done here as part of this feature patch series.
The existing issue needs to be reproduced and if needed, then to be
fixed in separate patches.
> 
> In vmd_remove(), the driver calls vmd_cleanup_srcu() which destroys
> the SRCU structures. However, since the IRQs are managed by devres,
> they aren't deregistered until after vmd_remove() returns.
> 
> If an interrupt fires in this window, vmd_irq() would call
> srcu_read_lock() on an already-destroyed SRCU structure.
> 
> > +		} else {
> > +			vmd_set_msi_remapping(vmd, false);
> > +		}
> >  	}  
> 

