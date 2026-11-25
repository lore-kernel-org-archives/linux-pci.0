Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646934;
	b=NKTq/4Epa2fEW1v/rZPHUeYP1zQwAysPpnl4mCNhe6RMlOkZyZQQoqpd7myof01FV1IZ
	 ++TWhDt+SFzwUyImhwtMzPuYhtt+sM/eH4RNUgZ/F6y8RoFe3/nrXZEXbXZiHD0W3KaGF
	 tcQyy12jXKWn8BRDAU8Pf/jwzBjYeCgjyJFqOb+zuwrGkXd8L/I0swcIHu38uDPRZTCr4
	 3NCFigoHSJTEE/WLMcslByEeSNvV2A6PzllihpCWBQaSqUDpln0/ee/J1ZROfbXqFHiQA
	 +YZ4WLeeOod/0nVlgEA/ZjZT4JEUk2Pj86r9nCAXzyBxTE58OJPy109ELc7NuLyMR5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YDsDCXLkXL3cNo22jNaL7+utbyOJuM3+sdQzz79cB1A=;
	b=tSnpBuYT0HnqyMDz99M28tcHOz/MtRttEVqOLpztC421+82C+hgX4684jvRX9153v4br
	 uhilBsatt+r3mnRxX0Pa/i3kMyUxRiJ2Xt2IwpXXDDdtQm+SOJtPRhjkmns0Qe4H8xOLQ
	 f2P+R5c1h4jdq1wW5UZDJuMlOvoCJX45E+ty0+MepJ35d1mXmVI6eEJyAiTWNN1QvWsIp
	 lCmlpKIpm95N9WNPP4pgjA3tU1aLRqSzvF77qs9SbdeWW15QTSJWtQl50dohghud3Rk19
	 6+qJyuDdJ5HlJJi4UaWgT2Fbxl0jFIGvnGeuxmDYQ0uCMEq0R9hWJZ+ddtYZJY7kCgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lHhUDsm3;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB40606A6B5
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 22:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB40606A6B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lHhUDsm3
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso3276750a12.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 14:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795646926; x=1796251726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YDsDCXLkXL3cNo22jNaL7+utbyOJuM3+sdQzz79cB1A=;
        b=lHhUDsm3vzYxbrG0XKMHpULVIRUum6mQ2gyPAuoK9IQgAQ94X3IXkwhla9s9ac0/ar
         zxJESCPJbraVYEhyqdQzsE4Vhp48XYK8zEeYSQjwUPqKPKvOCqX3GPwMWe82PhP8uHMj
         O1jOXSnR9sTWpVtbFr6ptxyGM3tIOGbh3leES2Rh3ziQe4x1WnMDk88dXg1um6Fgu446
         IHiVmFt4YKFpBhn3n/D8e3a3jHsSDkHXpPTa0P5f4HvsGDmJfRcyzd0L1VF+Ppah8klJ
         MLICsutSRHytfv9zlJCgUL8z/5nvc678T4dYuYzY2AKebt4yVd8XOs5T6scTQbPnaUQ0
         o+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795646926; x=1796251726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDsDCXLkXL3cNo22jNaL7+utbyOJuM3+sdQzz79cB1A=;
        b=TdH19CZh/CdQgGw4WVsoMOZW99JFI3/HuQiHmLcxi78dwPADJHNI2eupnAKGRPiWOI
         lsDD+oyc5Sp0OhgQznMkLQdboyjZZR3e7Q8e0W1gkwKou+fPkTF+xxSoyBtuhGMeLSgr
         l6KMDrloYJld32e5mc7qmkx1ijHm44e3XTBlUCwxEhSNKXo21qSHlOOIuAW6frQ3s1Uu
         KLKiik+qpnqiNCLV5c+8XO1dp/cdhUaPnNQwjuhWDpoSpImrojbFWq7HVGgwE6IaWc/b
         RLhtIBnFeC0hKqC3H4N83OZSiZMAdX9DAvj1xcHrZ4p9OvXtLAq7orE7A915amfENgnt
         J1UQ==
X-Forwarded-Encrypted: i=1; AL+hErH+cmvowptquxbzNDvH4nYcS+O4vtThzX1X8kdFYqLq2WbsFZ3XJNdjrj1oz6k7TFHDdVjKxdxJXJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9U6KT89f0gBUDpMe2kBJ757w0PFlb66x5lZfr+8nvyELuSYA1B
	d+lTM7bo9fhz5DmtjmTPq+ehB8imzGlMJtfWCQkshZ1A3rYtPOwm8hGW
