Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622185;
	b=W0LWHePHIXZx1hp7C0Qm7aKoGsZBdHJtVD4OuPcc/lfS08qRTu6xXdADHmQbloCqJHlH
	 2Py0tiwEhPCL2e3RmFqr3VM2sgCtpxrUFP7eHmYEddzl9St9oDPrmyrSV+wlVEKsLjcjA
	 4j3AS3Pbzlqz99th348fU39two9B0S02B/j1XiYVo/HH96VOVbuNFdzbyynT//Z5vvtfg
	 3YlULaSUoJLC8hJAufFYWJbdtY6u0ByN/JMwmAcxmNXkuc1WHzr57sQI7Jmp35TiFG8BB
	 hNQQRfc/MquHBwnwxY6WiFTxo/HSPhqWp/6aAS1MV4HYMn0CqTJO6ydIabHHwRvtBQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622185;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q4uv0asRR2dgGMXvOPx/Lal51OzeJ3KhJ9tib17HZ3c=;
	b=1tcBtIwMaa+tYBd96Uk/63OcfRZ+qOGERd87GJx5snHpbJsBf5wZ2XZsg0DABbKkdKU6
	 lL4POVKiMErTgG6Ej6iQvtDOHm6eymBRYrGBGi6dsql4IQDNO/ytbAOfptvHfCkz05tXV
	 KCkw/zspEj8UVYt2gRzzQvoQjdcLEdrYiZbfvFTD/0F0DAivnzCzb08b/Qa81zbsxvSNC
	 LHvwojsPnRoHjpP61oIg2WWPPttD6q75tzuP6fdcXNnmDk6GCV+QkU6XD4xcLF7Guw03V
	 tRRC5EtHHD2HPBtcmOXhxxZbpRmXndgZKwiUPBDHBFLBBpVuzth8d3+KHsdIQId9ayA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1qv51xI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC99606A321;
	Wed, 25 Nov 2026 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1qv51xI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF581F0093E;
	Wed, 25 Nov 2026 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622185;
	bh=q4uv0asRR2dgGMXvOPx/Lal51OzeJ3KhJ9tib17HZ3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R1qv51xIK6Mx7z4WavGDaEQcFgwJQvutqhCXM+ZAKWIklnCkqRyE/V1eejVf+E3AL
	 6AxKgPcQNqzrLC2qdJyMbBwrCyb19pNyVKaPQGesLvn56Tl/XBYq8eAYUat852bM/l
	 5b3hi1x0qvJEt3xurKf6iBdGDD61GFMmLgwW+mXhjWa47oy/9IXL2ZCrpEj94sTRAd
	 35S5nmvPcm81hxQX26Rjyh58U7nQU64f1wuLs6hQJkAdo5m+djbb8CjPbE8unnayN+
	 URJAcJloXrqoOTpUay/QP4Ate0tEStRd/ddouTQgq5MGdiPC8ReUkspwuhWnSCOkQl
	 HnNVLsx9NnT8Q==
Date: Wed, 25 Nov 2026 16:56:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Aksh Garg <a-garg7@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rhys Tumelty <rhys@tumelty.co.uk>,
	Manikandan K Pillai <mpillai@cadence.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Hans Zhang <18255117159@163.com>, Yao Zi <me@ziyao.cc>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 8/8] ata: ahci_imx: Use bulk PHY APIs for calibration
 PHYs
Message-ID: <awcFIJlCOxB7nXNz@ryzen>
References: <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-9-inochiama@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125043639.249525-9-inochiama@gmail.com>

Hello Inochi,

