Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B933F8D6;
	Wed, 20 May 2026 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307452; cv=none; b=nw8yRg0mWUxo6vgrcJXFEaOWfXMMr6sr25f/3TzjflN1KBjONQd3bFebCN8sqXgzlOWHNuvfgHafrKmJPfBDDtvQwVOfAkmVELEbnIq5lc/N8g3peERUZKp/3sm5wz7T0kfd2GlNM8MommoBVKPC6YIh/T+F1DxmHsfMS8WbxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307452; c=relaxed/simple;
	bh=W8nCQ3SCzucynukoN8YbGS+yMwL3/FsKM/T/LgWo6Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A1BJfncW5OhnYWx518EDwtY1X5zoMKBQLkWzug/4k5lva5hvzeprtiDEnKsedBTrQ/2T/VROcoByGOwhiN0EyA35Pq/ylDj6uAckm8B4KgcANqJvTteYgnoaLuPuaGjtiZAsC3oBX7neaj4iFpQ1e8Q1lGsYldDFCAQzIv6Osyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6U0xPSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6U0xPSL"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 999201F000E9;
	Wed, 20 May 2026 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307450;
	bh=hkMOwuQXaNBAdYLtFjUMiH4zzAgLe4SfdAgQtA8NLEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=H6U0xPSL3mETPkYNlEvHXd+V/epjsiYOkKELhJ+VQ9RxenRE6BNg7pkfU1zPZKMce
	 1l4kmN6pNKwx2DCM1QGjczc+7XVwj06EZrTwQvDDAgRSifS8kdbqKnkIS9XL99wsYn
	 LjE8vw9aCHscUVLrdyrKGXkwKlYTkDNAKeTfw37GQyiiYa9NaflukSnvD8LXtWo49s
	 XquntM5MidXCOJCEfTyd2xeCLUFpJsxob22wG7S9AW1OeJYIiSuX0hFETsMgJ21oAG
	 sYw67xgEonHFKy5rJgRx8kSsYRqFryywGDI803ygEQfOo8vPmVxEv7BVkaTQsNfZcw
	 m5RCk7+T+Pcyw==
Date: Wed, 20 May 2026 15:04:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, bhelgaas@google.com,
	robin.murphy@arm.com, praan@google.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	vsethi@nvidia.com, linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v5 2/3] PCI: Allow ATS to be always on for pre-CXL devices
Message-ID: <20260520200409.GA88687@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e75bf0abfa48f76bc87d73a772a3faf6271a9f.1779304390.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 12:46:09PM -0700, Nicolin Chen wrote:
> Some NVIDIA GPU/NIC devices, though they don't implement CXL config space,
> have many CXL-like properties. Call this kind "pre-CXL".
> 
> Similar to CXL.cache capability, these pre-CXL devices also require the ATS
> function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
> v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.
> 
> Introduce pci_dev_specific_ats_required() quirk function to scan a list of
> IDs for these devices. Then, include it in pci_ats_required().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nirmoy Das <nirmoyd@nvidia.com>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.h    |  9 +++++++++
>  drivers/pci/ats.c    |  3 ++-
>  drivers/pci/quirks.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4a14f88e543a2..e8ad27abb1cfe 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1155,6 +1155,15 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>  }
>  #endif
>  
> +#if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_PCI_ATS)
> +bool pci_dev_specific_ats_required(struct pci_dev *dev);
> +#else
> +static inline bool pci_dev_specific_ats_required(struct pci_dev *dev)
> +{
> +	return false;
> +}
> +#endif
> +
>  #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
>  int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>  			  struct resource *res);
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index ebdf761843867..3a04d5b04c883 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -247,7 +247,8 @@ bool pci_ats_required(struct pci_dev *pdev)
>  	if (pdev->is_virtfn)
>  		pdev = pci_physfn(pdev);
>  
> -	return pci_cxl_ats_required(pdev);
> +	return pci_cxl_ats_required(pdev) ||
> +	       pci_dev_specific_ats_required(pdev);
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_required);
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc02..c0242f3e9f063 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5715,6 +5715,48 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
> +
> +static bool quirk_nvidia_gpu_ats_required(struct pci_dev *pdev)
> +{
> +	switch (pdev->device) {
> +	case 0x2e00 ... 0x2e3f: /* GB20B */
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static const struct pci_dev_ats_required {
> +	u16 vendor;
> +	u16 device;
> +	bool (*ats_required)(struct pci_dev *dev);
> +} pci_dev_ats_required[] = {
> +	/* NVIDIA GPUs */
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, quirk_nvidia_gpu_ats_required },
> +	/* NVIDIA CX10 Family NVlink-C2C */
> +	{ PCI_VENDOR_ID_MELLANOX, 0x2101, NULL },
> +	{ 0 }
> +};
> +
> +/*
> + * Some NVIDIA devices do not implement CXL config space, but present as PCIe
> + * devices that can issue CXL-like cache operations like CXL.cache. Thus, they
> + * require ATS to obtain host physical addresses, like pci_cxl_ats_required().
> + */
> +bool pci_dev_specific_ats_required(struct pci_dev *pdev)
> +{
> +	const struct pci_dev_ats_required *i;
> +
> +	for (i = pci_dev_ats_required; i->vendor; i++) {
> +		if (i->vendor != pdev->vendor)
> +			continue;
> +		if (i->ats_required && i->ats_required(pdev))
> +			return true;
> +		if (!i->ats_required && i->device == pdev->device)
> +			return true;
> +	}
> +
> +	return false;
> +}
>  #endif /* CONFIG_PCI_ATS */
>  
>  /* Freescale PCIe doesn't support MSI in RC mode */
> -- 
> 2.43.0
> 
