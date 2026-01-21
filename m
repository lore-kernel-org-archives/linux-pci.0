Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903611EBFF7;
	Wed, 21 Jan 2026 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954088; cv=none; b=cdVTS26aYdA9yQzD1yYubpM00x2KfQc0APqXVhIYWagIig9RhsOoDwz3uA593ae2upKqqoLehrmS94Wsd92Cl5TPuftisLjMq8lsuWO61kLGCK+kV0xe53nttvr8LmRS7POTRDsFGquj3cv8Y82s1LSATubIahIa+9MkGAJcf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954088; c=relaxed/simple;
	bh=5Z2trgPTe2HIDqvh2jCkrgD8PTPQAv3Kyhd2n4FQMrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqypbyZYVZAMNRpP03h9ZaAPXCacN9e3frEiD0CjhHlV11bZu92Wh26UWPBk5eITlabtlxp2K25j9SpPfPXeRpFYL+CCsDDeKs86RIXm1qqgE+eb5flTKm/oC7LW5DuFu/3Ta7iQAQrSDCZUT9vx2vK5rNB2qRUEF+U3Wd49G/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaeuX3YM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaeuX3YM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768954083; x=1800490083;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5Z2trgPTe2HIDqvh2jCkrgD8PTPQAv3Kyhd2n4FQMrE=;
  b=PaeuX3YM+Iv56Bq6zh9VffqUifwUoleM8VmqLDtzedSuBK6O4tMlWgQc
   1uvoVfvpo8uEYyXm1Dw5W4804cK6rwUUWVwBnJftaqzB6gON3KDjaRSZ1
   RBPK5kfBYV7Z8N582szrBd/CLuxDwu5Xw6MoZovH0pxU0gZvA/8jYEeai
   HwxmjpLQXPKFie0otV9WPcJ/Vwv5e6++PZKrXxdZxGCF16TulL1CA391Y
   k6lI7g3wKUZicAYL2tPVViZrzEnIFZuyft8y3IKAEdT7dvmhtg7bEtpXm
   cpYC1vpeAJMw2pfJnqk/4WBjGOjHWpXJYOzQoi4WdlswqG1QaEGdmCdJQ
   Q==;
X-CSE-ConnectionGUID: D551rgB0SLKh2LJ662yshA==
X-CSE-MsgGUID: d/jV57UKTxS3gW90SsJAKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81284218"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="81284218"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 16:08:02 -0800
X-CSE-ConnectionGUID: /dNqspIbT6e+A+THqSW5cA==
X-CSE-MsgGUID: v81dw1UGRcesh1C9KuiisQ==
X-ExtLoop1: 1
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.108.33]) ([10.125.108.33])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 16:08:02 -0800
Message-ID: <5a25c92f-0525-40b5-bbce-6ca452f3fbcd@intel.com>
Date: Tue, 20 Jan 2026 17:08:01 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] PCI: add CXL reset method
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
 rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc: vaslot@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
 vidyas@nvidia.com, mochs@nvidia.com, jsequeira@nvidia.com,
 kernel test robot <lkp@intel.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-5-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260120222610.2227109-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/20/26 3:26 PM, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Add a PCI reset method "cxl_reset" that drives the CXL reset sequence using
> DVSEC controls and timeout encoding. The method is restricted to
> Type 2 devices, limiting the scope of the changes.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601172246.rz4Orygn-lkp@intel.com/

Don't think this is needed if it's kbot issue found during the series postings.

> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/pci/pci.c   | 104 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  10 ++++-
>  2 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8bb07e253646..e2d5ff25ab67 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4892,6 +4892,109 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return pci_parent_bus_reset(dev, probe);
>  }
> 
> +static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)

cxl_dev_reset() to go with existing reset method naming?

> +{
> +	/*
> +	 * Timeout values ref CXL Spec v3.2 Ch 8 Control and Status Registers,
> +	 * under section 8.1.3.1 DVSEC CXL Capability.
> +	 */
> +	u32 reset_timeouts_ms[] = { 10, 100, 1000, 10000, 100000 };
Should this be const?

> +	u16 reg;
> +	u32 timeout_ms;
> +	int rc, ind;
> +
> +	/* Check if CXL Reset MEM CLR is supported. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +
> +	if (reg & CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE) {
> +		rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
> +					  &reg);
> +		if (rc)
> +			return rc;
> +
> +		reg |= CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE;
> +		pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
> +	}
> +
> +	/* Read timeout value. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +	ind = FIELD_GET(CXL_DVSEC_CXL_RST_TIMEOUT_MASK, reg);
> +	timeout_ms = reset_timeouts_ms[ind];
> +
> +	/* Write reset config. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +
> +	reg |= CXL_DVSEC_INIT_CXL_RESET;
> +	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
> +
> +	/* Wait till timeout and then check reset status is complete. */
> +	msleep(timeout_ms);
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_STATUS2_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +	if (reg & CXL_DVSEC_CXL_RESET_ERR ||
> +	    ~reg & CXL_DVSEC_CXL_RST_COMPLETE)
> +		return -ETIMEDOUT;
> +
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +	reg &= (~CXL_DVSEC_DISABLE_CACHING);
> +	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset - initiate a cxl reset
> + * @dev: device to reset
> + * @probe: if true, return 0 if device can be reset this way
> + *
> + * Initiate a cxl reset on @dev.
> + */
> +static int cxl_reset(struct pci_dev *dev, bool probe)
> +{
> +	u16 dvsec, reg;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	/* Check if CXL Reset is supported. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
> +	if (rc)
> +		return -ENOTTY;
> +
> +	if ((reg & CXL_DVSEC_CXL_RST_CAPABLE) == 0)
> +		return -ENOTTY;
> +
> +#if !IS_REACHABLE(CONFIG_CXL_PCI)

Does this not require CONFIG_CXL_PCI to be built in (not module) to evaluate to 'y'? Also, instead of adding ifdef in the C code, maybe create a helper function for the remaining code within the function below and add an ifdef in the header depending on the config?

Although I think you may want to define cxl_is_type2_device() differently rather than relying on cxl_pci driver data. It probably should check the device type via config space instead to lessen the complications.

DJ

> +	return -ENOTTY;
> +#endif
> +
> +	/*
> +	 * Expose CXL reset for Type 2 devices.
> +	 */
> +	if (!cxl_is_type2_device(dev))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (!pci_wait_for_pending_transaction(dev))
> +		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
> +
> +	return cxl_reset_init(dev, dvsec);
> +}
> +
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
>  	struct pci_dev *bridge;
> @@ -5016,6 +5119,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_dev_acpi_reset, .name = "acpi" },
>  	{ pcie_reset_flr, .name = "flr" },
>  	{ pci_af_flr, .name = "af_flr" },
> +	{ cxl_reset, .name = "cxl_reset" },
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
>  	{ cxl_reset_bus_function, .name = "cxl_bus" },
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..4a8c4767db6e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,7 +51,7 @@
>  			       PCI_STATUS_PARITY)
> 
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
> 
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> @@ -1464,6 +1464,14 @@ int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
> 
>  int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
> +#ifdef CONFIG_CXL_PCI
> +bool cxl_is_type2_device(struct pci_dev *dev);
> +#else
> +static inline bool cxl_is_type2_device(struct pci_dev *dev)
> +{
> +	return false;
> +}
> +#endif
>  void pci_ignore_hotplug(struct pci_dev *dev);
>  struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
>  int pci_status_get_and_clear_errors(struct pci_dev *pdev);
> --
> 2.34.1
> 

