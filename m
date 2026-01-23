Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570F314A95
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156261; cv=none; b=jNdM1TOJK8jPn0AkmomMWf9SjfT2nho42RThmDpWP3pLm5tjsfAxYfXxJ+gdL2eKJKuyDTg71q+BYN9PvK00N9kufBn+4RbqUGyYWhok9cs1IWHXErCTZT9szhGVcVJQrhl8790SNneH894u7iGK1vbCXbnx/+YhAamw3L/hbJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156261; c=relaxed/simple;
	bh=O6WQSk0JWlZg4gF3Fn18sDXty23g5hcPR+NlrSVYyGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQrmiIFGxU+8mrO+Df3e3IzY6XEKJvTsd4LYBg7nHKMno8rdO3OYourLj7+Sl7PSxZkoFsa+gY8bGvA+BnpmB0TxILuJenW9WwluAuEkKMdwKmeFFJZkS8UtrfTjPsCcXrnfMuLbcf/YSaBMXYnysxH+imU7e3JmguV5zDOjEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6ZoW9wf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6ZoW9wf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05830C4CEF1;
	Fri, 23 Jan 2026 08:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769156261;
	bh=O6WQSk0JWlZg4gF3Fn18sDXty23g5hcPR+NlrSVYyGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6ZoW9wfbu05v20YAqJhHs8gGGe/M7nZK0VJ5PZOIL8JCK+8hFtBnNtsEdu7wdZUs
	 7tDtn4VcUI7DcAFDB/INkwnED9bZ8jsmJQlN2XnUcYi8qXbK9tKs0djlo+25QHMCiG
	 mqlqKEXjltpFS/NXkzcVWHrdW8UQdtMo1wYRUN+iNq99e4JZQf4I5mF7L4XRMf/9xE
	 lYaDtY4NMvEyk91A15sFUZF3uKzZfVBLk9mLRZRxp/3wd+87e/fv67Cy8dTktIHgKo
	 7o+ocDTpKY+rnf7ffm9q7JCmID4KLYPAO8WNrmD44h1AbJplmqOpnEXssplconbHS7
	 rXhD4yzHLiB1w==
Date: Fri, 23 Jan 2026 13:47:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Randolph Lin <randolph@andestech.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Frank Li <Frank.Li@nxp.com>, 
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
Message-ID: <bgfybv4og2otcq3bna26hmsuboxhleg4ahp37acqcoy5kmocpt@jeos2ksnofwf>
References: <20260122222914.523238-6-cassel@kernel.org>
 <20260122222914.523238-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122222914.523238-10-cassel@kernel.org>

On Thu, Jan 22, 2026 at 11:29:18PM +0100, Niklas Cassel wrote:
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
> dw_pcie_prog_inbound_atu() so that an error is returned if trying to
> programming an iATU that is outside the number of iATUs provided by
> the controller.
> 
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.c  |  6 ++++
>  2 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 76be24af7cfd..ef66a031f0bb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -441,7 +441,7 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
>  	/*
>  	 * Root bus under the host bridge doesn't require any iATU configuration
>  	 * as DBI region will be used to access root bus config space.
> -	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
> +	 * Immediate bus under Root Bus needs type 0 iATU configuration and

Spurious change.

>  	 * remaining buses need type 1 iATU configuration.
>  	 */
>  	atu.index = 0;
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
> -	ob_iatu_index_to_use = 1;
> +	if (pp->ecam_enabled) {
> +		ob_iatu_index_to_use = 2;
> +		ret = dw_pcie_config_ecam_iatu(pp);
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
> +			return ret;
> +		}
> +	} else {
> +		ob_iatu_index_to_use = 1;
> +	}
> +
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
>  		resource_size_t res_size;
>  
> @@ -1157,9 +1162,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	/*
>  	 * If the platform provides its own child bus config accesses, it means
>  	 * the platform uses its own address translation component rather than
> -	 * ATU, so we should not program the ATU here.
> +	 * ATU, so we should not program the ATU here. If ECAM is enabled,
> +	 * config space access goes through ATU, so set up ATU here.

Spurious change.

>  	 */
> -	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> +	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
>  		ret = dw_pcie_iatu_setup(pp);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 2fa9f6ee149e..225897c87c49 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -531,6 +531,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	u32 retries, val;
>  	u64 limit_addr;
>  
> +	if (!(atu->index < pci->num_ob_windows))

	if (atu->index >= pci->num_ob_windows)

> +		return -ENOSPC;
> +
>  	limit_addr = parent_bus_addr + atu->size - 1;
>  
>  	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
> @@ -604,6 +607,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  	u64 limit_addr = pci_addr + size - 1;
>  	u32 retries, val;
>  
> +	if (!(index < pci->num_ib_windows))

	if (index >= pci->num_ib_windows)

- Mani

-- 
மணிவண்ணன் சதாசிவம்
