Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DAE2E9729
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047388; cv=none; b=XgH2L3alj6JvcxnAeWYjSpKuXsOcXT2uvcpiSUZetT0ucgTP+8soictSJP7FgrAKq1lQA0OHTLuWzdeOSdSN+TkPYMqX2D8sVSx9qYeUlku7xRumyBhEWahsMP23LfM65WkeZZ8Q728Q0ZNxGHmgtwT5VrUTTOQ6ctM5Xr2CRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047388; c=relaxed/simple;
	bh=5geqhphC1dM3iTEXuEaHux/8JRKxHa3+qtLEHL5U9aU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+Vioj0gY9xuW1Wo0xgOkCPU0uvUbn8RLFyCu5Tchue1zRErZDFGbmNjDuEwiNbfpX49V6UaPPyOu68lx7swkS1ssJperkuymOg5ZJoDgoZdK0j/OvSMBc54zbwdJCB85vjEDlry7LweT3HoroW8tEd+69MdZwYdUNiZ/uHfLm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXb9fAIU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXb9fAIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781047386; x=1812583386;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5geqhphC1dM3iTEXuEaHux/8JRKxHa3+qtLEHL5U9aU=;
  b=kXb9fAIUasYxn+jh5q1KCqbwqvqQdthXX0Q3qmSJhYbgheoWcG1F9MTt
   JTaCqVFzn1jHH6iuo4XfTWRVv6gTyye0wc3OVJ7a8HKFZ9xCGYk8WecVX
   477xHcUmDYLHrcWatIPLzZrln8MGarFgegSkklYcj0iMrGzVKTZ1AE26d
   q5phjBMviHaIswtX/elGuPHyY3up45o6/dBYaD+fMjUhrHbs4KE7Hfp7+
   2XwOBUqoY/TojXkEg/2i7dfRRk+FrNwF5ggLtDfATGPlKqSTzQ3HSM/BQ
   p9Z5mpzRYUJgijL3BLjqLjq2pzszRaScKU61OVj4pTUb5VNwios244xZv
   w==;
X-CSE-ConnectionGUID: 6IidyUixSfGR9otwfAm80g==
X-CSE-MsgGUID: Yz4mqTRRQJeyLO99x3kuqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92935388"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="92935388"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 16:23:05 -0700
X-CSE-ConnectionGUID: WWJNEPKbTZSIKPddiiVsew==
X-CSE-MsgGUID: H0fKIRviRs2yFDW8CsJyLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="251075144"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 16:23:05 -0700
Date: Tue, 9 Jun 2026 16:23:03 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, nirmal.patel@intel.com
Subject: Re: [PATCH v4] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Message-ID: <20260609162303.00007fdb@linux.intel.com>
In-Reply-To: <n4jccdlwxfsuroxhepz34yn4zdrvexyfjstdrhyn2yuveriv2l@w26pv6xkxgr4>
References: <20260522150829.5246-1-nirmal.patel@linux.intel.com>
	<n4jccdlwxfsuroxhepz34yn4zdrvexyfjstdrhyn2yuveriv2l@w26pv6xkxgr4>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 22:30:07 +0530
Manivannan Sadhasivam <mani@kernel.org> wrote:

