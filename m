Received: from mail-m1973182.qiye.163.com (mail-m1973182.qiye.163.com [220.197.31.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842D221FB6;
	Wed,  9 Sep 2026 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931850; cv=none; b=rm3lOBDeME09uC5kEUJgfioKsgsZKkKb91/Z9tId2vGQSYjOtsNJq3rBgBweTl73Il4NtBpC9g0mTHXTp/oO2bCtJjR8k4Yd8it2JXNS70OSUO/HkUujWWNuA4dSsdZzBKAvyieOdPUwxMU55Thrdhj3G0fUNZfqHOtrd6Ix5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931850; c=relaxed/simple;
	bh=ZDKPCQF1yDXjigJnwLfjlphuUE0kScTNgQsmqsuTs0Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dG8k+5Zi9akam0jVVupxbOIpgwgk4hQsSgJr7TXbjMSDnet05lxQrpgYdsvJm8gX+tolBhJwAHSE6nGMFTeSl53rdzZEk3ez2rdAJEoVldmDLn6usX8n3j5CUQoWmov7Wi2QxvEYM5++HZbHCoEHuk8f3FdMH6CcjE7ZNqEXfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KmXB2npb; arc=none smtp.client-ip=220.197.31.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KmXB2npb"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d0905848;
	Wed, 9 Sep 2026 08:54:29 +0800 (GMT+08:00)
Message-ID: <26006eef-56b3-4a81-8b4c-95ac241412cb@rock-chips.com>
Date: Wed, 9 Sep 2026 08:54:29 +0800
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
Subject: Re: [PATCH v6 03/10] PCI: dw-rockchip: Move devm_phy_get out of
 phy_init
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
 <20260908-rockchip-pcie-system-suspend-v6-3-fbabcca9921b@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-3-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa083a8bf7103a4kunm4244ed5d43fc53
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSh1MVkNJQk4dTBhCSE0eS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KmXB2npbkEt7CZvkKJcT5M6qDw2i7cCdkaVp4hQw6JqugrzoiXbkmlVDz1fpqHrq3/Lo0GHHseH/PffkVdv699JZxxH+IB2ye2sZz/Gt7NfojO4bRGNoof0/1zQqTd1okvCihaUf7Kr5vLnWxfyoprykKBpqbKY0Qj67vVCiSd8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=RPL25zB+175xW+b9ln85IKNsB2hgoRLnH6maFPW5Ixw=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/08 星期二 22:51, Sebastian Reichel 写道:
> By moving devm_phy_get() to the probe routine, rockchip_pcie_phy_init()
> can be used to re-initialize the PCIe PHY, which is for example needed
> after a system suspend/resume cycle.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index f67ad3c31c35..7472ec78b473 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -612,14 +612,8 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>   
>   static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
>   {
> -	struct device *dev = rockchip->pci.dev;
>   	int ret;
>   
> -	rockchip->phy = devm_phy_get(dev, "pcie-phy");
> -	if (IS_ERR(rockchip->phy))
> -		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
> -				     "missing PHY\n");
> -
>   	ret = phy_init(rockchip->phy);
>   	if (ret < 0)
>   		return ret;
> @@ -858,6 +852,13 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   					     "failed to enable vpcie3v3 regulator\n");
>   	}
>   
> +	rockchip->phy = devm_phy_get(dev, "pcie-phy");
> +	if (IS_ERR(rockchip->phy)) {
> +		ret = PTR_ERR(rockchip->phy);
> +		dev_err_probe(dev, ret, "missing PHY\n");
> +		goto disable_regulator;
> +	}
> +
>   	ret = rockchip_pcie_phy_init(rockchip);
>   	if (ret)
>   		goto disable_regulator;
> 

