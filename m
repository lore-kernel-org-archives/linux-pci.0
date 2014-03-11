Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:53408 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755423AbaCKUQG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 11 Mar 2014 16:16:06 -0400
Date: Tue, 11 Mar 2014 14:15:33 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>,
	linux-tegra <linux-tegra@vger.kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 1/2] of/irq: Fix irq-mapping in of_irq_parse_raw()
Message-ID: <20140311201533.GF31835@obsidianresearch.com>
References: <1393944864-28113-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393944864-28113-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 04, 2014 at 06:54:24AM -0800, Tim Harvey wrote:
> When an interrupt-map contains multiple entries an imap pointer arithmetic
> bug can cause only the first entry to be properly evaluated and causes
> the out_irq parameters to be incorrect depending on the #interrupt-cells
> and #address-cells of the parent interrupt controller.

Tim,

I took a bit closer look at this for you, and I suspect the root fix
is this:

--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -55,7 +55,6 @@ Example:
        intc: interrupt-controller@fff11000 {
                compatible = "arm,cortex-a9-gic";
                #interrupt-cells = <3>;
-               #address-cells = <1>;
                interrupt-controller;
                reg = <0xfff11000 0x1000>,
                      <0xfff10100 0x100>;
(plus the corresponding purge from the .dt files)

It looks like the implementation does follow the OF specification:

 Each mapping entry consists of a 3-tuple of (child-interrupt,
 interrupt-parent, parent-interrupt). The number of cells for the
 child-interrupt specifier is determined by the "#address-cells" and
 "#interrupt-cells"property of this node. The number of cells for the
 parent-interrupt value is determined by the "#address-cells"and
 "#interrupt-cells"property values of this node's
 interrupt-parent.

So by specifying interrupt-cells = 3, address-cells = 1, the GIC is
requiring 4 DWs for its interrupt specifier.

I see no reason why it doesn't have an address-cells = 0 like other
interrupt controllers..

Setting #address-cells to 0 in the GIC node should be functionally
equivalent to your patch below, since newaddrsize will == 0.

Regards,
Jason

> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 9bcf2cf..8829197 100644
> +++ b/drivers/of/irq.c
> @@ -237,11 +237,11 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>  			/* Check for malformed properties */
>  			if (WARN_ON(newaddrsize + newintsize > MAX_PHANDLE_ARGS))
>  				goto fail;
> -			if (imaplen < (newaddrsize + newintsize))
> +			if (imaplen < newintsize)
>  				goto fail;
>  
> -			imap += newaddrsize + newintsize;
> -			imaplen -= newaddrsize + newintsize;
> +			imap += newintsize;
> +			imaplen -= newintsize;
>  
>  			pr_debug(" -> imaplen=%d\n", imaplen);
>  		}
