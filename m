Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2315FA81;
	Tue,  5 May 2026 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018571; cv=none; b=Vxg1yiPM6DBErNREPWx1ERtu+chYLhMn+EVMfpsNDE68ZPoIWTDDIZQrOqlTfGxc21ay1uCA/egKHo6HthZgoKqIJbh8fEE+RM/sFbCH6Vxab+bsYWEjXEP4uYOpgteFmVqHDdvP/EygHDhCXqo8QCryc1e/3S7S61a7YuKKhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018571; c=relaxed/simple;
	bh=F/d8tQlpNPUaHlsl5sECbpdsjIrt9nJ3+Kn1dBHhpfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDUviQmlrzGziIEV0rgaD8dfd8GC9VXm4R6lXqQBmEAXYmBhIBogNPn9vCm4uEYfjPhzW3Yg4Mvp5TJsgjQFpUSdQog3+z2xq99hOvjKmPdD8HOM6vUCs+/g3yDaDcnnYp5fqxoJH5yxlAYgBzNlrRN/2CSMtxIDlRP5xCEDrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7geSDpk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7geSDpk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778018570; x=1809554570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F/d8tQlpNPUaHlsl5sECbpdsjIrt9nJ3+Kn1dBHhpfg=;
  b=a7geSDpkLv1Wk7AYeteT217gi+jdOx2M0qh9rD3QAFXnPywZr8TJhbWU
   Ai/SiXQJsRbsLFyatpvNYtGpROF6QPrAVF1S9+v+jTtONfXwMsZbfnldP
   O67moXMQtBCCxE6NdA0+Dd2ugAuMX5vVPqznXHDBQSM+D/VEg78eDivYr
   7ipkuqdwvwTpRKP5O5JEz1Ky25aQ70J3FwSNN9M/2a0MBCusZDcAaZ+E8
   Loooc7ABexZMuUgyFkAgooV5U+zgL5ITi5fWmKVe1qpgPQjZrMhL7TKtg
   OgOvgb6hTCPgZzf9bAXw4dkXWIwZJNkJGY80+nlbNkC9UEdSxoJNYy4x6
   w==;
X-CSE-ConnectionGUID: yuZie4oSTzi1FieXJPk60w==
X-CSE-MsgGUID: LkxORQ0LTkqwY7E0GCiHIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90010215"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="90010215"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 15:02:49 -0700
X-CSE-ConnectionGUID: 7/m1GmB7SP+OLlaSDS0NUQ==
X-CSE-MsgGUID: I78p3padTkCvMHTcvka83g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="232814098"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.125.110.85]) ([10.125.110.85])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 15:02:47 -0700
Message-ID: <f23888a9-754f-49d9-b8fd-60d590d1cb9b@intel.com>
Date: Tue, 5 May 2026 15:02:45 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 03/11] cxl: Use common CPER handling for all CXL
 devices
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, djbw@kernel.org, bhelgaas@google.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com,
 corbet@lwn.net, rafael@kernel.org, xueshuai@linux.alibaba.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-4-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260505173029.2718246-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 10:30 AM, Terry Bowman wrote:
