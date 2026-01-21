Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1873D2FE1;
	Wed, 21 Jan 2026 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993784; cv=none; b=nYWJUpZq7oVUe8eWsLYCC5HM4QA49DLlRlt85S382dMM3tuxmOaEaaVGtV8+866otO677+y672Mv4E9kbpji+byPcAqcxM4RExpsw1J5nYpwJLaP+sHWV3P6K0kEjygX+N9v3EwtKKz/J/l+NAr8xrTEROMX6U0mLKw7UTm77oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993784; c=relaxed/simple;
	bh=+lXLW3G3XSo7skUr2cM9CJwhl/fcu9cAplUMB20LrOs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0eSM5JQhbMuhAETN41AE+18bOslSEOCoZwLdU4/7BLcMOGph4NoxsilYP7FU2lC45m6AYIxjVMwgFdEztH+kVcEMcbqvTbFeLL8+IjmELgGcdG9V6VnQOxzI02BYmlyvDO+ZZYgfxKwIOQilOGiGWVVeNVw+5vF+ofdirMmv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx1fN1j7bzHnHBT;
	Wed, 21 Jan 2026 19:09:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CDF8640086;
	Wed, 21 Jan 2026 19:09:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 11:09:32 +0000
Date: Wed, 21 Jan 2026 11:09:31 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <smadhavan@nvidia.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v4 05/10] cxl: add reset prepare and region teardown
Message-ID: <20260121110931.000063e2@huawei.com>
In-Reply-To: <20260120222610.2227109-6-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-6-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 20 Jan 2026 22:26:05 +0000
smadhavan@nvidia.com wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Prepare a Type 2 device for cxl_reset by validating memory is offline,
> flushing device caches for region participants, and tearing down decoders
> under cxl_region_rwsem. The lock stays held across reset to prevent new
> region creation while reset is in progress.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Some minor feedback from a quick look. I'll want to take a closer look
when we are closer to merging this.

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
> +
> +	rc = device_for_each_child(&cxled->cxld.dev, NULL,
> +				   cxl_check_region_driver_bound);

return device_for_each_child()

If that doesn't make sense after later patches, fine to leave as it is.


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

With unusual return value, definitely need docs for this function.
Given use below, maybe just return 0?

If there are caches and there is no way to force WB, what does that mean
for whether we can reset the device?  Feels like maybe this at least
deserves a warning print.

My suspicion is that lack of that feature just means there is a device
specific way to do it but I'm fine with Linux not supporting that ;)

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

Seems like target_pdev == NULL is a bug and if possible should be checked for
before doing anything in this function, so you could simplify this as

		if (!target_cxlds || target_clds->pdev != target_pdev)

> +			continue;
> +
> +		rc = cxl_device_cache_wb_invalidate(target_pdev);
> +		if (rc && rc != 1)

As above, I'm not sure the rc == 1 return is helpful.

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

That may need some lockdep annotations. Make sure to run a lockdep build.

> + *
> + * Return: 0 on success (lock held), -EBUSY if memory online, negative on error
> + */
> +static int cxl_reset_prepare_memdev(struct pci_dev *pdev)
> +{

> 

