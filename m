Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDED2DECCB
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107299; cv=none; b=uvjEEITtWbyf6mTpedmFJmD0oM0wUT2lfyoo9QXnMtBzhPcsZm/Fi/dsatqHa0wrMMQvsyjEdwTeTYQ4vFWDBrinOgNubbwjLGBH9qpflf+gCyOn6SheZ47xhtF0xyV021wxbZQzniN8IOCMVaPCgS4P2tajiXops/SV+np0D7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107299; c=relaxed/simple;
	bh=Y1rNeHZ4jPBWHCjJx/O4tJLqma2U9Pvm6I9rJdcfwxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j40a+6tMRkriAjE8nQk70T55CM5mRDh9h7SVNVSk+CIsvFKgB6e6ajdlXNBm4fIC4yZbIHsv+Yl3shrgbaqylHplHwsAzdPbkzeDGnPiebBjB1nLoueO14KJtX+TTEnVAhECVbht8rFaKkDJ6FSg+Z3e7WXhuMO5dbOk1R4/H/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CLkZX5Br; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CLkZX5Br"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=H+g2+7qeR9C234KWcyqoiBVv0qGSAUJhWsZ14nymImc=;
	b=CLkZX5BrKeqtcelvZQ48Z2DxCOwnPhcwKQELsodc9Aa0xPoiU9XoxDqVldl63nK23sL6FAjrP
	vyAIxuPw4NEB1EowhjvZ2t7D7qD2QUSHt635ztTL9VNiMaGhimrIwAsYrZrNNPMwAH8vgoxZO3M
	YHtXmMZffv1p/7v75h48uuY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fVGqV34FDzKm5n;
	Tue, 10 Mar 2026 09:43:18 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AE7E40565;
	Tue, 10 Mar 2026 09:48:13 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 09:48:13 +0800
