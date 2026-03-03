Received: from mail-m3296.qiye.163.com (mail-m3296.qiye.163.com [220.197.32.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14D199385;
	Tue,  3 Mar 2026 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772499680; cv=none; b=UOC8tj/uhpCpeNuW3UCVR4SQdB3kbd0a7BbFoEwWWba4aSXU598J46pUdNOy1YAXVSmz4UD/i0NuyAf6oMGurwBaKK1LcMU+5Xf6tEs0aC47iobkkggUDlmQtOj3xJzfzIpopk3C9mCK3IoPtjgRAip8cRrGLlEob06yotEZ7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772499680; c=relaxed/simple;
	bh=YlFxWE2cpADN+FWG/CYk4BPUDtSzJ8mEMkH9lcfd2Lc=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BYmebBqD6lV9VTaMqFQPH1fZ7lYb5hwvCFy28625cc5D4mIsZ45hBUyQ51X2jivEaT7KmyyOtowaMT8KllsxytcSViXcOou6cq1BnO9c+99zCd9M+jVIKRYz9x0iAoUfKOQ3gGgpn0gUJ4tyMQMmDRljJlfuwHyNefBAtdBbDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=EJ2lQYLn; arc=none smtp.client-ip=220.197.32.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="EJ2lQYLn"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3581f17ca;
	Tue, 3 Mar 2026 09:01:06 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, Grimmauld <grimmauld@grimmauld.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Anand Moon <linux.amoon@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <560f75f3-e82c-4825-554d-5ead1ae353ee@rock-chips.com>
Date: Tue, 3 Mar 2026 09:01:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260226101032.1042-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cb136851009cckunmdf53aed31047c16
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5OGVZJQkgeThgfSR0eQh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EJ2lQYLnZonrbwDR82koQeFF/FTrJdyirHy0znOoWno2PaizrLLmn9wiRPAorVoGNm5aMOGr51u90sWqjI18XzoPbg0uPGF/OQs5cXl1vmH5IMww5arnP+YNG7hzp0Lhr6/hR6egU1kwA2q1TjO6vH1WwFenyNGHI1NOLoA9EPw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Mjquj/FOs/2Zx2idcFz2Tunmyq43QxK3eJDgddxDoi8=;
	h=date:mime-version:subject:message-id:from;

在 2026/02/26 星期四 18:10, Anand Moon 写道:
> Rockchip DWC PCIe driver currently performs synchronous link training for
> combo PHYs (PCIe 3.0/2.0 and SATA 3.0) during boot. This process waits for
> the link to be fully established, adding several milliseconds to the boot
> sequence. To optimize boot time, this change enables asynchronous probing,
> allowing link establishment to proceed in the background while the kernel
> continues probing other devices.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Cc: Grimmauld <grimmauld@grimmauld.de>
> Cc: Niklas Cassel <cassel@kernel.org>
> Tested-by: Grimmauld <grimmauld@grimmauld.de>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v3: update the commit message to describe the changs.
>      added tested by Grimmauld.
>      https://lore.kernel.org/all/20240809073610.2517-1-linux.amoon@gmail.com/
> v2: update the commit message to describe the changs.
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 5b17da63151d5..c31e0e9848327 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -746,6 +746,7 @@ static struct platform_driver rockchip_pcie_driver = {
>   		.name	= "rockchip-dw-pcie",
>   		.of_match_table = rockchip_pcie_of_match,
>   		.suppress_bind_attrs = true,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>   	},
>   	.probe = rockchip_pcie_probe,
>   };
> 
> base-commit: f4d0ec0aa20d49f09dc01d82894ce80d72de0560
> 