X-Gm-Gg: AZFdTZe2gbmPHYpQqCEIGomChWJeLoeA2z4MO5K2QpiV0G18nCExz5YnhJRTCctplzJ
	VMJ/rWDnquqTBtq7spKs6LduzGiAP0HYV3NfLwec53mh5HHxpkDYDuuMCnADCgwReLSsyB1LtEp
	ltMMuBQ55CrA/W7HAIDESzZ7fJD2IK2+p/yyUQlafKPe8gmlU8xZHi6IrW8GNqLnnQP1No2V6FX
	3iCElc9x5zScxvFLs4aeSwC+61IkMSsHucWoTQoddhbSKQsZmbamVb+cGtoT6IC0jBMg2At1O3l
	tiCEwVL86pXAR8ZO5s4l6nPlHy3pz5dwBvbaoIg4Y7srfvwBcn7pMKZy1B/bkJLA6nuhYRiok9D
	vN6usiT2yVqy1iTOft3DWApu8kT8KSudCG40PXz0eLX3ebTWphkBVmeRVzNu+UwWaHNGqquwAoO
	FUOnUoO1PhyH1fKpeEqzwhO8BtPxYQq+jCm3rwPvALBbeapKLzhIro+wNn1ebvVNgxcHbIbOV0+
	1Fb5PAHfmhxPtqQuqKSeMDb/2o7HS7LF1Y4GEKX0f9NfGbCMdBQct35S8HBy88OV/yJbRIPiZ5V
	ouiiC88kq146OQ4ToYzr3IZSCNA=
X-Received: by 2002:a17:90b:134e:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3b41c96764dmr18868042a91.49.1795646925992;
        Wed, 25 Nov 2026 14:48:45 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm13819382a91.10.2026.11.25.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:48:45 -0800 (PST)
Date: Thu, 26 Nov 2026 06:48:37 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Niklas Cassel <cassel@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Aksh Garg <a-garg7@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rhys Tumelty <rhys@tumelty.co.uk>, 
	Manikandan K Pillai <mpillai@cadence.com>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Hans Zhang <18255117159@163.com>, Yao Zi <me@ziyao.cc>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 8/8] ata: ahci_imx: Use bulk PHY APIs for calibration
 PHYs
Message-ID: <awdjOLoxBpS6t1KN@inochi.infowork>
References: <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-9-inochiama@gmail.com>
 <awcFIJlCOxB7nXNz@ryzen>
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
In-Reply-To: <awcFIJlCOxB7nXNz@ryzen>

