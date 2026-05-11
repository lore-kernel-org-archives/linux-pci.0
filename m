Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F86A370D4D;
	Mon, 11 May 2026 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509550; cv=none; b=mXcXn/dde7aJe/SAD6UMfkCS0M/K29eWGYdQVHfmLycHIeWJE5FE/I6vv2R5KUe/POG+WvEA+EjBhebdzYfwO6kVCAtrIISdnsR4D7WbVq3otjFEXszhsm+lFo2AiYAyg2eAtlIE8DEQW4G5DhVfH5MPMiMHGplXzbyy3/IEK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509550; c=relaxed/simple;
	bh=sFQUYEK0zjzUfvC726a7WnZooGRy+9Y//Vf6mtfqYI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VltfHr9aE+lhw+4hw+PEDlYUeRHCBvfCJRNbRFo/zjcvJx6ovSSNZPLo1VP5+hAuoJRrLDiglPJBKTvjV6x68dui7cObxoZb+n1NRv5t9oGhNyI+hYbGriT415rA6xkaxm7+XJU4dlriK2les6Xpup6XmO39MOwc7t9SoMoYuow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stve6dby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stve6dby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CCFC2BCB0;
	Mon, 11 May 2026 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509550;
	bh=sFQUYEK0zjzUfvC726a7WnZooGRy+9Y//Vf6mtfqYI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Stve6dby3WG97Re/uEgpHnWJqtSMtZyNHcJxSDfXCXvf/aM+jG/Ar89v/gPydSCRd
	 x3QF0ZbWtKkQVNvkiDTApY26+KgmMfApsoo94VZPgi8pFz0LNovy4Qa8LGUVVK08D7
	 1o5capi+P67XFepjyAGEKLAskV+4zM/TMt7qUmvMjPqSuJ74F9W1YSIz/Gn3jql0k/
	 8sPiR2s/goArGbn2TQK1JW678iQWd8KN/rWhEQof+uUKO+fqck/aIfPx14r5bRm6MC
	 AO0DvLAtQD9JqRrbIYDWYIGmemH1lDFNyN3Dvd7+6BXlFyrD6w9xEOzhT581LpzDdd
	 lnicVJsK2oifg==
Date: Mon, 11 May 2026 19:55:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property
 for L1 entrance latency
Message-ID: <r2n66hkva2pf3qqfdwvmspciurd5kzslvh2tbcbxcziukj7xam@3fmzqwofm5ih>
References: <20260410073330.837238-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410073330.837238-1-mmaddireddy@nvidia.com>

On Fri, Apr 10, 2026 at 01:03:30PM +0530, Manikanta Maddireddy wrote:
> Program ASPM L1 entrance latency from the optional aspm-l1-entry-delay-ns
> device tree property instead of of_data. Convert the value from nanoseconds

Which 'of_data'?

> to the hardware encoding (log2(us) + 1, 3-bit field). If the property is

As Jon noted, this expression doesn't match the code.

> absent, default to 7 (maximum latency).
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>

This tag from mine is wrong. I never sent this patch on my own. So drop my
s-o-b and...

> Link: https://patch.msgid.link/20260324191000.1095768-10-mmaddireddy@nvidia.com

also this 'Link' tag.

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 50c5ef12552b..f171f7e32b75 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_pci.h>
> @@ -272,6 +273,7 @@ struct tegra_pcie_dw {
>  	u32 aspm_cmrt;
>  	u32 aspm_pwr_on_t;
>  	u32 aspm_l0s_enter_lat;
> +	u32 aspm_l1_enter_lat;
>  
>  	struct regulator *pex_ctl_supply;
>  	struct regulator *slot_ctl_3v3;
> @@ -710,6 +712,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>  	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>  	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
>  	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
> +	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
> +	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
>  	val |= PORT_AFR_ENTER_ASPM;
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>  }
> @@ -1110,6 +1114,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>  {
>  	struct platform_device *pdev = to_platform_device(pcie->dev);
>  	struct device_node *np = pcie->dev->of_node;
> +	u32 val;
>  	int ret;
>  
>  	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> @@ -1136,6 +1141,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>  		dev_info(pcie->dev,
>  			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
>  
> +	/* Default to max latency of 7. */
> +	pcie->aspm_l1_enter_lat = 7;
> +	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
> +	if (!ret) {
> +		u32 us = max(val / 1000, 1U);
> +
> +		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7);
> +	}
> +
>  	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
>  	if (ret < 0) {
>  		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
