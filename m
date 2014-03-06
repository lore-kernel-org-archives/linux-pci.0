Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:61583 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556AbaCFCiK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Mar 2014 21:38:10 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Simon Horman' <horms@verge.net.au>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Stephen Warren' <swarren@wwwdotorg.org>,
	'Ben Dooks' <ben-linux@fluff.org>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Arnd Bergmann' <arnd@arndb.de>, kernel@pengutronix.de,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-5-git-send-email-l.stach@pengutronix.de>
In-reply-to: <1394025951-32438-5-git-send-email-l.stach@pengutronix.de>
Subject: Re: [PATCH v2 4/6] ARM: dts: exynos5440: fix PCIe interrupt mapping
Date: Thu, 06 Mar 2014 11:38:07 +0900
Message-id: <000101cf38e5$1b9fd6c0$52df8440$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 05, 2014 10:26 PM, Lucas Stach wrote:
> 
> So it actually works.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jingoo Han <jg1.han@samsung.com>

It works properly on Exynos platform.
Thank you.

Best regards,
Jingoo Han

> ---
> v2: fix build breakage by including arm-gic.h
> ---
>  arch/arm/boot/dts/exynos5440.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> index 02a0a1226cef..7628e2edf1b6 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -9,6 +9,8 @@
>   * published by the Free Software Foundation.
>  */
> 
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
>  #include "skeleton.dtsi"
> 
>  / {
> @@ -274,7 +276,7 @@
>  			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0x0 0 &gic 53>;
> +		interrupt-map = <0 0 0 0 &gic GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>  		num-lanes = <4>;
>  		status = "disabled";
>  	};
> @@ -295,7 +297,7 @@
>  			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0x0 0 &gic 56>;
> +		interrupt-map = <0 0 0 0 &gic GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  		num-lanes = <4>;
>  		status = "disabled";
>  	};
> --
> 1.9.0

