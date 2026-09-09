Received: from mail-m3292.qiye.163.com (mail-m3292.qiye.163.com [220.197.32.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FEF175A74;
	Wed,  9 Sep 2026 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916458; cv=none; b=Mk8HLhXkrZ0gWmmCad8S05aa97qXfubcHea2rXORZfCX8dNk54KAeRcm+f+uyJsXZgIVIh1IiV0bfJl5pXxg8+p51eh26iYZB1StRlC/SDrxDQiwwmj/uuQeB2p4aBobZiCLVT6eKitIycdDX6ZhqqrkHV0d4q1Ab2w5g9E/xiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916458; c=relaxed/simple;
	bh=9RQ1tMhIgnwhEwwl64SwkkxCu8uE334f+T7vhReNGjI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sEtkJpQjaDMyyUin1ugIYP9NNmG3/85ca+nMNcdTfRRzsEo2WCxHLaOynDdaqZSi1R5ttBDnLmdJOLYv6Rw0S7Aoa5znbkcMCl8FJEs1EKuh/8pOflBEw/nufWYpIz0Pv8yA+LZ7swJsKeBcRqBqKOuKhXIh2rL7Kk85sUBsKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=D5qtsHD+; arc=none smtp.client-ip=220.197.32.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="D5qtsHD+"
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d0923156;
	Wed, 9 Sep 2026 08:58:50 +0800 (GMT+08:00)
Message-ID: <30d56a27-febb-48e8-909e-b87cad782514@rock-chips.com>
Date: Wed, 9 Sep 2026 08:58:50 +0800
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
Subject: Re: [PATCH v6 06/10] PCI: dw-rockchip: Add helper function for DDL
 indicator
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
 <20260908-rockchip-pcie-system-suspend-v6-6-fbabcca9921b@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-6-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa083acbac003a4kunmccc4e748440649
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGU1ITFYeGU8YGUkYSR
	0YTEtWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=D5qtsHD+yE9+RhcFUcRNxx9x9OPX0uCGrqLL6K0SPt3qcRxRp/MwneUjdBzakPLQiOqngJQCdQpKLR6zjnHM3bhTLjOHvN8HBQ6ccJ9liFJHTcN3yHA0GeMi2+T5/dKzs0qx3ubQTfQaRd2braoFZ5BnxWJ3vGXHWxkSuHnMBMU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=oy6H8lueAeqMs8djnjAqPYI7ZqjdcUMC2b/zRPRWG8k=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/08 星期二 22:51, Sebastian Reichel 写道:
> Remove code duplication and improve readability by introducing a new
> function to setup the DLL indicator.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 211776bbcb99..1e48099e36e4 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -713,6 +713,16 @@ static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rockchip, u3
>   	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLIENT_GENERAL_CON);
>   }
>   
> +static void rockchip_pcie_unmask_dll_indicator(struct rockchip_pcie *rockchip)
> +{
> +	u32 val;
> +
> +	/* unmask DLL up/down indicator and hot reset/link-down reset */
> +	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
> +	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +}
> +
>   static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>   				      struct rockchip_pcie *rockchip)
>   {
> @@ -760,7 +770,6 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
>   {
>   	struct device *dev = &pdev->dev;
>   	int irq, ret;
> -	u32 val;
>   
>   	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_EP))
>   		return -ENODEV;
> @@ -800,10 +809,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
>   
>   	pci_epc_init_notify(rockchip->pci.ep.epc);
>   
> -	/* unmask DLL up/down indicator and hot reset/link-down reset */
> -	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
> -	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +	rockchip_pcie_unmask_dll_indicator(rockchip);
>   
>   	return ret;
>   }
> 

