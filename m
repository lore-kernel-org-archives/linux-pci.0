Received: from mail-m128220.netease.com (mail-m128220.netease.com [103.209.128.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4752D3733;
	Wed,  9 Sep 2026 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788916466; cv=none; b=MQVfKmALd7B09TbKZ/zZu7sxYzxFnBeMWwwCEkAkD3qrZ+nHMos4WonQfl2h/SgWludtwcbrm7lflvAEPcAJZI1tXd4F+pTTYkGQ/dzcxm+aIU++qORHg3puUwtXnumm3JwI7SraYtNb9tVt9MB/rQU6SV3x7mYCOofG2hkpbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788916466; c=relaxed/simple;
	bh=HFY4RcdV25JzeD/kn0dCtOrn6PDhkuLH5VAuMKTQMr4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aNjnrdQ8OSOpr+Nlx2DdZSphUvkyovygK7ptH+5G8X98eHCzWtY8mQxmEj8U05v/NbWf7OHkGSGsVRbMGg+Gw1B+9ghsvLKb4k/3qxaoiV74g4inFNfLdOIW6fMHMqXa4c9W0vBaJNiLjVWWgD8cgYFFjqhNgdSqyrX4OKoGrUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XLw0Z5Pj; arc=none smtp.client-ip=103.209.128.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XLw0Z5Pj"
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d09c3d85;
	Wed, 9 Sep 2026 09:14:13 +0800 (GMT+08:00)
Message-ID: <8c2dd6a7-d733-4d78-9b92-c7e4c7e6b7d8@rock-chips.com>
Date: Wed, 9 Sep 2026 09:14:12 +0800
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
Subject: Re: [PATCH v6 10/10] PCI: dw-rockchip: Clear debug buffer before
 entering L2
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
 <20260908-rockchip-pcie-system-suspend-v6-10-fbabcca9921b@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-10-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa083bacfc303a4kunm71968669442fc6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUNKH1ZMTx0aGkoZSE
	1OQklWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XLw0Z5PjC40FLlLjEeuPsxjJH3DNpHn6kqQucBi89rQtQ8GMBSnyGCS+lCxIbo2P2qivwbPYZlABvOGQrBf82i3IwcXCABKIgffePviEmryW6oO28rIG3M4VeRzHFsA3wxL/eBxr+z3nGQf3BWcNsbOPpN5p8bCy37YLmRlBboI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=nXrG2bOu/f4zoy6afuZMtxAka40yrLWjvBxcUj894m8=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/08 星期二 22:51, Sebastian Reichel 写道:
> Clear the debug buffer before entering the L2 state to ease debugging
> link training issues on resume.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index e675918ba184..a508f4fffd2a 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -77,6 +77,9 @@
>   #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
>   #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
>   
> +/* General Debug Register */
> +#define PCIE_CLIENT_GENERAL_DEBUG	0x104
> +
>   /* RASDES TBA information */
>   #define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
>   #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
> @@ -1043,6 +1046,11 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
>   	return ret;
>   }
>   
> +static inline void rockchip_pcie_link_status_clear(struct rockchip_pcie *rockchip)
> +{
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_DEBUG, 0x0);
> +}
> +
>   static int rockchip_pcie_suspend(struct device *dev)
>   {
>   	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> @@ -1056,6 +1064,11 @@ static int rockchip_pcie_suspend(struct device *dev)
>   
>   	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
>   
> +	/* All sub-devices are in D3hot by PCIe stack */
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	rockchip_pcie_link_status_clear(rockchip);
> +
>   	ret = dw_pcie_suspend_noirq(pci);
>   	if (ret)
>   		return ret;
> 

