Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.82.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792981598;
	b=OpspNjQlS/9gXtl6qiQXcYRgRL5T21jCUD8A8t+G/UtAhsgZNYbTOTtCYPLnbzayEnbp
	 Sx0K16cv2eSkYvRfrK96uQJskuuSuDOCS4r/x9JJiG33GKqnsXFmuCum44lRJpK/E5vEU
	 YMd+VYv5XfLrMygN/t8u4UTI0pBJhtiQuPKnb/jMRtuwvbKl9awVYaoT5J4C8VAyoOZ7m
	 ky+YELeoI6pqupPHPJImshAoVTG7OWgiQKK2fb2aj8+WS20ceqDS6ZOiYsQHiLNWd9N02
	 D5hMPNkqYWy43nQl3PI6J2mNHwj00ucQSoiyOJhoBoY5mXyB2yFMV1QKzjBR2kMf8Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792981598;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=urfEyyHn5kTPStI4ZHijB5qvt2eSMg21ywUW0EWxMho=;
	b=G7SRGij1/6E50LJZnTFIXP/Jr4c4/ijceC5Z9zVtAoxRTuf7teZW4754vo66E90H2fJQ
	 JhfRxPEQa88I9n9a9k/JuQL/aCyNw5naKGMOy1tGsByl1bobEWJVPs5BwucMr3edVFvkP
	 CteXci32etVxPSDScIFFBf//kXf/XzSiih00OGGLjCf05eXy8hXAfE/do3hZO19wOwxrv
	 JZEVT9AZ3HUScDaP+pOBdggRMDsIOUdoWbyey0tz3WvYF+jsNHtTwdhraJ0in79lKSqPO
	 VufQ7AUhiZcG8FX0Ai2sYJ8YqWN3ggltV+qzGASCZztc8NBNGqPLVCrjrU9Osx3KORA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=JcYUNmGU;
	arc=none smtp.remote-ip=156.224.82.230
Received: from mail-m82230.xmail.ntesmail.com (mail-m82230.xmail.ntesmail.com [156.224.82.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F4606A31A;
	Mon, 26 Oct 2026 02:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 338F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=JcYUNmGU
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 524c7990e;
	Mon, 26 Oct 2026 10:26:27 +0800 (GMT+08:00)
Message-ID: <78564cbc-8faa-4392-ab66-2a1395fdca4e@rock-chips.com>
Date: Mon, 26 Oct 2026 10:26:26 +0800
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
Cc: shawn.lin@rock-chips.com, Rob Herring <robh@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Remove redundant dev_err()
To: Diederik de Haas <diederik@cknow-tech.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>
References: <20261021101533.609118-1-diederik@cknow-tech.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261021101533.609118-1-diederik@cknow-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17607d42803a4kunm445aa2303d8aee
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUhCS1YaQh9PHk5LQh
	0YHxlWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JcYUNmGUGamMX0H4edPTX5buUkXYPXtzWNZJzuHFd2cO8Zvt2/2GQlk2tcILYDNXTCofCO2xjK3aRQhgmlyWPSA+CVjG9pvEvwbP3R0qUDmNF7iOLfUaaigRZOrSbL2fVRjdZ4PAwHFI6XI/ULrph+sqGPCExHf1KWV2SXip0NM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=urfEyyHn5kTPStI4ZHijB5qvt2eSMg21ywUW0EWxMho=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/21 星期三 18:14, Diederik de Haas 写道:
> The devm_request_threaded_irq() function already automatically logs
> detailed error messages on failure since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
> So remove the now-redundant driver-specific dev_err() calls.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks.

> Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 14976861f8ef..a4dbfc52c2f1 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -718,10 +718,8 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>   	ret = devm_request_threaded_irq(dev, irq, NULL,
>   					rockchip_pcie_rc_sys_irq_thread,
>   					IRQF_ONESHOT, "pcie-sys-rc", rockchip);
> -	if (ret) {
> -		dev_err(dev, "failed to request PCIe sys IRQ\n");
> +	if (ret)
>   		return ret;
> -	}
>   
>   	/* LTSSM enable control mode */
>   	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
> @@ -764,10 +762,8 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
>   	ret = devm_request_threaded_irq(dev, irq, NULL,
>   					rockchip_pcie_ep_sys_irq_thread,
>   					IRQF_ONESHOT, "pcie-sys-ep", rockchip);
> -	if (ret) {
> -		dev_err(dev, "failed to request PCIe sys IRQ\n");
> +	if (ret)
>   		return ret;
> -	}
>   
>   	/*
>   	 * LTSSM enable control mode, and automatically delay link training on