> On Fri, May 22, 2026 at 03:08:29PM +0000, Nirmal Patel wrote:
> > Newer VMD  with device ID 0x28c1 has unique settings compared to its
> > predecessor where BIOS enumerates the entire VMD device tree and
> > assigns respective configurations.
> > 
> > VMD configuration BAR0 carries over from GNR legacy VMD as the
> > mechanism to access the configuration space of the devices owned by
> > VMD. The size of this window is fixed at 256 MB, where each
> > function consumes 4 KB and every bus consumes 1 MB.
> > 
> > The shadow and scratchpad registers have been relocated from the VMD
> > configuration space to the VMD MMIO space in VMD BAR4/BAR5,
> > otherwise refers to as MEMBAR2 or MSI-X bar.
> > 
> > VMD MSI-X remapping enable/disable is no longer supported.
> > 
> > All the VMD driver code needs to do is to obtain bus hide range
> > along with shadow register values set by BIOS and perform a bus
> > scan.
> > 
> > The patch also involves small refactoring of vmd_enable_domain
> > function. 
> 
> s/patch/commit
Ack
> 
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>  
> 
> Just a few nits below...
> 
> > ---
> > v4 : Updating vmd_set_msi_remapping for supported devices only.
> > v3 : Hard code configbar .end to 0xff same as probe.c; Adjust
> > membar2 offset to accommodate more registers in 28C1. Remove
> > redundant IORESOURCE_MEM check in vmd_prepare_offsets_and_bus.
> > v2 : Using PCI features flag instead of devic ID and fixing corner
> > cases for vmd_remove_irq.
> > ---
> >  drivers/pci/controller/vmd.c | 174
> > +++++++++++++++++++++++++++-------- include/linux/pci_ids.h      |
> >  1 + 2 files changed, 136 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index d4ae250d4bc6..7c90243b5ff0
> > 100644 --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -37,6 +37,12 @@
> >  #define MB2_SHADOW_OFFSET	0x2000
> >  #define MB2_SHADOW_SIZE		16
> >  
> > +/* DMR BAR4 register offsets */
> > +#define SHADOW_MEMBAR1_28C1		0x2818 /* MEMBAR1
> > physical address */ +#define SHADOW_MEMBAR2_28C1
> > 0x2820 /* MEMBAR2 physical address */ +#define
> > BASE_ID_REG_28C1		0x2840 +#define
> > MEMBAR2_OFFSET_28C1		0x30d0 +
> >  enum vmd_features {
> >  	/*
> >  	 * Device may contain registers which hint the physical
> > location of the @@ -77,6 +83,15 @@ enum vmd_features {
> >  	 * proper power management of the SoC.
> >  	 */
> >  	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
> > +
> > +	/*
> > +	 * Newer VMD  with device ID 0x28c1 has unique settings
> > compared to its  
> 
> Double space after 'VMD'
Ack
> 
> > +	 * predecessor where BIOS enumerates the entire VMD device
> > tree and
> > +	 * stores respective configurations including bus start
> > range and
> > +	 * shadow registers in VMD MMIO space in VMD BAR4/BAR5,
> > otherwise refers
> > +	 * to as MEMBAR2 or MSI-X bar.
> > +	 */
> > +	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
> >  };
> >  
> >  #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
> > @@ -142,6 +157,7 @@ struct vmd_dev {
> >  	u8			first_vec;
> >  	char			*name;
> >  	int			instance;
> > +	unsigned long		features;
> >  };
> >  
> >  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> > @@ -365,6 +381,8 @@ static int vmd_create_irq_domain(struct vmd_dev
> > *vmd) static void vmd_set_msi_remapping(struct vmd_dev *vmd, bool
> > enable) {
> >  	u16 reg;  
> 
> Leave a new line between variable declaration and statement.
> 
> > +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> > +		return;
> >  
> >  	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
> >  	reg = enable ? (reg & ~VMCONFIG_MSI_REMAP) :
> > @@ -374,6 +392,8 @@ static void vmd_set_msi_remapping(struct
> > vmd_dev *vmd, bool enable) 
> >  static void vmd_remove_irq_domain(struct vmd_dev *vmd)
> >  {
> > +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> > +		return;  
> 
> Add a new line.
Ack
> 
> >  	/*
> >  	 * Some production BIOS won't enable remapping between
> > soft reboots.
> >  	 * Ensure remapping is restored before unloading the
> > driver. @@ -393,7 +413,12 @@ static void __iomem
> > *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus, unsigned
> > int devfn, int reg, int len) {
> >  	unsigned int busnr_ecam = bus->number - vmd->busn_start;
> > -	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> > +	u32 offset;
> > +
> > +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> > +		busnr_ecam = bus->number;
> > +
> > +	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> >  
> >  	if (offset + len >=
> > resource_size(&vmd->dev->resource[VMD_CFGBAR])) return NULL;
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
> 
> Extra newline.
Ack
> 
> > +	bar4 = pci_ioremap_bar(vmd->dev, 4);
> > +	if (!bar4)
> > +		return -ENOMEM;
> > +
> > +	/* Read shadow registers for MEMBAR1 and MEMBAR2 physical
> > addresses. */
> > +	phys1 = readq(bar4 + SHADOW_MEMBAR1_28C1);
> > +	phys2 = readq(bar4 + SHADOW_MEMBAR2_28C1);
> > +
> > +	/*
> > +	 * Read and set bus start number from Base ID register.
> > +	 * 24-bit Base ID register is part of 64-bit shadowed
> > reqid hide
> > +	 * range register and holds segment, bus, device and
> > function.
> > +	 */  
> 
> Make use of 80 column width for comments.
Ack
> 
> > +	bar4_2840 = readq(bar4 + BASE_ID_REG_28C1);
> > +	base_id = bar4_2840 & 0xFFFFFF;
> > +	base_bus = base_id >> 8;
> > +	vmd->busn_start = base_bus;
> > +
> > +	/* Calculate offsets like vmd_get_phys_offsets() does. */
> > +	if (phys1)
> > +		*offset1 = vmd->dev->resource[VMD_MEMBAR1].start -
> > +			(phys1 & PCI_BASE_ADDRESS_MEM_MASK);
> > +	if (phys2)
> > +		*offset2 = vmd->dev->resource[VMD_MEMBAR2].start -
> > +			(phys2 & PCI_BASE_ADDRESS_MEM_MASK);
> > +
> > +	pci_iounmap(vmd->dev, bar4);  
> 
> Add a newline before return statement.
> 
> > +	return 0;
> > +}
> > +
> >  static irqreturn_t vmd_irq(int irq, void *data)
> >  {
> >  	struct vmd_irq_list *irqs = data;
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
> 
> Club both comments into one.
> 
> > +	if (features & VMD_FEAT_USE_BIOS_INFO) {
> > +		*membar2_offset = MEMBAR2_OFFSET_28C1;
> > +		ret = vmd_get_bus_info_from_bar4(vmd, offset1,
> > offset2);
> > +		if (ret)
> > +			return ret;
> > +	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
> > +		*membar2_offset = MB2_SHADOW_OFFSET +
> > MB2_SHADOW_SIZE;
> > +		ret = vmd_get_phys_offsets(vmd, true, offset1,
> > offset2);
> > +		if (ret)
> > +			return ret;
> > +	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
> > +		ret = vmd_get_phys_offsets(vmd, false, offset1,
> > offset2);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/*
> > +	 * Certain VMD devices may have a root port configuration
> > option which
> > +	 * limits the bus range to between 0-127, 128-255, or
> > 224-255.
> > +	 */
> > +	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
> > +		ret = vmd_get_bus_number_start(vmd);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Since VMD is an aperture to regular PCIe root ports, only allow
> > it to
> >   * control features that the OS is allowed to control on the
> > physical PCI bus. @@ -784,38 +896,16 @@ static int
> > vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > struct pci_dev *dev; int ret;
> >  
> > -	/*
> > -	 * Shadow registers may exist in certain VMD device ids
> > which allow
> > -	 * guests to correctly assign host physical addresses to
> > the root ports
> > -	 * and child devices. These registers will either return
> > the host value
> > -	 * or 0, depending on an enable bit in the VMD device.
> > -	 */
> > -	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
> > -		membar2_offset = MB2_SHADOW_OFFSET +
> > MB2_SHADOW_SIZE;
> > -		ret = vmd_get_phys_offsets(vmd, true, &offset[0],
> > &offset[1]);
> > -		if (ret)
> > -			return ret;
> > -	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
> > -		ret = vmd_get_phys_offsets(vmd, false, &offset[0],
> > &offset[1]);
> > -		if (ret)
> > -			return ret;
> > -	}
> > -
> > -	/*
> > -	 * Certain VMD devices may have a root port configuration
> > option which
> > -	 * limits the bus range to between 0-127, 128-255, or
> > 224-255
> > -	 */
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
> Is this change related to this patch?
Yes.
> 
> - Mani
> 

