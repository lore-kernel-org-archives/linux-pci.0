Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839892;
	b=Jhik0R5fu/oyB+AzFNEXoDdz4xhK5PfP5bgfOdf3f4EHyBhEj90w85iG9oxBnLXushkm
	 eL53IIjtmRlIVPdevojfG8hGAluk6xabZxoPSas/hCv5QYPHevN65jTwS72efsGyJ9rWW
	 Poplb2vsa4YUtftwd4ww3zW05hTJZjnPuv+lNJRPjkmEtkO13sWMLkyMjQwC7osOyyCCL
	 rjiK9/6DsD7qNXqpPZbTcR09a7HF9yIOKrBZVdwOe5Z85KyPESbGabyqFz9vBj2g+At0W
	 8JidFvUc+xqYYAk/dErLEKb7hGlVXWvTwIB5VA6diGMvxcXgpMMhaKd1m77efSjCgUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839892;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=+2E6dr27WqMqCaaLamwNn6gQm66M2Zv099gvqTnexrw=;
	b=RWXn1MV/PP8G7dq8zDxn3luIIMy5wEYdqQNgsI3O6ICTwgWSBmOEZ+AaIzkSvDtoAw+a
	 ARE+lsIDgj8bfCyWx752FHDum2M+OhpGKwXC8Ay8NB70DsXrGIUgT2qODwkzgQNODFGBO
	 NCYgFNfz0ksjz2hNm62C+gM1648PdEtkyuQjDlXOQec+2qYGsThwyJ08i7aHTBFkZO5iU
	 xFYaWcB5z16rPMpemI/EwdjY6EZ3R5K3QFuHUhhu0h3fRBf4PamwtJTIYeD7r1Q9+k32Q
	 /5wxnW9DJGcpnvEHw3ZmJ4iRuVIqtXE3ft53NhwaliPin3usB5xEuIcdkrEKdpipa6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b="ed/W9pMI";
	arc=none smtp.remote-ip=210.79.60.84
Received: from mail-m6084.netease.com (mail-m6084.netease.com [210.79.60.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E8606A31B;
	Thu,  5 Nov 2026 00:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 232E8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=ed/W9pMI
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53894dd57;
	Thu, 5 Nov 2026 08:51:18 +0800 (GMT+08:00)
Message-ID: <f047dcbe-efa2-4c60-8436-6d001c936467@rock-chips.com>
Date: Thu, 5 Nov 2026 08:51:14 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Alexey Charkov <alchark@flipper.net>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v8 7/9] PCI: dw-rockchip: Add pme_turn_off support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-7-0434b4f373bc@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-7-0434b4f373bc@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1a930507d03a4kunm7b7b2c6111ce48
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSBlJVkgaQkNKTR9MSR5CHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ed/W9pMIXtu5yRJRX83WEULDuzONtKh2KGDEcb97UklFlrvv5C3CMhCccjEFUhMlchyOLJAprM686mxfc7tWjHzWqBUhRRM8shTlsrCQnZUsxYIU1rtFwSDJojCUXPr6oPLLxEocusN0/jY3UmO7AmWWmEB0XONgEidRDNO+fjc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+2E6dr27WqMqCaaLamwNn6gQm66M2Zv099gvqTnexrw=;
	h=date:mime-version:subject:message-id:from;

在 2026/11/05 星期四 7:47, Sebastian Reichel 写道:
> Prepare Rockchip PCIe controller for system suspend support by
> adding the PME turn off operation.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 47 +++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 0e26abc50920..7933c50df340 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -47,6 +47,10 @@
>   #define  PCIE_CLIENT_ENABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 1)
>   #define  PCIE_CLIENT_DISABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 0)
>   
> +/* Interrupt Status Register for Received Messages */
> +#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
> +#define  PME_TO_ACK			BIT(9)
> +
>   /* Interrupt Status Register Related to Legacy Interrupt */
>   #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
>   
> @@ -71,6 +75,11 @@
>   #define  PCIE_CLKREQ_READY		FIELD_PREP_WM16(BIT(0), 1)
>   #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
>   #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
> +#define  PME_READY_ENTER_L23		BIT(3)
> +
> +/* Message Request Register */
> +#define PCIE_CLIENT_MSG_GEN		0x34
> +#define  PME_TURN_OFF			FIELD_PREP_WM16(BIT(4), 1)
>   
>   /* RASDES TBA information */
>   #define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
> @@ -439,8 +448,46 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>   	return 0;
>   }
>   
> +static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	struct device *dev = rockchip->pci.dev;
> +	u32 status;
> +	int ret;
> +
> +	/* 1. Broadcast PME_Turn_Off Message, bit 4 self-clear once done */
> +	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN);
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN,
> +				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret) {
> +		dev_warn(dev, "Failed to send PME_Turn_Off\n");
> +		return;
> +	}
> +
> +	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STATUS_MSG_RX,
> +				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret) {
> +		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
> +		return;
> +	}
> +
> +	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
> +	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER_CON,
> +				 status, status & PME_READY_ENTER_L23,
> +				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret)
> +		dev_err(dev, "Failed to get ready to enter L23 message\n");
> +}


This is a question for the DWC core: should we change
dw_pcie_host_ops::pme_turn_off() to return a value instead of silently
ignoring a failure?

Looking at pcie-designware-host.c, we have:

if (pci->pp.ops->pme_turn_off) {
     pci->pp.ops->pme_turn_off(&pci->pp);
} else {
     ret = dw_pcie_pme_turn_off(pci);
     if (ret)
         return ret;
}

The handling feels asymmetric. If ->pme_turn_off fails, shouldn't we 
abort dw_pcie_suspend_noirq as well?

Other than that, this patch looks good to me in current shape,
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

We can further discuss the callback's return value issue on top.

> +
>   static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
>   	.init = rockchip_pcie_host_init,
> +	.pme_turn_off = rockchip_pcie_pme_turn_off,
>   };
>   
>   /*
> 

