Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:45267
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754209AbaCNNbI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Mar 2014 09:31:08 -0400
Date: Fri, 14 Mar 2014 21:31:46 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Tim Harvey <tharvey@gateworks.com>
CC: <linux-pci@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Richard Zhu <r65037@freescale.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-tegra <linux-tegra@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx: fix invalid #address-cells value
Message-ID: <20140314133144.GE813@S2101-09.ap.freescale.net>
References: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
 <1394732405-2260-3-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1394732405-2260-3-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 13, 2014 at 10:40:05AM -0700, Tim Harvey wrote:
> The invalid value of #address-cells in the imx6 pcie host controller node
> causes of_irq_parse_raw() to incorrectly advance through an interrupt-map
> table of more than one interrupt.
> 
> This patch resolves this issue and allows proper interrupt mapping for an
> imx6 pcie host connected to a P2P bridge when using legacy interrupts.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: linux-tegra <linux-tegra@vger.kernel.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index af8d28d..2285299 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -49,7 +49,7 @@
>  	intc: interrupt-controller@00a01000 {
>  		compatible = "arm,cortex-a9-gic";
>  		#interrupt-cells = <3>;
> -		#address-cells = <1>;
> +		#address-cells = <0>;
>  		#size-cells = <1>;

So we should probably just drop both #address-cells and #size-cells?  If
so, please help patch imx6sl.dtsi as well.

Shawn

>  		interrupt-controller;
>  		reg = <0x00a01000 0x1000>,
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 

