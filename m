Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952A3CF97A
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938014; cv=none; b=ZtjpE5Pcu6CeILWFuI9S1kEir9AOvn9KcOMGNMFw0/6p5GBesszZx36xWGFa9zgTEuEp9Dk3/3/hxgot+sRG8bj45/1Sxgwd5w4JbSljTjd2ppqWBPxWCI/adaf79JvXOduGoACVx3JSEYgC5VPelI9f3qKvUDX6JKoxO1a6Qn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938014; c=relaxed/simple;
	bh=AVZDBnA+J32SaerNDvzVlEh1HLk7hj9Ofpgc58Erp3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWOaGWgyfgqTy7sGgICSHSltKqJirDPVOPWWqUnzOn5aWkY0tgRWWUtGsjqhb4Ql1BTEJt22eM8PxWOHipkfV6LnXL4DKxmUghtKQMN7Xip43b1YuXmWHcYrc0L0yZdLBgm2xwN0G3HLwuHYmRe4PePGm/mCX056X5251qvXBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUphTSek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUphTSek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEDB1F00893;
	Mon,  8 Jun 2026 17:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780938012;
	bh=a4p4TAKVOj0lM5Q+5HuZavRBDdp3gJeBvVuGTCcX5qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DUphTSeknSJHCPh33MhfhwJSq1tiTB5V30nV68wsUwLU+nkkRqGq/tJAh4fIunQDt
	 jdl1wSE2EcMm27OTXZKg1N9tbRyg2G7tCpqaWq7E6L3GS3QdT1eYGRqOj4lz8a96fa
	 EB0fT+9XVCffjKpqIBlAEvMtWodtKH8UEWbnd7Tsga3PKxtWX9uX4NBM+KiKepPdGf
	 XgzK5FVbU6CS/EN2mlun9JHUmpx89Ud9V+9zBoMnuF8UeE8ty+UTM8LJUgXYcVzdCz
	 TF3/WJo1BZsj/mFiQnIA+SYJ/YYRQ2mwOkSLkCUrQE6QJP9TReNVSCwD3cqF/PNSx+
	 4df9pXjW+g1HQ==
Date: Mon, 8 Jun 2026 22:30:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org, nirmal.patel@intel.com
Subject: Re: [PATCH v4] PCI: vmd: Add feature to scan BIOS enumerated devices.
Message-ID: <n4jccdlwxfsuroxhepz34yn4zdrvexyfjstdrhyn2yuveriv2l@w26pv6xkxgr4>
References: <20260522150829.5246-1-nirmal.patel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522150829.5246-1-nirmal.patel@linux.intel.com>

On Fri, May 22, 2026 at 03:08:29PM +0000, Nirmal Patel wrote:
> Newer VMD  with device ID 0x28c1 has unique settings compared to its
> predecessor where BIOS enumerates the entire VMD device tree and
> assigns respective configurations.
> 
> VMD configuration BAR0 carries over from GNR legacy VMD as the mechanism
> to access the configuration space of the devices owned by VMD. The size
> of this window is fixed at 256 MB, where each function consumes 4 KB and
> every bus consumes 1 MB.
> 
> The shadow and scratchpad registers have been relocated from the VMD
> configuration space to the VMD MMIO space in VMD BAR4/BAR5, otherwise
> refers to as MEMBAR2 or MSI-X bar.
> 
> VMD MSI-X remapping enable/disable is no longer supported.
> 
> All the VMD driver code needs to do is to obtain bus hide range along
> with shadow register values set by BIOS and perform a bus scan.
> 
> The patch also involves small refactoring of vmd_enable_domain function.
> 

s/patch/commit

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>

Just a few nits below...

