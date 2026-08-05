Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20933CF20C;
	Wed,  5 Aug 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950985; cv=none; b=o5c0E43cpzhKDU+f8KJZmEPYjrQ63trIVyMhqt/Dw9AfrvaT/tMRU8i0xlaW0Z4ZWsyRCTJZMRxBYCX3VAPdP+3lEXP2LCiLkSVUciyjDQYgZ5X5ak/RG9FwSw1ZLRjp37CpXs6UnBoM6dtyoCPEVQ7+TyLeyVkE2aHuI5FjMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950985; c=relaxed/simple;
	bh=d7WBis3fvuKi4+kCDu44HldZKhkKA8v0YXQGkLf3kB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hC9I3lAYN/0WPnNn4jdRpy0B1+qjO2XbP0dSJI2TAtVub5///bvHjhE66ody+Hp992UHlYdW692YJJ7EUBNbiskbYL1m5nUD6Pps1msxOOxVOXbWVN5ElTsZ2Uyepf3Ni/WJ/Y9UoFVxMkE74uum6zI5N/oWLHzL45B0FT7eroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SqmQ0mAi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SqmQ0mAi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Umsp5qJSMtD4ZjauRWy5N06yE5sTtUVqZNEHsiq3f/0=; b=SqmQ0mAiPDHlYTdR0fiG8cEm2x
	tzkuofAxUpk+ESU7CVmSp+CjHYS12SYTqe6sioJRKqEq4k0qhOY9AIp1YHV73Y/YmWxgWO12qCOjc
	o1pHs86ipYADqUj75zlcqohc35EBfxTHdXiDurJX1+Pe05+I6YWWmOjuTfYbfDRfRGAANEnOD8j2X
	pZfLynHRLlDgXzWu70k8i8zn54fq+fuH3ZrhwxfxjEoQMR01a6aLCQhukatBDCyNiUsfpgHNbarRV
	76ZPnon6fjVmUvx/MnMGw1ItHIyAAl4jq+iBx2EYYIpJKGJz7kaFEg6MTeLCvzAco/U1R+F7EkM2J
	VGXYOE9w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrfQt-00000004Ktw-2Bi4;
	Wed, 05 Aug 2026 17:29:35 +0000
Message-ID: <c5cde08d-237f-4030-8fda-734489ce4333@infradead.org>
Date: Wed, 5 Aug 2026 10:29:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence-plat: Fix host/endpoint dependencies
To: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, mpillai@cadence.com,
 18255117159@163.com, unicorn_wang@outlook.com
Cc: linux-kernel@vger.kernel.org, s-vadapalli@ti.com, danishanwar@ti.com
References: <20260805105014.3952686-1-a-garg7@ti.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260805105014.3952686-1-a-garg7@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/5/26 3:50 AM, Aksh Garg wrote:
> The cadence-plat driver has a single platform driver that can be built-in
> or a loadable module, but it calls two separate backend drivers depending
> on whether it is a host or endpoint.
> 
> If one of the mode is build as built-in and another as loadable module,
> we end up with a situation where the built-in pcie-cadence-plat driver
> tries to call the modular host or endpoint driver, which causes a link
> failure:
> 
>   ld: error: undefined symbol: cdns_pcie_ep_setup
>   >>> referenced by pcie-cadence-plat.c
>   >>>               drivers/pci/controller/cadence/pcie-cadence-plat.o:(cdns_plat_pcie_probe) in archive vmlinux.a
> 
>   ld: error: undefined symbol: cdns_pcie_host_setup
>   >>> referenced by pcie-cadence-plat.c
>   >>>               drivers/pci/controller/cadence/pcie-cadence-plat.o:(cdns_plat_pcie_probe) in archive vmlinux.a
> 
> Fix this by moving the 'select' of PCIE_CADENCE_HOST and PCIE_CADENCE_EP
> from the individual PLAT_HOST/PLAT_EP symbols into the common PCIE_CADENCE_PLAT
> symbol, conditioned on which backends (modes) are enabled.
> 
> Fixes: 611627a4e5e4 ("PCI: cadence: Add module support for platform controller driver")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-next/589ea512-93c6-4e1c-83d7-ba45a0b35843@infradead.org/
> Signed-off-by: Aksh Garg <a-garg7@ti.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/pci/controller/cadence/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 9e651d545973..fd704dec47dd 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -20,11 +20,12 @@ config PCIE_CADENCE_EP
>  
>  config PCIE_CADENCE_PLAT
>  	tristate
> +	select PCIE_CADENCE_HOST if PCIE_CADENCE_PLAT_HOST != n
> +	select PCIE_CADENCE_EP if PCIE_CADENCE_PLAT_EP != n
>  
>  config PCIE_CADENCE_PLAT_HOST
>  	tristate "Cadence platform PCIe controller (host mode)"
>  	depends on OF
> -	select PCIE_CADENCE_HOST
>  	select PCIE_CADENCE_PLAT
>  	help
>  	  Say Y here if you want to support the Cadence PCIe platform controller in
> @@ -35,7 +36,6 @@ config PCIE_CADENCE_PLAT_EP
>  	tristate "Cadence platform PCIe controller (endpoint mode)"
>  	depends on OF
>  	depends on PCI_ENDPOINT
> -	select PCIE_CADENCE_EP
>  	select PCIE_CADENCE_PLAT
>  	help
>  	  Say Y here if you want to support the Cadence PCIe platform controller in

-- 
~Randy
