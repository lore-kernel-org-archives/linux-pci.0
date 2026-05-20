Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1E381B04
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314103; cv=none; b=MurjObaMis4wnLnMwj4ukKx4eWHuDZgd1s1iBoFHV6zf53LYCapiKdJvEiqRfTK5g7EEDUihrJRh5d8bMx177RTmalySpDTljpYJ/jCjt4xTJsG8zj7A0675z/BbH0MsKjGzenK0ICFzBeGQzLQNaEFJ0MU5P+u2NuyUPzXPNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314103; c=relaxed/simple;
	bh=+CXFZOD+Y2b+42FoTEHtxtoiXw+q957/TpCFaUNzM+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTUhz/nIPOnH+I5AEuen1oL6j6mEKZg/W0GvpFPFyS0b7GZR2igQrpzLxOO19+iyc/8OJiniNB+9Z4aedHLjGxLicfSca7Rt49oDWITpp6P+xTr+OYpqTCrTpBMkOFw63bsoUNxOA4EYkl7UWWL1ah16/ApV2OPIAqaQngHg6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5DT8ssw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5DT8ssw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779314101; x=1810850101;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+CXFZOD+Y2b+42FoTEHtxtoiXw+q957/TpCFaUNzM+g=;
  b=e5DT8sswrOcE0YVUkBIx3ud6LYOhg1kmwNIGxiJQkFaFSa6fLKo6ACTl
   oOsXg7pYQznsw/VWJzXeFIaRn5eDIIOijf5x1it8bB/6naJ0PlNtmnMeo
   HoeyQrjCQBAGZAvbELDY2qvcGdT5/jUxFvCYkQK7kgJI6AiDxMPXf6ljy
   9lTXdEZ6s2MYqimF2+z8M7+xv7VTP/OzuCCNesLlCMmAD5XCl6dQA2tZV
   v2F0byKNBYHD9Qv2pC/tGGE9DDNb7ftJzxOk8B2kOmRnFP+0vYWhjmItg
   Ur8KAfOhoLzHfiKwqIyymphHvJ3DiKRPV3dfoR9hoA5jP6Jl1JzGI84yQ
   w==;
X-CSE-ConnectionGUID: b+IdC2jxSFCVr3ICRKkJwg==
X-CSE-MsgGUID: Arrnj6e9S9ynPsj+f1tquA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="84083787"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="84083787"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 14:55:00 -0700
X-CSE-ConnectionGUID: RcbajyMHTneVP/oXLqfwUQ==
X-CSE-MsgGUID: pf9+jegwTkayTED+WuejjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="278446858"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 14:54:59 -0700
Date: Wed, 20 May 2026 14:54:57 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Message-ID: <20260520145457.00001f52@linux.intel.com>
In-Reply-To: <20260519160505.704F2C2BCB3@smtp.kernel.org>
References: <20260519151832.9005-1-nirmal.patel@linux.intel.com>
	<20260519160505.704F2C2BCB3@smtp.kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 16:05:04 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> 