> ---
> v4 : Updating vmd_set_msi_remapping for supported devices only.
> v3 : Hard code configbar .end to 0xff same as probe.c; Adjust membar2
>      offset to accommodate more registers in 28C1. Remove redundant
>      IORESOURCE_MEM check in vmd_prepare_offsets_and_bus.
> v2 : Using PCI features flag instead of devic ID and fixing corner cases
>      for vmd_remove_irq.
> ---
>  drivers/pci/controller/vmd.c | 174 +++++++++++++++++++++++++++--------
>  include/linux/pci_ids.h      |   1 +
>  2 files changed, 136 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6..7c90243b5ff0 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -37,6 +37,12 @@
>  #define MB2_SHADOW_OFFSET	0x2000
>  #define MB2_SHADOW_SIZE		16
>  
> +/* DMR BAR4 register offsets */
> +#define SHADOW_MEMBAR1_28C1		0x2818 /* MEMBAR1 physical address */
> +#define SHADOW_MEMBAR2_28C1		0x2820 /* MEMBAR2 physical address */
> +#define BASE_ID_REG_28C1		0x2840
> +#define MEMBAR2_OFFSET_28C1		0x30d0
> +
>  enum vmd_features {
>  	/*
>  	 * Device may contain registers which hint the physical location of the
> @@ -77,6 +83,15 @@ enum vmd_features {
>  	 * proper power management of the SoC.
>  	 */
>  	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
> +
> +	/*
> +	 * Newer VMD  with device ID 0x28c1 has unique settings compared to its

Double space after 'VMD'

> +	 * predecessor where BIOS enumerates the entire VMD device tree and
> +	 * stores respective configurations including bus start range and
> +	 * shadow registers in VMD MMIO space in VMD BAR4/BAR5, otherwise refers
> +	 * to as MEMBAR2 or MSI-X bar.
> +	 */
> +	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
>  };
>  
>  #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
> @@ -142,6 +157,7 @@ struct vmd_dev {
>  	u8			first_vec;
>  	char			*name;
>  	int			instance;
> +	unsigned long		features;
>  };
>  
>  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> @@ -365,6 +381,8 @@ static int vmd_create_irq_domain(struct vmd_dev *vmd)
>  static void vmd_set_msi_remapping(struct vmd_dev *vmd, bool enable)
>  {
>  	u16 reg;

Leave a new line between variable declaration and statement.

> +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> +		return;
>  
>  	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
>  	reg = enable ? (reg & ~VMCONFIG_MSI_REMAP) :
> @@ -374,6 +392,8 @@ static void vmd_set_msi_remapping(struct vmd_dev *vmd, bool enable)
>  
>  static void vmd_remove_irq_domain(struct vmd_dev *vmd)
>  {
> +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> +		return;

Add a new line.

>  	/*
>  	 * Some production BIOS won't enable remapping between soft reboots.
>  	 * Ensure remapping is restored before unloading the driver.
> @@ -393,7 +413,12 @@ static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
>  				  unsigned int devfn, int reg, int len)
>  {
>  	unsigned int busnr_ecam = bus->number - vmd->busn_start;
> -	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> +	u32 offset;
> +
> +	if (!!(vmd->features & VMD_FEAT_USE_BIOS_INFO))
> +		busnr_ecam = bus->number;
> +
> +	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
>  
>  	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
>  		return NULL;
> @@ -661,6 +686,46 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
>  	return 0;
>  }
>  
> +static int vmd_get_bus_info_from_bar4(struct vmd_dev *vmd,
> +				       resource_size_t *offset1,
> +				       resource_size_t *offset2)
> +{
> +	u64 phys1, phys2, bar4_2840;
> +	void __iomem *bar4;
> +	u32 base_id;
> +	u8 base_bus;
> +
> +

Extra newline.

> +	bar4 = pci_ioremap_bar(vmd->dev, 4);
> +	if (!bar4)
> +		return -ENOMEM;
> +
> +	/* Read shadow registers for MEMBAR1 and MEMBAR2 physical addresses. */
> +	phys1 = readq(bar4 + SHADOW_MEMBAR1_28C1);
> +	phys2 = readq(bar4 + SHADOW_MEMBAR2_28C1);
> +
> +	/*
> +	 * Read and set bus start number from Base ID register.
> +	 * 24-bit Base ID register is part of 64-bit shadowed reqid hide
> +	 * range register and holds segment, bus, device and function.
> +	 */

Make use of 80 column width for comments.

> +	bar4_2840 = readq(bar4 + BASE_ID_REG_28C1);
> +	base_id = bar4_2840 & 0xFFFFFF;
> +	base_bus = base_id >> 8;
> +	vmd->busn_start = base_bus;
> +
> +	/* Calculate offsets like vmd_get_phys_offsets() does. */
> +	if (phys1)
> +		*offset1 = vmd->dev->resource[VMD_MEMBAR1].start -
> +			(phys1 & PCI_BASE_ADDRESS_MEM_MASK);
> +	if (phys2)
> +		*offset2 = vmd->dev->resource[VMD_MEMBAR2].start -
> +			(phys2 & PCI_BASE_ADDRESS_MEM_MASK);
> +
> +	pci_iounmap(vmd->dev, bar4);

Add a newline before return statement.

> +	return 0;
> +}
> +
>  static irqreturn_t vmd_irq(int irq, void *data)
>  {
>  	struct vmd_irq_list *irqs = data;
> @@ -711,6 +776,53 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  	return 0;
>  }
>  
> +static int vmd_prepare_offsets_and_bus(struct vmd_dev *vmd,
> +					unsigned long features,
> +					resource_size_t *membar2_offset,
> +					resource_size_t *offset1,
> +					resource_size_t *offset2)
> +{
> +	int ret;
> +
> +	/*
> +	 * Shadow registers may exist in certain VMD device ids which allow
> +	 * guests to correctly assign host physical addresses to the root ports
> +	 * and child devices. These registers will either return the host value
> +	 * or 0, depending on an enable bit in the VMD device.
> +	 */
> +	/*
> +	 * For certain VMD devices (i.e. 0x28C1), BIOS places device info
> +	 * in BAR4 shadow registers to determine the base bus number and memory
> +	 * offsets.
> +	 */

Club both comments into one.

> +	if (features & VMD_FEAT_USE_BIOS_INFO) {
> +		*membar2_offset = MEMBAR2_OFFSET_28C1;
> +		ret = vmd_get_bus_info_from_bar4(vmd, offset1, offset2);
> +		if (ret)
> +			return ret;
> +	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
> +		*membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
> +		ret = vmd_get_phys_offsets(vmd, true, offset1, offset2);
> +		if (ret)
> +			return ret;
> +	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
> +		ret = vmd_get_phys_offsets(vmd, false, offset1, offset2);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Certain VMD devices may have a root port configuration option which
> +	 * limits the bus range to between 0-127, 128-255, or 224-255.
> +	 */
> +	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
> +		ret = vmd_get_bus_number_start(vmd);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Since VMD is an aperture to regular PCIe root ports, only allow it to
>   * control features that the OS is allowed to control on the physical PCI bus.
> @@ -784,38 +896,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	struct pci_dev *dev;
>  	int ret;
>  
> -	/*
> -	 * Shadow registers may exist in certain VMD device ids which allow
> -	 * guests to correctly assign host physical addresses to the root ports
> -	 * and child devices. These registers will either return the host value
> -	 * or 0, depending on an enable bit in the VMD device.
> -	 */
> -	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
> -		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
> -		ret = vmd_get_phys_offsets(vmd, true, &offset[0], &offset[1]);
> -		if (ret)
> -			return ret;
> -	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
> -		ret = vmd_get_phys_offsets(vmd, false, &offset[0], &offset[1]);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	/*
> -	 * Certain VMD devices may have a root port configuration option which
> -	 * limits the bus range to between 0-127, 128-255, or 224-255
> -	 */
> -	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
> -		ret = vmd_get_bus_number_start(vmd);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = vmd_prepare_offsets_and_bus(vmd, features, &membar2_offset,
> +					  &offset[0], &offset[1]);
> +	if (ret)
> +		return ret;
>  
>  	res = &vmd->dev->resource[VMD_CFGBAR];
>  	vmd->resources[0] = (struct resource) {
>  		.name  = "VMD CFGBAR",
>  		.start = vmd->busn_start,
> -		.end   = vmd->busn_start + (resource_size(res) >> 20) - 1,
> +		.end   = 0xff,

Is this change related to this patch?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
