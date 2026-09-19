Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6452DC76A;
	Sat, 19 Sep 2026 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789819509; cv=none; b=edUCkC+niN0LUPNxHM7JCj5Fhnz4JVARZAv7LBG6Tyv9gD8butFQb9jnpvTofgh8vn36C6PwiP3FXFTvUUiVqfdcvtJte2CIHDhXYvRj/g4LZIm/xS2flysa+hJTu5vtllXw8l5OOM4ZqvtYriiymMTfvzX1CgP2Ra0zeGflgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789819509; c=relaxed/simple;
	bh=qT0uHq50xuDhbsDO5hHlQBOwDv2Zr0eCRbEkzMG7I3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rxk3rLX8x8njHUjzAfCqwdQr0Icovbg83fCJvHgYgmVlN+FNGPdAofmt2CCA2qh8w89yIe7fSOq4XzQrLHM7rakxWQCN8JoGRTBMmmXRHUaIck/Wt+z4KUXF8LakFYpwDMvM5V6NsFJaX4R2AiHhXv5BkIIBveMw87fCYih0i3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i6MQZccq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i6MQZccq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 78AA14E40589;
	Sat, 19 Sep 2026 12:05:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB431606CA;
	Sat, 19 Sep 2026 12:05:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1195E1032802B;
	Sat, 19 Sep 2026 14:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789819500; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SFMPcolUh4zpvmGrKEAW5fnqAUuQ8Gy43QODCsF/j7o=;
	b=i6MQZccqtvleTOJOc2xjeW74ER3MJIHhkShL13MtzMohMMbitlY+MYOeRapQZv1FRiszrs
	zsf1Pv/lOh5OT6jSrSMJ4+EokPhsjhR2nNW0DzbFOFsB7Cz6h7q8KceiPVEr8c/hVjzTQE
	nqWaJ3jUnxndGN+Av5Y/zTKlPIozQ9H0inoQiaosndiodGrV9KAbI4uoJd7zMc8ncYo6Zk
	P6PzdTlsRqie0aGyDM4ExXIMsVaonLvOTTS6NvT3XEezxcxgwTD/wUnrR/f5DLEmh6snZn
	cRuCQZNwoa0sUcWwmZASNz92J0cRcRQihCO++rAu2wDZgfruuPhVucTt1phM4g==
Message-ID: <7b0a957d-f770-4bad-b3b9-aeb7a61bfb49@bootlin.com>
Date: Sat, 19 Sep 2026 14:04:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 07/12] net: stmmac: dwmac-s32: Add SGMII support
To: jan.petrous@oss.nxp.com,
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Bogdan Hamciuc
 <bogdan.hamciuc@nxp.com>, Ionut Vicovan <ionut.vicovan@nxp.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Clark Wang <xiaoning.wang@nxp.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 imx@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-7-9d68868c1e89@oss.nxp.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260919-s32g_serdes-v3-7-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jan,

On 9/19/26 08:54, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Wire the NXP S32G SerDes XPCS PCS into the dwmac-s32 glue layer so the
> MAC can run SGMII over a SerDes lane.
> 
> Changes:
> - s32_gmac_write_phy_intf_select: replace the hard-coded RGMII selector
>   with a switch on phy_interface so SGMII (0x01), RGMII, RMII and MII
>   all programme the SoC control register correctly.
> - Add s32_gmac_pcs_init: obtain the phylink_pcs handle from the SerDes
>   subsystem via s32g_serdes_pcs_create(), keyed by the standard
>   pcs-handle property on the GMAC node pointing at the SerDes XPCS lane
>   child. Propagates -EPROBE_DEFER if the SerDes driver has not probed
>   yet. There is no matching exit hook: the device link created by
>   s32g_serdes_pcs_create() covers the lifetime.
> - Add s32_gmac_select_pcs: return the stored PCS handle when the
>   negotiated interface is SGMII.
> - Hook pcs_init and select_pcs into plat_stmmacenet_data.
> 
> Note that installing a select_pcs callback suppresses the core's
> integrated_pcs fallback, because stmmac treats a NULL return from
> select_pcs as "no PCS" rather than "fall through". This matches what
> dwmac-rzn1 and dwmac-intel already do.
> 
> Both negotiation modes are supported by the PCS. The board device
> trees added later in this series describe the MAC-side link as fixed,
> so they exercise the out-of-band path.
> 
> The XPCS header guards its s32g_serdes_pcs_create() declaration with
> IS_REACHABLE(CONFIG_PHY_S32G_SERDES) and provides a static-inline stub
> returning -ENODEV otherwise. IS_REACHABLE is false both when the SerDes
> driver is disabled and in the built-in-consumer / modular-provider case
> (DWMAC_S32=y with PHY_S32G_SERDES=m), so this driver links in all four
> combinations of the two symbols.
> 
> Linking is not sufficient on its own, though. In the DWMAC_S32=y with
> PHY_S32G_SERDES=m case the stub makes s32_gmac_pcs_init() return
> -ENODEV, and stmmac treats a failing plat->pcs_init() as fatal, so a
> built-in MAC would refuse to probe on any device tree describing
> pcs-handle. Add a Kconfig dependency forbidding that combination
> rather than letting it build into a MAC that cannot probe.
> 
> Tested on an S32G3-VNP-RDB3 board: GMAC0 links at 1G over SGMII and
> passes traffic, both in SerDes mode 1 (alongside two active PCIe root
> complexes) and in mode 3.
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig     |  6 ++
>  drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c | 74 ++++++++++++++++++++++++-
>  2 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index e3dd5adda5ac..1443ff4149b4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -192,6 +192,12 @@ config DWMAC_S32
>  	tristate "NXP S32G/S32R GMAC support"
>  	default ARCH_S32
>  	depends on OF && (ARCH_S32 || COMPILE_TEST)
> +	# SGMII needs the PCS from the SerDes driver. The header falls back
> +	# to a stub returning -ENODEV when that driver is not reachable, and
> +	# stmmac makes a failing plat->pcs_init() fatal, so a built-in MAC
> +	# with a modular SerDes would refuse to probe on any DT describing
> +	# pcs-handle. Forbid that combination instead.
> +	depends on PHY_S32G_SERDES || PHY_S32G_SERDES=n