> New issues:
> - [High] Invalid VMD CFGBAR resource range calculated for older
> hardware with restricted bus ranges.
> - [High] VMD shadow register exposed to the child device resource
> pool, risking memory corruption.
> - [Medium] Silent failure and continued execution with uninitialized
> variables if BAR4 is not an IORESOURCE_MEM.
> 
> Pre-existing issues:
> - [High] Missing pci_free_irq_vectors() calls on error paths leaks
> IRQ resources. --
> 
> commit fb1f4c20650569f7ba38772b55e3d4757083bcf4
> Author: Nirmal Patel <nirmal.patel@linux.intel.com>
> 
> PCI: vmd: Add feature to scan BIOS enumerated devices.
> 
> Newer VMD with device ID 0x28c1 has unique settings compared to its
> predecessor where BIOS enumerates the entire VMD device tree and
> assigns respective configurations. This patch adds support to obtain
> the bus hide range and shadow registers set by BIOS.
> 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index d4ae250d4bc6d..ca8738285659a
> > 100644 --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c  
> [ ... ]
> > @@ -711,6 +773,55 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
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
> [ ... ]
> > +	if (features & VMD_FEAT_USE_BIOS_INFO) {
> > +		if (resource_type(&vmd->dev->resource[4]) ==
> > IORESOURCE_MEM) {
> > +			*membar2_offset = SHADOW_MEMBAR1_28C1 +
> > MB2_SHADOW_SIZE;  
> 
> [Severity: High]
> Does this offset calculation expose VMD configuration registers to
> child devices?
No. This is for vmd driver to read and assign bus start range and
location of shadow registers.
> 
> The calculation SHADOW_MEMBAR1_28C1 + MB2_SHADOW_SIZE resolves to
> 0x2828. However, the BASE_ID_REG_28C1 register is at offset 0x2840,
> which falls after 0x2828.
> 

These two hardware registers don't have dependency. BASE_ID_REG_28C1
holds bus start value. Since the hardware register is named as Base ID,
I kept the name as it is.

> If a child device maps a BAR over this region, could it overwrite the
> VMD shadow register at 0x2840 and cause hardware misbehavior?
> 
> Should the offset be set large enough to protect all internal VMD
> registers, such as >= 0x2848?
There is no overlap. All of the these registers are separate.
64-bit SHADOW_MEMBAR1_28C1 and SHADOW_MEMBAR2_28C1 are located at
0x2818 and 0x2820. So the 16 byte size MB2_SHADOW_SIZE includes both of
these registers.
The BASE_ID_REG_28C1 is located at 0x2840, much farther from shadow
registers.
> 
> > +			ret = vmd_get_bus_info_from_bar4(vmd,
> > offset1, offset2);
> > +			if (ret)
> > +				return ret;
> > +		}  
> 
> [Severity: Medium]
> What happens if VMD_FEAT_USE_BIOS_INFO is set, but resource 4 is not
> of type IORESOURCE_MEM?
> 
> Because the subsequent fallback checks use else if, they are bypassed
> entirely. The function will silently return 0 without retrieving valid
> offsets.
> 
> Will this cause the driver to probe with uninitialized offset values,
> failing to handle broken hardware or firmware configurations?

resource 4 is needed to obtain required information for bus scan. So
unassigned resource 4 should return an error and stop the enumeration/
probe. I can return an error in else part.

> 
> > +	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
> > +		*membar2_offset = MB2_SHADOW_OFFSET +
> > MB2_SHADOW_SIZE;
> > +		ret = vmd_get_phys_offsets(vmd, true, offset1,
> > offset2);  
> [ ... ]
> > @@ -784,38 +895,16 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features) struct pci_dev *dev;
> >  	int ret;  
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
> > +		.end   = (resource_size(res) >> 20) - 1,  
> 
> [Severity: High]
> Does this change break bus enumeration for older hardware with
> restricted bus ranges?
> 
> By unconditionally dropping vmd->busn_start from the .end calculation,
> it works for the new 28C1 device with a busn_start of 0.
> 
> However, for an older device with busn_start = 128 and a 32 MB CFGBAR
> size, .start would be 128, but .end would calculate to 31.
> 
> Could this create a malformed resource where .start > .end?

This is a good point. But in my v1 patch, I kept vmd->busn_start +
(resource_size(res) >> 20) - 1. it was flagged as an issue.
If the busn_start is 128 and ConfigBar is 256 MB, then .end will be set
to out of bound value. I can set hard coded value of 0xff same as
pci/probe.c

> 
> >  		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> >  	};  
> [ ... ]
> > @@ -868,19 +957,21 @@ static int vmd_enable_domain(struct vmd_dev
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
> 
> [Severity: High]
> This is a pre-existing issue, but does this error path leak IRQ
> resources?
> 
> According to PCI subsystem guidelines, every error path after a
> successful pci_alloc_irq_vectors() must call pci_free_irq_vectors()
> before returning.
> 
> If vmd_enable_domain() fails after allocating IRQs, or if
> vmd_alloc_irqs() fails internally (e.g., during devm_kcalloc(),
> init_srcu_struct(), or devm_request_irq()), it appears to return
> directly without freeing the allocated MSI-X vectors.
> 
> Could this eventually exhaust system IRQ capacity?

I can address this issue in another patch series as a bug fix or
improvement. 

> 
> > +			vmd_set_msi_remapping(vmd, true);
> >  
> > -		ret = vmd_create_irq_domain(vmd);
> > -		if (ret)
> > -			return ret;
> > -	} else {
> > -		vmd_set_msi_remapping(vmd, false);
> > +			ret = vmd_create_irq_domain(vmd);
> > +			if (ret)
> > +				return ret;
> > +		} else {
> > +			vmd_set_msi_remapping(vmd, false);
> > +		}
> >  	}
> >  
> 

