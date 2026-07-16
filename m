Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC83383328;
	Thu, 16 Jul 2026 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220258; cv=none; b=sDR/ETRkpSPVqh4eeFb91VJ6QoFH7YnQSrU36ifSWfDe2mDllYGAeoJHt1Y6sWcUsAYr+oAS1bkVlcpfH7V5wrAoH2uUa80FNx5bEgdPR9oboF1+I1uOH66YU7KkXh3hqhDw35N0qTquedzrD2c6EmuSM/IrtqcQF0oFRth1uTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220258; c=relaxed/simple;
	bh=U92FztNr8d9j3me6XSOeGW9RVf958zGBdqW3sqV4cJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qReiPTT37TSaDjix0yDSZfqlk8Pv1MxbjL31sGJbK1M7bKJ38qEnm8beyMt9XHcxHW28DQ7t6TWf6LGDRXnz+v4OB1G+ZOhWJ495lD/idkPdQBTlQUwKZbPKFaktQos9VIsZ9LjEKrTA1QwrtSifzMwon2tLqkvqUAsg6/IUG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSVWybz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSVWybz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59961F000E9;
	Thu, 16 Jul 2026 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220247;
	bh=KRQXasdSjh/IVyj+LLVVvuKUHT3n1CA/5KP9qz5vin8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bSVWybz7hoRT6SwmRrOHtV4PdMzz02I7aAxH9ydTXI3xq2ij/ySjxL7NobDNDmx/Q
	 l6Ckz+/LD6fkpfqrSabZew2DjAM4oDQZ2FC11ziHvNXI9uCZQ/4k63fEK2pBmgpLeM
	 7Qervo37/1gwY7R18JunzNEJfvtzWKEgzctHXQ6wkphF+N0UHmRki/A0UUNkvtAX1r
	 mJEMhXsuCbcgXqi8JScXu9dxnNx+S18xanJWKwOUNFjRVN8wLfceYfYgV47j5lE1Nn
	 Zuz6yeztWML3Udeycwve/w68HrGv4fL/zA6MgtJd7iMzjxrTJkGTRndNZJ1m+EcZ1a
	 MJiRKzNIsdDAg==
Date: Thu, 16 Jul 2026 18:43:48 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Add runtime PM support for i.MX95
Message-ID: <aprkipjl3lpdn37dlcdv7wx6piepbbqjsd6ljfgpa5pmua2axu@etxjfuahtg3u>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>

On Wed, Jul 08, 2026 at 11:59:26AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Enable runtime PM support for i.MX95 PCIe Root Complex to allow dynamic
> power management when the PCIe link is idle.
> 
> The i.MX95 PCIe controller supports entering D3hot state when PCIe
> devices are not actively in use. This implementation uses
> pm_runtime_no_callbacks() to leverage the PCI core's generic runtime PM
> handling. The PCI core automatically manages D-state transitions based
> on the runtime PM state of connected endpoint devices.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Please resend this patch separately. Currently, you've sent other patches as a
reply to this patch which just messes up the order.

- Mani

> ---
> Changes in v2:
> Use devm_pm_runtime_set_active_enabled() simplify the codes and error
> path.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index eae495a1b7990..578410f262aed 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -130,6 +130,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_SKIP_L23_READY		BIT(12)
>  /* Preserve MSI capability for platforms that require it */
>  #define IMX_PCIE_FLAG_KEEP_MSI_CAP		BIT(13)
> +#define IMX_PCIE_FLAG_PM_RUNTIME		BIT(14)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -1973,6 +1974,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		 */
>  		imx_pcie_add_lut_by_rid(imx_pcie, 0);
>  	} else {
> +		if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_PM_RUNTIME) {
> +			pm_runtime_no_callbacks(dev);
> +			ret = devm_pm_runtime_set_active_enabled(dev);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
>  		/*
>  		 * i.MX RC is powered off during suspend, force L2 entry to
>  		 * ensure proper endpoint notification before power loss.
> @@ -2121,6 +2129,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES |
>  			 IMX_PCIE_FLAG_HAS_LUT |
>  			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
> +			 IMX_PCIE_FLAG_PM_RUNTIME |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
