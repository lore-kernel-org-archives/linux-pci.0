Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170411DED42;
	Thu,  3 Sep 2026 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472277; cv=none; b=CanJ/SdT9NJ1HEBPsHiKzt0hb0QF1V9lCWl93OWo2eSsukXYlRKuxMXqpI11XJJiWQvIimPXjkBKyjpguURHS5UcEsqu5aBQW7pcNCO1R4X9MUsGbwyIKqoLR2q80+XgKrWXm0j3o2lUu3zoHyZC/gKOCXwSBqWpn83BXU2b6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472277; c=relaxed/simple;
	bh=D6vckDvfwy3J0p9rCU09Cjwkb5n2j2oveTTRhvXxRDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcFURrDuNUkGgFDLnXNGjLiy/twRtdmiuRRPo2RyWiE1B1AD4gDFxTk8dkWwHqhRcWjgtVoceFcoktMSpHJrE/PhygSr8UawgnSBxwWn4Lk3uhfApPAWSVWGN8RuG+KBH+FY0nIfBmRCwxxWPQIzRboRPcxPLfbCicf0ZdEpb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJmlVUyi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJmlVUyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788472276; x=1820008276;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D6vckDvfwy3J0p9rCU09Cjwkb5n2j2oveTTRhvXxRDs=;
  b=JJmlVUyiVafSg43l16RNqxNjoMkj24NB/VEbq2vKEzfYfxGiU5k4s81k
   3ZU9UkWGNby7PA7eEaOt/xUrv36yvzeJlAgrhwDzy48LA1p/AjGaG1qRX
   nDjbaCsExODjHMNjSiF7gAVbpRIt5WYFxssMx3sTYXXU0QOnmnqnx6c64
   zHHba76N9IWv6SGiaR7xVu5Kvi4DIknRy2ULib+WvTT1U1wXeSVo52KIq
   KrOcBWWpBa3b0wi+TfC8YA3VVIqqB8INyYdkWQpLnS+0oXcqLYLsKwm2L
   7qaan83TLreL+4YmFGcf04spB/ziufG6ZZB8ru6eqFuwQClR4ci5MHf+G
   A==;
