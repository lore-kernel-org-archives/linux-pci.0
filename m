Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94D25524C
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194422; cv=none; b=pw2D4an5p5+IGtYcbHHdVaA4BQG+Pc9q4vOmGqKbpm/Vhtkz1+sgPnLJCmws0l+wJF05gOmqvRT3UFcRV3Fl+4aAlx2xbzh10bKDAjwCch2Ot5k8NrbHHCdzGiUSOEPpYStMIrkuSvnaY9cUrkY/pP1Sczsoj+5M/KL+kBprs5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194422; c=relaxed/simple;
	bh=98XtrGgu8HiCVk1DMGWdBJTFvpBhDmwOgVvw6d0g9NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuYIAMLId/tip69rufrY+NOxW0aiSELNeRiDcYBKvaZMKWI1M1YeaO9OZk0riibEKoz0stJhjAhR4Z5GTsjeAMu1JMEsyfuQ7+z436QavdKaHN4KZxMz6Pd1YQgmCT5AYnlC+9RgGnYhUsd5SnrsPjDTgZRHX8vCyLFogiZ3wZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmRfQfeg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmRfQfeg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B677DC4CEF1;
	Fri, 23 Jan 2026 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194422;
	bh=98XtrGgu8HiCVk1DMGWdBJTFvpBhDmwOgVvw6d0g9NE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DmRfQfegaSlpUOyRcljZsSJMvgqXspTYWzvuyH5zZphrmgWP1ztUcMgnGCRAM2twD
	 3BoIcV+YHJAPG47X2W5ayqxpVcyypvy5p8L6hqGnwJhnppfqKmnD+fq+xfiL3dIui5
	 21/6oHTm8EpcDRNKd6lz9N1hjWnX/RVl6LFyi/MlPTccDXFF7MolomMFZOkGreRw9F
	 3ZXU6P4RSBUkFwzC7EmyLmUUh1Ye7XYCcTeFE5GzupZzyDB+4P+la0+uXTVrif1bgP
	 77Xn2Yfgr6YChwo3WQmbY13UcF9WH7nywd4Tg/w9+oqiI2juQDut0btZSuZlfDJbPN
	 WN1EPInl5QuBg==
Message-ID: <7fd4fced-86c0-4fe9-843e-60a30a9b74a9@kernel.org>
Date: Sat, 24 Jan 2026 05:53:36 +1100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Randolph Lin <randolph@andestech.com>,
 Samuel Holland <samuel.holland@sifive.com>, Frank Li <Frank.Li@nxp.com>,
 Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-pci@vger.kernel.org
References: <20260123182835.831710-6-cassel@kernel.org>
 <20260123182835.831710-10-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260123182835.831710-10-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/01/24 5:28, Niklas Cassel wrote:
> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
> before configuring ECAM iATU entries. This left IO and MEM outbound
> windows unprogrammed, resulting in broken IO transactions. Additionally,
> dw_pcie_config_ecam_iatu() was only called during host initialization,
> so ECAM-related iATU entries were not restored after suspend/resume,
> leading to failures in configuration space access
> 
> To resolve these issues, the ECAM iATU configuration is moved into
> dw_pcie_iatu_setup(), and dw_pcie_iatu_setup() is invoked when ECAM is
> enabled.
> 
> Furthermore, error checks are added in dw_pcie_prog_outbound_atu() and
> dw_pcie_prog_inbound_atu() such that an error is returned if trying to
> program an iATU that is outside the number of iATUs provided by the
> controller.
> 
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

It looks like this patch depends on patch 3, which does not have a Fixes tag. So
why not squash together patches 3 and 4 ?

> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.c  |  6 ++++
>  2 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 87e6a32dbb9a..bc2e08ec515e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -641,14 +641,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_free_msi;
>  
> -	if (pp->ecam_enabled) {
> -		ret = dw_pcie_config_ecam_iatu(pp);
> -		if (ret) {
> -			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
> -			goto err_free_msi;
> -		}
> -	}
> -
>  	/*
>  	 * Allocate the resource for MSG TLP before programming the iATU
>  	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> @@ -915,8 +907,21 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	 * NOTE: For outbound address translation, outbound iATU at index 0 is
>  	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
>  	 * index 1.
> +	 *
> +	 * If using ECAM, outbound iATU at index 0 and index 1 is reserved for
> +	 * CFG IOs.
>  	 */
> -	ob_iatu_index = 1;
> +	if (pp->ecam_enabled) {
> +		ob_iatu_index = 2;
> +		ret = dw_pcie_config_ecam_iatu(pp);
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
> +			return ret;
> +		}
> +	} else {
> +		ob_iatu_index = 1;
> +	}
> +
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
>  		resource_size_t res_size;
>  
> @@ -985,8 +990,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  			 * be shared between I/O space and CFG IOs, by
>  			 * temporarily reconfiguring the iATU to CFG space, in
>  			 * order to do a CFG IO, and then immediately restoring
> -			 * it to I/O space.
> +			 * it to I/O space. This is only implemented when using
> +			 * dw_pcie_other_conf_map_bus(), which is not the case
> +			 * when using ECAM.
>  			 */
> +			if (pp->ecam_enabled) {
> +				dev_err(pci->dev, "Cannot add outbound window for I/O\n");
> +				return -ENOMEM;
> +			}
>  			pp->cfg0_io_shared = true;
>  		}
>  	}
> @@ -1157,7 +1168,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	 * the platform uses its own address translation component rather than
>  	 * ATU, so we should not program the ATU here.
>  	 */
> -	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> +	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
>  		ret = dw_pcie_iatu_setup(pp);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 18331d9e85be..5741c09dde7f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -532,6 +532,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	u32 retries, val;
>  	u64 limit_addr;
>  
> +	if (atu->index >= pci->num_ob_windows)
> +		return -ENOSPC;
> +
>  	limit_addr = parent_bus_addr + atu->size - 1;
>  
>  	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
> @@ -605,6 +608,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  	u64 limit_addr = pci_addr + size - 1;
>  	u32 retries, val;
>  
> +	if (index >= pci->num_ib_windows)
> +		return -ENOSPC;
> +
>  	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
>  	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
>  	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {


-- 
Damien Le Moal
Western Digital Research
