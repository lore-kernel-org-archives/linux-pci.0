Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE592330D4C;
	Thu,  5 Mar 2026 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706579; cv=none; b=gbns/XXsO/pfCuDP2QBmkvbQRQuDtCC7DfwUt/iaLn5wOiuN7DZEP11SEkKDWY8Tw8k7OTbFPDyPBNoedtDUHk7m0VaLgzM9pvecrESd3oQLGE62CT2yqo70pl9CsB5CtwFCwj7l9RxIsXEm9WADi82jOeHhfZdHslSuYvIUt04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706579; c=relaxed/simple;
	bh=3NKQzD1ngXc8FxHPL30tr69/1jxMVdDBacxygFcfxvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvq3V+jUkr1z3wIieUicKRk31IU+6GtJUgOVOJx+xKY97z67kav9a5mkgX1pdTAXNpkan0VsIuE4wdhVPuBy5T0eilNPrj5fQIfCs2AWrEetmASixszYt/blPg2x/IPM2+rKCqf0mRoanipgURHYkZ+yPOIm4HTz0mJlOk5VOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlM4pam8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlM4pam8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26CBC116C6;
	Thu,  5 Mar 2026 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772706578;
	bh=3NKQzD1ngXc8FxHPL30tr69/1jxMVdDBacxygFcfxvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlM4pam8btijx5PpMcb9x5koYamC/kI+CbRc/fORXHwZATrOZJ+rUOmXJG/k19x99
	 vrBGlbVmovCFVuZ4Fn31gcGwG/PN5Id15QUPvZrzn7Y7QynbdGpEElU+CGTKTMWoOT
	 dS2AkJ4dhycHyONt8HbB1RmfoNs47zymb2VtcXGPZTp8wEFBwY2/7+uuobS+/tjVZ8
	 HK/M151aToRiue6gqczQ9bZUh0L1oRCxqllbw4kJe+WkcU5Ri2zNOFsNRVxj3NbzWH
	 KQ6es8bD/kSZ7Xq5nfI/9mLC/HmJgi+xqwiLK36DqkxJI4N9wU/g6y64V8A2CEMF3Z
	 jQlvX8P6YT0bw==
Date: Thu, 5 Mar 2026 15:59:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/13] PCI: tegra194: Allow system suspend when the
 Endpoint link is not up
Message-ID: <f556ofs7s7d3tzcefxhwqalzz3z6mmj3pc22frqii4ozkoseit@mbo43kjsvbwz>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-10-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065448.2361488-10-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:24:44PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Only a Root Port initiates the L2 sequence. PCIe link is kept in L2 state

It is not Root Port, it is the host software which initiates the L2 entry
sequence.

And L2 is only guaranteed if the Vaux is available.

> during suspend. If Endpoint mode is enabled and the link is up, the
> software cannot proceed with suspend. However, when the PCIe Endpoint
> driver is probed, but the PCIe link is not up, Tegra can go into suspend
> state. So, allow system to suspend in this case.
> 
> Fixes: de2bbf2b71bb ("PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode")
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V1 -> V7: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 31 +++++++++++++++++-----
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 5b79d3c28ba6..b2794be35cfe 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2267,16 +2267,28 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
>  		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
>  }
>  
> -static int tegra_pcie_dw_suspend_late(struct device *dev)
> +static int tegra_pcie_dw_suspend(struct device *dev)
>  {
>  	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> -	u32 val;
>  
>  	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
> -		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
> -		return -EPERM;
> +		if (pcie->ep_state == EP_STATE_ENABLED) {
> +			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
> +			return -EPERM;
> +		}
> +
> +		disable_irq(pcie->pex_rst_irq);

So you just disable PERST# IRQ during suspend? And even if the host deasserts
PERST#, EP is not going to wakeup?

Technically it is possible that whenever the EP wakes up, it will see PERST# IRQ
since PERST# is level triggered, but it just sounds dumb to let the endpoint
sleep after host deasserting PERST#.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
