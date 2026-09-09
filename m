Received: from mail-m16023652195.xmail.ntesmail.com (mail-m16023652195.xmail.ntesmail.com [160.236.52.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ADA492E5D;
	Wed,  9 Sep 2026 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.236.52.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914702; cv=none; b=KOCbSPzNNH4wYOdBJ3ChbWBIBsH0wxnbJdYWvUxVBX+8osd9a2cpUPsyx73RRYZj6xbq5Ia66EbFgoL9nY0grA8kFYO9AxlD3bI7GP+4e+UISFEqO0pLRVoZp1WqrsMKeWhPXnv8yGQn9hLdZGBrmb2LxqVyfa64NKf2IwgN2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914702; c=relaxed/simple;
	bh=sH4FKnF2NxYQnc2Zi/kCH5M1QzxGotg9J4RDP9ViLaE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QPEFasuRrb1CaN8DKrWmWhjsbSgiolquel4eKRTaHF9MjuZ3paDYhwVd63lUifcRCTxsFEsfGnptbHjZV+tIUZycGRBwPy8NLN/YH+MFohO9rxmlVS3D05dMh39+/HfyIPJ8cp1eO966FQLAj3TmZMvcjDwepA40/jRGX+La+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=e9NTEEIW; arc=none smtp.client-ip=160.236.52.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="e9NTEEIW"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d08c1d9d;
	Wed, 9 Sep 2026 08:44:48 +0800 (GMT+08:00)
Message-ID: <4d441232-6ab5-4865-a70c-f868e8128f7e@rock-chips.com>
Date: Wed, 9 Sep 2026 08:44:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Alexey Charkov <alchark@flipper.net>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v6 02/10] PCI: dw-rockchip: Restore vpcie3v3 regulator
 handle
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-2-fbabcca9921b@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-2-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0839fe00403a4kunm50f3116743e785
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0IdVk9MGkseSUJOQ01JTFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=e9NTEEIWqkh7Z68AwWcaKw2n1Tx+hNYucPDaLw/joe2dmc0eusuvJC9uTUS6/osiyrEz/1iXmbi+GcbCQzY84/xyRH5OnH7Tt91mMMAwTo4iuryxRApYrm6MvmZOQZqAOV2qJg2ROIsA16acFLY3yXJ/KzvONULKiDLcOGWCgEw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=8BHp18JK7JZ2Mrw0ZrUESo0RJu+yED+tqkK5PcwM6KM=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/08 星期二 22:51, Sebastian Reichel 写道:
> This reverts commit c930b10f17c0 ("PCI: dw-rockchip: Simplify regulator
> setup with devm_regulator_get_enable_optional()"), which nicely cleaned
> up the code.
> 
> The vpcie3v3 regulator handle is needed to disable the regulator during
> system suspend (to be added in its own patch).
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index dc85564e5001..f67ad3c31c35 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -112,6 +112,7 @@ struct rockchip_pcie {
>   	unsigned int clk_cnt;
>   	struct reset_control *rst;
>   	struct gpio_desc *rst_gpio;
> +	struct regulator *vpcie3v3;
>   	struct irq_domain *irq_domain;
>   	const struct rockchip_pcie_of_data *data;
>   	bool supports_clkreq;
> @@ -844,15 +845,22 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	/* DON'T MOVE ME: must be enable before PHY init */
> -	ret = devm_regulator_get_enable_optional(dev, "vpcie3v3");
> -	if (ret < 0 && ret != -ENODEV)
> -		return dev_err_probe(dev, ret,
> -				     "failed to enable vpcie3v3 regulator\n");
> +	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> +	if (IS_ERR(rockchip->vpcie3v3)) {
> +		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
> +					"failed to get vpcie3v3 regulator\n");
> +		rockchip->vpcie3v3 = NULL;
> +	} else {
> +		ret = regulator_enable(rockchip->vpcie3v3);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to enable vpcie3v3 regulator\n");
> +	}
>   
>   	ret = rockchip_pcie_phy_init(rockchip);
>   	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "failed to initialize the phy\n");
> +		goto disable_regulator;
>   
>   	ret = reset_control_deassert(rockchip->rst);
>   	if (ret)
> @@ -885,6 +893,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>   deinit_phy:
>   	rockchip_pcie_phy_deinit(rockchip);
> +disable_regulator:
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
>   
>   	return ret;
>   }
> 

