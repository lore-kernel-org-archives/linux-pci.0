Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F84BC015;
	Wed,  6 May 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089391; cv=none; b=dxoTyFhoypvQ2ToIodD8XHdIHAgKg3VODVJpeBSpAAzd9gUiz7Bho0ytV4YTUZlBOw5of8Zwr7uiNgrLILiFpxYs/G9OfCzNX6NbF+spb4WmSU+Uy/9TK9+tHC/xR+bFE99vOkzBbUSVwTZU8hacRoBqZI/vLqhj3dkdq2PTgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089391; c=relaxed/simple;
	bh=uCR3RwTsnrVAjQfKOQZVMImunep76UHiZRuWEpNrqgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC8TPhQElqxkPb0RgZQiV7yXHmLInL6BNtBPtCfT1TfnlcsP7nhL6bkrFYNywVooRElLW0VwxaVv+gwW5TaXjHeQgGoOFSRAX7BcT0yCMdFng6vvJv4CZIWL1QBTZQSzftMsuIuQH5xywJ20T7guYl0Ca+y7wCKbnuihTiSb/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fg54+LwJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fg54+LwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778089388; x=1809625388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uCR3RwTsnrVAjQfKOQZVMImunep76UHiZRuWEpNrqgU=;
  b=fg54+LwJYoJSzTpXILleAHeHLJ6Sw4rDnqeQiMMyfoxzL68an/PKqirb
   L9c98Vm9fnc+BwK1IqhtGiZxPKoiLpYNe8Xs86MyMP3ZurmY5vBfrfnGo
   yrqS39osAglPS/9bZ+5oGm/COOaGhwMcrNaFZovXchguF/74W3ckXSCC0
   RnN+cGQyarDAuvMJt1u89aV05VOeMWTEgqtVFcW3jM/gDEiLLo1AJT4+v
   5k5TmxtT2j2jhn2l9q+qWv48/hlHOV4IW2AxKxC4vJNqq62wO77NnLK5f
   5Ob7uvf0KcqLSLvJqPtnxDIkgYZ2/+C4RGDfJOlBjTXYFxlp1aMlnT/hy
   w==;
X-CSE-ConnectionGUID: l+iDbfaJQMaLsTmzB283YQ==
X-CSE-MsgGUID: MU5BCrykQamuFHD/t/Rcdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82651143"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82651143"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 10:43:06 -0700
X-CSE-ConnectionGUID: KxTuzebqSxWpSISwf2JJjg==
X-CSE-MsgGUID: pUXqmJxZQvK+0lilyXfjQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="233556555"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.169]) ([10.125.110.169])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 10:43:03 -0700
Message-ID: <0cda6505-a217-4c75-b3cb-51a8c396793c@intel.com>
Date: Wed, 6 May 2026 10:43:02 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 09/11] cxl: Update Endpoint AER uncorrectable handler
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, djbw@kernel.org, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, vishal.l.verma@intel.com,
 alucerop@amd.com, ira.weiny@intel.com, corbet@lwn.net, rafael@kernel.org,
 xueshuai@linux.alibaba.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-10-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260505173029.2718246-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 10:30 AM, Terry Bowman wrote:
