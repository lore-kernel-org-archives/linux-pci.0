Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CC2FD66D
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770408648; cv=none; b=PoN3R0hAILFP7j+XSrI6ma0SvrDpdqLorLy99f9Xk64h//OwqAXvoGDdmBu8lJgmkkjY6Nkc741Ohi0/a456gcbiBUi8taiMj4v6vgXq/kSi/PeaXg1VZ92XLk9XlAs2WFOeQkPejLC1mSsXBEl8+HgZtdGSmd7aQyRLtE2qVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770408648; c=relaxed/simple;
	bh=wU2JrBVcnQUxqAfz0N2cgbFsG87BCwHty61E36yoPUw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MTn6gGxR9GpXB3r39/FPy+Y0Dv4knZXdBD1+KWQkJWnQfvkEue/WT+5rRFIbN0Nt0BSzoFDXH93DyzpjUnWwpEyHUx4Z2uPsxxa4xpjyLK2p772LnAPFY8nGF7up+4GyZufelzYmfv0xb4KCgB7lhiGheY/+hdT6X1PFmY7+rWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8J1FfSl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8J1FfSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8421EC116C6;
	Fri,  6 Feb 2026 20:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770408647;
	bh=wU2JrBVcnQUxqAfz0N2cgbFsG87BCwHty61E36yoPUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i8J1FfSlpIQYsyladqgVkLtVT0ZZxIP11gQ61m74ZTE6jyvpKNLUqUDnfUznnuTui
	 zaiBJon25q9MVL5Zpwz6P/MCwU3DY3UxRRvC99T5D7gQIIRMUQeLc01q4Ezdpj2vWB
	 /WkDNVmT12Oioes2Tfmrl7KzlsggaK4pADFAdo5IfDHucIKJOMVdzmwNcquGxE9Ie6
	 WgkXwQOe6XE5QtbOdsvdgpa3VVdRgd7kdJFurphXS9Z8wnJUF1bs9sD94joOqyYTUN
	 qOhvviORP4IfO9zhkhMdpCEBNZQJZQl2z13jIOLF1ThBwB5h9QpynnHexJIwDe5Frw
	 1Rl8tAzGOkpUA==
Date: Fri, 6 Feb 2026 14:10:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sizhe Liu <liusizhe5@huawei.com>
Cc: bhelgaas@google.com, jonathan.cameron@huawei.com, shiju.jose@huawei.com,
	pandoh@google.com, linux-pci@vger.kernel.org, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, fanghao11@huawei.com,
	shenyang39@huawei.com
Subject: Re: [PATCH v2] PCI/AER: Fix AER log missing in DPC case
Message-ID: <20260206201046.GA75132@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129140103.712011-1-liusizhe5@huawei.com>

On Thu, Jan 29, 2026 at 10:01:03PM +0800, Sizhe Liu wrote:
> In the current DPC error reporting case, some AER log information is missing.
> 
> -- Error log abnormal
> pcieport 0000:20:00.0: DPC: containment event, status: 0x1f11: unmasked uncorrectable error detected
> (------ AER error log supposed to be printed here, but missing ------)
> nvme nvme0: frozen state error detected, reset controller
> {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
> 
> Cause:
> In aer_print_error(), PCIe AER errors is reported, and is rate-limited
> by info->ratelimit_print[i]. There are two entry points for
> aer_print_error().
> 
> 1) Native AER
> aer_isr_one_error_type() -> aer_process_err_devices() ->
> aer_print_error()
> 2) DPC
> dpc_process_error() -> aer_print_error()
> 
> The value of info->ratelimit_print[i] is initialized correctly in
> the native AER case:
> aer_isr_one_error_type() -> find_source_device() ->
> find_device_iter() -> add_error_device()
> 
> In the DPC case, info->ratelimit_print[i] is not initialized and
> alloc by 0 , so in aer_print_error(), it will directly return at line
> if (!info->ratelimit_print[i])
> This will result in losing the AER log messages in the DPC case.
> 
> Solution:
> 1. Move the initialization of info->ratelimit_print[i] to
> aer_ratelimit_print_init().
> 2. Add aer_ratelimit_print_init() in dpc_process_error().
> 3. Replace the initialization by aer_ratelimit_print_init()in
> Native AER case.

I see the problem, and I think you're right that we're not logging any
AER info for DPC events (including events handled via the EDR path,
which also calls dpc_process_error()).

Currently we do the ratelimit init in add_error_device(), which also
includes pci_dev_get() for the device.  I don't see a similar
pci_dev_get() anywhere in the DPC path.  There is one in the EDR path:

  edr_handle_event
    acpi_dpc_port_get
      pci_dev_get                    <--
    dpc_process_error
      aer_get_device_error_info(aer_err_info)
      aer_print_error(aer_err_info)
    pcie_do_recovery
    pci_dev_put

Maybe DPC and EDR should be using add_error_device() directly?  It
seems like holding that reference on the device is important.

> Test with AER inject:
> Set the DPC reporting priority in the BIOS and send
> MalfTLP(AER FATAL ERROR) to device.
> 
> -- Error log normal
> pcieport 0000:20:00.0: DPC: containment event, status:0x1f11: unmasked uncorrectable error detected
> pcieport 0000:20:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> pcieport 0000:20:00.0: device [19e5:a120] error status/mask=00040000/04580000
> pcieport 0000:20:00.0:    [18] MalfTLP   (First)
> pcieport 0000:20:00.0: AER:   TLP Header: 0x00000000 0x00000000 0x00000000 0x00000000
> nvme nvme0: frozen state error detected, reset controller
> {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
> 
> [1] https://lore.kernel.org/linux-pci/20260127035405.712271-1-liusizhe5@huawei.com/
> 
> Fixes: a57f2bfb4a58 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
> ---
> v2
> - Corrected the format and spelling errors in the commit log.
> 
>  drivers/pci/pci.h      |  1 +
>  drivers/pci/pcie/aer.c | 35 +++++++++++++++++++++++------------
>  drivers/pci/pcie/dpc.c |  1 +
>  3 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0e67014aa001..0cbcbcd52354 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -748,6 +748,7 @@ struct aer_err_info {
>  
>  int aer_get_device_error_info(struct aer_err_info *info, int i);
>  void aer_print_error(struct aer_err_info *info, int i);
> +void aer_ratelimit_print_init(struct pci_dev *dev, struct aer_err_info *e_info, int idx);
>  
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  		      unsigned int tlp_len, bool flit,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e0bcaa896803..b73915b63327 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -925,6 +925,28 @@ int cper_severity_to_aer(int cper_severity)
>  EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  #endif
>  
> +/**
> + * aer_ratelimit_print_init - set flag whether error message is printed
> + * @dev: pointer to pci_dev to be rate-limited
> + * @e_info: pointer to error info
> + * @idx: index for ratelimit_print array
> + */
> +void aer_ratelimit_print_init(struct pci_dev *dev, struct aer_err_info *e_info, int idx)
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
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		   struct aer_capability_regs *aer)
>  {
> @@ -990,18 +1012,7 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
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
> index fc18349614d7..d17adc642781 100644
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
> -- 
> 2.33.0
> 
