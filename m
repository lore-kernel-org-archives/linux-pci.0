Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D3305693
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883194; cv=none; b=aeBf4+XYRoThO5IC/t7ewGyIrCAZz+1QY+xBwajTwWjrNhr0Ktf3Cmb62hIrcmkOZcdgrqmsNhg6XFOzjDdv8HIZBXgXpu1Fg+y0VabZG/wkdfjuYyfb8DXeklFCQst0Vwx3St2LOmU4dKPQ17uvzV1eSK4NEs/PkXd3qX7okN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883194; c=relaxed/simple;
	bh=g/xqUL8SxWZxhvsedyvZWYmyTXwHkSBnqFOnidbelcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AC9+wB4QAGc4x4g4Dl7mXoP0ngw6J0zsZjB6eP5Y2FUo5475OJ4l3ai6rPES9j87aAPN7QLzujznas4b3EmIYBZztxhMTi17dPtwL+c2Eqnek0tdcofpkcNK4Zb6ppw0nIhazdFF1ULRalI/xlXnx7UTnMSAIvXfzG7eNPiAY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKPZA6FF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKPZA6FF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778883191; x=1810419191;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/xqUL8SxWZxhvsedyvZWYmyTXwHkSBnqFOnidbelcc=;
  b=hKPZA6FFVdtJ+awu13CeY+It0nUoefgwdV7MPop7bwLlfle2laPcMKNn
   nFr2MuWpm6HF7sNketxdSdSbyt8+Xy9sqXT9koY5OrOGasG9SPyfx3cxU
   D1ZaFtzS1+cHuaPvf50Bp8ioktamNIMDZx7OLTX6Q2XGgFjH9Oj/ebjW+
   zDRChhWvL0rFCLstv1gGmGlflc2ZQ1zfII0nlDfMchEqqolisia65fkle
   CeNGKPzuWCAhb0ErMyIsdpLlOKxmJ0RGWlC6abPlkT8AQeAu09327XYvk
   +Z16DFVasIf0fKgBLPN7GtmP9oZlsZPPoMKl55MJVeXU0Pd2Y48ErzWxV
   w==;
X-CSE-ConnectionGUID: HC2tPjT0Q42nhpgtwtf3eQ==
X-CSE-MsgGUID: H2Mhn9npQiC54SQB9dYhGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79821706"
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="79821706"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 15:13:10 -0700
X-CSE-ConnectionGUID: dT5k2weyQ4qekEMUHiRoaQ==
X-CSE-MsgGUID: cWb2vYzyT9i5/7+G8ctAjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,237,1770624000"; 
   d="scan'208";a="238692115"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 15:13:11 -0700
Date: Fri, 15 May 2026 15:13:09 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Add feature to add BIOS enumerated
 devices.
Message-ID: <20260515151309.000005f4@linux.intel.com>
In-Reply-To: <20260514222038.92A8FC2BCC7@smtp.kernel.org>
References: <20260514215131.179743-1-nirmal.patel@linux.intel.com>
	<20260514222038.92A8FC2BCC7@smtp.kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 22:20:38 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
