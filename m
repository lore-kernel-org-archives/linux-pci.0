Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=154.81.10.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104617;
	b=ghqR7C4BUhJlNb89txTcB/27gZtUAVZqnUXaiXdgt1Zv8lybxS9sWMWj5WqaNvN6QcTE
	 hWQKnc8WtcjqzEB7yzrimlygwkYtyv1+UL+wtHxEF5wUqabsl+PDhgWs8d0XHdQF4RSa5
	 q1+DGDBAgEAfdItnYbjsblqi31j8UG81TgnpY26qs7k1evejSXDIdyer6KYos4UPzeLn0
	 ulQjZl6YIdkRF4Yedano4Z5T2oP6z8AzHsuJ+Y0fhCQ0FOM224tjysPl6y4iTtiME1YRM
	 G0clLWx1pzANo+laeittdLSP5W9m8SzO2yJb7PwOlI98zgwc4c9M03lEDbzhwyBYCBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104617;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=CiGmRdlkoViId5TfscHFKflRSN2mgmPjTQiT6qBmjg0=;
	b=v2x/U1iQc40N7GJeqlQMyjk3mrUf5bwAO4gaqKoLInJAUIPHU4s65bYovOUz1eNfxTQB
	 QrX6ogAH8LwCEQuGEfEgWFuWq+oZy6EhyDful4rHqLXqooFxVQ5e5HXjW3/Qwul8X0PVk
	 eMZIhwkzQthBNnMai48Ed7kAZ2L76x5yIN1Tt+9fGCq49cOKRNPDlgvts+6DqML63JUK3
	 Sii3H2RI87OxI2GcMYf733iHc1Go2OkaD4pfEg3SjbaQ+ndTB3pDfN2nZNjTaJ9vPLqD7
	 Cmo3LgBtfPFZ2id6o+iD8KZG4Bu06mIYwmO5tg7p+YzsEd9QpURx3Vy9qRE089astGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=JcY10bMX;
	arc=none smtp.remote-ip=154.81.10.79
Received: from mail-m1079.netease.com (mail-m1079.netease.com [154.81.10.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A00606A31B;
	Tue, 27 Oct 2026 12:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0A00606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=JcY10bMX
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 528682039;
	Tue, 27 Oct 2026 20:36:42 +0800 (GMT+08:00)
Message-ID: <311338f7-ae03-47b9-96fe-1ec2b2851c7b@rock-chips.com>
Date: Tue, 27 Oct 2026 20:36:41 +0800
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
Cc: shawn.lin@rock-chips.com, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/16] PCI: dwc: rockchip: Use cached PCIe capability
 offset
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 jingoohan1@gmail.com
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-7-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261027122827.2725643-7-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17d5ce66c03a4kunm8cbf4897570f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGktJVk9ISU0eTR5CHUIeHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JcY10bMX5VWFSTKD/G7A+Y8NZJqvgD8AMt+1D9jMkiqr+9Jj2ehRz18pkYtHT8ZunL5eUiWUhHwAdDix7KG3Iz5rowwLyFwISqEK7Ufpz8TkQo2jzcOTYLFdc41EbsaxeluNB0tsf/s/ByM6UAVG153ph24+T3bO3XlJYxZOroY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=CiGmRdlkoViId5TfscHFKflRSN2mgmPjTQiT6qBmjg0=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/27 星期二 20:28, Hans Zhang 写道:
> rockchip_pcie_enable_l0s() is called from rockchip_pcie_host_init(),
> i.e. from the .init callback, which runs after the controller clocks and
> resets have been enabled. Replace the capability search with
> dw_pcie_get_pcie_cap(), which reads and caches the offset at this very
> point.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index af26a07c0c9e..753606193855 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -373,7 +373,7 @@ static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>   	u32 cap, lnkcap;
>   
>   	/* Enable L0S capability for all SoCs */
> -	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	cap = dw_pcie_get_pcie_cap(pci);
>   	if (cap) {
>   		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
>   		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;

