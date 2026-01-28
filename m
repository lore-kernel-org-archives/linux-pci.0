Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533ED32471A;
	Wed, 28 Jan 2026 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619050; cv=none; b=MllEWQtYn3FYiWoBabtacxV8WpYbT4HYLKjZgch3hSv+EYK5pIWiEhQ0FxDY2zh4XDO8yb+XZixIptf8P44g+8ee23HXE6dInmHyUk7+LLs/+kg7a11xwsi71bC3GnydsX21tO7QZ2egMxVIKm6CsGsHIlkw2zLgf5feU/Y8gpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619050; c=relaxed/simple;
	bh=DVw9BJxAoPpEHPQrION90KjVs+dfIp9epNdwWfywfAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQ9vZMMZahKYWW0BesVXAm72VD/ZvbEVaYOvOnPamSwfdYLJQY/UqHaoqf5GCjLp8jSSO9mltbhMfRvXe6r29x4nIVE92vwroJjpGWKLFrDRyqZskDzxn43L48YpaUmWY12lltQh17IKf2JhVfS85krYmHX61MdvS8dTkur0qcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbNYHUqi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbNYHUqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769619049; x=1801155049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DVw9BJxAoPpEHPQrION90KjVs+dfIp9epNdwWfywfAI=;
  b=VbNYHUqi30XKOUHLMkUX+N/jQiT2y2FseJpHnO5imyJ0ZXbYWV1r8Y+V
   0URxxhVEgPX/WPYNmBDV3SfQ3GykUUlc0osFGF/NqNf+K9z3HzzJ6jyQ6
   797WVnxXOslr4Wnfhroqdv7XN3H2SLNbXu0dGa5OTc1HGYefZriDIJHSd
   K+tmtig1dW2v11QPx6LdRcXm56uLAu9fCRaiLH4MsPQmHdqGX4wCtbXFg
   nvyMLyfDFBkobWQSoKZS2UNAWxr8mUMv7N3wF3h9K3clbOGq5GIYumHEN
   GoPJujHJhta0Q+eeSKgPiRjOAHRQy9npnVWlYRwXD2s2jUXD0k1dtnLnl
   Q==;
X-CSE-ConnectionGUID: u7X9FbNHRT+WQgN+3jQ+gQ==
X-CSE-MsgGUID: SjkZRrCCT6aOpvaqVORQyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="88413234"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="88413234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 08:50:47 -0800
X-CSE-ConnectionGUID: f50kd9bzQeO+sj0DQOj/og==
X-CSE-MsgGUID: BFIjtYQWTgGiYnE+FCCn/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208223093"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 08:50:47 -0800
Message-ID: <7cf3c13f-1cef-429b-a9f6-0404bbe721d3@linux.intel.com>
Date: Wed, 28 Jan 2026 08:50:46 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
To: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com, tianruidong@linux.alibaba.com, lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-4-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260124074557.73961-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/23/2026 11:45 PM, Shuai Xue wrote:
> The AER driver has historically avoided reading the configuration space of
> an endpoint or RCiEP that reported a fatal error, considering the link to
> that device unreliable. Consequently, when a fatal error occurs, the AER
> and DPC drivers do not report specific error types, resulting in logs like:
> 
>   pcieport 0015:00:00.0: EDR: EDR event received
>   pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
>   pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
>   pcieport 0015:00:00.0: AER: broadcast error_detected message
>   pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
>   pcieport 0015:00:00.0: AER: broadcast resume message
>   pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
>   pcieport 0015:00:00.0: AER: device recovery successful
>   pcieport 0015:00:00.0: EDR: DPC port successfully recovered
>   pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80
> 
> AER status registers are sticky and Write-1-to-clear. If the link recovered
> after hot reset, we can still safely access AER status and TLP header of the
> error device. In such case, report fatal errors which helps to figure out the
> error root case.
> 
> After this patch, the logs like:
> 
>   pcieport 0015:00:00.0: EDR: EDR event received
>   pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
>   pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
>   pcieport 0015:00:00.0: AER: broadcast error_detected message
> + vfio-pci 0015:01:00.0: AER: Errors reported prior to reset
> + vfio-pci 0015:01:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> + vfio-pci 0015:01:00.0:   device [144d:a80a] error status/mask=00001000/00400000
> + vfio-pci 0015:01:00.0:    [12] TLP                    (First)
> + vfio-pci 0015:01:00.0: AER:   TLP Header: 0x4a004010 0x00000040 0x01000000 0xffffffff
>   pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
>   pcieport 0015:00:00.0: AER: broadcast resume message
>   pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
>   pcieport 0015:00:00.0: AER: device recovery successful
>   pcieport 0015:00:00.0: EDR: DPC port successfully recovered
>   pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---

