Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0945B2D6E58;
	Thu,  9 Apr 2026 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759800; cv=none; b=bweVx6/2apaeRnYQ3RsmYxckvSwS81QMfBRbj12b2idEzpg4hdRox2Z0DpZsssA+MA6xVTCuxv+1osyFejuPDjxstldMsmH+zfds0IA59hVdA6h+mQk+9L5eDMiLp9iuhC60bN+0d0nTJqNxNeOR25Y8Im/mZQf4vVrn5xZUgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759800; c=relaxed/simple;
	bh=pSLWhcviM5YvQ5fe+G4dcyEh1DqYJJXJ2+Z9AdgDKlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ujQgmkdV+Q3Xj2iXauUvlyC7LrZvYcKWJKIOMr0kP4Dib2t+f9HPNv0Cf2N9ia/BQ3iDxAFj01pHAhds0RfBeJOXbyjCXzuX2lupuHNw5btVk4MESJ0H7RAcoCrpaVlx0XvRw89+FZjRDsvo9qy3qJBSmndAv4kcvieHgMwcPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6Fsjj3c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6Fsjj3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EA1C4CEF7;
	Thu,  9 Apr 2026 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775759799;
	bh=pSLWhcviM5YvQ5fe+G4dcyEh1DqYJJXJ2+Z9AdgDKlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F6Fsjj3csyLXDcjTiWIHUcaDDCT9vT04xo4JyuPpmR0NUBlm8nQHcIJ3HXITHA0MT
	 of/aZhI2dkXZ0jtKFvHK9rPrukkPcNB+nN/ncpFQBwLTBVM5bfWRK4Vv3EvHpL+rRd
	 3TtRuG4HWZvimCPWPkeUQchnVUHQEbuI7TI91h4Qk1ZmFDaug9HtSRRrU1739VJq1Q
	 hjDZckOVStHM7Eaith6qprlzNb5enoLg8dJMiyRVRWuu3LhDAcpi5vWTyW1e7pYiqW
	 o+I6sJd6lPc+4tXZCvAoyxzRsIDRvrl+ASw2Dvlt6kTH2tiEcpYwdy+7RttLJ6CDjl
	 DyuNb2w3iacAw==
Date: Thu, 9 Apr 2026 13:36:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com,
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org,
	18255117159@163.com, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 9/9] PCI: tegra194: Use aspm-l1-entry-delay-ns DT
 property for L1 entrance latency
Message-ID: <20260409183638.GA490960@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324191000.1095768-10-mmaddireddy@nvidia.com>

On Wed, Mar 25, 2026 at 12:40:00AM +0530, Manikanta Maddireddy wrote:
> Program ASPM L1 entrance latency from the optional aspm-l1-entry-delay-ns
> device tree property instead of of_data. Convert the value from nanoseconds
> to the hardware encoding (log2(us) + 1, 3-bit field). If the property is
> absent, default to 7 (maximum latency).
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

I dropped this patch from the pci/controller/dwc-tegra194 branch for
now so we could get the rest in pci/next.

> ---
> Changes V8: Use aspm-l1-entry-delay-ns instead of of_data
> Changes V1 -> V7: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 3278353b2c29..a856a48362df 100644
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
> +		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
> +	}
> +
>  	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
>  	if (ret < 0) {
>  		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);
> -- 
> 2.34.1
> 
