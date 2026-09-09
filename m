Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com [101.71.155.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9077C1D4606;
	Wed,  9 Sep 2026 02:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919954; cv=none; b=FajIq414nHd1LMCrvl6DOb2YLZ1h5yWYBgZmvp1EVfhKguHmoA0HUs6D7xT8Ag9oDH3Hg8/3uKzBF6Tw3YtJpGYGd47MmJcyFMJLX6HqWQ0XkrXdalqOZrRQL6y64ANgdtCFuGkOR2A6Nmm//M6coV/LvDzGRBwwW1QW06ZSM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919954; c=relaxed/simple;
	bh=s4Er3CcgxMh8NZ3RtDzUBec2wo9/lN8HlEU7UoDE2LE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oO60bKQmobasYy/5pmSMtfob7ZY+3dmwlTi3CgqH3W1O332pboSIWxjaeZ36iHnDOQIuv+IaZzzpfheITAIx+SM1g39izsMitCRO+TRpz05F0YFSylpL97sIyvedisBwiocMQViiyNhIiqYaHKTn/tG6YoTnn7HTT8iu/za2qjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=M85xuT2J; arc=none smtp.client-ip=101.71.155.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="M85xuT2J"
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d0922f42;
	Wed, 9 Sep 2026 08:56:45 +0800 (GMT+08:00)
Message-ID: <f26552c9-0950-4206-8d39-b615e3737651@rock-chips.com>
Date: Wed, 9 Sep 2026 08:56:44 +0800
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
Subject: Re: [PATCH v6 04/10] PCI: dw-rockchip: Add helper function for
 enhanced LTSSM control mode
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
 <20260908-rockchip-pcie-system-suspend-v6-4-fbabcca9921b@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-4-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa083aad1c203a4kunm88587246440179
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGkhJGlYfHh4aTk9KHR
	pJQk1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=M85xuT2JXX3DURsJ++iD9e9zee9YmU6/UQ/FVBMxz6V/w1u5rksNrh9mykBTETEjSIMOoPHrMaRbvXqsDmjzKzaYQeIXyCT9Nv/6OvTBPVkWib9HHNbW/eRMhpG//5nsZt2obyb/gGPfRX8AFyEG4JdqlOqZIV+QCTDB/TdGEBc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=7MYZRtAVw85vCznj5/QFIWvq8+/sZ52tn4n6V859Sc4=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/08 星期二 22:51, Sebastian Reichel 写道:
> Remove code duplication and improve readability by introducing a new
> function to setup the enhanced LTSSM mode.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 7472ec78b473..6f84b07406d4 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -696,6 +696,18 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>   	return IRQ_HANDLED;
>   }
>   
> +static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rockchip_pcie *rockchip,
> +							     u32 flags)
> +{
> +	u32 val;
> +
> +	/* Enable the enhanced control mode of signal app_ltssm_enable */
> +	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
> +	if (flags)
> +		val |= FIELD_PREP_WM16(flags, 1);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +}
> +
>   static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>   				      struct rockchip_pcie *rockchip)
>   {
> @@ -719,9 +731,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>   		return ret;
>   	}
>   
> -	/* LTSSM enable control mode */
> -	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
>   
>   	rockchip_pcie_writel_apb(rockchip,
>   				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
> @@ -765,13 +775,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
>   		return ret;
>   	}
>   
> -	/*
> -	 * LTSSM enable control mode, and automatically delay link training on
> -	 * hot reset/link-down reset.
> -	 */
> -	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1) |
> -	      FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_EN, 1);
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, PCIE_LTSSM_APP_DLY2_EN);
>   
>   	rockchip_pcie_writel_apb(rockchip,
>   				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),
> 

