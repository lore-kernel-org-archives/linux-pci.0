Return-Path: <SRS0=9PB/=Y7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72C8C5DF61
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3112084D
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 09:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbfKGJw6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:52:58 -0500
Received: from foss.arm.com ([217.140.110.172]:52982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfKGJw6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 04:52:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D10846A;
        Thu,  7 Nov 2019 01:52:57 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D62023F71A;
        Thu,  7 Nov 2019 01:52:56 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:52:54 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 1/2] PCI: uniphier: Set mode register to host mode
Message-ID: <20191107095254.GU9723@e119886-lin.cambridge.arm.com>
References: <1573102695-7018-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573102695-7018-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 01:58:14PM +0900, Kunihiko Hayashi wrote:
> In order to avoid effect of the initial mode depending on SoCs,
> this patch sets the mode register to host(RC) mode.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 3f30ee4..8fd7bad 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -33,6 +33,10 @@
>  #define PCL_PIPEMON			0x0044
>  #define PCL_PCLK_ALIVE			BIT(15)
>  
> +#define PCL_MODE			0x8000
> +#define PCL_MODE_REGEN			BIT(8)
> +#define PCL_MODE_REGVAL			BIT(0)
> +
>  #define PCL_APP_READY_CTRL		0x8008
>  #define PCL_APP_LTSSM_ENABLE		BIT(0)
>  
> @@ -85,6 +89,12 @@ static void uniphier_pcie_init_rc(struct uniphier_pcie_priv *priv)
>  {
>  	u32 val;
>  
> +	/* set RC MODE */
> +	val = readl(priv->base + PCL_MODE);
> +	val |= PCL_MODE_REGEN;
> +	val &= ~PCL_MODE_REGVAL;
> +	writel(val, priv->base + PCL_MODE);
> +

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

>  	/* use auxiliary power detection */
>  	val = readl(priv->base + PCL_APP_PM0);
>  	val |= PCL_SYS_AUX_PWR_DET;
> -- 
> 2.7.4
> 
