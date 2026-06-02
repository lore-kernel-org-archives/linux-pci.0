Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF339936D;
	Tue,  2 Jun 2026 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444224; cv=none; b=MUpMd0s0tsqARZBMMW+f4WXnbmOrfnMw5mSfelqU4ifYoN1EZaUnJWdGGs4+Tk+5hhVUG4qi/coh1kIcvvlQVFz2Tq1GuBDeilR27kMk6HYd5ysBbOje2wv4E8KdyiusSAhUrLb/0C2XqNU+xr853iHxVSsIMH4xqQDMuNDGk2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444224; c=relaxed/simple;
	bh=3nMKGtxtqzOIDe3Xs32XULZIpIZ8Il/V4Gs6GXXhvHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upuGht5XHkPOEKXuYkQrp/tX1bNiJ6CfQJ7/ElNbzoy7aEEL83HvDnWsu2M43UADkp4hqWlffGhJgk0XBD4OZevGHx/s2xDQ0JbEKeEamaFwNavP55FSs7FL5ml2JSSdCXCbbirOABgm+4iO0qjkcbI/Tfe3TRLXPrW9A1rTJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klrBQFgV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klrBQFgV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780444223; x=1811980223;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3nMKGtxtqzOIDe3Xs32XULZIpIZ8Il/V4Gs6GXXhvHE=;
  b=klrBQFgVzTAEnxa5BKkfN0kx1kyt4Z2VUV/Q61ZoUywl/NHNry/Ib3+I
   FhP/d8zMkh/7ACSS160qHi7WseQ3Ldexms9RxqX+/c3IrgyQtyMOIypJc
   8TyQGz62u0hQjB/0zaznw8oRSZvf/WdZd85Qf5WJ6rhn8bZy+dLCvqoEo
   wR89p6ncibQZs4PdL/EMPjqKI7qk42QsnL6YeEgd4CvG764SkWEpLH/Sj
   zsDH3tG7bzVU/X6U/r5dUa6y1D9rRjhE8/SyNegtN+Aiqqe7noIfhowLu
   JnthlAOpdtj7sWKam/RDgQwIaEGFsTiDIAbkJ3eDGThRqr6HfBFfIBG7E
   A==;
X-CSE-ConnectionGUID: bWuyqOTkQ1yvKPemj4L44g==
X-CSE-MsgGUID: loGNcvR8QeWZ+f1bMDWCrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="98663091"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="98663091"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:50:22 -0700
X-CSE-ConnectionGUID: wsZQNYLCTjywzepo8UboDw==
X-CSE-MsgGUID: tPPY+vZAQbW1rgszN8qSRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243888301"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.56]) ([10.125.108.56])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:50:21 -0700
Message-ID: <ec166b91-dbee-4966-8f65-081082e1b1f5@intel.com>
Date: Tue, 2 Jun 2026 16:50:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] cxl/memdev: Add cxl_reset sysfs attribute
To: Srirangan Madhavan <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, alwilliamson@nvidia.com,
 Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-9-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260528083154.137979-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 1:31 AM, Srirangan Madhavan wrote:
> Expose CXL reset through the CXL memdev device. The reset flow
> depends on CXL memdev state to identify affected regions, coordinate
> decoder restore, and keep CXL-specific policy out of the PCI sysfs ABI.
> 
> Add a write-only cxl_reset attribute under memX. The attribute is visible
> only when the memdev's PCI parent advertises CXL Reset capability.
> Writing a true boolean value invokes the CXL reset orchestration.

Probably should explicitly mention that the reset is only for Type2 devices in the commit log and that is a design choice.

DJ

> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/memdev.c |  30 +++++++++++
>  drivers/cxl/core/pci.c    | 102 +++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h         |   3 ++
>  drivers/cxl/cxlmem.h      |   2 +
>  4 files changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 80e65690eb77..af67fa3d11b8 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -199,6 +199,26 @@ static ssize_t security_erase_store(struct device *dev,
>  static struct device_attribute dev_attr_security_erase =
>  	__ATTR(erase, 0200, NULL, security_erase_store);
>  
> +static ssize_t cxl_reset_store(struct device *dev,
> +			       struct device_attribute *attr, const char *buf,
> +			       size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	bool reset;
> +	int rc;
> +
> +	rc = kstrtobool(buf, &reset);
> +	if (rc)
> +		return rc;
> +
> +	if (!reset)
> +		return -EINVAL;
> +
> +	rc = cxl_memdev_reset(cxlmd);
> +	return rc ? rc : len;
> +}
> +static DEVICE_ATTR_WO(cxl_reset);
> +
>  bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
>  			       enum poison_cmd_enabled_bits cmd)
>  {
> @@ -421,6 +441,7 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_payload_max.attr,
>  	&dev_attr_label_storage_size.attr,
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_cxl_reset.attr,
>  	NULL,
>  };
>  
> @@ -485,8 +506,16 @@ static struct attribute *cxl_memdev_security_attributes[] = {
>  static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  				  int n)
>  {
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
>  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
>  		return 0;
> +
> +	if (a == &dev_attr_cxl_reset.attr &&
> +	    !cxl_memdev_reset_capable(cxlmd))
> +		return 0;
> +
>  	return a->mode;
>  }
>  
> @@ -1099,6 +1128,7 @@ static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
>  
>  	cxlmd->cxlds = cxlds;
>  	cxlds->cxlmd = cxlmd;
> +	cxl_memdev_init_reset(cxlmd);
>  
>  	rc = cdev_device_add(&cxlmd->cdev, &cxlmd->dev);
>  	if (rc) {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 486c447e98f3..09f016544d24 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1207,6 +1207,22 @@ static bool cxl_reset_has_cache_or_mem(struct pci_dev *pdev)
>  	return cap & (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE);
>  }
>  
> +static bool cxl_reset_is_type2(struct pci_dev *pdev)
> +{
> +	u16 dvsec, cap;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return false;
> +
> +	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		return false;
> +
> +	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
> +	       (cap & PCI_DVSEC_CXL_MEM_CAPABLE);
> +}
> +
>  static int cxl_reset_add_sibling(struct cxl_reset_context *ctx,
>  				 struct pci_dev *sibling)
>  {
> @@ -1939,7 +1955,7 @@ static int cxl_do_reset_locked(struct cxl_reset_context *ctx, bool mem_clear)
>  	return rc;
>  }
>  
> -static int __maybe_unused cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
> +static int cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
>  {
>  	struct cxl_reset_context ctx = {
>  		.target = pdev,
> @@ -1966,3 +1982,87 @@ static int __maybe_unused cxl_do_reset(struct pci_dev *pdev, bool mem_clear)
>  	cxl_reset_context_destroy(&ctx);
>  	return rc;
>  }
> +
> +static struct pci_dev *cxl_reset_get_fn0(struct pci_dev *pdev)
> +{
> +	unsigned int devfn;
> +
> +	/*
> +	 * CXL Reset control/status is exposed in Function 0 and affects all
> +	 * CXL.cache/mem functions in the device.
> +	 */
> +	if (pci_ari_enabled(pdev->bus))
> +		devfn = 0;
> +	else
> +		devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
> +
> +	if (pdev->devfn == devfn)
> +		return pci_dev_get(pdev);
> +
> +	return pci_get_slot(pdev->bus, devfn);
> +}
> +
> +static bool cxl_memdev_probe_reset_capable(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev = cxlmd->dev.parent;
> +	struct pci_dev *pdev, *fn0;
> +	int dvsec;
> +	u16 cap;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +	if (!cxl_reset_is_type2(pdev))
> +		return false;
> +
> +	fn0 = cxl_reset_get_fn0(pdev);
> +	if (!fn0)
> +		return false;
> +
> +	dvsec = pci_find_dvsec_capability(fn0, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		goto out;
> +
> +	if (pci_read_config_word(fn0, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> +		goto out;
> +
> +	pci_dev_put(fn0);
> +	return cap & PCI_DVSEC_CXL_RST_CAPABLE;
> +
> +out:
> +	pci_dev_put(fn0);
> +	return false;
> +}
> +
> +void cxl_memdev_init_reset(struct cxl_memdev *cxlmd)
> +{
> +	cxlmd->reset_capable = cxl_memdev_probe_reset_capable(cxlmd);
> +}
> +
> +bool cxl_memdev_reset_capable(struct cxl_memdev *cxlmd)
> +{
> +	return cxlmd->reset_capable;
> +}
> +
> +int cxl_memdev_reset(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev = cxlmd->dev.parent;
> +	struct pci_dev *fn0;
> +	int rc;
> +
> +	if (!cxl_memdev_reset_capable(cxlmd))
> +		return -EOPNOTSUPP;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;
> +
> +	fn0 = cxl_reset_get_fn0(to_pci_dev(dev));
> +	if (!fn0)
> +		return -ENODEV;
> +
> +	rc = cxl_do_reset(fn0, false);
> +	pci_dev_put(fn0);
> +	return rc;
> +}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b51b1e9d6400..bf65996e24dc 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -796,6 +796,9 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info);
>  int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd);
>  int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd);
> +void cxl_memdev_init_reset(struct cxl_memdev *cxlmd);
> +bool cxl_memdev_reset_capable(struct cxl_memdev *cxlmd);
> +int cxl_memdev_reset(struct cxl_memdev *cxlmd);
>  
>  bool is_cxl_region(struct device *dev);
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 776c50d1db51..c8e7349fb130 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -48,6 +48,7 @@ struct cxl_memdev_attach {
>   * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>   * @endpoint: connection to the CXL port topology for this memory device
>   * @attach: creator of this memdev depends on CXL link attach to operate
> + * @reset_capable: cached CXL Reset support
>   * @id: id number of this memdev instance.
>   * @depth: endpoint port depth
>   * @scrub_cycle: current scrub cycle set for this device
> @@ -65,6 +66,7 @@ struct cxl_memdev {
>  	struct cxl_nvdimm *cxl_nvd;
>  	struct cxl_port *endpoint;
>  	const struct cxl_memdev_attach *attach;
> +	bool reset_capable;
>  	int id;
>  	int depth;
>  	u8 scrub_cycle;

