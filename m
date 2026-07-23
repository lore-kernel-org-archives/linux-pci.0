Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC024766A6
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832012; cv=none; b=kdrkmHQ0p3AQf10OyyEnl3m9XzT9MKiVbd4FplsgVk7ooufPlc56ejyhe8t9aBfgoyzew+C5YGnWPyIic2Z+oiFqMavPeLGdfCBBD3tXuQSqmW+EpkN9DnYJQjWjcbrH9NWcPvjqiN6Ct0n9J6Lo5grjON4VTc7Xlx7Qv3+70HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832012; c=relaxed/simple;
	bh=cL4JAZ9BV7u1m206l1hk79KytfDo0V6V2twUyH+3TcU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffpdUW0HNOkK7jvCnL3vVuEYozvelk24ocVGLbhP9YTO0Q9CJSP3RGaRvp9etjZBsvC380rBmnJKy3uOEku+GF+oGqJ4+/ByLdQSfuFb4jku/+UkaeweBrCvk5N94P+IIhgKsf5uO6jNi2fL4TowjY7rXPK+ipJc2gh/2VjEIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah3p6xR4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah3p6xR4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-472326ca506so709267f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832007; x=1785436807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RHtRx7/TrncyXEUejofUChLHf2uO3p9RQph6fNJ/fvk=;
        b=Ah3p6xR4FX3FxixjeWpbkMewPQr68P4PJ0meRiwrb2ahHpm32X+Z22JuqbF8aLwBoy
         sjGyjvxYc2I4uCh7hzDXI93w1eHVijBr9ySWJSdw6KCW5ZnW5cfi2QldTvI7/4j9kHMj
         QZK/FrXjnOjPdLEwFVYnWBend8f8lUrWhzpPXUvk4Rg8f4gxpWBvw41BeQNY7mIAH+bm
         dETSR3toAqLdIpl2fWOOX9fgHZ+KZE6GEHzkt5L95L0cjmA9NxPYdclrlWcB+qcu7zqW
         KhRFoT7QhA2LD0B6f1xFCqDlVTkcuLIKf12LVJwgKp3uikf85BTxGDEJ99Vc1SxkIR7H
         OzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832007; x=1785436807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHtRx7/TrncyXEUejofUChLHf2uO3p9RQph6fNJ/fvk=;
        b=H4JK30+4gmOWKxLCOX5X3Q8ip+bKOG1v3Cq9pE3H+br7yatzWjBkGORqHED0nfNneo
         vOC14LMRRPor9DTYLCQk7Sd+23OjjxZi9Q7uGMVji/seAFtXovIa3tGYgYtRL7hdpWbv
         f1YtkgOKJ1/haHPSXTUJ4DpAVDHbNAgaKXevSIxUvCl18OGYBb8Tj7I5aIXRCwEPLGtQ
         LBE08QFkK17VMEzNQJswh2LKDGa/7+hBmjgwdi1gQU/3b0sfLK+F52Me+gAyXcunfTzw
         a/DB83cc/TrW0e5btoS6Ay3/rvvgBSrHygi7A/JM3xSfeY7ocGpVP2K+OvqJeZmiHlw8
         +IpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4dnPlqwa8tmhjb4i/7MyS1n5jh5UHrvnmVeh+FahN6mSj4JNpfMiw9fBR3g39hdhX9jXBaxX36O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1XmjzJEJjollruEG9i2JI0dA2kpL+bhpX98MVOtpaan6dzaH
	TeUzZyOZGzxdSN+l3YAVA4YP+fAF9B1JAaWjmq+9qxAWEKq01TuurTP2
