Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02F35F17A
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261400; cv=none; b=A7hoFu54d0tJI1cPsjnxnFbrbhx5fcEQOqFLlxU1GuhO1TRSTPUGxfnTPYQX94DQALGlLUVMglBMgFwP1qmeLAyk8x0+pd2sG0gq6IcRL4bqHeCCdu/LNHNpA50tSTCUdDkx4dIAIOI9J7//R1qujga85/kn+H6lVX8Mmvdux+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261400; c=relaxed/simple;
	bh=qYYq9QByiFqeLn0pfmXjVP+hCnljDFrAmENHAGDV6aY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aT+/DlO0EDLn0RA4dNzQhqM4mS8LRqq2Yroh6jjTVou/+W59lNPBL6SSFJBrZQjYCavKxuKZ5LG+Ed8NdQxyFEmClvrCglU+02yno96JWHPxi5e6WK4pSwdhhK5Q6lqjzVifRi2JWzK/UQhWUxnrZ7QyE3gX/ry4E4a98lEXCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoyJkR/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoyJkR/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D3FC116C6;
	Wed, 11 Mar 2026 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773261400;
	bh=qYYq9QByiFqeLn0pfmXjVP+hCnljDFrAmENHAGDV6aY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VoyJkR/M/IxOUME9ZYoX2VqhcATj/vDmi/gf+ibPlgD2199PdCtaEZ5ns/l1V1tAJ
	 5YPZVmp5Q+tA6cRQ6tAPbO56Qyk8Pq5hxmVSOpIvFOmtA2f+nOcawLPLj5N4gtURRN
	 4FoOXdl70j0fWRofMTbvhpg+c+BnbuAuUmtCKFCa2tVyD0fMZvS9sk/CiCN4wIu0FN
	 BBmr5w9ApuUB+EW5ee7OtkZge+2FvY9CnNgTNe+bQBBTrYJRyC8o/3z+BJBnTzDC2R
	 tUI6j8gJKSkR4zwKJ5GHjKC2dzaYTYF8D2QXVoNI1Nd0c9IWpTVX5GXjinW5lvmU8n
	 LTfqUY1jEcFSw==
Date: Wed, 11 Mar 2026 15:36:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sizhe Liu <liusizhe5@huawei.com>
Cc: bhelgaas@google.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>, Jon Pan-Doh <pandoh@google.com>,
	linux-pci@vger.kernel.org, linuxarm@huawei.com,
	Zeng Tao <prime.zeng@hisilicon.com>,
	Hao Fang <fanghao11@huawei.com>, Yang Shen <shenyang39@huawei.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v3] PCI/AER: Fix missing AER logs in DPC and EDR paths
Message-ID: <20260311203639.GA1008208@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214081130.1878424-1-liusizhe5@huawei.com>

On Sat, Feb 14, 2026 at 04:11:30PM +0800, Sizhe Liu wrote:
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
>     find_source_device(aer_err_info)
>         find_device_iter(aer_err_info)
>             add_error_device(aer_err_info)
>                 pci_dev_get(aer_err_info)                 <-- Get refcount
>                 if (aer_ratelimit(aer_err_info->severity))
>                     info->ratelimit_print[i] = 1        <-- Init ratelimit
>     aer_process_err_devices(aer_err_info)
>         aer_print_error(aer_err_info)
>             if (!info->ratelimit_print[i])
>                 return;
>             __aer_print_error()                         <-- Print AER info
>         handle_error_source(aer_err_info)
>             pci_dev_put()                             <-- Release refcount
> 
> 2) DPC path (missing ratelimit init; refcount not held):
> dpc_handler()
>     dpc_process_error()
>         dpc_get_aer_uncorrect_severity(aer_err_info)
>         aer_get_device_error_info(aer_err_info)
>         aer_print_error(aer_err_info)
>             if (!info->ratelimit_print[i])
>                 return;                          <-- Early return (no log)
>             __aer_print_error()
> 
> 3) EDR path (missing ratelimit init only):
> edr_handle_event()
>     acpi_dpc_port_get()
>         pci_dev_get() / pci_get_domain_bus_and_slot()     <-- Get refcount
>     dpc_process_error()
>         dpc_get_aer_uncorrect_severity(aer_err_info)
>         aer_get_device_error_info(aer_err_info)
>         aer_print_error(aer_err_info)
>             if (!info->ratelimit_print[i])
>                 return;                          <-- Early return (no log)
>             __aer_print_error()
>     pci_dev_put()    <-- Release refcount
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

Applied to pci/dpc for v7.1, thank you!

I split this into two patches (holding the ref and fixing the
ratelimit) and shortened commit log, function name, and parameters to
match the surrounding code:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=1ca15d3c1b05
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=8f690004ff9c

> ---
> v1 -> v2
> - Corrected the format and spelling errors in the commit log.
> 
> v2 -> v3
> - Add PCI device reference count handling in the DPC path.
> 
>  drivers/pci/pci.h      |  2 ++
>  drivers/pci/pcie/aer.c | 36 ++++++++++++++++++++++++------------
>  drivers/pci/pcie/dpc.c |  3 +++
>  3 files changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c8a0522e2e1f..070ef360189e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -840,6 +840,8 @@ struct aer_err_info {
>  
>  int aer_get_device_error_info(struct aer_err_info *info, int i);
>  void aer_print_error(struct aer_err_info *info, int i);
> +void aer_ratelimit_print_init(struct pci_dev *dev, struct aer_err_info *e_info,
> +			int idx);
>  
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  		      unsigned int tlp_len, bool flit,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2b0ac6bfdd76..f8d248e397ce 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -972,6 +972,29 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  }
>  EXPORT_SYMBOL_GPL(pci_print_aer);
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
>  /**
>   * add_error_device - list device to be handled
>   * @e_info: pointer to error info
> @@ -987,18 +1010,7 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>  	e_info->dev[i] = pci_dev_get(dev);
>  	e_info->error_dev_num++;
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
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index fc18349614d7..6ee1f3daa766 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -275,6 +275,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  			 status);
>  		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
>  		    aer_get_device_error_info(&info, 0)) {
> +			aer_ratelimit_print_init(pdev, &info, 0);
>  			aer_print_error(&info, 0);
>  			pci_aer_clear_nonfatal_status(pdev);
>  			pci_aer_clear_fatal_status(pdev);
> @@ -372,11 +373,13 @@ static irqreturn_t dpc_handler(int irq, void *context)
>  		return IRQ_HANDLED;
>  	}
>  
> +	pci_dev_get(pdev);
>  	dpc_process_error(pdev);
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */
>  	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
>  
> +	pci_dev_put(pdev);
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.33.0
> 