> The CXL cxl_core driver now implements protocol RAS support. PCI
> uncorrectable (UCE) protocol errors, however, continue to be reported via
> the AER capability and must still be handled by a PCI error recovery callback.
> UCE handling is required to provide direction for recovery.
> 
> Replace the existing cxl_error_detected() callback in cxl/pci.c with a new
> cxl_pci_error_detected() implementation that handles uncorrectable AER PCI
> protocol errors.
> 
> The handler decides solely based on the pci_channel_state_t parameter and
> does not access PCIe AER capability registers from .error_detected, matching
> the pattern used by other drivers including the NVMe and ixgbe drivers.
> CXL.cachemem-corrupting protocol errors are routed separately through the
> AER-CXL kfifo to cxl_handle_proto_error(), so cxl_pci does not need to
> second-guess the AER core's classification.
> 
> claude-opus-4.7 was used for research on PCI error state transitions and
> requirements.
> 
> Assisted-by: Claude:claude-opus-4.7
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v16->v17:
> - Rename pci_error_handlers struct instance to cxl_pci_error_handlers to
>   avoid shadowing the struct type tag.
> - Restore scoped_guard(device) and dev->driver check around AER read.
> - NULL-check find_cxl_port_by_dev() before deref of port->uport_dev.
> - Updated commit message. (Terry)
> - Add scope cleanup for port variable in cxl_pci_error_detected() (Terry)
> - Drop cxl_uncor_aer_present(), rely on AER state
> 
> Changes in v15->v16:
> - Update commit message (DaveJ)
> - s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
> - cxl_uncor_aer_present(): Leave original result calculation based on
>   if a UCE is present and the provided state (Terry)
> - Add call to pci_print_aer(). AER fails to log because is upstream
>   link (Terry)
> 
> Changes in v14->v15:
> - Update commit message and title. Added Bjorn's ack.
> - Move CE and UCE handling logic here
> 
> Changes in v13->v14:
> - Add Dave Jiang's review-by
> - Update commit message & headline (Bjorn)
> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>   one line (Jonathan)
> - Remove cxl_walk_port() (Dan)
> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>   sufficient (Dan)
> - Remove device_lock_if()
> - Combined CE and UCE here (Terry)
> 
> Changes in v12->v13:
> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>   patch (Terry)
> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> - Remove check for dport->dport_dev (Dave)
> - Remove whitespace (Terry)
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/ras.c | 43 ++++++++++++++++--------------------------
>  drivers/cxl/cxlpci.h   |  8 ++++----
>  drivers/cxl/pci.c      |  6 +++---
>  3 files changed, 23 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 5cc4087c2807..a98ce0f412ad 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -253,38 +253,27 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	return true;
>  }
>  
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t state)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port __free(put_cxl_port) =
> +		find_cxl_port_by_dev(&pdev->dev, &dport);

Move this to right before 'port' is being checked. It's ok to do inline var declaration with __free().

DJ

> +	struct cxl_memdev *cxlmd;
> +	struct device *dev;
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> -		}
> +	if (!port)
> +		return PCI_ERS_RESULT_DISCONNECT;
>  
> -		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> -		 */
> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
> -				    cxlmd->endpoint->regs.ras);
> -	}
> +	cxlmd = to_cxl_memdev(port->uport_dev);
> +	dev = &cxlmd->dev;
>  
>  	switch (state) {
>  	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
> +		/*
> +		 * Non-fatal CXL protocol errors are handled asynchronously
> +		 * by the AER-CXL kfifo worker (cxl_proto_err_work_fn).
> +		 */
>  		return PCI_ERS_RESULT_CAN_RECOVER;
>  	case pci_channel_io_frozen:
>  		dev_warn(&pdev->dev,
> @@ -299,7 +288,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	}
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
>  
>  static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport, int severity)
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 06c46adcf0f6..8aeb80a4e573 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -89,13 +89,13 @@ struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_RAS
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state);
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t state);
>  void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
>  void devm_cxl_port_ras_setup(struct cxl_port *port);
>  #else
> -static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -						  pci_channel_state_t state)
> +static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +						      pci_channel_state_t state)
>  {
>  	return PCI_ERS_RESULT_NONE;
>  }
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5eb64ced0de5..6459f94f8fa8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1000,8 +1000,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	}
>  }
>  
> -static const struct pci_error_handlers cxl_error_handlers = {
> -	.error_detected	= cxl_error_detected,
> +static const struct pci_error_handlers cxl_pci_error_handlers = {
> +	.error_detected	= cxl_pci_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
>  	.reset_done	= cxl_reset_done,
> @@ -1011,7 +1011,7 @@ static struct pci_driver cxl_pci_driver = {
>  	.name			= KBUILD_MODNAME,
>  	.id_table		= cxl_mem_pci_tbl,
>  	.probe			= cxl_pci_probe,
> -	.err_handler		= &cxl_error_handlers,
> +	.err_handler		= &cxl_pci_error_handlers,
>  	.dev_groups		= cxl_rcd_groups,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,