LGTM. Few suggestions inline.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/pci/pci.h      |  4 +++-
>  drivers/pci/pcie/aer.c | 32 ++++++++++++++++++++++++++++----
>  drivers/pci/pcie/dpc.c |  2 +-
>  drivers/pci/pcie/err.c |  5 +++++
>  4 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 58640e656897..bd020ba0cef0 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -746,8 +746,10 @@ struct aer_err_info {
>  	struct pcie_tlp_log tlp;	/* TLP Header */
>  };
>  
> -int aer_get_device_error_info(struct aer_err_info *info, int i);
> +int aer_get_device_error_info(struct aer_err_info *info, int i,
> +			      bool link_healthy);
>  void aer_print_error(struct aer_err_info *info, int i);
> +void aer_report_frozen_error(struct pci_dev *dev);
>  
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  		      unsigned int tlp_len, bool flit,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e0bcaa896803..4c0a2bbe9197 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1384,12 +1384,14 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
>   * aer_get_device_error_info - read error status from dev and store it to info
>   * @info: pointer to structure to store the error record
>   * @i: index into info->dev[]
> + * @link_healthy: link is healthy or not
>   *
>   * Return: 1 on success, 0 on error.
>   *
>   * Note that @info is reused among all error devices. Clear fields properly.
>   */
> -int aer_get_device_error_info(struct aer_err_info *info, int i)
> +int aer_get_device_error_info(struct aer_err_info *info, int i,
> +			      bool link_healthy)
>  {
>  	struct pci_dev *dev;
>  	int type, aer;
> @@ -1420,7 +1422,8 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>  		   type == PCI_EXP_TYPE_RC_EC ||
>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
> -		   info->severity == AER_NONFATAL) {
> +		   info->severity == AER_NONFATAL ||
> +		   (info->severity == AER_FATAL && link_healthy)) {
>  
>  		/* Link is still healthy for IO reads */
>  		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
> @@ -1447,17 +1450,38 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>  	return 1;
>  }
>  
> +void aer_report_frozen_error(struct pci_dev *dev)

Since this function focuses specifically on printing fatal error details, would
aer_print_fatal_error() be a more descriptive name?

> +{
> +	struct aer_err_info info;
> +	int type = pci_pcie_type(dev);
> +
> +	if (type != PCI_EXP_TYPE_ENDPOINT && type != PCI_EXP_TYPE_RC_END)
> +		return;
> +
> +	info.error_dev_num = 0;
> +	info.severity = AER_FATAL;
> +	info.level = KERN_ERR;
> +	add_error_device(&info, dev);
> +
> +	if (aer_get_device_error_info(&info, 0, true)) {
> +		pci_err(dev, "Errors reported prior to reset\n");

The 'prior to reset' context depends on where this is called. I'd suggest moving
this log to the caller or removing it entirely to keep this helper generic.

> +		aer_print_error(&info, 0);
> +	}
> +
> +	pci_dev_put(dev); /* pairs with pci_dev_get() in add_error_device() */
> +}
> +
>  static inline void aer_process_err_devices(struct aer_err_info *e_info)
>  {
>  	int i;
>  
>  	/* Report all before handling them, to not lose records by reset etc. */
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -		if (aer_get_device_error_info(e_info, i))
> +		if (aer_get_device_error_info(e_info, i, false))
>  			aer_print_error(e_info, i);
>  	}
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -		if (aer_get_device_error_info(e_info, i))
> +		if (aer_get_device_error_info(e_info, i, false))
>  			handle_error_source(e_info->dev[i], e_info);
>  	}
>  }
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f6069f621683..21c4e8371279 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -284,7 +284,7 @@ struct pci_dev *dpc_process_error(struct pci_dev *pdev)
>  		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
>  			 status);
>  		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
> -		    aer_get_device_error_info(&info, 0)) {
> +		    aer_get_device_error_info(&info, 0, false)) {
>  			aer_print_error(&info, 0);
>  			pci_aer_clear_nonfatal_status(pdev);
>  			pci_aer_clear_fatal_status(pdev);
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index bebe4bc111d7..0780ea09478b 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -253,6 +253,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			pci_warn(bridge, "subordinate device reset failed\n");
>  			goto failed;
>  		}
> +
> +		/* Link recovered, report fatal errors of RCiEP or EP */
> +		if (state == pci_channel_io_frozen)

To align with your comment regarding RCiEPs and EPs, should we explicitly
validate the device type here before calling the report function?

> +			aer_report_frozen_error(dev);
> +
>  	}
>  
>  	if (status == PCI_ERS_RESULT_NEED_RESET) {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

