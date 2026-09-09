Received: from mail-m32104.qiye.163.com (mail-m32104.qiye.163.com [220.197.32.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AF42BE639;
	Wed,  9 Sep 2026 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916415; cv=none; b=KaYGFbFwIZAcU/37a/5Wu+aPPX3F1VZyUXKiesDMvXDnkp/OJ7TbJKtyHY5YZak37wiN8VMbFG3ma3epgm6jd2TCh7d2NgSQ0ryFmfCygey3/CAELzcheEFIsRZWyqaXPL/KRPghqM5zACvBd+GxKiJHJ0OHVnXhIUowTXyant0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916415; c=relaxed/simple;
	bh=i8EsaTbGQ9BCSgEZrwzQiYR9ShSuPzYQznKQ2zTPRGA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iP3EjgS/le3BDvYazk5GMJ+WTay685rq4ei8n70LVGrakIP41MpFYzsBZEm6Va2Zc9Ow/UXlqeV0fLZ8CG7smD3G+wf45FtsZwAIXwLR1pM5Tb+udknR6tVhmoGTL0LOO7986yzi4NdWK6jc2o9esE/r5DI8bR2jako7IVapKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XP6iTy/d; arc=none smtp.client-ip=220.197.32.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XP6iTy/d"
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d0923065;
	Wed, 9 Sep 2026 08:58:02 +0800 (GMT+08:00)
Message-ID: <d3a665e6-e9f6-41c7-9684-9db1cb811039@rock-chips.com>
Date: Wed, 9 Sep 2026 08:58:01 +0800
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
Subject: Re: [PATCH v6 05/10] PCI: dw-rockchip: Add helper function for
 controller mode
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
 <20260908-rockchip-pcie-system-suspend-v6-5-fbabcca9921b@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-5-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa083abfd6103a4kunm2a53221b44044d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUsaQ1ZOHkkaHRpKTx
	lDTUpWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XP6iTy/dSQmg7/bZJLR97rvOuhsfxw6x8i0uhjmb2gdTTOdgfWlxIeApYFv0KpIJqWYYHez9/FNcaTS292GFeo4cwZc6yAYNx07JiqMAmK/Yat8cqoPIhoBX7W+sDWd7FW/mrLb31KcbQoQJJiWxyLlSQl/jTlGJoGRG/PQJK8g=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=bsT5whRXIWPhoZ883AZa0XgzOkBvLWYJ556g8quXo00=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/08 星期二 22:51, Sebastian Reichel 写道:
> Remove code duplication and improve readability by introducing a new
> function to setup the controller mode.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 6f84b07406d4..211776bbcb99 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -708,6 +708,11 @@ static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rockchip_pci
>   	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
>   }
>   
> +static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rockchip, u32 mode)
> +{
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLIENT_GENERAL_CON);
> +}
> +
>   static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>   				      struct rockchip_pcie *rockchip)
>   {
> @@ -732,10 +737,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>   	}
>   
>   	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
> -
> -	rockchip_pcie_writel_apb(rockchip,
> -				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
> -				 PCIE_CLIENT_GENERAL_CON);
> +	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
>   
>   	pp = &rockchip->pci.pp;
>   	pp->ops = &rockchip_pcie_host_ops;
> @@ -776,10 +778,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
>   	}
>   
>   	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, PCIE_LTSSM_APP_DLY2_EN);
> -
> -	rockchip_pcie_writel_apb(rockchip,
> -				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),
> -				 PCIE_CLIENT_GENERAL_CON);
> +	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_EP);
>   
>   	rockchip->pci.ep.ops = &rockchip_pcie_ep_ops;
>   	rockchip->pci.ep.page_size = SZ_64K;
> 