On Wed, Nov 25, 2026 at 04:56:16PM +0100, Niklas Cassel wrote:
> Hello Inochi,
> 
> On Wed, Nov 25, 2026 at 12:36:39PM +0800, Inochi Amaoto wrote:
> > The i.MX8QM SATA PHY relies on the first two HSIO lanes for shared
> > impedance calibration. Store these calibration PHYs in a bulk array
> > and acquire them by name with devm_phy_bulk_get().
> > 
> > Initialize both calibration PHYs before powering them on in lane order,
> > then keep the SATA PHY initialization, mode selection and power-on
> > separate. Use the bulk helpers to release the calibration PHYs after
> > SATA startup and to unwind failures without repeating power-off after
> > a failed bulk power-on.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/ata/ahci_imx.c | 57 ++++++++++++++++--------------------------
> >  1 file changed, 21 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> > index 6aaa18e29abc..18faa033e44f 100644
> > --- a/drivers/ata/ahci_imx.c
> > +++ b/drivers/ata/ahci_imx.c
> > @@ -25,6 +25,8 @@
> >  
> >  #define DRV_NAME "ahci-imx"
> >  
> > +#define NUM_CALIPHY		2
> > +
> >  enum {
> >  	/* Timer 1-ms Register */
> >  	IMX_TIMER1MS				= 0x00e0,
> > @@ -66,8 +68,7 @@ struct imx_ahci_priv {
> >  	struct clk *ahb_clk;
> >  	struct regmap *gpr;
> >  	struct phy *sata_phy;
> > -	struct phy *cali_phy0;
> > -	struct phy *cali_phy1;
> > +	struct phy_bulk_data cali_phys[NUM_CALIPHY];
> >  	bool no_device;
> >  	bool first_time;
> >  	u32 phy_params;
> > @@ -428,30 +429,20 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
> >  	 * Initialize the first two lane PHYs here, although only the
> >  	 * third lane PHY is used by SATA.
> >  	 */
> > -	ret = phy_init(imxpriv->cali_phy0);
> > +	ret = phy_bulk_init(NUM_CALIPHY, imxpriv->cali_phys);
> >  	if (ret) {
> >  		dev_err(dev, "cali PHY init failed\n");
> >  		return ret;
> >  	}
> > -	ret = phy_power_on(imxpriv->cali_phy0);
> > +	ret = phy_bulk_power_on(NUM_CALIPHY, imxpriv->cali_phys);
> >  	if (ret) {
> >  		dev_err(dev, "cali PHY power on failed\n");
> > -		goto err_cali_phy0_exit;
> > -	}
> > -	ret = phy_init(imxpriv->cali_phy1);
> > -	if (ret) {
> > -		dev_err(dev, "cali PHY1 init failed\n");
> > -		goto err_cali_phy0_off;
> > -	}
> > -	ret = phy_power_on(imxpriv->cali_phy1);
> > -	if (ret) {
> > -		dev_err(dev, "cali PHY1 power on failed\n");
> > -		goto err_cali_phy1_exit;
> > +		goto err_cali_phy_exit;
> 
> This changes the order the calibration PHYs are brought up in.
> 
> The commit message describes the new order:
> 
>   "Initialize both calibration PHYs before powering them on in lane
>   order"
> 
> but doesn't say that it differs from the current sequence. Could the
> commit message mention the change, and why it is safe for the shared
> calibration?
> 

According to the document, there is no initialization order requirement
mentioned, so I thought it will be safe to change that since the
document shows that the calibration is independent in section 19.3.3.5.

> The cover letter mentions that the PHY timing requirements were checked
> against the documentation. Has the new sequence also been tested on
> i.MX8QM hardware?
> 

I does not check it on real hardware, the only thing I find is the
document.

> 
> >  	}
> >  	ret = phy_init(imxpriv->sata_phy);
> >  	if (ret) {
> >  		dev_err(dev, "sata PHY init failed\n");
> > -		goto err_cali_phy1_off;
> > +		goto err_cali_phy_off;
> >  	}
> >  	ret = phy_set_mode(imxpriv->sata_phy, PHY_MODE_SATA);
> >  	if (ret) {
> > @@ -465,10 +456,8 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
> >  	}
> >  
> >  	/* The cali_phy# can be turned off after SATA PHY is initialized. */
> > -	phy_power_off(imxpriv->cali_phy1);
> > -	phy_exit(imxpriv->cali_phy1);
> > -	phy_power_off(imxpriv->cali_phy0);
> > -	phy_exit(imxpriv->cali_phy0);
> > +	phy_bulk_power_off(NUM_CALIPHY, imxpriv->cali_phys);
> > +	phy_bulk_exit(NUM_CALIPHY, imxpriv->cali_phys);
> >  
> >  	/* RxWaterMark setting */
> >  	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
> > @@ -480,14 +469,10 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
> >  
> >  err_sata_phy_exit:
> >  	phy_exit(imxpriv->sata_phy);
> > -err_cali_phy1_off:
> > -	phy_power_off(imxpriv->cali_phy1);
> > -err_cali_phy1_exit:
> > -	phy_exit(imxpriv->cali_phy1);
> > -err_cali_phy0_off:
> > -	phy_power_off(imxpriv->cali_phy0);
> > -err_cali_phy0_exit:
> > -	phy_exit(imxpriv->cali_phy0);
> > +err_cali_phy_off:
> > +	phy_bulk_power_off(NUM_CALIPHY, imxpriv->cali_phys);
> > +err_cali_phy_exit:
> > +	phy_bulk_exit(NUM_CALIPHY, imxpriv->cali_phys);
> >  
> >  	return ret;
> >  }
> > @@ -839,19 +824,19 @@ static const struct scsi_host_template ahci_platform_sht = {
> >  
> >  static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
> >  {
> > +	int ret;
> > +
> >  	imxpriv->sata_phy = devm_phy_get(dev, "sata-phy");
> >  	if (IS_ERR(imxpriv->sata_phy))
> >  		return dev_err_probe(dev, PTR_ERR(imxpriv->sata_phy),
> >  				     "Failed to get sata_phy\n");
> >  
> > -	imxpriv->cali_phy0 = devm_phy_get(dev, "cali-phy0");
> > -	if (IS_ERR(imxpriv->cali_phy0))
> > -		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy0),
> > -				     "Failed to get cali_phy0\n");
> > -	imxpriv->cali_phy1 = devm_phy_get(dev, "cali-phy1");
> > -	if (IS_ERR(imxpriv->cali_phy1))
> > -		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy1),
> > -				     "Failed to get cali_phy1\n");
> > +	imxpriv->cali_phys[0].id = "cali-phy0";
> > +	imxpriv->cali_phys[1].id = "cali-phy1";
> > +
> > +	ret = devm_phy_bulk_get(dev, NUM_CALIPHY, imxpriv->cali_phys);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to get cali_phy\n");
> 
> phy_bulk_get() already reports which PHY failed:
> 
> drivers/phy/phy-core.c:phy_bulk_get() {
>     ...
>         for (i = 0; i < num_phys; i++) {
>                 phys[i].phy = phy_get(dev, phys[i].id);
> 
>                 ret = PTR_ERR_OR_ZERO(phys[i].phy);
>                 if (ret) {
>                         phys[i].phy = NULL;
> 
>                         dev_err_probe(dev, ret, "Failed to get phy: (%s)\n",
>                                       phys[i].id);
>                         goto err;
>                 }
>         }
>     ...
> }
> 
> so a missing cali-phy1 entry in phy-names now prints two errors, and the
> second one doesn't name the PHY.
> 
> A plain "return ret;" should be enough here.
> 
> 

Thanks, I will fix it.

Regards,
Inochi