Received: from [10.67.120.233] (10.67.120.233) by
 kwepemn200012.china.huawei.com (7.202.194.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 09:48:12 +0800
Message-ID: <5537e99d-0b99-4b10-aa91-9511c90a56e7@huawei.com>
Date: Tue, 10 Mar 2026 09:48:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI/AER: Fix missing AER logs in DPC and EDR paths
To: <bhelgaas@google.com>, <jonathan.cameron@huawei.com>,
	<shiju.jose@huawei.com>, <pandoh@google.com>
CC: <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <shenyang39@huawei.com>,
	<xueshuai@linux.alibaba.com>, Lukas Wunner <lukas@wunner.de>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <terry.bowman@amd.com>
References: <20260214081130.1878424-1-liusizhe5@huawei.com>
From: Sizhe Liu <liusizhe5@huawei.com>
In-Reply-To: <20260214081130.1878424-1-liusizhe5@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn200012.china.huawei.com (7.202.194.135)

Hi all,

Just a gentel ping on this patch and +cc others interested in error 
handling.

Regards,
Sizhe

On 2026/2/14 16:11, Sizhe Liu wrote:
> Current DPC and EDR processing paths fail to print complete AER logs
> information: aer_print_error() returns early without printing logs
> due to uninitialized ratelimit_print variables.
>
> Phenomenon:
> -- Error log abnormal
> pcieport 0000:20:00.0: DPC: containment event, status: 0x1f11: unmasked uncorrectable error detected
> (------ AER logs should be printed here, but are missing ------)
> nvme nvme0: frozen state error detected, reset controller
> {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
>
> Root cause analysis:
> In aer_print_error(), PCIe AER errors are rate-limited via info->ratelimit_print[i],
> but this variable is not initialized in DPC/EDR paths, leading to
> early return before log printing.
>
> aer_print_error() entry points and key logic:
> 1) Native AER path (working correctly):
> aer_isr_one_error_type(aer_err_info)
>      find_source_device(aer_err_info)
>          find_device_iter(aer_err_info)
>              add_error_device(aer_err_info)
>                  pci_dev_get(aer_err_info)                 <-- Get refcount
>                  if (aer_ratelimit(aer_err_info->severity))
>                      info->ratelimit_print[i] = 1        <-- Init ratelimit
>      aer_process_err_devices(aer_err_info)
>          aer_print_error(aer_err_info)
>              if (!info->ratelimit_print[i])
>                  return;
>              __aer_print_error()                         <-- Print AER info
>          handle_error_source(aer_err_info)
>              pci_dev_put()                             <-- Release refcount
>
> 2) DPC path (missing ratelimit init; refcount not held):
> dpc_handler()
>      dpc_process_error()
>          dpc_get_aer_uncorrect_severity(aer_err_info)
>          aer_get_device_error_info(aer_err_info)
>          aer_print_error(aer_err_info)
>              if (!info->ratelimit_print[i])
>                  return;                          <-- Early return (no log)
>              __aer_print_error()
>
> 3) EDR path (missing ratelimit init only):
> edr_handle_event()
>      acpi_dpc_port_get()
>          pci_dev_get() / pci_get_domain_bus_and_slot()     <-- Get refcount
>      dpc_process_error()
>          dpc_get_aer_uncorrect_severity(aer_err_info)
>          aer_get_device_error_info(aer_err_info)
>          aer_print_error(aer_err_info)
>              if (!info->ratelimit_print[i])
>                  return;                          <-- Early return (no log)
>              __aer_print_error()
>      pci_dev_put()    <-- Release refcount
>
> Fix approach (minimal intrusive):
> 1. Extract the initialization of info->ratelimit_print[i]
> and e_info->root_ratelimit_print into aer_ratelimit_print_init().
> 2. Call aer_ratelimit_print_init() in dpc_process_error() to initialize
> ratelimit variables for DPC/EDR paths.
> 3. Add pci_dev_get()/pci_dev_put() pairs in dpc_handler() to align
> DPC path with EDR and native AER paths.
>
> Note on not using add_error_device() directly:
> https://lore.kernel.org/linux-pci/962a43ca-9593-430b-9a89-1591a5ae9bf9@huawei.com/
>
> Test case (AER error injection):
> - Enable DPC toggle in BIOS.
> - Inject MalfTLP (AER FATAL ERROR) to target device.
>
> Test result (normal error log):
> pcieport 0000:20:00.0: DPC: containment event, status:0x1f11: unmasked uncorrectable error detected
> pcieport 0000:20:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> pcieport 0000:20:00.0: device [19e5:a120] error status/mask=00040000/04580000
> pcieport 0000:20:00.0:    [18] MalfTLP   (First)
> pcieport 0000:20:00.0: AER:   TLP Header: 0x00000000 0x00000000 0x00000000 0x00000000
> nvme nvme0: frozen state error detected, reset controller
> {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
>
> [1] https://lore.kernel.org/linux-pci/20260127035405.712271-1-liusizhe5@huawei.com/
> [2] https://lore.kernel.org/linux-pci/20260129140103.712011-1-liusizhe5@huawei.com/
>
> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
> ---
> v1 -> v2
> - Corrected the format and spelling errors in the commit log.
>
> v2 -> v3
> - Add PCI device reference count handling in the DPC path.
>
>   drivers/pci/pci.h      |  2 ++
>   drivers/pci/pcie/aer.c | 36 ++++++++++++++++++++++++------------
>   drivers/pci/pcie/dpc.c |  3 +++
>   3 files changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c8a0522e2e1f..070ef360189e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -840,6 +840,8 @@ struct aer_err_info {
>   
>   int aer_get_device_error_info(struct aer_err_info *info, int i);
>   void aer_print_error(struct aer_err_info *info, int i);
> +void aer_ratelimit_print_init(struct pci_dev *dev, struct aer_err_info *e_info,
> +			int idx);
>   
>   int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>   		      unsigned int tlp_len, bool flit,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2b0ac6bfdd76..f8d248e397ce 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -972,6 +972,29 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   }
>   EXPORT_SYMBOL_GPL(pci_print_aer);
>   
> +/**
> + * aer_ratelimit_print_init - set flag whether error message should be printed
> + * @dev: pointer to pci_dev to be rate-limited
> + * @e_info: pointer to aer error info
> + * @idx: index for dev array in aer error info
> + */
> +void aer_ratelimit_print_init(struct pci_dev *dev, struct aer_err_info *e_info,
> +			int idx)
> +{
> +	/*
> +	 * Ratelimit AER log messages.  "dev" is either the source
> +	 * identified by the root's Error Source ID or it has an unmasked
> +	 * error logged in its own AER Capability.  Messages are emitted
> +	 * when "ratelimit_print[i]" is non-zero.  If we will print detail
> +	 * for a downstream device, make sure we print the Error Source ID
> +	 * from the root as well.
> +	 */
> +	if (aer_ratelimit(dev, e_info->severity)) {
> +		e_info->ratelimit_print[idx] = 1;
> +		e_info->root_ratelimit_print = 1;
> +	}
> +}
> +
>   /**
>    * add_error_device - list device to be handled
>    * @e_info: pointer to error info
> @@ -987,18 +1010,7 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>   	e_info->dev[i] = pci_dev_get(dev);
>   	e_info->error_dev_num++;
>   
> -	/*
> -	 * Ratelimit AER log messages.  "dev" is either the source
> -	 * identified by the root's Error Source ID or it has an unmasked
> -	 * error logged in its own AER Capability.  Messages are emitted
> -	 * when "ratelimit_print[i]" is non-zero.  If we will print detail
> -	 * for a downstream device, make sure we print the Error Source ID
> -	 * from the root as well.
> -	 */
> -	if (aer_ratelimit(dev, e_info->severity)) {
> -		e_info->ratelimit_print[i] = 1;
> -		e_info->root_ratelimit_print = 1;
> -	}
> +	aer_ratelimit_print_init(dev, e_info, i);
>   	return 0;
>   }
>   
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fc18349614d7..6ee1f3daa766 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -275,6 +275,7 @@ void dpc_process_error(struct pci_dev *pdev)
>   			 status);
>   		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
>   		    aer_get_device_error_info(&info, 0)) {
> +			aer_ratelimit_print_init(pdev, &info, 0);
>   			aer_print_error(&info, 0);
>   			pci_aer_clear_nonfatal_status(pdev);
>   			pci_aer_clear_fatal_status(pdev);
> @@ -372,11 +373,13 @@ static irqreturn_t dpc_handler(int irq, void *context)
>   		return IRQ_HANDLED;
>   	}
>   
> +	pci_dev_get(pdev);
>   	dpc_process_error(pdev);
>   
>   	/* We configure DPC so it only triggers on ERR_FATAL */
>   	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
>   
> +	pci_dev_put(pdev);
>   	return IRQ_HANDLED;
>   }
>   