On Wed, Nov 25, 2026 at 12:36:39PM +0800, Inochi Amaoto wrote:
> The i.MX8QM SATA PHY relies on the first two HSIO lanes for shared
> impedance calibration. Store these calibration PHYs in a bulk array
> and acquire them by name with devm_phy_bulk_get().
> 
> Initialize both calibration PHYs before powering them on in lane order,
> then keep the SATA PHY initialization, mode selection and power-on
> separate. Use the bulk helpers to release the calibration PHYs after
> SATA startup and to unwind failures without repeating power-off after
> a failed bulk power-on.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/ata/ahci_imx.c | 57 ++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 6aaa18e29abc..18faa033e44f 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -25,6 +25,8 @@
>  
>  #define DRV_NAME "ahci-imx"
>  
> +#define NUM_CALIPHY		2
> +
>  enum {
>  	/* Timer 1-ms Register */
>  	IMX_TIMER1MS				= 0x00e0,
> @@ -66,8 +68,7 @@ struct imx_ahci_priv {
>  	struct clk *ahb_clk;
>  	struct regmap *gpr;
>  	struct phy *sata_phy;
> -	struct phy *cali_phy0;
> -	struct phy *cali_phy1;
> +	struct phy_bulk_data cali_phys[NUM_CALIPHY];
>  	bool no_device;
>  	bool first_time;
>  	u32 phy_params;
> @@ -428,30 +429,20 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
>  	 * Initialize the first two lane PHYs here, although only the
>  	 * third lane PHY is used by SATA.
>  	 */
> -	ret = phy_init(imxpriv->cali_phy0);
> +	ret = phy_bulk_init(NUM_CALIPHY, imxpriv->cali_phys);
>  	if (ret) {
>  		dev_err(dev, "cali PHY init failed\n");
>  		return ret;
>  	}
> -	ret = phy_power_on(imxpriv->cali_phy0);
> +	ret = phy_bulk_power_on(NUM_CALIPHY, imxpriv->cali_phys);
>  	if (ret) {
>  		dev_err(dev, "cali PHY power on failed\n");
> -		goto err_cali_phy0_exit;
> -	}
> -	ret = phy_init(imxpriv->cali_phy1);
> -	if (ret) {
> -		dev_err(dev, "cali PHY1 init failed\n");
> -		goto err_cali_phy0_off;
> -	}
> -	ret = phy_power_on(imxpriv->cali_phy1);
> -	if (ret) {
> -		dev_err(dev, "cali PHY1 power on failed\n");
> -		goto err_cali_phy1_exit;
> +		goto err_cali_phy_exit;

This changes the order the calibration PHYs are brought up in.

The commit message describes the new order:

  "Initialize both calibration PHYs before powering them on in lane
  order"

but doesn't say that it differs from the current sequence. Could the
commit message mention the change, and why it is safe for the shared
calibration?

The cover letter mentions that the PHY timing requirements were checked
against the documentation. Has the new sequence also been tested on
i.MX8QM hardware?


>  	}
>  	ret = phy_init(imxpriv->sata_phy);
>  	if (ret) {
>  		dev_err(dev, "sata PHY init failed\n");
> -		goto err_cali_phy1_off;
> +		goto err_cali_phy_off;
>  	}
>  	ret = phy_set_mode(imxpriv->sata_phy, PHY_MODE_SATA);
>  	if (ret) {
> @@ -465,10 +456,8 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
>  	}
>  
>  	/* The cali_phy# can be turned off after SATA PHY is initialized. */
> -	phy_power_off(imxpriv->cali_phy1);
> -	phy_exit(imxpriv->cali_phy1);
> -	phy_power_off(imxpriv->cali_phy0);
> -	phy_exit(imxpriv->cali_phy0);
> +	phy_bulk_power_off(NUM_CALIPHY, imxpriv->cali_phys);
> +	phy_bulk_exit(NUM_CALIPHY, imxpriv->cali_phys);
>  
>  	/* RxWaterMark setting */
>  	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
> @@ -480,14 +469,10 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
>  
>  err_sata_phy_exit:
>  	phy_exit(imxpriv->sata_phy);
> -err_cali_phy1_off:
> -	phy_power_off(imxpriv->cali_phy1);
> -err_cali_phy1_exit:
> -	phy_exit(imxpriv->cali_phy1);
> -err_cali_phy0_off:
> -	phy_power_off(imxpriv->cali_phy0);
> -err_cali_phy0_exit:
> -	phy_exit(imxpriv->cali_phy0);
> +err_cali_phy_off:
> +	phy_bulk_power_off(NUM_CALIPHY, imxpriv->cali_phys);
> +err_cali_phy_exit:
> +	phy_bulk_exit(NUM_CALIPHY, imxpriv->cali_phys);
>  
>  	return ret;
>  }
> @@ -839,19 +824,19 @@ static const struct scsi_host_template ahci_platform_sht = {
>  
>  static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
>  {
> +	int ret;
> +
>  	imxpriv->sata_phy = devm_phy_get(dev, "sata-phy");
>  	if (IS_ERR(imxpriv->sata_phy))
>  		return dev_err_probe(dev, PTR_ERR(imxpriv->sata_phy),
>  				     "Failed to get sata_phy\n");
>  
> -	imxpriv->cali_phy0 = devm_phy_get(dev, "cali-phy0");
> -	if (IS_ERR(imxpriv->cali_phy0))
> -		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy0),
> -				     "Failed to get cali_phy0\n");
> -	imxpriv->cali_phy1 = devm_phy_get(dev, "cali-phy1");
> -	if (IS_ERR(imxpriv->cali_phy1))
> -		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy1),
> -				     "Failed to get cali_phy1\n");
> +	imxpriv->cali_phys[0].id = "cali-phy0";
> +	imxpriv->cali_phys[1].id = "cali-phy1";
> +
> +	ret = devm_phy_bulk_get(dev, NUM_CALIPHY, imxpriv->cali_phys);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get cali_phy\n");

phy_bulk_get() already reports which PHY failed:

drivers/phy/phy-core.c:phy_bulk_get() {
    ...
        for (i = 0; i < num_phys; i++) {
                phys[i].phy = phy_get(dev, phys[i].id);

                ret = PTR_ERR_OR_ZERO(phys[i].phy);
                if (ret) {
                        phys[i].phy = NULL;

                        dev_err_probe(dev, ret, "Failed to get phy: (%s)\n",
                                      phys[i].id);
                        goto err;
                }
        }
    ...
}

so a missing cali-phy1 entry in phy-names now prints two errors, and the
second one doesn't name the PHY.

A plain "return ret;" should be enough here.


Kind regards,
Niklas
