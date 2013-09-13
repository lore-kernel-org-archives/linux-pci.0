Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:56409
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751847Ab3IMMmP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Sep 2013 08:42:15 -0400
Date: Fri, 13 Sep 2013 20:42:31 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Sean Cross <xobs@kosagi.com>
CC: <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Zhu Richard-R65037 <r65037@freescale.com>
Subject: Re: [PATCH v4 1/3] ARM: imx: Add LVDS general-purpose clocks to
 i.MX6Q
Message-ID: <20130913124229.GC31147@S2101-09.ap.freescale.net>
References: <1379065222-7275-1-git-send-email-xobs@kosagi.com>
 <1379065222-7275-2-git-send-email-xobs@kosagi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1379065222-7275-2-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 13, 2013 at 09:40:20AM +0000, Sean Cross wrote:
> The i.MX6 has two general-purpose LVDS clocks that can be driven
> from a variety of sources.  This patch adds a mux and a gate for
> both of these clocks.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> ---
>  .../devicetree/bindings/clock/imx6q-clock.txt      |    4 ++++
>  arch/arm/mach-imx/clk-imx6q.c                      |   21 +++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> index 5a90a72..35e82c7 100644
> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> @@ -215,6 +215,10 @@ clocks and IDs.
>  	cko2      		200
>  	cko      		201
>  	vdoa      		202
> +	lvds1_sel		203
> +	lvds2_sel		204
> +	lvds1_gate		205
> +	lvds2_gate		206
>  
>  Examples:
>  
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 9181a24..679d49a 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -217,6 +217,16 @@ static const char *cko2_sels[] = {
>  	"uart_serial", "spdif", "asrc", "hsi_tx",
>  };
>  static const char *cko_sels[] = { "cko1", "cko2", };
> +static const char *lvds1_sels[] = {
> +	"dummy", "dummy", "dummy", "dummy", "dummy", "dummy",
> +	"pll4_audio", "pll5_video", "pll8_mlb", "enet_ref",
> +	"pcie_ref", "sata_ref",
> +};
> +static const char *lvds2_sels[] = {
> +	"dummy", "dummy", "dummy", "dummy", "dummy", "dummy",
> +	"pll4_audio", "pll5_video", "pll8_mlb", "enet_ref",
> +	"pcie_ref", "sata_ref",
> +};

Since lvds1 and lvds2 share the same clock selection, we can define just
one lvds_sels[] to save one string array.

>  
>  enum mx6q_clks {
>  	dummy, ckil, ckih, osc, pll2_pfd0_352m, pll2_pfd1_594m, pll2_pfd2_396m,
> @@ -251,7 +261,8 @@ enum mx6q_clks {
>  	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
>  	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
>  	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, eim_slow,
> -	spdif, cko2_sel, cko2_podf, cko2, cko, vdoa, clk_max
> +	spdif, cko2_sel, cko2_podf, cko2, cko, vdoa,
> +	lvds1_sel, lvds2_sel, lvds1_gate, lvds2_gate, clk_max
>  };
>  
>  static struct clk *clk[clk_max];
> @@ -342,6 +353,12 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  			base + 0xe0, 0, 2, 0, clk_enet_ref_table,
>  			&imx_ccm_lock);
>  
> +	clk[lvds1_sel] = imx_clk_mux("lvds1_sel", base + 0x160, 0, 5, lvds1_sels,         ARRAY_SIZE(lvds1_sels));
> +	clk[lvds2_sel] = imx_clk_mux("lvds2_sel", base + 0x160, 5, 5, lvds2_sels,         ARRAY_SIZE(lvds2_sels));

The indentation before ARRAY_SIZE() does not make sense here.  Using one
space might fit better.

> +
> +	clk[lvds1_gate] = imx_clk_gate("lvds1_gate", "dummy", base + 0x160, 10);
> +	clk[lvds2_gate] = imx_clk_gate("lvds2_gate", "dummy", base + 0x160, 11);
> +

It deserves some document, since they are not real gates.

>  	/*                                name              parent_name        reg       idx */
>  	clk[pll2_pfd0_352m] = imx_clk_pfd("pll2_pfd0_352m", "pll2_bus",     base + 0x100, 0);
>  	clk[pll2_pfd1_594m] = imx_clk_pfd("pll2_pfd1_594m", "pll2_bus",     base + 0x100, 1);
> @@ -569,6 +586,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	clk_register_clkdev(clk[cko1_sel], "cko1_sel", NULL);
>  	clk_register_clkdev(clk[ahb], "ahb", NULL);
>  	clk_register_clkdev(clk[cko1], "cko1", NULL);
> +	clk_register_clkdev(clk[lvds1_gate], "lvds1_gate", NULL);
> +	clk_register_clkdev(clk[lvds2_gate], "lvds2_gate", NULL);

If the clocks are defined in device tree, we can look up them from there
to save these clkdev registrations.

Shawn

>  	clk_register_clkdev(clk[arm], NULL, "cpu0");
>  	clk_register_clkdev(clk[pll4_post_div], "pll4_post_div", NULL);
>  	clk_register_clkdev(clk[pll4_audio], "pll4_audio", NULL);
> -- 
> 1.7.9.5
> 

