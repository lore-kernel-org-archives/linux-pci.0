Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:34110 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaKEFuo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Nov 2014 00:50:44 -0500
Date: Wed, 5 Nov 2014 14:50:41 +0900
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: shmobile: Enable PCI domains for R-Car Gen2 devices
Message-ID: <20141105055041.GB32680@verge.net.au>
References: <1415122708-4011-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415122708-4011-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 04, 2014 at 05:38:28PM +0000, Phil Edworthy wrote:
> The PCI core will soon automatically handle the PCI domain number,
> allowing the internal PCI and external PCIe bridges work at the same time.
> In order for that to work, we need to enable PCI_DOMAINS.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Thanks, I have queued this up.

> ---
> 
> In order to automatically handle the PCI domain number, we need a patch from
> Lorenzo Pieralisi:
>  "[RFC PATCH 2/2] arm: pcibios: move to generic PCI domains"
> However, enabling PCI_DOMAINS without this doesn't have an adverse effect,
> and the plan is to use PCI domains to solve this problem, so we can apply
> this patch straight away.
> 
>  arch/arm/mach-shmobile/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 21f457b..1c05768 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -18,6 +18,7 @@ config ARCH_RCAR_GEN2
>  	select PM_RCAR if PM || SMP
>  	select RENESAS_IRQC
>  	select SYS_SUPPORTS_SH_CMT
> +	select PCI_DOMAINS if PCI
>  
>  config ARCH_RMOBILE
>  	bool
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
