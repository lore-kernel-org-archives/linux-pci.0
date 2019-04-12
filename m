Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC892C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 16:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA76220869
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 16:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDLQ0S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:26:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLQ0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 12:26:18 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hEz0K-0004rI-GM; Fri, 12 Apr 2019 18:26:16 +0200
Message-ID: <1555086376.11529.40.camel@pengutronix.de>
Subject: Re: [PATCH v3 11/11] PCI: imx6: Replace calls to udelay() with
 usleep_range()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-pci@vger.kernel.org
Date:   Fri, 12 Apr 2019 18:26:16 +0200
In-Reply-To: <20190401042547.14067-12-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
         <20190401042547.14067-12-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Sonntag, den 31.03.2019, 21:25 -0700 schrieb Andrey Smirnov:
> In both cases udelay() is called in non-atomic context, so there's
> really no need to use it there. Change the code to use usleep_range()
> instead.
> 
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c9431a8a7ca1..3f13022991ec 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -167,7 +167,7 @@ static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
>  		if (val == exp_val)
>  			return 0;
>  
> -		udelay(1);
> +		usleep_range(10, 100);

I'm not sure we want to change this. This is dragging out the timeout
considerably while the really short delay, together with the low number
of max loop iterations suggests that the condition is usually met very
quickly.

Maybe this would even want a change in the other direction by replacing
the udelay with a cpu_relax to speed up the condition detection and
stall the CPU in device memory loads, instead of having it spin in a
tight inner loop.

>  	} while (wait_counter < max_iterations);
>  
>  	return -ETIMEDOUT;
> @@ -449,7 +449,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		 * reset time is too short, cannot meet the requirement.
>  		 * add one ~10us delay here.
>  		 */
> -		udelay(10);
> +		usleep_range(10, 100);

This one looks good.

Regards,
Lucas

>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
>  		break;