X-CSE-ConnectionGUID: 3TEMIIAuRWi2Ifn4aQ1skQ==
X-CSE-MsgGUID: jV2v3lJZREuaazdH2j/SSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92668705"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92668705"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 14:51:14 -0700
X-CSE-ConnectionGUID: ALN53Xb0R7GovQd7Z6uwgw==
X-CSE-MsgGUID: jYSTnWNiQrSlFqAU/OsX7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="267272459"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.110.190]) ([10.125.110.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 14:51:11 -0700
Message-ID: <e8cfd5f8-7704-4dcd-ae1a-01f3f42e3b46@intel.com>
Date: Thu, 3 Sep 2026 14:51:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/27] cxl/regs: Skip sub-block region request for
 BAR-owning drivers
To: mhonap@nvidia.com, alex@shazbot.org, jgg@ziepe.ca, ankita@nvidia.com,
 jic23@kernel.org, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 corbet@lwn.net, skhan@linuxfoundation.org, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org,
 ming.li@zohomail.com, yishaih@nvidia.com, skolothumtho@nvidia.com,
 kevin.tian@intel.com, bhelgaas@google.com, dmatlack@google.com,
 kees@kernel.org, gustavoars@kernel.org
Cc: cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260813093631.2288172-1-mhonap@nvidia.com>
 <20260813093631.2288172-3-mhonap@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260813093631.2288172-3-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/26 2:36 AM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> cxl_map_component_regs() claims each mapped sub-block with
> devm_request_mem_region(). A driver that owns the whole component
> register BAR, such as vfio-cxl, has already claimed the full BAR, so
> the per-sub-block claim collides and the mapping fails.
> 
> Add a bar_owned parameter to cxl_pci_setup_regs() and record it in
> skip_sub_bar_request on the register map. When set, cxl-core maps the
> sub-block without requesting the region and leaves ownership with the
> upper driver. cxl_pci passes false and keeps its existing claim,
> preserving /dev/mem tooling access to the rest of the component space.

So currently it's either cxl_pci driver that binds to the PCI device or vfio_cxl driver right? Why does cxl_pci needs to pass in false? When vfio_cxl driver is being attached, cxl_pci is not involved and all the bar ranges should be free? Or is there a contention between vfio_cxl and cxl_core that it calls on? 

DJ
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/cxl/core/pci.c  |  9 ++++++++-
>  drivers/cxl/core/regs.c | 32 ++++++++++++++++++++++----------
>  drivers/cxl/pci.c       |  4 ++--
>  include/cxl/cxl.h       |  3 +++
>  include/cxl/pci.h       |  2 +-
>  5 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..08d4c955137d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -720,7 +720,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  }
>  
>  int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		       struct cxl_register_map *map)
> +		       struct cxl_register_map *map, bool bar_owned)
>  {
>  	int rc;
>  
> @@ -750,6 +750,13 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		return rc;
>  	}
>  
> +	/*
> +	 * A caller that owns the whole register BAR (for example vfio-cxl)
> +	 * maps the sub-blocks without claiming them, so the later
> +	 * cxl_map_component_regs() does not collide with the full-BAR request.
> +	 */
> +	map->skip_sub_bar_request = bar_owned;
> +
>  	return cxl_setup_regs(map);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 989e79383b99..90dd85f322f5 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -177,35 +177,47 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, "CXL");
>  
> -void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> -				   resource_size_t length)
> +static void __iomem *__cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				       resource_size_t length, bool request)
>  {
> +	resource_size_t end = addr + length - 1;
>  	void __iomem *ret_val;
>  	struct resource *res;
>  
>  	if (WARN_ON_ONCE(addr == CXL_RESOURCE_NONE))
>  		return NULL;
>  
> -	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
> -	if (!res) {
> -		resource_size_t end = addr + length - 1;
> -
> -		dev_err(dev, "Failed to request region %pa-%pa\n", &addr, &end);
> -		return NULL;
> +	/*
> +	 * An owning driver (e.g. vfio-cxl) may already hold the whole BAR; a
> +	 * sub-block request would then collide with that claim.
> +	 */
> +	if (request) {
> +		res = devm_request_mem_region(dev, addr, length, dev_name(dev));
> +		if (!res) {
> +			dev_err(dev, "Failed to request region %pa-%pa\n", &addr, &end);
> +			return NULL;
> +		}
>  	}
>  
>  	ret_val = devm_ioremap(dev, addr, length);
>  	if (!ret_val)
> -		dev_err(dev, "Failed to map region %pr\n", res);
> +		dev_err(dev, "Failed to map region %pa-%pa\n", &addr, &end);
>  
>  	return ret_val;
>  }
> +
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				   resource_size_t length)
> +{
> +	return __cxl_iomap_block(dev, addr, length, true);
> +}
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>  
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask)
>  {
> +	bool request = !map->skip_sub_bar_request;
>  	struct device *host = map->host;
>  	struct mapinfo {
>  		const struct cxl_reg_map *rmap;
> @@ -227,7 +239,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  			continue;
>  		addr = map->resource + mi->rmap->offset;
>  		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
> +		*(mi->addr) = __cxl_iomap_block(host, addr, length, request);
>  		if (!*(mi->addr))
>  			return -ENOMEM;
>  	}
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bb892dbfdd6d..ec1693c21f61 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -816,7 +816,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
>  
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, false);
>  	if (rc)
>  		return rc;
>  
> @@ -829,7 +829,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 * still be useful for management functions so don't return an error.
>  	 */
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> -				&cxlds->reg_map);
> +				&cxlds->reg_map, false);
>  	if (rc)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  	else if (!cxlds->reg_map.component_map.ras.valid)
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index efb8ac97bd92..f8e8fddba152 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -213,6 +213,8 @@ struct cxl_pmu_reg_map {
>   * @resource: physical resource base of the register block
>   * @max_size: maximum mapping size to perform register search
>   * @reg_type: see enum cxl_regloc_type
> + * @skip_sub_bar_request: set via cxl_pci_setup_regs(); the owning driver holds
> + *			  the BAR, so skip the sub-block claim
>   * @component_map: cxl_reg_map for component registers
>   * @device_map: cxl_reg_maps for device registers
>   * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> @@ -223,6 +225,7 @@ struct cxl_register_map {
>  	resource_size_t resource;
>  	resource_size_t max_size;
>  	u8 reg_type;
> +	bool skip_sub_bar_request;
>  	union {
>  		struct cxl_component_reg_map component_map;
>  		struct cxl_device_reg_map device_map;
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index 3e0000015871..81a32004a604 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -18,5 +18,5 @@ struct cxl_register_map;
>  struct pci_dev;
>  
>  int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		       struct cxl_register_map *map);
> +		       struct cxl_register_map *map, bool bar_owned);
>  #endif