select PHY_S32G_SERDES ? This is what other glues that require PCS do,
or there's a catch that prevents using it ?

>  	help
>  	  Support for ethernet controller on NXP S32CC SOCs.
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> index 024d8e10e918..a3a56b21181a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> @@ -16,12 +16,14 @@
>  #include <linux/of_mdio.h>
>  #include <linux/of_address.h>
>  #include <linux/phy.h>
> +#include <linux/phy/nxp-s32g-serdes.h>
>  #include <linux/phylink.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/stmmac.h>
>  
>  #include "stmmac_platform.h"
> +#include "stmmac.h"
>  
>  #define GMAC_INTF_RATE_125M	125000000	/* 125MHz */
>  
> @@ -40,23 +42,89 @@ struct s32_priv_data {
>  	phy_interface_t *intf_mode;
>  	struct clk *tx_clk;
>  	struct clk *rx_clk;
> +	/* SGMII PCS provided by the SerDes subsystem (NULL if not SGMII) */
> +	struct phylink_pcs *pcs;

There's already a phylink_pcs pointer in priv->hw, you shouldn't have to
store your own here.

>  };
>  
>  static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
>  {
> +	u32 intf_sel;
>  	int ret = 0;
>  
> +	switch (*gmac->intf_mode) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		intf_sel = S32_PHY_INTF_SEL_SGMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		intf_sel = S32_PHY_INTF_SEL_RGMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		intf_sel = S32_PHY_INTF_SEL_RMII;
> +		break;
> +	case PHY_INTERFACE_MODE_MII:
> +		intf_sel = S32_PHY_INTF_SEL_MII;
> +		break;
> +	default:
> +		dev_err(gmac->dev, "Unsupported phy interface mode: %s\n",
> +			phy_modes(*gmac->intf_mode));
> +		return -EINVAL;
> +	}

We go from supporting RGMII only to RGMII + RMII + MII + SGMII.

Are RMII and MII actually supported on that platform ? if so, can you split
that into 2 commits : one for proper inft_sel support with RMII + MII added,
the another one for SGMII ? 

> +
>  	if (gmac->ctrl_sts)
> -		writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> +		writel(intf_sel, gmac->ctrl_sts);
>  	else
>  		ret = regmap_write(gmac->sts_regmap, gmac->sts_offset,
> -				   S32_PHY_INTF_SEL_RGMII);
> +				   intf_sel);
>  
>  	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
>  
>  	return ret;
>  }
>  
> +static int s32_gmac_pcs_init(struct stmmac_priv *priv)
> +{
> +	struct s32_priv_data *gmac = priv->plat->bsp_priv;
> +	struct device_node *pcs_node;
> +
> +	/*
> +	 * pcs-handle points at the SerDes XPCS lane child node; its
> +	 * nxp,xpcs-instance property is what identifies the XPCS instance.
> +	 */
> +	pcs_node = of_parse_phandle(gmac->dev->of_node, "pcs-handle", 0);
> +	if (!pcs_node) {
> +		dev_dbg(gmac->dev, "no 'pcs-handle' property, SGMII PCS unavailable\n");
> +		return 0;
> +	}
> +
> +	gmac->pcs = s32g_serdes_pcs_create(gmac->dev, pcs_node);
> +	of_node_put(pcs_node);
> +
> +	if (IS_ERR(gmac->pcs)) {
> +		int err = PTR_ERR(gmac->pcs);
> +
> +		gmac->pcs = NULL;
> +		/* SerDes may not be probed yet - defer probe. */
> +		return err;
> +	}
> +
> +	dev_dbg(gmac->dev, "SGMII PCS created via SerDes XPCS\n");
> +	return 0;
> +}
> +
> +static struct phylink_pcs *s32_gmac_select_pcs(struct stmmac_priv *priv,
> +					       phy_interface_t interface)
> +{
> +	struct s32_priv_data *gmac = priv->plat->bsp_priv;
> +
> +	if (interface == PHY_INTERFACE_MODE_SGMII && gmac->pcs)
> +		return gmac->pcs;

No need for the && gmac->pcs here, if it's NULL we return NULL anyway so you
can return priv->hw->phylink_pcs

> +
> +	return NULL;
> +}
> +
>  static int s32_gmac_init(struct device *dev, void *priv)
>  {
>  	struct s32_priv_data *gmac = priv;
> @@ -204,6 +272,8 @@ static int s32_dwmac_probe(struct platform_device *pdev)
>  
>  	plat->init = s32_gmac_init;
>  	plat->exit = s32_gmac_exit;
> +	plat->pcs_init = s32_gmac_pcs_init;
> +	plat->select_pcs = s32_gmac_select_pcs;
>  
>  	plat->clk_tx_i = gmac->tx_clk;
>  	plat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
> 

Thanks,

Maxime
