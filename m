Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871630E82E;
	Thu,  5 Mar 2026 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705966; cv=none; b=nyXdj1yrjbIGDuTdl357n63h6mcLZPzyBG8r9ZeaU3FEFst53MYZhDQxQi3mhbftqHtQyVDMHJj2MVGM+/QHM/ANUNwGbbz6hU0GpeD9wbsITv3ElvsSgqGup6/tZRPhleALm7KSJoFnFiGNlKowzLH37e+hV8+SNBJeBQzWcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705966; c=relaxed/simple;
	bh=YRUPoTIN6g9/Tsh4RXysP2NE0Z8y/s75k1jZouDgLD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTknJXN3D1TR2IVW4v7PAgo23tqVA4OgbiDBgDKoos/LZHuXYDjoO36DCTwB4P8Ud2rAd/+cXb8S791B/ub8S5L0TZVLrPOr51/cnK5tOpaskpdrbqCoIs71wnGCP2I61S7fd11EA+QEbaFeKrjCVvbEMwRBLMT1FVsSrQZjNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6MMU5z3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6MMU5z3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14248C19425;
	Thu,  5 Mar 2026 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772705965;
	bh=YRUPoTIN6g9/Tsh4RXysP2NE0Z8y/s75k1jZouDgLD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6MMU5z3lZoXt+0pWHqhDI3W8zBJS4JDB8cp1TW4WWlBrnvcnK/YG7tEmoozagFJT
	 oCHyo7LR8WXmNmbslDu1t1z3lKtLGQ5G4JnEcT9ewlIjYTGMg/td4YOrrqMdAYnfiI
	 uIWqDYy3NMutiHnNruke0X7H7jXz4x+5uOMCiba9gLFCTmacOnPsX8iBTScYDb1WcF
	 PItXsS+D0l9LdbnbluVV5ngM+0d7Dp9hcvOrX4xypU+yX5GdBkE9d8sguT0/CUzRHB
	 NdNY4k4eMUeITNGHR0JFVChlHd6d5t6Z5McXJVKWCJEPvRtOi9/Ei5hl7RPL1NQxuX
	 S4CF1CqvdC+Ww==
Date: Thu, 5 Mar 2026 15:49:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/13] PCI: tegra194: Apply pinctrl settings for both
 PCIe RP and EP
Message-ID: <gui4y7vjc4f5brtjgsfvqdn2ig6kw3tsiinrijweltgeukiwdy@2zqe2orx6pas>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-9-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065448.2361488-9-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:24:43PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> PERST# and CLKREQ# pinctrl settings should be applied for both Root Port
> and Endpoint mode. Move pinctrl_pm_select_default_state() function call
> from Root Port specific configuration function to probe().
> 

Why should this driver care about setting default pinctrl state? Why can't it
rely on the pinctrl framework as like other drivers?

- Mani

> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V5 -> V7: None
> Changes V4 -> V5: Use dev_err_probe() function
> Changes V1 -> V4: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index b50229df890e..5b79d3c28ba6 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1598,12 +1598,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>  		goto fail_pm_get_sync;
>  	}
>  
> -	ret = pinctrl_pm_select_default_state(dev);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
> -		goto fail_pm_get_sync;
> -	}
> -
>  	ret = tegra_pcie_init_controller(pcie);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to initialize controller: %d\n", ret);
> @@ -2077,6 +2071,10 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>  	pp = &pci->pp;
>  	pp->num_vectors = MAX_MSI_IRQS;
>  
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to configure sideband pins: %d\n", ret);
> +
>  	ret = tegra_pcie_dw_parse_dt(pcie);
>  	if (ret < 0) {
>  		const char *level = KERN_ERR;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
