Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0235.outbound.protection.outlook.com ([207.46.163.235]:37992
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932112AbaDBNMn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Apr 2014 09:12:43 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Sean Cross <xobs@kosagi.com>, Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	"Pawel Moll" <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 1/8] ARM: imx6q-clk: parent lvds_gate from lvds_sel
Date: Wed, 2 Apr 2014 12:57:25 +0000
Message-ID: <2d4c3e19ef3f4579a2cbdea70176e7d3@BLUPR03MB136.namprd03.prod.outlook.com>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas:
Thanks for your re-structure the management of the output on CLK1/2 pads.


> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> On Behalf Of Lucas Stach
> Sent: Saturday, March 29, 2014 12:53 AM
> To: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org;
> devicetree@vger.kernel.org; Sean Cross; Marek Vasut; Zhu Richard-R65037; Bjorn
> Helgaas; Jingoo Han; Shawn Guo; Ian Campbell; Mark Rutland; Pawel Moll; Rob
> Herring; Arnd Bergmann; Tim Harvey; kernel@pengutronix.de
> Subject: [PATCH 1/8] ARM: imx6q-clk: parent lvds_gate from lvds_sel
> 
> Allows fror proper refcounting of the parent clocks when enabling the clock
> output on CLK1/2 pads.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Richard Zhu <r65037@freescale.com>

> ---
>  arch/arm/mach-imx/clk-imx6q.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index af2e582d2b74..f98a6bb98145 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -208,8 +208,8 @@ static void __init imx6q_clocks_init(struct device_node
> *ccm_node)
>  	 * the "output_enable" bit as a gate, even though it's really just
>  	 * enabling clock output.
>  	 */
> -	clk[lvds1_gate] = imx_clk_gate("lvds1_gate", "dummy", base + 0x160, 10);
> -	clk[lvds2_gate] = imx_clk_gate("lvds2_gate", "dummy", base + 0x160, 11);
> +	clk[lvds1_gate] = imx_clk_gate("lvds1_gate", "lvds1_sel", base + 0x160,
> 10);
> +	clk[lvds2_gate] = imx_clk_gate("lvds2_gate", "lvds2_sel", base +
> +0x160, 11);
> 
>  	/*                                name              parent_name
> reg       idx */
>  	clk[pll2_pfd0_352m] = imx_clk_pfd("pll2_pfd0_352m", "pll2_bus",     base
> + 0x100, 0);
> --
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 


Best Regards
Richard Zhu