> Fold the Port and Endpoint specific paths in cxl_cper_handle_prot_err()
> into a single code path. Drop the PCI type dispatch block as both Port
> and Endpoint devices now go through the same code path.
> 
> Extend the pdev->dev.driver != NULL gate to Port devices, which previously
> bypassed it. This check and the existing device lock will ensure the CXL
> device remains accessible while in scope.
> 
> Recent trace event changes generalize the interface to take a
> struct device * for all CXL devices. Update the Endpoint CPER path
> to pass &pdev->dev (the PCI device) instead of &cxlmd->dev (the
> memdev). This makes the trace event's "device=" field show the PCI
> BDF for all CPER callers, replacing the prior "device=memN" output
> for Endpoints. Userspace consumers correlating CPER trace events to
> memdev names must map the PCI BDF back via /sys/bus/cxl/devices/.
> 
> Remove the bus_find_device(&cxl_bus_type, ..., match_memdev_by_parent)
> lookup along with the match_memdev_by_parent() helper.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v16->v17:
> - New commit
> ---
>  drivers/cxl/core/ras.c | 81 +++++++-----------------------------------
>  1 file changed, 13 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index d7081caaf5d3..56611da8357a 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -8,65 +8,28 @@
>  #include <cxlpci.h>
>  #include "trace.h"
>  
> -static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> -					      struct cxl_ras_capability_regs ras_cap)
> +static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev, u64 serial,
> +					 struct cxl_ras_capability_regs *ras_cap)
>  {
> -	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> +	u32 status = ras_cap->cor_status & ~ras_cap->cor_mask;
>  
> -	trace_cxl_aer_correctable_error(&pdev->dev, status, pci_get_dsn(pdev));
> +	trace_cxl_aer_correctable_error(&pdev->dev, status, serial);
>  }
>  
> -static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> -						struct cxl_ras_capability_regs ras_cap)
> +static void cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev, u64 serial,
> +					   struct cxl_ras_capability_regs *ras_cap)
>  {
> -	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> +	u32 status = ras_cap->uncor_status & ~ras_cap->uncor_mask;
>  	u32 fe;
>  
>  	if (hweight32(status) > 1)
>  		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> -				   ras_cap.cap_control));
> +				   ras_cap->cap_control));
>  	else
>  		fe = status;
>  
>  	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
> -					  ras_cap.header_log,
> -					  pci_get_dsn(pdev));
> -}
> -
> -static void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> -					 struct cxl_memdev *cxlmd,
> -					 struct cxl_ras_capability_regs ras_cap)
> -{
> -	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> -
> -	trace_cxl_aer_correctable_error(&cxlmd->dev, status,
> -					pci_get_dsn(pdev));
> -}
> -
> -static void
> -cxl_cper_trace_uncorr_prot_err(struct pci_dev *pdev,
> -			       struct cxl_memdev *cxlmd,
> -			       struct cxl_ras_capability_regs ras_cap)
> -{
> -	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> -	u32 fe;
> -
> -	if (hweight32(status) > 1)
> -		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> -				   ras_cap.cap_control));
> -	else
> -		fe = status;
> -
> -	trace_cxl_aer_uncorrectable_error(&cxlmd->dev, status, fe,
> -					  ras_cap.header_log,
> -					  pci_get_dsn(pdev));
> -}
> -
> -static int match_memdev_by_parent(struct device *dev, const void *uport)
> -{
> -	if (is_cxl_memdev(dev) && dev->parent == uport)
> -		return 1;
> -	return 0;
> +					  ras_cap->header_log, serial);
>  }
>  
>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
> @@ -77,38 +40,20 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>  					    data->prot_err.agent_addr.bus,
>  					    devfn);
> -	struct cxl_memdev *cxlmd;
> -	int port_type;
>  
>  	if (!pdev)
>  		return;
>  
> -	port_type = pci_pcie_type(pdev);
> -	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> -	    port_type == PCI_EXP_TYPE_UPSTREAM) {
> -		if (data->severity == AER_CORRECTABLE)
> -			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
> -		else
> -			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
> -
> -		return;
> -	}
> -
>  	guard(device)(&pdev->dev);
>  	if (!pdev->dev.driver)
>  		return;
>  
> -	struct device *mem_dev __free(put_device) = bus_find_device(
> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> -	if (!mem_dev)
> -		return;
> -
> -	cxlmd = to_cxl_memdev(mem_dev);
>  	if (data->severity == AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(pdev, cxlmd, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(pdev, pci_get_dsn(pdev),
> +					     &data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(pdev, cxlmd, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(pdev, pci_get_dsn(pdev),
> +					       &data->ras_cap);
>  }
>  EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
>  

