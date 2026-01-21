Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1A33C18A;
	Wed, 21 Jan 2026 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769030747; cv=none; b=jhot/+cWS7RV1ZcvT1QaucdiB7bdNxSkmNwmHxKsaNEZKXnZi/aH0O9lDbQfT9+Q96+KNEbM7LO3S1PKLz78WSrB2/FxGSLV1TrKEYCijinYiDsydrKuG7CdG81ZQvXGhcv821WnJ/b5fRwCxW9SmHIJzTvE7/+fnKwle8KHFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769030747; c=relaxed/simple;
	bh=hHwUyCMdza/QhbKW5UCLEW2pO5qeXfU96vNfJV33wXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMPaH5Dgu5Jx0LUiRwGFA8RsvNqmeFnUmO/gbbeeAC8VPCYEQL+oRCA6koHB6g94vxNn+XV9WRP/mUntDxcOuiGb1qFComqnb273rFMSOwbHutKpd9qzrxqgZt9ckeB91QTJo7FQcjGGgxWx+ffPC4JVKsIg1Ih7AhXkm1zDw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEJUoZ4O; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEJUoZ4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769030745; x=1800566745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hHwUyCMdza/QhbKW5UCLEW2pO5qeXfU96vNfJV33wXg=;
  b=bEJUoZ4OVMqxXMZcEeQjsP7+OH5JLKHXeyBtwhL6AtWJmObva53ZZEiR
   wv3lZxS/Q6jZHUdJOogpYwM6/mNoNPc8/dT9AZv39LCkTbfmUbR+4Gs5q
   jWeRdfs9OlscEfm6rng4OPDO7TRsp41OmmObsvWgDzkOIAAIcmGnyRdkZ
   LgBYhx6FPh3KD77YxFz+VBZOVoucu7LwLezTVhZ/ogy6frVPJdxKg2WWH
   5gALobupmtCPI6RNkKhK7nyeIkh8N7LSH+0lvW3NvAp/SxH0BwVSdq44/
   FMLYpvOstUJPIpPk5Wta4dxRdx7mv1Kwi2mOBbc+/7GRG8emGA38pMgrE
   w==;
X-CSE-ConnectionGUID: mDYzr8FeRByyhQ0GfDUcGg==
X-CSE-MsgGUID: IFUTGsb2Qt+9KstAKXkw6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70320234"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70320234"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 13:25:44 -0800
X-CSE-ConnectionGUID: FLorIi/gQji9xuyGYUsLQg==
X-CSE-MsgGUID: fcDddow6TO2SoRCmfP7+Jg==
X-ExtLoop1: 1
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.97]) ([10.125.108.97])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 13:25:42 -0800
Message-ID: <4b63a52b-0042-4c05-8bf8-4a2705e6b9c0@intel.com>
Date: Wed, 21 Jan 2026 14:25:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] cxl: add reset prepare and region teardown
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
 rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc: vaslot@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
 vidyas@nvidia.com, mochs@nvidia.com, jsequeira@nvidia.com
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-6-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260120222610.2227109-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/20/26 3:26 PM, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Prepare a Type 2 device for cxl_reset by validating memory is offline,
> flushing device caches for region participants, and tearing down decoders
> under cxl_region_rwsem. The lock stays held across reset to prevent new
> region creation while reset is in progress.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/pci.c | 214 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 214 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b562e607ec46..e4134162e82a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1085,6 +1085,220 @@ bool cxl_is_type2_device(struct pci_dev *pdev)
>  	return cxlds->type == CXL_DEVTYPE_DEVMEM;
>  }
> 
> +static int cxl_check_region_driver_bound(struct device *dev, void *data)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	if (cxld->region && cxld->region->driver)

I think you may need to take the region device lock before checking the region driver. The cxl_region_rwsem won't protect you from region device driver un/binding. While we know cxl_pci is bound since the callback is on a PCI device, there's no gaurantee that the region driver is.


> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +static int cxl_decoder_kill_region_iter(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	if (!cxled->cxld.region)
> +		return 0;
> +
> +	cxl_decoder_kill_region_locked(cxled);

Where does this function come from? It's not present upstream.

> +
> +	rc = device_for_each_child(&cxled->cxld.dev, NULL,
> +				   cxl_check_region_driver_bound);

Why check if driver is bound after region is killed? Also, the check happens in cxl_reset_prepare_memdev() before cxl_decoder_kill_region_iter() is called, and if true fails the cxl_reset_prepare_memdev(). So at this point there shouldn't be any drivers bound right?

> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static int cxl_device_cache_wb_invalidate(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	u16 reg, val, cap;
> +	int dvsec, rc;
> +
> +	if (!cxlds)
> +		return -ENODEV;
> +
> +	dvsec = cxlds->cxl_dvsec;
> +	if (!dvsec)
> +		return -ENODEV;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & CXL_DVSEC_CACHE_WBI_CAPABLE))
> +		return 1;

Why return 1 when it's ignored anyhow? Can just return 0.

> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &val);
> +	if (rc)
> +		return rc;
> +
> +	val |= CXL_DVSEC_INIT_CACHE_WBI;
> +	rc = pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, val);
> +	if (rc)
> +		return rc;
> +
> +	do {
> +		rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_STATUS2_OFFSET, &reg);
> +		if (rc)
> +			return rc;
> +	} while (!(reg & CXL_DVSEC_CACHE_INVALID));
> +
> +	return 0;
> +}
> +
> +static int cxl_region_flush_device_caches(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> +	struct cxl_region *cxlr = cxled->cxld.region;
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct pci_dev *target_pdev = data;
> +	int i, rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	if (!cxlr || !cxlr->params.res)
> +		return 0;
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *target_cxled = p->targets[i];
> +		struct cxl_memdev *target_cxlmd = cxled_to_memdev(target_cxled);
> +		struct cxl_dev_state *target_cxlds = target_cxlmd->cxlds;
> +
> +		if (!target_cxlds || !target_cxlds->pdev)
> +			continue;
> +
> +		if (target_cxlds->pdev != target_pdev)
> +			continue;
> +
> +		rc = cxl_device_cache_wb_invalidate(target_pdev);
> +		if (rc && rc != 1)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset_prepare_memdev - Prepare CXL device for reset
> + * @pdev: PCI device
> + *
> + * Validates it's safe to reset and tears down regions atomically under lock.
> + * Acquires cxl_region_rwsem and keeps it held throughout reset.
> + *
> + * Return: 0 on success (lock held), -EBUSY if memory online, negative on error
> + */
> +static int cxl_reset_prepare_memdev(struct pci_dev *pdev)

Given the function name, shouldn't this pass in a cxl_memdev?

> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_port *endpoint;
> +	int rc;
> +
> +	if (!cxlds)
> +		return -ENODEV;
> +
> +	cxlmd = cxlds->cxlmd;
> +	if (!cxlmd)
> +		return -ENODEV;
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		return 0;
> +
> +	if (cxl_num_decoders_committed(endpoint) == 0)
> +		return 0;

Without any decoders committed, this endpoint shouldn't be part of any region correct? Why bother checking driver bound after this. Seems overkill.

> +
> +	down_write(&cxl_region_rwsem);
> +
> +	/* Check and error out if memory is online */

Having cxl_region driver bound does not mean memory is online in the sense if it's hot-plugged to the memory subsystem. Are you looking for it to be not system memory here, or that cxl has claimed the region, or if there's just a hardware committed region?

> +	rc = device_for_each_child(&endpoint->dev, NULL,
> +				   cxl_check_region_driver_bound);
> +	if (rc) {
> +		up_write(&cxl_region_rwsem);
> +		dev_err(&pdev->dev,
> +			"Reset blocked: device has active regions with drivers bound\n");
> +		return -EBUSY;
> +	}
> +
> +	/* Flush device caches and tear down regions */
> +	device_for_each_child(&endpoint->dev, pdev,
> +			      cxl_region_flush_device_caches);
> +
> +	rc = device_for_each_child(&endpoint->dev, NULL,
> +				   cxl_decoder_kill_region_iter);
> +	if (rc) {
> +		up_write(&cxl_region_rwsem);
> +		dev_err(&pdev->dev, "Failed to tear down regions: %d\n", rc);
> +		return rc;
> +	}
> +
> +	/* Keep cxl_region_rwsem held, released by cleanup function */

May want to annotate the function with __acquires()
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset_cleanup_memdev - Release locks after CXL reset
> + * @pdev: PCI device
> + */
> +static void cxl_reset_cleanup_memdev(struct pci_dev *pdev)
> +{
> +	if (lockdep_is_held_type(&cxl_region_rwsem, -1))

why check when it's expected that the lock is held? Probably should have lockdep_assert_held() instead. Also may need a __releases() to annotate that this function releases the lock acquires in cxl_reset_prepare_memdev(). 

DJ

> +		up_write(&cxl_region_rwsem);
> +}
> +
> +/**
> + * cxl_reset_prepare_device - Prepare CXL device for reset
> + * @pdev: PCI device being reset
> + *
> + * CXL-reset-specific preparation. Validates memory is offline, flushes
> + * device caches, and tears down regions.
> + *
> + * Returns: 0 on success, -EBUSY if memory online, negative on error
> + */
> +int cxl_reset_prepare_device(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = cxl_reset_prepare_memdev(pdev);
> +	if (rc) {
> +		if (rc == -EBUSY)
> +			dev_err(&pdev->dev,
> +				"Cannot reset: device has online memory or active regions\n");
> +		else
> +			dev_err(&pdev->dev,
> +				"Failed to prepare device for reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_reset_prepare_device, "CXL");
> +
> +/**
> + * cxl_reset_cleanup_device - Cleanup after CXL reset
> + * @pdev: PCI device that was reset
> + *
> + * Releases region locks held during reset.
> + */
> +void cxl_reset_cleanup_device(struct pci_dev *pdev)
> +{
> +	cxl_reset_cleanup_memdev(pdev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_reset_cleanup_device, "CXL");
> +
>  static void cxl_error_resume(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> --
> 2.34.1
> 

