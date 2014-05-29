Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34274 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933694AbaE2Gs7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 May 2014 02:48:59 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, tony@atomide.com,
	'Rob Herring' <robh+dt@kernel.org>,
	'Pawel Moll' <pawel.moll@arm.com>,
	'Mark Rutland' <mark.rutland@arm.com>,
	'Kumar Gala' <galak@codeaurora.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com>
 <1401345500-20188-17-git-send-email-kishon@ti.com>
In-reply-to: <1401345500-20188-17-git-send-email-kishon@ti.com>
Subject: Re: [PATCH v2 16/18] ARM: OMAP: Enable PCI for DRA7
Date: Thu, 29 May 2014 15:48:55 +0900
Message-id: <000601cf7b0a$0fbce200$2f36a600$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, May 29, 2014 3:38 PM, Kishon Vijay Abraham I wrote:
> 
> Now that we have added PCIe driver for DRA7 SOCs, enable PCI on
> DRA7 SOCs.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index cb31d43..b179e80 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -75,6 +75,8 @@ config SOC_DRA7XX
>  	select ARM_GIC
>  	select HAVE_ARM_ARCH_TIMER
>  	select IRQ_CROSSBAR
> +	select MIGHT_HAVE_PCI
> +	select ARCH_SUPPORTS_MSI

Hi Kishon,

Please, don't select ARCH_SUPPORTS_MSI, because this kconfig
option was already removed in v3.12 by the commit ebd97be635
('PCI: remove ARCH_SUPPORTS_MSI kconfig option'). So, there is
NO need to select 'ARCH_SUPPORTS_MSI'.

Best regards,
Jingoo Han

> 
>  config ARCH_OMAP2PLUS
>  	bool
> --
> 1.7.9.5

