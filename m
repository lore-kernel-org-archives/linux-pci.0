Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB3374730;
	Thu,  5 Mar 2026 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709182; cv=none; b=pjbfNOri678gBTUXg4xrs3EVnHn4CjdhIcqBLoypaPVxsTGfx9Hv93xttlkOHZLFCkstNURL2B8wAcr/CJsd/PrYVfSP1cLs01wDV3pt22HE+aWLIg+45Sc2FhwSLjji7+tb6sWXW2EkcuuUhBD3bwvSCIcTvOStDhItIoqk/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709182; c=relaxed/simple;
	bh=yG8IGQlWpdvvViFJqhyapo8dbnXkUkwKnF359s1kUAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKUAA4ZPHxARXd2I3GV/ssWoFBWM2uysdQSd0mf8Yy/efG1a9ht9QzTXkncQ9ZTOiNrylngdpUBPJiXb4NjXFvdEbKZDbKl5It0YWSDJGhpNFDeDWNZOp09iWWFyntqxN4g65sZg2tpDI+po96VNMecqLD+g0pCsZ+T93toZtIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3Y0tCP7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3Y0tCP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCE0C116C6;
	Thu,  5 Mar 2026 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772709181;
	bh=yG8IGQlWpdvvViFJqhyapo8dbnXkUkwKnF359s1kUAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3Y0tCP7vkuImxRG8sV8G4ZOmfalOLnaXDBBrs6wnPtXeRYcwE2yZ2M/YwTRfZ5Tx
	 0+DS1eOnOlkHaiOH0ktTrLQLL7OP9t7lRyICJY9+wlMiehLEaWWoKKLkfuCWCHooV+
	 1w1A6iixjY4A8Cn7MIl3qzWoTHL2i4VBoFeeaEzxoAUpbBIDtUQKg7zZZWinb1TRZD
	 zxACvxJLOzN/lKW5zo59xKoqntSAPzErhn8/Q0SPDG3nUNZ3S5hjGqt0XVJyQWmXFw
	 lqsQGktTUpwFenhaNufcf8Vef8KmtlsYCo76uziYEW27Zg+KOr/zo4cBgc6KD5YVqk
	 3cciWOlcmT30w==
Date: Thu, 5 Mar 2026 16:42:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/9] PCI: tegra194: Add core monitor clock support
Message-ID: <p5eoraarj2v5oh5z4qxvixcs3whlt5vlzlgblytaeasujseupz@zjo4nufie2fy>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
 <20260303065758.2364340-9-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065758.2364340-9-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:27:57PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Tegra supports PCIe core clock monitoring for any rate changes that may be
> happening because of the link speed changes. This is useful in tracking
> any changes in the core clock that are not initiated by the software. This
> patch adds support to parse the monitor clock info from device-tree and
> enable it if present.
> 

Reword the description in imperative mood and avoid 'This patch...'.

> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V1 -> V7: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 070eb7f4058d..e0455d322166 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -249,6 +249,7 @@ struct tegra_pcie_dw {
>  	struct resource *atu_dma_res;
>  	void __iomem *appl_base;
>  	struct clk *core_clk;
> +	struct clk *core_clk_m;
>  	struct reset_control *core_apb_rst;
>  	struct reset_control *core_rst;
>  	struct dw_pcie pci;
> @@ -945,6 +946,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>  	}
>  
>  	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> +	if (clk_prepare_enable(pcie->core_clk_m))
> +		dev_err(pci->dev, "Failed to enable core monitor clock\n");
>  
>  	return 0;
>  }
> @@ -1017,6 +1020,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>  		val &= ~PCI_DLF_EXCHANGE_ENABLE;
>  		dw_pcie_writel_dbi(pci, offset + PCI_DLF_CAP, val);
>  
> +		/*
> +		 * core_clk_m is enabled as part of host_init callback in
> +		 * dw_pcie_host_init(). Disable the clock since below
> +		 * tegra_pcie_dw_host_init() will enable it again.
> +		 */
> +		clk_disable_unprepare(pcie->core_clk_m);

Again, this change should be in a separate patch.

>  		tegra_pcie_dw_host_init(pp);
>  		dw_pcie_setup_rc(pp);
>  
> @@ -1610,6 +1619,7 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>  
>  static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
>  {
> +	clk_disable_unprepare(pcie->core_clk_m);
>  	dw_pcie_host_deinit(&pcie->pci.pp);
>  	tegra_pcie_dw_pme_turnoff(pcie);
>  	tegra_pcie_unconfig_controller(pcie);
> @@ -2161,6 +2171,13 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  		return PTR_ERR(pcie->core_clk);
>  	}
>  
> +	pcie->core_clk_m = devm_clk_get_optional(dev, "core_m");
> +	if (IS_ERR(pcie->core_clk_m)) {
> +		dev_err(dev, "Failed to get monitor clock: %ld\n",
> +			PTR_ERR(pcie->core_clk_m));

To simplify, just do:

		return dev_err_probe();

- Mani

-- 
மணிவண்ணன் சதாசிவம்
