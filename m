Return-Path: <SRS0=9PB/=Y7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B185C5DF60
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AB8206C3
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 10:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfKGKCL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:02:11 -0500
Received: from foss.arm.com ([217.140.110.172]:53192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfKGKCL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 05:02:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A05B146A;
        Thu,  7 Nov 2019 02:02:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0535F3F71A;
        Thu,  7 Nov 2019 02:02:09 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:02:08 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 2/2] PCI: uniphier: Add checking whether PERST# is
 deasserted
Message-ID: <20191107100207.GV9723@e119886-lin.cambridge.arm.com>
References: <1573102695-7018-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1573102695-7018-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573102695-7018-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 01:58:15PM +0900, Kunihiko Hayashi wrote:
> When PERST# is asserted once, EP configuration will be initialized.

I don't quite understand this - does the EP/RC mode depend on how often
PERST# is toggled?

> If PERST# has been already deasserted, it isn't necessary to assert
> here.

What is the motativation for this patch? Is it to avoid a delay during
boot, or to fix some bug? Isn't it nice to always reset the IP before
use anyway?

> 
> This checks whether PERST# is deasserted using PCL_PINMON register,
> and adds omit controlling PERST#.

Should this read 'and omits controlling PERST#'?

> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 8fd7bad..1ea4220 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -22,6 +22,9 @@
>  
>  #include "pcie-designware.h"
>  
> +#define PCL_PINMON			0x0028
> +#define PCL_PINMON_PERST_OUT		BIT(16)
> +
>  #define PCL_PINCTRL0			0x002c
>  #define PCL_PERST_PLDN_REGEN		BIT(12)
>  #define PCL_PERST_NOE_REGEN		BIT(11)
> @@ -100,6 +103,11 @@ static void uniphier_pcie_init_rc(struct uniphier_pcie_priv *priv)
>  	val |= PCL_SYS_AUX_PWR_DET;
>  	writel(val, priv->base + PCL_APP_PM0);
>  
> +	/* return if PERST# is already deasserted */

This comment just describes what the following line does which may be
self-explanatory, perhaps a better comment would describe why we avoid
a reset.

Thanks,

Andrew Murray

> +	val = readl(priv->base + PCL_PINMON);
> +	if (val & PCL_PINMON_PERST_OUT)
> +		return;
> +
>  	/* assert PERST# */
>  	val = readl(priv->base + PCL_PINCTRL0);
>  	val &= ~(PCL_PERST_NOE_REGVAL | PCL_PERST_OUT_REGVAL
> -- 
> 2.7.4
> 
