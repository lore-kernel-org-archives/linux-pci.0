Received: from mail-m49251.qiye.163.com (mail-m49251.qiye.163.com [45.254.49.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF14425B30D;
	Wed,  9 Sep 2026 01:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917220; cv=none; b=pBXB5i1qS8iTO99ZmXmEiXkF1aQVSrevZg0w3Xz4HVOKOrKLWRqU10/Se2EGWUPoR5A+J4SKigIo5CwphtMT4OD+oV5/ohkkCNSOwyKa3aoimYQpO8+VPR61SIGfCPlDCa/nBgBQV7cGniTJ/w3ZcEVS50UGfRhivYyb0GSk4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917220; c=relaxed/simple;
	bh=F0o1t7QejIGtYvECNGik6alfh5KLG+fJzOTKEWZTuPc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ivzi3hY/Xze6oKNn81K8RS9S+6yvH6n/gXsoCv/LfKJJUUU4/SArsw2Wz+7IYandXU3SiCxHi4w9zUptg08K47tLDsjPV+vxE4XEdP/xgJfWaCCGFDKdUBu0nmytkM80pkORK6bIkTJVuOYc2aI65CoSsaaGL5ddnF5VG6o+EUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ASB17gow; arc=none smtp.client-ip=45.254.49.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ASB17gow"
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d09a7d19;
	Wed, 9 Sep 2026 09:11:28 +0800 (GMT+08:00)
Message-ID: <1255b90b-1388-4ca4-a869-75db37100a2d@rock-chips.com>
Date: Wed, 9 Sep 2026 09:11:27 +0800
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
Subject: Re: [PATCH v6 08/10] PCI: dw-rockchip: Set broken L1SS resume flag
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
 <20260908-rockchip-pcie-system-suspend-v6-8-fbabcca9921b@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-8-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa083b84b0203a4kunm0f25797c442935
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUgeH1YfGhhOGkkZTx
	0YSBlWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ASB17gow20NLkS56QPasneUGrbAw71hZaG2hR4uSIADguVNkQym4V5wJ7fVuZH2HvxZKRkqicThjzBM2JW+i4SGaKA0ye4mUUWp1pIRh0eWD5mhzO454Vco7GwOlBG5khWE2m/NXWgdsftFaxXEsqwhsZGZf3iEHBAEd3NEQiGs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=UbpeY8A/bkmtJlJ/cwp8vEYR3E9oMYSezTRlhuo4liw=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/08 星期二 22:51, Sebastian Reichel 写道:
> Setup the broken_l1ss_resume flag, so that pci_suspend_retains_context()
> returns false on the Rockchip platform allowing PCIe peripheral device
> drivers to act upon.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 17530507e41b..47d9cab909bc 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -458,6 +458,21 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>   	return 0;
>   }
>   
> +static void rockchip_pcie_host_post_init(struct dw_pcie_rp *pp)
> +{
> +	/*
> +	 * During system suspend, the Rockchip RC driver effectively powers off
> +	 * the controller. If the link is in L1SS and the endpoint asserts
> +	 * CLKREQ# to exit L1SS, the time required to wake the system and
> +	 * restore the PHY/REFCLK may exceed the L1SS exit timing
> +	 * (L10_REFCLK_ON + T_COMMONMODE), resulting in Link Down (LDn) and a
> +	 * reset of the endpoint. Set this flag to indicate this limitation to
> +	 * client drivers so that they can avoid relying on device state being
> +	 * preserved during system suspend.
> +	 */

Yes, this is ture for Rockchip platforms that powering off the
controller as well as PHY is a default action during system suspend.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> +	pp->bridge->broken_l1ss_resume = true;
> +}
> +
>   static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -497,6 +512,7 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>   
>   static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
>   	.init = rockchip_pcie_host_init,
> +	.post_init = rockchip_pcie_host_post_init,
>   	.pme_turn_off = rockchip_pcie_pme_turn_off,
>   };
>   
> 

