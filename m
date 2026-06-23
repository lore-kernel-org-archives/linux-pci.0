Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12151DDC3F
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174124; cv=none; b=hqTaF97ASWW32SnoQSgydealUkxL7oL8wbsC3V33sIC4MiUFm0JR40CNoHQyeQ8gUZyc4rHqPgtS/blLkUE/Oh8/i5sXsO2nBn2Gl5ldp4PV4yHolkX8TJI/GJzZrQtXSknuPqdHJOdPuDzZTR6GcUNO2SjA09N9E9+eHW0Ml+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174124; c=relaxed/simple;
	bh=RIq0QbN/T4HGXujH3MNJwAZ4U8f43QtGckPLsTfOJ70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0r95dQQIyqnIn7HTK9ox/LODl/Ynjbi+1qMadq5PMQlAnJOObg+dzPYAqrF98JUtzwTLSJu0FXVLtnE0kJipA2ZkmX2g4jKoqWGIFk7QrzRmblSlBh1MQX1KMsTgWXK0I2asTptOXRGVFfHAQ29RxNW68woTxzVrQESXwPrNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bx5R+9dh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bx5R+9dh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782174121; x=1813710121;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RIq0QbN/T4HGXujH3MNJwAZ4U8f43QtGckPLsTfOJ70=;
  b=bx5R+9dhlqvzYYHO1bfpZ3F3pA3K2IeEE1Kl9B0bv7UhnO/W8b0flNc2
   jakYHYVDyzd1oTPfGkUQKapXO0vwG+vjJ1Y3sPZRvI+H77ijbD+/gIBFN
   Ds5csKjAYHRPI/oUiU4KCYH3G5HsqmdxK6eJvb2tMxxgBYrmC+FucA5Rh
   K5A4LRumqDb9aqgNhOK2v7dhKO+ZqZrsygCvnPG4PdSFVJP5dlmI26QAS
   DHMetnToOMzgmqyto0ia9DsQxtg1BRviK/mQ4apNSOjwHOowG3InC13kF
   fFD8Vm2rsilQHnhXGR0vK9vSTrHUJc2JSuOE2Yf9LYwJz9WujKoB4zYFF
   w==;
X-CSE-ConnectionGUID: EE1np72QSo+Aoi+/mM3GbA==
X-CSE-MsgGUID: kwVOFUDmSZa2tcSGxwougQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="83026790"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="83026790"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 17:22:01 -0700
X-CSE-ConnectionGUID: iKYGxe/ZQbe4HbImr6oMcg==
X-CSE-MsgGUID: U/W/gLEvTw+vZk5zLzfQgg==
X-ExtLoop1: 1
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 17:22:01 -0700
Date: Mon, 22 Jun 2026 17:21:59 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Message-ID: <20260622172159.0000402e@linux.intel.com>
In-Reply-To: <20260622155632.462341F00A3A@smtp.kernel.org>
References: <20260622154325.119809-1-nirmal.patel@linux.intel.com>
	<20260622155632.462341F00A3A@smtp.kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 15:56:31 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> - [Critical] vmd_remove_irq_domain() returns early for devices with
