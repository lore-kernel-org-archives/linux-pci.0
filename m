Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50849 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbaEPA1l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 May 2014 20:27:41 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Murali Karicheri' <m-karicheri2@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	'Santosh Shilimkar' <santosh.shilimkar@ti.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <1400169692-9677-2-git-send-email-m-karicheri2@ti.com>
In-reply-to: <1400169692-9677-2-git-send-email-m-karicheri2@ti.com>
Subject: Re: [PATCH v1 1/5] ARM: keystone: add pcie related options
Date: Fri, 16 May 2014 09:27:38 +0900
Message-id: <004e01cf709d$a48b4240$eda1c6c0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, May 16, 2014 1:01 AM, Murali Karicheri wrote:
> 
> Add pcie related options by default for keystone architecture
> 
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Russell King <linux@arm.linux.org.uk>
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  arch/arm/mach-keystone/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
> index f50bc93..f87844d 100644
> --- a/arch/arm/mach-keystone/Kconfig
> +++ b/arch/arm/mach-keystone/Kconfig
> @@ -8,6 +8,8 @@ config ARCH_KEYSTONE
>  	select COMMON_CLK_KEYSTONE
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select ZONE_DMA if ARM_LPAE
> +	select MIGHT_HAVE_PCI
> +	select ARCH_SUPPORTS_MSI

Please, don't select ARCH_SUPPORTS_MSI, because this kconfig
option was already removed in v3.12 by the commit ebd97be635
('PCI: remove ARCH_SUPPORTS_MSI kconfig option'). So. there is
NO need to select 'ARCH_SUPPORTS_MSI'.

Best regards,
Jingoo Han

>  	help
>  	  Support for boards based on the Texas Instruments Keystone family of
>  	  SoCs.
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

