Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1E3F2114;
	Wed,  1 Apr 2026 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045973; cv=none; b=fHLPfiTrLlxnyYUOvJRaJ6DVp1JfHrvmCmT7gOWAOAT8A9RYfM6dZzqkw1ryEeVVEahgb2tC3NwK59P8X6Wzke5Ca+LfsWZbE4OgeVDZrFPKMUwxXc4uCmeBlsjPOPSAIUFjewXK0R5EVSYyx9Cc7FpKn+9t/ig8UtxSsrtI+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045973; c=relaxed/simple;
	bh=U2chIgld3ec2AzP0+woeUhBzxiB30kpsbfVXjgxQpnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m97lEMVKg0PURw/umz1CMLOnCK0GU+Ik+homhmkbuaQ1C6Oh0sy3PQ/z/QhTZOb4rl12XuAxb/YL07wntMXHTJPovVnyR7y95BjvwPtcS80Ze6OcGBMjRGXJj2J/0xAWYl9Jng5eiBaYiyK9XVFAFll1HqAGDqjhGRHPHmXqsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozbrvJxp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozbrvJxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4DFC4CEF7;
	Wed,  1 Apr 2026 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775045972;
	bh=U2chIgld3ec2AzP0+woeUhBzxiB30kpsbfVXjgxQpnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozbrvJxp1hCEaO+OqA5RSPyS6ivh97M810FcogJ+qweaHIHH54EX+tW49zBBsA9vp
	 yWFLVaSdVmQPXvJNbHGgcnDHV3Aur16AuZMvik4VkjuT4l85I8iJPOEno7tjEfKKZg
	 ARXfcovEr6/xoL2GuM0H1DES1eCiRg6229ab0ckBJDZTh54JANl4PpXIFklNjUvoBZ
	 unV3ilMoL5eu5X9jj1h2CwfkKUkcCXCcojPlNnT/mg59JvoPCu5lw4jlXOeuwArL4E
	 1eTjDB/OR1cBpa8TqM2sXI9BSnBf2BFtdzI3uFakdcNa9RnciAEdgcOOkKh7v0QvgY
	 rD1pgPN658YBg==
Date: Wed, 1 Apr 2026 17:49:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jian Yang <jian.yang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, chuanjia.liu@mediatek.com, yonglong.wu@mediatek.com
Subject: Re: [PATCH v1] PCI: mediatek-gen3: Align PERST# sequence with PCIe
 CEM specification
Message-ID: <x6nabkumov75khx4icgibrmd4o3oz5drm3cfthh6j2himsihla@echprgpjanoq>
References: <20260401031917.9108-1-jian.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260401031917.9108-1-jian.yang@mediatek.com>

On Wed, Apr 01, 2026 at 11:16:42AM +0800, Jian Yang wrote:
> Fix the control sequence of PERST# during system bootup/shutdown to
> meet the requirement from PCIe CEM specification. There are two major
> changes in this patch:
> 

You are fixing multiple issues in one patch, which is not acceptable.

> 1. Some of MediaTek's chip will stop generating REFCLK if the
> PCIE_PHY_RSTB signal of PCIe controller is asserted. We have to
> adjust the startup sequence as follows to ensure that PERST# will be
> de-asserted after the REFCLK is stable:
> Assert PHY reset and PERST# -> delay 10ms -> De-assert PHY reset ->
> delay 100ms -> De-assert PERST#
> 

This issue is separate and not related to the below two issues.

> 2. Add 'shutdown' callback to control the timing of PERST# and power
> during the system shutdown phase, ensuring that PERST# is active
> before the power on connector is removed.
> 

Adding 'shutdown()' callback should belong to a separate patch with its own
motivation.

> Signed-off-by: Jian Yang <jian.yang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 39 +++++++++++++++++++--
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index a94fdbaf47fe..66d177918565 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -62,6 +62,7 @@
>  #define PCIE_PHY_RSTB			BIT(1)
>  #define PCIE_BRG_RSTB			BIT(2)
>  #define PCIE_PE_RSTB			BIT(3)
> +#define PCIE_BRG_RST_RDY_MS		10
>  
>  #define PCIE_LTSSM_STATUS_REG		0x150
>  #define PCIE_LTSSM_STATE_MASK		GENMASK(28, 24)
> @@ -133,6 +134,7 @@
>  #define MAX_NUM_PHY_RESETS		3
>  
>  #define PCIE_MTK_RESET_TIME_US		10
> +#define PCIE_MTK_PDN_PERST_TIME_MS	5
>  
>  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
>  #define PCIE_EN7581_RESET_TIME_MS	100
> @@ -430,6 +432,21 @@ static int mtk_pcie_devices_power_up(struct mtk_gen3_pcie *pcie)
>  		return err;
>  	}
>  
> +	/*
> +	 * Some of MediaTek's chips won't output REFCLK when PCIE_PHY_RSTB is
> +	 * asserted, we have to de-assert MAC & PHY & BRG reset signals first
> +	 * to allow the REFCLK to be stable. While PCIE_BRG_RSTB is asserted,
> +	 * there is a short period during which the PCIe internal register
> +	 * cannot be accessed, so we need to wait 10ms here.
> +	 */
> +	msleep(PCIE_BRG_RST_RDY_MS);
> +
> +	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> +		/* De-assert MAC, PHY and BRG reset signals */
> +		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
> +		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> +	}
> +
>  	/*
>  	 * Described in PCIe CEM specification revision 6.0.
>  	 *
> @@ -439,9 +456,8 @@ static int mtk_pcie_devices_power_up(struct mtk_gen3_pcie *pcie)
>  	msleep(PCIE_T_PVPERL_MS);
>  
>  	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> -		/* De-assert reset signals */
> -		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> -			 PCIE_PE_RSTB);
> +		/* De-assert PERST# signal */
> +		val &= ~PCIE_PE_RSTB;
>  		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>  	}
>  
> @@ -459,6 +475,14 @@ static void mtk_pcie_devices_power_down(struct mtk_gen3_pcie *pcie)
>  		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
>  	}
>  
> +	/*
> +	 * Described in PCIe CEM specification revision 6.0.
> +	 *
> +	 * The PERST# gose active before the power on the connector is removed.
> +	 * Wait a while to ensure the voltage transition of PERST# is completed.
> +	 */
> +	msleep(PCIE_MTK_PDN_PERST_TIME_MS);

PERST# is asserted by setting the 'PCIE_PE_RSTB' bit. So if that controls the
actual voltage transition of PERST# signal, will reading it back ensure that the
transition has been completed without waiting for an arbitrary delay?

Nevertheless, this also belongs to a separate patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