> VMD_FEAT_USE_BIOS_INFO, permanently leaking the IRQ domain and its
> fwnode, and causing an exploitable Use-After-Free.
> - [High] vmd_domain_reset() accesses incorrect ECAM offsets when
> VMD_FEAT_USE_BIOS_INFO is set, failing to reset actual VMD bridges
> and corrupting unrelated MMIO configuration space.
> - [Medium] The new `vmd_get_bus_info_from_bar4()` function accesses
> MMIO regions in BAR4 at hardcoded offsets without validating that the
> mapped BAR is sufficiently large. --
> 
> commit 371d26de7e81b3dcfea77481a03dd53acb14c51c
> Author: Nirmal Patel <nirmal.patel@linux.intel.com>
> 
> PCI: vmd: Add feature to scan BIOS enumerated devices.
> 
> Newer VMD devices with ID 0x28c1 use BIOS enumeration for the device
> tree. This commit updates the VMD driver to read bus hide ranges and
> shadow registers from VMD BAR4 to perform bus scans for these devices.
> 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index d4ae250d4bc6d..a4e03f10a54d6
> > 100644 --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c  
> 
> [ ... ]
> 
> > @@ -374,6 +393,9 @@ static void vmd_set_msi_remapping(struct
> > vmd_dev *vmd, bool enable) 
> >  static void vmd_remove_irq_domain(struct vmd_dev *vmd)
> >  {
> > +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> > +		return;
> > +  
> 
> [Severity: Critical]
> Does this early return bypass irq_domain_remove() and
> irq_domain_free_fwnode(), permanently leaking the IRQ domain?
> 
> In vmd_enable_domain(), vmd_create_irq_domain() is successfully called
> for these devices because VMD_FEAT_CAN_BYPASS_MSI_REMAP is not set.
> 
> If the IRQ domain remains globally registered, could it cause a
> use-after-free when its struct vmd_dev host_data pointer is
> automatically freed by devres during device removal?
Let me fix it.
> 
> >  	/*
> >  	 * Some production BIOS won't enable remapping between
> > soft reboots.
> >  	 * Ensure remapping is restored before unloading the
> > driver.  
> 
> [ ... ]
> 
> > @@ -393,7 +415,12 @@ static void __iomem *vmd_cfg_addr(struct
> > vmd_dev *vmd, struct pci_bus *bus, unsigned int devfn, int reg, int
> > len) {
> >  	unsigned int busnr_ecam = bus->number - vmd->busn_start;
> > -	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> > +	u32 offset;
> > +
> > +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> > +		busnr_ecam = bus->number;
> > +
> > +	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);  
> 
> [Severity: High]
> Since the ECAM offset calculation now uses the absolute bus number for
> VMD_FEAT_USE_BIOS_INFO devices, does vmd_domain_reset() also need to
> be updated?
> 
> Looking at vmd_domain_reset(), it iterates bus from 0 to max_buses and
> calculates the MMIO address like this:
> 
> drivers/pci/controller/vmd.c:vmd_domain_reset() {
>     ...
>     for (bus = 0; bus < max_buses; bus++) {
>         for (dev = 0; dev < 32; dev++) {
>             base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
>                                     PCI_DEVFN(dev, 0), 0);
>     ...
> }
Fair point, i need to change vmd_cfg_addr to avoid reading out of
bound. I will also udpate ECAM calculation.

> If the VMD buses start at a higher number (e.g., 128), could
> this hardcoded loop cause vmd_domain_reset() to miss the actual VMD
> bridges and perform MMIO reads/writes to incorrect offsets in the
> lower half of the BAR?
> 
> >  	if (offset + len >=
> > resource_size(&vmd->dev->resource[VMD_CFGBAR])) return NULL;  
> 
> [ ... ]
> 
> > @@ -661,6 +688,46 @@ static int vmd_get_bus_number_start(struct
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
> > +	bar4 = pci_ioremap_bar(vmd->dev, 4);
> > +	if (!bar4)
> > +		return -ENOMEM;
> > +
> > +	/* Read shadow registers for MEMBAR1 and MEMBAR2 physical
> > addresses. */
> > +	phys1 = readq(bar4 + SHADOW_MEMBAR1_28C1);
> > +	phys2 = readq(bar4 + SHADOW_MEMBAR2_28C1);  
> 
> [Severity: Medium]
> Could these reads access unmapped kernel memory if the device's BAR4
> is smaller than expected?
> 
> Since SHADOW_MEMBAR1_28C1 and BASE_ID_REG_28C1 access offsets like
> 0x2818 and 0x2840, should we verify that pci_resource_len(vmd->dev,
> 4) is large enough to cover these offsets before performing the
> readq() calls?

> 
> > +	/*
> > +	 * Read and set bus start number from Base ID register.
> > 24-bit Base ID
> > +	 * register is part of 64-bit shadowed reqid hide range
> > register and
> > +	 * holds segment, bus, device and function.
> > +	 */  
> 

