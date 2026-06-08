Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD63BE647
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929203; cv=none; b=TUU4Kbp2Mc6QcHgt1ZQJONem2qEjlgU4nealPccaIVp112os0cdvb5tFM1z/THt1o0oJNUoAtNgPq+66ZPGP4I22uYjqHy3MQT2ifuw84co2v4106iaVNXn2HWybp5cHsRPNN3RZcfC2yyxTrXe5WWfxRWRTJpPupK3VltVnPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929203; c=relaxed/simple;
	bh=Shp+rXcRFdoAj1xXUnuojUD2uWQRT+nsrmQdeSaIzpc=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5Dw5TD2Gd8C0ueSTvniM4vWqkdvY0vOMlyWP/X8vtpA6Hy+ybde/mv+upwHdQFwz+48qexMsKkcZGXyWuApbNr/csT/5ngx8y+uebFfkCVZqJwvxvvcg5i+A8ZenjOwFFmcH1HS8VJiYy2t2xWI//jU7ncGlN/t0SIB6fDzMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxsTpSEJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxsTpSEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780929201; x=1812465201;
  h=date:from:to:subject:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Shp+rXcRFdoAj1xXUnuojUD2uWQRT+nsrmQdeSaIzpc=;
  b=JxsTpSEJAIga0Bsdj6pp5ZCLBzyHS80Eaem/iPX+YEGe1F+NS7Injhjr
   L8d7NKxe6m4JLRSJANakquDSUzHxt11xfp1zdaMD3I1+15/OJ9zm5xDFV
   S/RcOliSMXvNBSopPyfy368+5OpFHPdFvO4thayATQKU8lM7KaShZQOfr
   I1sin0VUGAUMBzS5ADF/F0AU/GNyjUri8va4W78qgKivXr0SHAGF6xsCU
   QBkkF+nPGudMu5+OwO6BPpB7qoHJQhU5lcZaP6NlKN091PTjwMSsBOBAb
   RSrvvmlYzupZZTTg2ukmG3fDwnoOVX/pV/gJvaTQNxL9akNOhGnOPVkPH
   Q==;
X-CSE-ConnectionGUID: j1Q/NEBHQmmhw1DxQif3vQ==
X-CSE-MsgGUID: qWASdHwqTFCnFSVuCmaZOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81783061"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81783061"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 07:33:21 -0700
X-CSE-ConnectionGUID: v52zedhkQMG/binyF1IZ8w==
X-CSE-MsgGUID: s/PfsG5cSCia/HwH8eRb4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="241120463"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 07:33:21 -0700
Date: Mon, 8 Jun 2026 07:33:20 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: <linux-pci@vger.kernel.org>, lpieralisi@kernel.org,
 nirmal.patel@intel.com
Subject: Re: [PATCH v4] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Message-ID: <20260608073320.000035a0@linux.intel.com>
In-Reply-To: <20260527120139.00004254@linux.intel.com>
References: <20260522150829.5246-1-nirmal.patel@linux.intel.com>
	<20260527120139.00004254@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 12:01:39 -0700
Nirmal Patel <nirmal.patel@linux.intel.com> wrote:

> On Fri, 22 May 2026 15:08:29 +0000
> Nirmal Patel <nirmal.patel@linux.intel.com> wrote:
> 
> > Newer VMD  with device ID 0x28c1 has unique settings compared to its
> > predecessor where BIOS enumerates the entire VMD device tree and
> > assigns respective configurations.
> > 
> > VMD configuration BAR0 carries over from GNR legacy VMD as the
> > mechanism to access the configuration space of the devices owned by
> > VMD. The size of this window is fixed at 256 MB, where each function
> > consumes 4 KB and every bus consumes 1 MB.
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
> > 
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
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
> > 1 + 2 files changed, 136 insertions(+), 39 deletions(-)
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
> > +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> > +		return;
> >  
> >  	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
> >  	reg = enable ? (reg & ~VMCONFIG_MSI_REMAP) :
> > @@ -374,6 +392,8 @@ static void vmd_set_msi_remapping(struct vmd_dev
> > *vmd, bool enable) 
> >  static void vmd_remove_irq_domain(struct vmd_dev *vmd)
> >  {
> > +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> > +		return;
> >  	/*
> >  	 * Some production BIOS won't enable remapping between soft
> > reboots.
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
> > +	 * 24-bit Base ID register is part of 64-bit shadowed reqid
> > hide
> > +	 * range register and holds segment, bus, device and
> > function.
> > +	 */
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
> >  	pci_add_resource(&resources, &vmd->resources[0]);
> > @@ -998,6 +1090,7 @@ static int vmd_probe(struct pci_dev *dev, const
> > struct pci_device_id *id) 
> >  	vmd->dev = dev;
> >  	vmd->sysdata.domain = PCI_DOMAIN_NR_NOT_SET;
> > +	vmd->features = features;
> >  	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
> >  	if (vmd->instance < 0)
> >  		return vmd->instance;
> > @@ -1114,6 +1207,9 @@ static const struct pci_device_id vmd_ids[] =
> > { .driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> >  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> >  				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
> > +	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C1),
> > +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> > +				VMD_FEAT_USE_BIOS_INFO,},
> >  	{PCI_VDEVICE(INTEL, 0x467f),
> >  		.driver_data = VMD_FEATS_CLIENT,},
> >  	{PCI_VDEVICE(INTEL, 0x4c3d),
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 24cb42f66e4b..2a8ebe7df92e 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2889,6 +2889,7 @@
> >  #define PCI_DEVICE_ID_INTEL_HDA_ICH8	0x284b
> >  #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
> >  #define PCI_DEVICE_ID_INTEL_VMD_28C0	0x28c0
> > +#define PCI_DEVICE_ID_INTEL_VMD_28C1    0x28c1
> >  #define PCI_DEVICE_ID_INTEL_ICH9_0	0x2910
> >  #define PCI_DEVICE_ID_INTEL_ICH9_2	0x2912
> >  #define PCI_DEVICE_ID_INTEL_ICH9_3	0x2913  
> 
> Gentle reminder. FYI, I also addressed comments from AI review.
> 
> Thanks.

Gentle review reminder.
Thanks.

