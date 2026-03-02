Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63A36492D;
	Mon,  2 Mar 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467287; cv=none; b=X2xSv3Q5aYcZr2/FdgWHJ/hrP05gitqZl6SvD2srU0mqaXjw3N9vY3+h6izfYzsTKq9/3+Nqi/xRFOjTu4daM2p/TIf/kb5PS9kQjwsS/96KaaMFDZK0voOrE+84kxgmG9zfivO7elbTWP/t6AneOAmmf/ok+thihTCu011WQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467287; c=relaxed/simple;
	bh=v16XPKhbgVnwceWsCy31FX/WYbrRF1iDlIZT1537f9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NS9ObJeB5B96G73tZaaIpvWaTM9X7k+DHfZ2KiMguoMvQvyJerz65y8yB54EH7NzywMBgty6SrBACvEEP/Bdzf+k5deIILclf0zSFU7tbuMUnPo/UGa1XV2RdVaYhqMzrOFzUuZME+/IlorjQ61wlu8JxtI156SPszykGNKU7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ScKWJQaU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ScKWJQaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=RSQdPhN9oVhNY3UYyEfe+K/nlo15sOXkFONrZofQjoI=;
	b=ScKWJQaU/8+qKpd6w6655Aggq4gH+zKQfLlUg34hpn09zkSK1vpltgjGprZtEe
	JfcgbQpUFduz+6QExa7WM0GWyByiVhC3/w537KO9Olo7dZ7jBBZoQCs86jQPMqAl
	HPvtEPOLXjdIxWifwm2J1AV84Yks5geT8EipO+IUAGhYs=
Received: from [IPV6:240e:b8f:927e:1000:4390:9d39:cacd:606d] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wA3Jwv8s6VpeXz2NQ--.21625S2;
	Mon, 02 Mar 2026 23:59:57 +0800 (CST)
Message-ID: <53c62d0c-cc5e-4ae3-82ce-03d408217837@163.com>
Date: Mon, 2 Mar 2026 23:59:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Anand Moon <linux.amoon@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Grimmauld <grimmauld@grimmauld.de>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260226101032.1042-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wA3Jwv8s6VpeXz2NQ--.21625S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1fZrWDGw4fAr47KryfWFg_yoW8Ww43pa
	1DAF17Ar95Gr4SqF4xGaykuFyYqanrA3yDJ393W34a9Fyayr15K3sIgF9Iqrnrtr42ka4F
	kw15tF9rGa9IvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRtKs8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B7vk2mls-446gAA3d



On 2026/2/26 18:10, Anand Moon wrote:
> Rockchip DWC PCIe driver currently performs synchronous link training for
> combo PHYs (PCIe 3.0/2.0 and SATA 3.0) during boot. This process waits for
> the link to be fully established, adding several milliseconds to the boot
> sequence. To optimize boot time, this change enables asynchronous probing,
> allowing link establishment to proceed in the background while the kernel
> continues probing other devices.
> 
> Cc: Grimmauld <grimmauld@grimmauld.de>
> Cc: Niklas Cassel <cassel@kernel.org>
> Tested-by: Grimmauld <grimmauld@grimmauld.de>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Reviewed-by: Hans Zhang <18255117159@163.com>

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

