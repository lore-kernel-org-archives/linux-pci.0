Received: from mail-m32117.qiye.163.com (mail-m32117.qiye.163.com [220.197.32.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B232EEE8A;
	Wed,  9 Sep 2026 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918823; cv=none; b=lj7SuUxY7zU+upqn/hFxx/2M2+VcOZmoH4qb4w+VXamd0nL7YHLUpX7F6mbCjVFI9k6O1UCMfivVrgpwDglXgJeuoA7eVXuFfgc6iK7ut3Pq7rXTJxF0NMJn2qvqdrfZdYKzCMdkOQAeUV4UF30YmVwAWmqji+gKt5poBDAlvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918823; c=relaxed/simple;
	bh=YNj41kJdPIDjrhAA9TUzl7JGUCt8RSJCbYae1Noq0Vk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HFvEdmtyD/tAa7hF+ak2fjDgmu9zPTFIdyEqPwH49FQE5/T1d+PojTLgfqUNN7w1X1AAm6i9wuGPv62G6nsJrqzLgSrlkLB8DxgsN3nrsf9MzErpdJJEEY34t0gjExJNw1+Mm4I6f80OPtOucpJY4EQQAV9Mv6Kqvyn5gqx0AmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FGKdjvlA; arc=none smtp.client-ip=220.197.32.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FGKdjvlA"
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d089fcf7;
	Wed, 9 Sep 2026 08:37:53 +0800 (GMT+08:00)
Message-ID: <d2f5d998-5d1d-4246-8b01-01382f3cffd2@rock-chips.com>
Date: Wed, 9 Sep 2026 08:37:50 +0800
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
Subject: Re: [PATCH v6 01/10] PCI: dw-rockchip: Fix LTSSM set functions
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
 <20260908-rockchip-pcie-system-suspend-v6-1-fbabcca9921b@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-1-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa083998c7203a4kunm31a3c89943d92d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ0wZQlZIHUwaTxhDSx
	lIGRpWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FGKdjvlACFPFgsNMYwEWJ6Y0jyF+FQ1TkoCbAKv3eLPEGrvVpZi4emplWQEmmUl4oVm0DEYa7F1Ptp4wfYpeE1As8d3px66nQfcCioYZ60nHwL1YzhCRzCyUwvRJPcB1fLuUMjKckLwFRZt4El6BGu7ZvmUnpVxjQy3tgZ7FMa4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jQ3ATaI2YxqRI0p16u8NNlyCH2fphaDSpOTesBL5qj4=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/08 星期二 22:51, Sebastian Reichel 写道:
> Before the Rockchip PCIe driver has been switched over to the
> FIELD_PREP_WM16 macro, PCIE_CLIENT_ENABLE_LTSSM and
> PCIE_CLIENT_DISABLE_LTSSM were setting bits with a mask of 0xc = 0b1100,
> which means BIT 2 and BIT 3. After the conversion it only sets bit 2,
> with bit 3 being handled by a separate define named
> PCIE_CLIENT_LD_RQ_RST_GRT. Apparently the conversion missed to make use
> of this new macros resulting in the third bit not being set.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Fixes: 30e919570581 ("PCI: dw-rockchip: Switch to FIELD_PREP_WM16 macro")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index af26a07c0c9e..dc85564e5001 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -321,14 +321,16 @@ static void rockchip_pcie_ltssm_trace(struct rockchip_pcie *rockchip,
>   
>   static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
>   {
> -	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> -				 PCIE_CLIENT_GENERAL_CON);
> +	u32 val = PCIE_CLIENT_ENABLE_LTSSM | PCIE_CLIENT_LD_RQ_RST_GRT;
> +
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_GENERAL_CON);
>   }
>   
>   static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
>   {
> -	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DISABLE_LTSSM,
> -				 PCIE_CLIENT_GENERAL_CON);
> +	u32 val = PCIE_CLIENT_DISABLE_LTSSM | PCIE_CLIENT_LD_RQ_RST_GRT;
> +
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_GENERAL_CON);
>   }
>   
>   static bool rockchip_pcie_link_up(struct dw_pcie *pci)
> 

