Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CFD1624C5
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462096; cv=none; b=d8pg++IOTEzA2y+XRhvzeX4tMlBYr4h2XEUVxpXRNu2vNscVOGO8/7JxhPEy9SN52lqODgHP9dkUUchCsE1URMqGgRBxEZP3CcdXABRE6+NThUGxgxu5d8bk6nKym5aGL9pNWimFPJ+xC088fWBC20CaAUTSYtWX5+6E2w5goqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462096; c=relaxed/simple;
	bh=rvhovx0txOwzkh6+B1PDB5ZwinKv64O5O09u7YKfj/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeqasyp4UqGaSM/98PiuAWdHoVaJfIRgrsWIZnpBfAFq4V+TcteMsPhkbUXmokAU/l050Cn9FYTL/DxFRXWzTGID/WNv16FkzyG8TrTih1ovUVyfFPR/FEz66Pr3XJIwzMr/3MGxzGATJBoDZ4pqmnVEGnYlPemcSLFGM8EDwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbv/M0ds; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbv/M0ds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779462095; x=1810998095;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rvhovx0txOwzkh6+B1PDB5ZwinKv64O5O09u7YKfj/4=;
  b=nbv/M0dsmKjhtyHFPmL29do0eNyO1/01NjTNSJdgYCdtLUVJzt3O5QEU
   g8kkbmOunAkqPWMCXq5Tpari12Ly3Z7rl9N00yqZ+lSspK1vcWWKueKvR
   WdvfcU6DZBBePUV6dFZOMy0MN5nx3z9FuMgyuGRkadb/1kKu65wPmDKuX
   E+PP8bjbVwxo4ls8zbTNRu/RhIKwJRzZ8QpdUaEbYcQkba9TGyYnFB56c
   9jB3QmLEuw+XQjfEflXXiYTe1HV1INHCsyN+iNv0kWdeY6KH/sWQkUZRz
   f2LfLgau9NPtAwJUdX6u/h9djjlxK5n60ZdNdelyGP9m+69hewLTtIIdv
   g==;
X-CSE-ConnectionGUID: 4sZseDQRTTSepYNkGNNurw==
X-CSE-MsgGUID: V4KBQFbJRI2YIVAF4o2ATg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="90966708"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="90966708"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 08:01:26 -0700
X-CSE-ConnectionGUID: vHwd5iudRSeKXiXvqXwtYw==
X-CSE-MsgGUID: ucbJCYWdSAuggtHKQIc0Kw==
X-ExtLoop1: 1
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 08:01:25 -0700
Date: Fri, 22 May 2026 08:01:24 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Message-ID: <20260522080124.00005752@linux.intel.com>
In-Reply-To: <20260521235257.3745B1F000E9@smtp.kernel.org>
References: <20260521232019.2562-1-nirmal.patel@linux.intel.com>
	<20260521235257.3745B1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 23:52:56 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> 
> New issues:
> - [High] vmd_resume() unconditionally modifies legacy MSI remapping
> configuration on unsupported hardware.
Ack.
> 
> Pre-existing issues:
> - [High] SRCU structures are permanently leaked on probe error paths.
> - [High] SRCU structs are destroyed while the managed IRQ handler is
> still registered, leading to a Use-After-Free.
> - [High] Truncation of 64-bit physical addresses on 32-bit systems
> due to incorrect use of PCI_BASE_ADDRESS_MEM_MASK. --

Proposing to fix these issues in separate patches to keep the patch
size more manageable.
> 
> commit f05a884975712ad2dc4d55677318e1620e041df9
> Author: Nirmal Patel <nirmal.patel@linux.intel.com>
> 
> PCI: vmd: Add feature to scan BIOS enumerated devices.
> 
> Newer VMD with device ID 0x28c1 has unique settings compared to its
> predecessor where BIOS enumerates the entire VMD device tree and
> assigns respective configurations.
> 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index d4ae250d4bc6d..15a3f6a357889
> > 100644 --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c  
> [ ... ]
> > @@ -661,6 +684,46 @@ static int vmd_get_bus_number_start(struct
> > vmd_dev *vmd) return 0;
> >  }
> >  
> > +static int vmd_get_bus_info_from_bar4(struct vmd_dev *vmd,
> > +				       resource_size_t *offset1,
> > +				       resource_size_t *offset2)
> > +{  
> [ ... ]
> > +	/* Calculate offsets like vmd_get_phys_offsets() does. */
> > +	if (phys1)
> > +		*offset1 = vmd->dev->resource[VMD_MEMBAR1].start -
> > +			(phys1 & PCI_BASE_ADDRESS_MEM_MASK);
> > +	if (phys2)
> > +		*offset2 = vmd->dev->resource[VMD_MEMBAR2].start -
> > +			(phys2 & PCI_BASE_ADDRESS_MEM_MASK);  
> 
> [Severity: High]
> Will this truncate the 64-bit physical addresses on 32-bit systems?
> 
> Since PCI_BASE_ADDRESS_MEM_MASK is ~0x0fUL, on 32-bit systems it
> evaluates to a 32-bit 0xFFFFFFF0. When bitwise ANDed with a 64-bit
> u64 like phys1 or phys2, the mask is zero-extended to
> 0x00000000FFFFFFF0ULL, clearing the upper 32 bits of the address.
> 
> Could this result in entirely incorrect memory mapping offsets for
> VMD devices mapped above 4GB?
> 
> This is a pre-existing issue in vmd_get_phys_offsets() as well, but
> it seems to be repeated here.
> 
> > +
> > +	pci_iounmap(vmd->dev, bar4);
> > +	return 0;
> > +}
> > +
> >  static irqreturn_t vmd_irq(int irq, void *data)
> >  {
> >  	struct vmd_irq_list *irqs = data;
> > @@ -711,6 +774,53 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
> >  	return 0;
> >  }  
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the driver leak
> srcu_struct structures on the probe error paths?
> 
> Looking at vmd_alloc_irqs(), it initializes srcu_struct structures in
> a loop. If a subsequent step fails (such as init_srcu_struct or
> vmd_create_irq_domain later in probe), vmd_probe() jumps to
> out_release_instance and returns an error without calling
> cleanup_srcu_struct() for the already initialized structures.
> 
> While IRQ vectors are automatically freed via devres, the srcu_struct
> allocations inside the per-CPU memory appear to be permanently leaked.
> 
> [Severity: High]
> This is also a pre-existing issue, but does vmd_remove() introduce a
> use-after-free by manually destroying srcu_struct structures while
> the managed IRQ handler is still registered?
> 
> The driver registers its interrupt handlers using devm_request_irq().
> Because devres handlers run only after vmd_remove() returns, the IRQ
> remains active and can fire during or after the srcu_struct
> structures are manually destroyed.
> 
> If vmd_irq() fires during this window, it calls srcu_read_lock() on a
> destroyed srcu_struct. Can this sequence trigger a use-after-free?
> 
> [ ... ]
> > @@ -868,19 +956,21 @@ static int vmd_enable_domain(struct vmd_dev
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
> 
> [Severity: High]
> This patch bypasses MSI remapping initialization for
> VMD_FEAT_USE_BIOS_INFO in vmd_enable_domain(), but is it also
> necessary to update vmd_resume()?
> 
> vmd_resume() unconditionally calls vmd_set_msi_remapping(), which
> will read and write the legacy PCI_REG_VMCONFIG register during
> system resume. Could this cause undefined behavior or PCI aborts on
> the new hardware?
> 

 I will address this issue. We dont want vmd_resume to ser msi for
 unsupported devices.

