Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A4F44A72F;
	Wed, 21 Jan 2026 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033671; cv=none; b=T8k3mcc9Znjw7YxzQRNjPaN2mlgDdCWVL3evTf89AcW53Pk3NjgUc8PMqiGCvxRM4mTjTQUtx7LB+THZMBLN1iEt6Cf7uXDr5JWmt0cdsWLfrOWS9o17UoWx+1fG5ybQ2IAFmNpAPiA+BcT2FaF7VZCYPxq/ZGyhMpFHosZKiLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033671; c=relaxed/simple;
	bh=k+hL08wUhH4umCFTO5uXJ4ZKQvqs5n6tkg1koAiwafk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLSKVgS/1uMvMd7ALtLBNWLCpb7uEoszD1wK2L50jSWn3xlZHgME3MfJhGs24UpyevjlyteOlqdps0w8fkkarlPHXTK0lZviTeyLSEuthszsHGHpcILhLwn0mckbwdYfhkSSIesECQvcXkW4Wfa3ntT7clqCAWiDqLpY5ODBhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqsmtIrk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqsmtIrk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769033669; x=1800569669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k+hL08wUhH4umCFTO5uXJ4ZKQvqs5n6tkg1koAiwafk=;
  b=cqsmtIrkRVu/NoWctd5171GRW7Wdw3aaUpOPqp4xIPL0rDfPUO++jGRO
   GuOsT3QXPzjAw3GkzkEZuDMOxpNWJ/cu4wza93hAYLRWSs21gggcgh7fa
   PNry+UjvRtxH/utTRXX+LnW4414giVJ4BRLa2YdDC3gbdVju/UBsL4B7r
   II9mGEuO2GnRs96pKycAhTKPaPO1nyzV1D3nHq1azbD0AVQVsOoLOrilP
   ouK0Of1I0dlKBUscT9MmEa/prIROw2gQJ/K2SvdZzSye5iny6uWApnoC8
   9htXlB+3CIRd+gjCJucFGaVGW6uoKUBrL9ad9s/xTMUfEdyBNR1Fis29E
   w==;
X-CSE-ConnectionGUID: JtQA5wiBTDe1oeE05AU4mg==
X-CSE-MsgGUID: fSdRf6vTSZyuCnHhBzf8lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70436999"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70436999"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:13:25 -0800
X-CSE-ConnectionGUID: oHbvg2pxTnek8dzyed3udA==
X-CSE-MsgGUID: IsaYn9z1QHmr/16ckVnShw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="237815413"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.97]) ([10.125.108.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:13:23 -0800
Message-ID: <8b974b31-3ac7-4158-bb25-497a254296bb@intel.com>
Date: Wed, 21 Jan 2026 15:13:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] PCI: wire CXL reset prepare/cleanup
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
 rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 huaisheng.ye@intel.com, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc: vaslot@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
 vidyas@nvidia.com, mochs@nvidia.com, jsequeira@nvidia.com
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-7-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260120222610.2227109-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/20/26 3:26 PM, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Wire CXL reset preparation and cleanup into the PCI CXL reset path.
> The flow now validates/offlines regions, performs teardown and cache
> flushes, then releases the lock on completion or error. This keeps the
> common reset_prepare flow intact while adding cxl_reset-specific quiesce logic.

Can this be moved to the ->reset_prepare() callback of 'pci_error_handlers' rather than directly wire it into PCI core code? I don't think we want build a dependency of cxl core to the PCI core.

> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/pci/pci.c   | 19 ++++++++++++++++++-
>  include/linux/pci.h | 11 +++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e2d5ff25ab67..18047c893b0c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4989,10 +4989,27 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
> 
> +	/*
> +	 * CXL-reset-specific preparation: validate memory offline,
> +	 * tear down regions, flush device caches.
> +	 */
> +	rc = cxl_reset_prepare_device(dev);
> +	if (rc)
> +		return rc;
> +
>  	if (!pci_wait_for_pending_transaction(dev))
>  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
> 
> -	return cxl_reset_init(dev, dvsec);
> +	rc = cxl_reset_init(dev, dvsec);
> +	if (rc)
> +		goto out_cleanup;
> +
> +	cxl_reset_cleanup_device(dev);
> +	return 0;
> +
> +out_cleanup:
> +	cxl_reset_cleanup_device(dev);
> +	return rc;
>  }
> 
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4a8c4767db6e..c074c2040b28 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1466,11 +1466,22 @@ int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
>  #ifdef CONFIG_CXL_PCI
>  bool cxl_is_type2_device(struct pci_dev *dev);
> +int cxl_reset_prepare_device(struct pci_dev *pdev);
> +void cxl_reset_cleanup_device(struct pci_dev *pdev);
>  #else
>  static inline bool cxl_is_type2_device(struct pci_dev *dev)
>  {
>  	return false;
>  }
> +
> +static inline int cxl_reset_prepare_device(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
> +
> +static inline void cxl_reset_cleanup_device(struct pci_dev *pdev)
> +{
> +}
>  #endif
>  void pci_ignore_hotplug(struct pci_dev *dev);
>  struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
> --
> 2.34.1
> 

