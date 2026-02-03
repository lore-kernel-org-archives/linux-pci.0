Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0733B6E6;
	Tue,  3 Feb 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139900; cv=none; b=Cot3P8JSJ3YVhKlI6aOXNQA7DV0xZOoyK0KPzRVaFFxNwtF4NIcw6k1sI6nWrOF932O/OgimE3BknlUd0E4/caH7AVTznVzYbSZGiezDp5WWJv98nQ6yXvMksM0x9b4OVxO8NK5SPvTWH4+bJy68eRPgXF+TxUBDsC1Twa6oZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139900; c=relaxed/simple;
	bh=0DyiDRW35qStuo/PK7oLV3p0wpVgLaHDouEOr32SFwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/VdCPKPlU2sp8OWzYjO2H+sAo7c+jP3sqQ7SauAlkidgzVkQZyKfpM7jhIXbkUPvb3IadrYFTP5omWOv179uH7I2XHAMdAvNnf949CPx3lWWMotF9CMU49lfvpZmGGnb79NsBCrHVbMoljxBGNtWHOgmfCY+mcf/VE5GXvBN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbgN0qR4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbgN0qR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770139899; x=1801675899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0DyiDRW35qStuo/PK7oLV3p0wpVgLaHDouEOr32SFwM=;
  b=bbgN0qR4ueqkRGa9L0IUMdkigxqJD67s+YByu6CMAq3veoUVwKeTI62G
   zHv0MpuXNS7P9WrU6411r8nAq+ZB7+CMbIraolYqLn+3AXw8SplIp2TfW
   MAszsUyrQGkcqiCTsh7W7OQsSKdfbnTvPI6aAWC5JarIcWnpzWmSdPGMU
   ngeXwksaSIAWf7t763afn8dF+u0ISPrgmRxrAdX6LyU+gbAPOv2dGzW1x
   8muQfRMqGHbBP0jQPENmv4n1GtUdAJHM0PsX1u/YfgIg/yX68mT2Ha9At
   Me8fzyUdHJl9VLQvMPPUVFlj6ulzCJEgdLu7U6aWuDLKYBEmqsn9oUjlN
   Q==;
X-CSE-ConnectionGUID: ZcZ3nYhhRKCk62CuGiGdLA==
X-CSE-MsgGUID: DiwzBhuzQlGkxFdnGhY+dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="73916483"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="73916483"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:31:38 -0800
X-CSE-ConnectionGUID: +Y4SG04aSfWURMm4lRqBxA==
X-CSE-MsgGUID: 0gVqM9MwRIaCtE7lZBBCJg==
X-ExtLoop1: 1
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.221]) ([10.125.110.221])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:31:36 -0800
Message-ID: <cecc5dd9-616a-4b8b-b081-d77ac947ccad@intel.com>
Date: Tue, 3 Feb 2026 10:31:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 7/9] cxl: Update Endpoint AER uncorrectable handler
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-8-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260203025244.3093805-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/2/26 7:52 PM, Terry Bowman wrote:
> CXL drivers now implement protocol RAS support. PCI protocol errors,
> however, continue to be reported via the AER capability and must still be
> handled by a PCI error recovery callback.
> 
> Replace the existing cxl_error_detected() callback in cxl/pci.c with a
> new cxl_pci_error_detected() implementation that handles only uncorrectable
> PCI protocol errors reported through AER.

Do we need to explain why only uncorrectable is handled?

