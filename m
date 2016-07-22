Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56882 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbcGVJYX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2016 05:24:23 -0400
Subject: Re: [PATCH 2/2] ARM: DRA7: select PCI_DOMAINS config
To: Kishon Vijay Abraham I <kishon@ti.com>,
	Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
References: <1469102276-14777-1-git-send-email-kishon@ti.com>
 <1469102276-14777-3-git-send-email-kishon@ti.com>
 <8047226.VhgpLo8JQu@wuerfel> <20160722071644.GZ28140@atomide.com>
 <5791D8C7.5020303@ti.com>
CC: <bcousson@baylibre.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <linux@armlinux.org.uk>,
	<linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <5791E615.3070904@ti.com>
Date: Fri, 22 Jul 2016 14:53:33 +0530
MIME-Version: 1.0
In-Reply-To: <5791D8C7.5020303@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 22 July 2016 01:56 PM, Kishon Vijay Abraham I wrote:

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 90542db..0cccb50 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -338,6 +338,7 @@ config ARCH_MULTIPLATFORM
>         select MULTI_IRQ_HANDLER
>         select SPARSE_IRQ
>         select USE_OF
> +       select PCI_DOMAINS if PCI

Keep the select list in sorted order.

Regards,
Sekhar