> - [Critical] VMD MEMBAR2 payload resource overlaps with internal
> hardware shadow registers, exposing them to child devices.
> - [High] MSI-X remapping is incorrectly enabled on hardware that no
> longer supports it when BIOS physical offsets are present.
> - [High] Missing `pci_free_irq_vectors()` in error paths causes IRQ
> capacity leaks.
> - [High] Calculated end bus number for the VMD root bus can exceed
> the absolute PCI limit (255), corrupting bus enumeration.
> - [Low] Hardcoding device ID in core routing logic instead of
> utilizing existing feature flags. --
I will address them.
> 
> commit 68d8397e4bc530fad180d8f900d3ca84607b00a1
> Author: Nirmal Patel <nirmal.patel@linux.intel.com>
> 
> PCI: vmd: Add feature to add BIOS enumerated devices.
> 
> This commit adds support for newer VMD hardware by relying on the
> BIOS to enumerate the device tree and assign configurations. It reads
> the bus hide range and shadow register values directly from VMD
> BAR4/BAR5.
> 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index d4ae250d4bc6d..6a5879d099a16
> > 100644 --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -393,7 +407,12 @@ static void __iomem *vmd_cfg_addr(struct
> > vmd_dev *vmd, struct pci_bus *bus, unsigned int devfn, int reg, int
> > len) {
> >  	unsigned int busnr_ecam = bus->number - vmd->busn_start;
> > -	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> > +	u32 offset;
> > +
> > +	if (vmd->dev->device == PCI_DEVICE_ID_INTEL_VMD_28C1)
> > +		busnr_ecam = bus->number;
> > +
> > +	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);  
> 
> This isn't a bug, but does it make sense to use the explicit device
> ID check here instead of using the existing vmd_features bitmask?
> Adding a feature flag might scale better for future hardware
> iterations.
> 
Ack.
> [ ... ]
> > @@ -711,6 +770,54 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
> >  
> [ ... ]
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
> > +		if (resource_type(&vmd->dev->resource[4]) ==
> > IORESOURCE_MEM) {
> > +			ret = vmd_get_bus_info_from_bar4(vmd,
> > offset1, offset2);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
> > +		*membar2_offset = MB2_SHADOW_OFFSET +
> > MB2_SHADOW_SIZE;  
> 
> When VMD_FEAT_USE_BIOS_INFO evaluates to true, the else if block is
> skipped and membar2_offset remains at its default 0x2000. Could this
> allow the guest payload resource to overlap with the new 28C1
> hardware shadow registers located at 0x2818 to 0x2840, exposing them
> to child devices?

Let me adjust it to avoid potential overlap.

> 
> [ ... ]
> > @@ -784,32 +891,10 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features)  
> [ ... ]
> > +	ret = vmd_prepare_offsets_and_bus(vmd, features,
> > &membar2_offset,
> > +					  &offset[0], &offset[1]);
> > +	if(ret)
> > +		return ret;
> >  
> >  	res = &vmd->dev->resource[VMD_CFGBAR];
> >  	vmd->resources[0] = (struct resource) {
> >  		.name  = "VMD CFGBAR",
> >  		.start = vmd->busn_start,
> >  		.end   = vmd->busn_start + (resource_size(res) >>
> > 20) - 1,  
> 
> Since the 28C1 CFGBAR size is 256 MB, resource_size(res) >> 20
> evaluates to 256. If the BIOS assigns a non-zero vmd->busn_start
> (e.g., 128), does this cause the calculated .end to exceed the
> maximum 8-bit PCI bus limit of 255 and corrupt bus enumeration?

I am working on another patch to use DEFINE_RES_BUS*() in ioport.h
> 
> [ ... ]
> > @@ -880,7 +965,8 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features) if (ret)
> >  			return ret;
> >  	} else {
> > -		vmd_set_msi_remapping(vmd, false);
> > +		if (!(features & VMD_FEAT_USE_BIOS_INFO))
> > +			vmd_set_msi_remapping(vmd, false);
> >  	}  
> 
> The commit message mentions that MSI-X remapping enable/disable is no
> longer supported on this hardware. If the BIOS populates non-zero
> physical offsets, offset[0] or offset[1] will be non-zero, forcing
> execution into the if branch above this code:
> 
> drivers/pci/controller/vmd.c:vmd_enable_domain() {
>     ...
>     if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>         offset[0] || offset[1]) {
>         ret = vmd_alloc_irqs(vmd);
>         ...
>         vmd_set_msi_remapping(vmd, true);
> 
> Does this unconditionally enable MSI-X remapping on hardware that no
> longer supports it?
> 
> Also, looking at vmd_alloc_irqs() called in that same path:
> 
> drivers/pci/controller/vmd.c:vmd_alloc_irqs() {
>     ...
>     vmd->msix_count = pci_alloc_irq_vectors(dev, ...);
>     if (vmd->msix_count < 0)
>         return vmd->msix_count;
> 
>     vmd->irqs = devm_kcalloc(...);
>     if (!vmd->irqs)
>         return -ENOMEM;
>     ...
> }
> 
> If devm_kcalloc() or devm_request_irq() fails, it returns without
> freeing the vectors. Should pci_free_irq_vectors() be called in these
> error paths to prevent IRQ capacity leaks? 
> 
> Furthermore, if vmd_alloc_irqs() succeeds, but a subsequent function
> like vmd_create_irq_domain() fails, does this leak the allocated IRQ
> vectors since there is no call to pci_free_irq_vectors() in the error
> paths?
> 

Let me fix it using features & VMD_FEAT_USE_BIOS_INFO.