> 
> Introduce helper named cxl_handler_aer() amd implement to handle and
> log the CXL device's AER error.
> 
> This cleanly separates CXL protocol error handling from PCI AER handling
> and ensures that each subsystem processes only the errors it is
> responsible.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v14->v15:
> - Title update (Terry)
> - Change cxl_pci_error-detected() to handle & log AER (Terry)
> - Update commit message (Terry)
> - Moved cxl_handle_ras()/cxl_handle_cor_ras() to earlier patch (Terry)
> 
> Changes in v13->v14:
> - Update commit headline (Bjorn)
> - Rename pci_error_detected()/pci_cor_error_detected() ->
>   cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
> - Remove now-invalid comment in cxl_error_detected() (Jonathan)
> - Split into separate patches for UCE and CE (Terry)
> 
> Changes in v12->v13:
> - Update commit messaqge (Terry)
> - Updated all the implementation and commit message. (Terry)
> - Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
>   pdev (Dave Jiang)
> 
> Changes in v11->v12:
> - None
> 
> Changes in v10->v11:
> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
> - cxl_error_detected() - Remove extra line (Shiju)
> - Changes moved to core/ras.c (Terry)
> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
> - Move #include "pci.h from cxl.h to core.h (Terry)
> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
> ---
>  drivers/cxl/core/ras.c | 68 +++++++++++++++---------------------------
>  drivers/cxl/cxlpci.h   |  9 +++---
>  drivers/cxl/pci.c      |  6 ++--
>  3 files changed, 31 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 970ff3df442c..061e6aaec176 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -441,55 +441,35 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +static bool cxl_handle_aer(struct pci_dev *pdev)

For a function that returns a bool, the function name doesn't sound quite right. Maybe cxl_uncor_aer_present()?

DJ

>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> -
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> -		}
> +	struct aer_capability_regs aer;
> +	u32 aer_cap = pdev->aer_cap;
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> -		 */
> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
> -				    cxlmd->endpoint->regs.ras);
> +	if (!aer_cap) {
> +		pr_warn_ratelimited("%s: AER capability isn't present\n",
> +				    pci_name(pdev));
> +		return false;
>  	}
>  
> -	switch (state) {
> -	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
> -		return PCI_ERS_RESULT_CAN_RECOVER;
> -	case pci_channel_io_frozen:
> -		dev_warn(&pdev->dev,
> -			 "%s: frozen state error detected, disable CXL.mem\n",
> -			 dev_name(dev));
> -		device_release_driver(dev);
> -		return PCI_ERS_RESULT_NEED_RESET;
> -	case pci_channel_io_perm_failure:
> -		dev_warn(&pdev->dev,
> -			 "failure state error detected, request disconnect\n");
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> -	return PCI_ERS_RESULT_NEED_RESET;
> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_STATUS, &aer.uncor_status);
> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_MASK, &aer.uncor_mask);
> +
> +	/* The AER driver logged the error */
> +	pci_aer_clear_nonfatal_status(pdev);
> +	pci_aer_clear_fatal_status(pdev);
> +
> +	return (aer.uncor_status & aer.uncor_mask);
> +}
> +
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t error)
> +{
> +	u32 rc = cxl_handle_aer(pdev);
> +
> +	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_CAN_RECOVER;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
>  
>  static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>  {
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 970add0256e9..5534422b496c 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -79,15 +79,14 @@ void read_cdat_data(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_RAS
>  void cxl_cor_error_detected(struct pci_dev *pdev);
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state);
>  void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t error);
>  void devm_cxl_port_ras_setup(struct cxl_port *port);
>  #else
>  static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
> -
> -static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -						  pci_channel_state_t state)
> +static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +						      pci_channel_state_t state)
>  {
>  	return PCI_ERS_RESULT_NONE;
>  }
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index acb0eb2a13c3..ff741adc7c7f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1051,8 +1051,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	}
>  }
>  
> -static const struct pci_error_handlers cxl_error_handlers = {
> -	.error_detected	= cxl_error_detected,
> +static const struct pci_error_handlers pci_error_handlers = {
> +	.error_detected	= cxl_pci_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
>  	.cor_error_detected	= cxl_cor_error_detected,
> @@ -1063,7 +1063,7 @@ static struct pci_driver cxl_pci_driver = {
>  	.name			= KBUILD_MODNAME,
>  	.id_table		= cxl_mem_pci_tbl,
>  	.probe			= cxl_pci_probe,
> -	.err_handler		= &cxl_error_handlers,
> +	.err_handler		= &pci_error_handlers,
>  	.dev_groups		= cxl_rcd_groups,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,

