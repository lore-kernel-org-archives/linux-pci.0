Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B03624BA;
	Wed, 25 Feb 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025628; cv=none; b=Wz3Ib+Vk0yvelEa7jDMHuNJGjAMPZ/VvvihvqILCEoClzfXc87hjErEtnPO8OJyNJ20EGdYEM4+Lk6hCx5czCQic/GhVbjJjux9dH6vfvqQp5bnPGswfBXrPywQXKk/LSeEmptqgmpUvY5D+7v1tXL3GHCmLjB2tY4bfacIqYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025628; c=relaxed/simple;
	bh=1mkdM7iU7RQ2uyVLB0bUYW0bVW4UjTSJ7ybMNMDMDHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJIa/pmLKYmloeWzyURybAj1H4OIFJtbCyApIH3oh1iSiGR8BXmp+iTyQxs4awFdaxvdL3Axwnrplun1ZcWlqnUakXazts+lvzu6YMAG8GjhkeSOs7/jHPoLv5SWxR9ieF33WGiI4CvMdqCYugz5Uoy0CvPoCKuhUgjIWln5AuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCye/Jg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCye/Jg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E394BC116D0;
	Wed, 25 Feb 2026 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025628;
	bh=1mkdM7iU7RQ2uyVLB0bUYW0bVW4UjTSJ7ybMNMDMDHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCye/Jg9G8o7weeJ8/QtDSJjMsNc23ZG4DFuK5/Koolz0wxkRIE9Il7iB65fM5Ace
	 MRsCCPr+lCaVzwf/Z+K21TVriuw14vXiGRAGfVaNdXGMvI62UEkH7McEd+c+Drumll
	 lzUIJcbunvX92OcmOrZ0pkzeoNJhOvrR3j3RrBJtdvzGmtsVZFiERvTk1ICZuM1AJW
	 yWi8QHzb2hyI6e1zRt+OZU1UXNh9dzeMuTrn/ncSXumXBbso2FmboS1NoysWNSdmin
	 HH2UI7OFro21bRSQ3ET1HqNDraNjdXMhwLtQ2z2WouvjE4WmndT5ecOiDEJAYQzXT9
	 W2b1uRfvQfryw==
Date: Wed, 25 Feb 2026 18:50:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Message-ID: <ymzodxznygg5dwes2lebi35gn763ylo2pyg33tr7sxeazbrzej@wpu6nfeulwiv>
References: <20260225072225.3345307-1-wenst@chromium.org>
 <20260225072225.3345307-6-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225072225.3345307-6-wenst@chromium.org>

On Wed, Feb 25, 2026 at 03:22:22PM +0800, Chen-Yu Tsai wrote:
> With the new PCI pwrctrl API and PCI slot binding and power drivers, we
> now have a way to describe and power up WiFi/BT adapters connected
> through a PCIe or M.2 slot, or exploded onto the mainboard itself.
> 
> Integrate the PCI pwrctrl API into the PCIe driver, so that power is
> properly enabled before PCIe link training is done, allowing the
> card to successfully be detected.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 38 ++++++++++++++++-----
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 7459e1c1899d..93e591f788f7 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
> +#include <linux/pci-pwrctrl.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -421,15 +422,23 @@ static int mtk_pcie_device_power_up(struct mtk_gen3_pcie *pcie)
>  		val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
>  		       PCIE_PE_RSTB;
>  		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +	}
> +
> +	err = pci_pwrctrl_power_on_devices(pcie->dev);
> +	if (err) {
> +		dev_err(pcie->dev, "Failed to power on devices: %pe\n", ERR_PTR(err));
> +		return err;
> +	}
>  
> -		/*
> -		 * Described in PCIe CEM specification revision 6.0.
> -		 *
> -		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> -		 * for the power and clock to become stable.
> -		 */
> -		msleep(PCIE_T_PVPERL_MS);
> +	/*
> +	 * Described in PCIe CEM specification revision 6.0.
> +	 *
> +	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> +	 * for the power and clock to become stable.
> +	 */
> +	msleep(PCIE_T_PVPERL_MS);
>  
> +	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
>  		/* De-assert reset signals */
>  		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
>  			 PCIE_PE_RSTB);
> @@ -449,6 +458,8 @@ static void mtk_pcie_device_power_down(struct mtk_gen3_pcie *pcie)
>  		val |= PCIE_PE_RSTB;
>  		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>  	}
> +
> +	pci_pwrctrl_power_off_devices(pcie->dev);
>  }
>  
>  static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
> @@ -1211,9 +1222,13 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	pcie->soc = device_get_match_data(dev);
>  	platform_set_drvdata(pdev, pcie);
>  
> +	err = pci_pwrctrl_create_devices(pcie->dev);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to create pwrctrl devices\n");
> +
>  	err = mtk_pcie_setup(pcie);
>  	if (err)
> -		return err;
> +		goto err_destroy_pwrctrl;
>  
>  	host->ops = &mtk_pcie_ops;
>  	host->sysdata = pcie;
> @@ -1226,7 +1241,12 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  
>  err_teardown_irq_and_power_down:
>  	mtk_pcie_irq_teardown(pcie);
> +	mtk_pcie_device_power_down(pcie);
>  	mtk_pcie_power_down(pcie);
> +err_destroy_pwrctrl:
> +	if (err != -EPROBE_DEFER)

Sorry for this mess. I hope to fix it soon.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
