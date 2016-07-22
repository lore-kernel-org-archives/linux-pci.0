Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:63727 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbcGVNaF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2016 09:30:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com,
	robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 2/2] ARM: DRA7: select PCI_DOMAINS config
Date: Fri, 22 Jul 2016 15:29:26 +0200
Message-ID: <5655227.Z3Bo3vTPGH@wuerfel>
In-Reply-To: <5791D8C7.5020303@ti.com>
References: <1469102276-14777-1-git-send-email-kishon@ti.com> <20160722071644.GZ28140@atomide.com> <5791D8C7.5020303@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 22, 2016 1:56:47 PM CEST Kishon Vijay Abraham I wrote:
> 
> since it doesn't harm even if a platform has a single PCIe port, it should be
> okay to set PCI_DOMAINS. I'll resend the following as a separate patch if it's
> okay.
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 90542db..0cccb50 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -338,6 +338,7 @@ config ARCH_MULTIPLATFORM
>         select MULTI_IRQ_HANDLER
>         select SPARSE_IRQ
>         select USE_OF
> +       select PCI_DOMAINS if PCI
> 

Sounds good, but please remove all other 'select PCI_DOMAINS if PCI'
statements in arch/arm then in the same patch.

I have checked that all of them are for ARCH_MULTIPLATFORM based machines.

	Arnd