X-Gm-Gg: AR+sD12U75mQ278TdMaUU/SZPbcG8qg+ruW7hZGmH9yFOIiZm1KS2c+LzVl/tMQaWRG
	Q5W5CbYhUHnPPLJwbX/75wo4oSK5LO9wxzbtRrZUD/UhA32wWcuhVCAA1l8wvfC3sdN1WmsP2SJ
	qISgC1XEQSULsCN14wH24XsdM+QKM7zTUpdUqgTEpnyL9uL3cOocQv0jWttz00jfD30zGtEUK7P
	CkZa6cAH503UtLiuJqk+X6g3PbdZAm/Pt8WmTlQTfzVE+GMzK4mXHxCTCD/i1ca2/DALLTsmmuC
	82zI7Od163gU7gTs4wTXQkxhh+Jo8EveaI6e1d+NwgbS9yz8N5J8dpNC23zqIWYLs7ihvMJErB5
	MtEHjHBEd6nMAm5xafr7fr/AEQ1E8BKmq9zA7pXX7m7f0TqXPh9FdKVnkaJtsatrZMTYMNHjfnb
	TmevvGH3/9C6NEDFMJ3KTC6zj6WAR1+EbJ14up+8bSIsHySI8=
X-Received: by 2002:a05:6000:712:b0:47f:87f5:ed32 with SMTP id ffacd0b85a97d-47f8d75f5f3mr5808844f8f.46.1784832007156;
        Thu, 23 Jul 2026 11:40:07 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-3-249-180.retail.telecomitalia.it. [87.3.249.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6f076sm18340282f8f.34.2026.07.23.11.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:40:06 -0700 (PDT)
Message-ID: <6a626006.4d70c427.b2b96.c939@mx.google.com>
X-Google-Original-Message-ID: <amJgA6tsUqTinTkZ@Ansuel-XPS.>
Date: Thu, 23 Jul 2026 20:40:03 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add 2-lanes mode support for
 Airoha AN7581
References: <20260714115848.8537-5-ansuelsmth@gmail.com>
 <20260722174010.GA746214@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722174010.GA746214@bhelgaas>

On Wed, Jul 22, 2026 at 12:40:10PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 14, 2026 at 01:58:46PM +0200, Christian Marangi wrote:
> > The Airoha AN7581 SoC supports configuring the first PCIe0 lane to 2-lanes
> > mode (2x link) by bonding it with the second PCIe lane (PCIe1). This is
> > done by configuring the PCIe MUX in the SCU register.
> 
> s/2x/x2/ to match usual convention, e.g., PCIe r7.0 sec 1.2
> 
> I mentioned this before at
> https://lore.kernel.org/all/20260626162508.GA27685@bhelgaas
> 
> > To correctly configure PCIe0 in 2x link, define in DT the following
> > additional property:
> 
> s/property/properties/
> 
> Add a blank line here and indent the following list a couple spaces:
> 
> > - additional reg, 'sec-pcie-mac' for the secondary PCIe.
> > - PERSTOUT reset for both main and secondary PCIE0, called 'perstout' and
> >   'sec-perstout'
> > - airoha,scu property to correctly configure the SCU register for the PCIe
> >   MUX
> > - 'num-lanes' set to '2' to enable PCIe0 in 2x link
> 
> Add '' around 'airoha,scu' to match the others
> s/2x/x2/
> 
> > In such configuration the EQ preset are configured to the same values.
> > 
> > To permit correct configuration of the PCIe line, additional logic is added
> > to assert and deassert the PERSTOUT resets.
> 
> s/line/link/
> 
> In the PCIe context, "line" doesn't mean anything.
> 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 106 ++++++++++++++++----
> >  1 file changed, 89 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index b0accd828589..764974045340 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -32,6 +32,11 @@
> >  
> >  #include "../pci.h"
> >  
> > +/* AN7581 SCU register */
> > +#define SCU_PCIC			0x88
> > +#define SCU_PCIC_PCIE_CTRL		GENMASK(7, 0)
> > +
> > +/* PCIe register */
> >  #define PCIE_BASE_CFG_REG		0x14
> >  #define PCIE_BASE_CFG_SPEED		GENMASK(15, 8)
> >  
> > @@ -131,6 +136,7 @@
> >  #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
> >  
> >  #define MAX_NUM_PHY_RESETS		3
> > +#define MAX_NUM_PERSTOUT_RESETS		2
> >  
> >  #define PCIE_MTK_RESET_TIME_US		10
> >  
> > @@ -203,9 +209,11 @@ struct mtk_msi_set {
> >  struct mtk_gen3_pcie {
> >  	struct device *dev;
> >  	void __iomem *base;
> > +	void __iomem *sec_base;
> >  	phys_addr_t reg_base;
> >  	struct reset_control *mac_reset;
> >  	struct reset_control_bulk_data phy_resets[MAX_NUM_PHY_RESETS];
> > +	struct reset_control_bulk_data perstout_resets[MAX_NUM_PERSTOUT_RESETS];
> >  	struct phy *phy;
> >  	struct clk_bulk_data *clks;
> >  	int num_clks;
> > @@ -928,6 +936,14 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
> >  	if (ret)
> >  		return dev_err_probe(dev, ret, "failed to get PHY bulk reset\n");
> >  
> > +	pcie->perstout_resets[0].id = "perstout";
> > +	pcie->perstout_resets[1].id = "sec-perstout";
> > +
> > +	ret = devm_reset_control_bulk_get_optional_exclusive(dev, MAX_NUM_PERSTOUT_RESETS,
> > +							     pcie->perstout_resets);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to get PERSTOUT bulk reset\n");
> > +
> >  	pcie->mac_reset = devm_reset_control_get_optional_exclusive(dev, "mac");
> >  	if (IS_ERR(pcie->mac_reset))
> >  		return dev_err_probe(dev, PTR_ERR(pcie->mac_reset), "failed to get MAC reset\n");
> > @@ -949,18 +965,38 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
> >  			pcie->num_lanes = num_lanes;
> >  	}
> >  
> > +	/* Map secondary PCIe for 2-lanes mode for EN7581 */
> > +	if (pcie->num_lanes == 2 && device_is_compatible(dev, "airoha,en7581-pcie")) {
> > +		regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sec-pcie-mac");
> > +		if (!regs)
> > +			return -EINVAL;
> > +		pcie->sec_base = devm_ioremap_resource(dev, regs);
> > +		if (IS_ERR(pcie->sec_base))
> > +			return dev_err_probe(dev, PTR_ERR(pcie->sec_base), "failed to map secondary register base\n");
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> >  static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> >  {
> >  	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> > +	unsigned int num_lanes = max(1, pcie->num_lanes);
> > +	struct regmap *pbus_regmap, *scu;
> >  	struct device *dev = pcie->dev;
> >  	struct resource_entry *entry;
> > -	struct regmap *pbus_regmap;
> >  	u32 val, args[2], size;
> >  	resource_size_t addr;
> > -	int err;
> > +	int i, err;
> > +
> > +	if (num_lanes > 2)
> > +		return dev_err_probe(dev, -EINVAL, "unsupported num-lanes, maximum 2 lanes supported\n");
> > +
> > +	if (num_lanes == 2) {
> > +		scu = syscon_regmap_lookup_by_phandle(dev->of_node, "airoha,scu");
> > +		if (IS_ERR(scu))
> > +			return dev_err_probe(dev, PTR_ERR(scu), "failed to map SCU regmap\n");
> > +	}
> >  
> >  	/*
> >  	 * The controller may have been left out of reset by the bootloader
> > @@ -992,6 +1028,19 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> >  	size = lower_32_bits(resource_size(entry->res));
> >  	regmap_write(pbus_regmap, args[1], GENMASK(31, __fls(size)));
> >  
> > +	/* Assert PERSTOUT for all relevant lines */
> 
> s/lines/lanes/ (also several more places below)
> 
> > +	err = reset_control_bulk_assert(MAX_NUM_PERSTOUT_RESETS,
> > +					pcie->perstout_resets);
> > +	if (err) {
> > +		dev_err(dev, "failed to assert PERSTOUTs\n");
> > +		return err;
> > +	}
> > +
> > +	/* Configure SCU MUX to disable PCIE1 for 2 lines mode */
> > +	if (num_lanes == 2)
> > +		regmap_update_bits(scu, SCU_PCIC, SCU_PCIC_PCIE_CTRL,
> > +				   FIELD_PREP(SCU_PCIC_PCIE_CTRL, BIT(1)));
> > +
> >  	/*
> >  	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
> >  	 * requires PHY initialization and power-on before PHY reset deassert.
> > @@ -1024,18 +1073,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> >  	pm_runtime_enable(dev);
> >  	pm_runtime_get_sync(dev);
> >  
> > -	val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> > -	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> > -	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> > -	      FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> > -	writel_relaxed(val, pcie->base + PCIE_EQ_PRESET_01_REG);
> > -
> > -	val = PCIE_K_PHYPARAM_QUERY | PCIE_K_QUERY_TIMEOUT |
> > -	      FIELD_PREP(PCIE_K_PRESET_TO_USE_16G, 0x80) |
> > -	      FIELD_PREP(PCIE_K_PRESET_TO_USE, 0x2) |
> > -	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
> > -	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
> > -
> >  	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
> >  	if (err) {
> >  		dev_err(dev, "failed to prepare clock\n");
> > @@ -1043,14 +1080,47 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> >  	}
> >  
> >  	/*
> > -	 * Airoha EN7581 performs PCIe reset via clk callbacks since it has a
> > -	 * hw issue with PCIE_PE_RSTB signal. Add wait for the time needed to
> > -	 * complete the PCIe reset.
> > +	 * Old Airoha EN7581 clock driver performed PCIe reset via
> > +	 * clk callbacks since it has a hw issue with PCIE_PE_RSTB signal.
> > +	 * This is now handled by dedicated PERSTOUT resets with clk
> > +	 * driver only enabling the refclk.
> 
> This reference to the "old Airoha EN7581 clock driver" makes me think
> there's a dependency between a EN7581 clock driver change and this
> PERSTOUT change.  If so, please mention the commit SHA1 for the EN7581
> clock driver change so they're connected and people backporting to
> older kernels know to be careful to get both of them.
> 
> It sounds like this PERSTOUT change might be independent of the x2
> configuration support.  If so, it should be done in a separate patch.
>

Hi,

thanks for the review. The clock change can go on a separate patch but
since the hash will change when it will get merged what should I use as
reference? Also any hint on the tag to use or the format?

Or just describe this in the commit description following the usual
hash + commit title format?
 
> > +	 * Wait is still needed for refclk to stabilize
> >  	 */
> >  	msleep(PCIE_T_PVPERL_MS);
> >  
> > +	/* Configure all the lines to the same EQ config */
> > +	for (i = 0; i < num_lanes; i++) {
> > +		void __iomem *base = pcie->base;
> > +
> > +		if (i == 1)
> > +			base = pcie->sec_base;
> > +
> > +		val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> > +			FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> > +			FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> > +			FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> > +		writel_relaxed(val, base + PCIE_EQ_PRESET_01_REG);
> > +
> > +		val = PCIE_K_PHYPARAM_QUERY | PCIE_K_QUERY_TIMEOUT |
> > +			FIELD_PREP(PCIE_K_PRESET_TO_USE_16G, 0x80) |
> > +			FIELD_PREP(PCIE_K_PRESET_TO_USE, 0x2) |
> > +			FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
> > +		writel_relaxed(val, base + PCIE_PIPE4_PIE8_REG);
> > +	}
> > +
> > +	/* Deassert PERSTOUT for all relevant lines */
> > +	err = reset_control_bulk_deassert(MAX_NUM_PERSTOUT_RESETS,
> > +					  pcie->perstout_resets);
> > +	if (err) {
> > +		dev_err(dev, "failed to deassert PERSTOUTs\n");
> > +		goto err_perstout_deassert;
> > +	}
> > +
> >  	return 0;
> >  
> > +err_perstout_deassert:
> > +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> >  err_clk_prepare_enable:
> >  	pm_runtime_put_sync(dev);
> >  	pm_runtime_disable(dev);
> > @@ -1136,6 +1206,8 @@ static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
> >  
> >  	phy_power_off(pcie->phy);
> >  	phy_exit(pcie->phy);
> > +	reset_control_bulk_assert(MAX_NUM_PERSTOUT_RESETS,
> > +				  pcie->perstout_resets);
> >  	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> >  				  pcie->phy_resets);
> >  }
> > -- 
> > 2.53.0
> > 

-- 
	Ansuel
