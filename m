Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF3C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 09:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876552084D
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 09:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDKJJD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:09:03 -0400
Received: from foss.arm.com ([217.140.101.70]:38382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDKJJD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 05:09:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AC5880D;
        Thu, 11 Apr 2019 02:09:03 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE0CC3F718;
        Thu, 11 Apr 2019 02:09:01 -0700 (PDT)
Date:   Thu, 11 Apr 2019 10:08:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v3 PATCH] PCI: mediatek: get optional clock by
 devm_clk_get_optional()
Message-ID: <20190411090856.GA6227@red-moon>
References: <c4579e5a72f169808a9ad4aefdd7bf7b75d10d61.1554879079.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4579e5a72f169808a9ad4aefdd7bf7b75d10d61.1554879079.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 02:54:16PM +0800, Chunfeng Yun wrote:
> Use devm_clk_get_optional() to get optional clock
> 
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Honghui Zhang <honghui.zhang@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> Acked-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
> v3: add Acked-by Ryder and Honghui
> ---
>  drivers/pci/controller/pcie-mediatek.c | 50 ++++++++------------------
>  1 file changed, 15 insertions(+), 35 deletions(-)

Applied to pci/mediatek for v5.2, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 0b6c72804e03..adb6cb15daa2 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -915,49 +915,29 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
>  
>  	/* sys_ck might be divided into the following parts in some chips */
>  	snprintf(name, sizeof(name), "ahb_ck%d", slot);
> -	port->ahb_ck = devm_clk_get(dev, name);
> -	if (IS_ERR(port->ahb_ck)) {
> -		if (PTR_ERR(port->ahb_ck) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -
> -		port->ahb_ck = NULL;
> -	}
> +	port->ahb_ck = devm_clk_get_optional(dev, name);
> +	if (IS_ERR(port->ahb_ck))
> +		return PTR_ERR(port->ahb_ck);
>  
>  	snprintf(name, sizeof(name), "axi_ck%d", slot);
> -	port->axi_ck = devm_clk_get(dev, name);
> -	if (IS_ERR(port->axi_ck)) {
> -		if (PTR_ERR(port->axi_ck) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -
> -		port->axi_ck = NULL;
> -	}
> +	port->axi_ck = devm_clk_get_optional(dev, name);
> +	if (IS_ERR(port->axi_ck))
> +		return PTR_ERR(port->axi_ck);
>  
>  	snprintf(name, sizeof(name), "aux_ck%d", slot);
> -	port->aux_ck = devm_clk_get(dev, name);
> -	if (IS_ERR(port->aux_ck)) {
> -		if (PTR_ERR(port->aux_ck) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -
> -		port->aux_ck = NULL;
> -	}
> +	port->aux_ck = devm_clk_get_optional(dev, name);
> +	if (IS_ERR(port->aux_ck))
> +		return PTR_ERR(port->aux_ck);
>  
>  	snprintf(name, sizeof(name), "obff_ck%d", slot);
> -	port->obff_ck = devm_clk_get(dev, name);
> -	if (IS_ERR(port->obff_ck)) {
> -		if (PTR_ERR(port->obff_ck) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -
> -		port->obff_ck = NULL;
> -	}
> +	port->obff_ck = devm_clk_get_optional(dev, name);
> +	if (IS_ERR(port->obff_ck))
> +		return PTR_ERR(port->obff_ck);
>  
>  	snprintf(name, sizeof(name), "pipe_ck%d", slot);
> -	port->pipe_ck = devm_clk_get(dev, name);
> -	if (IS_ERR(port->pipe_ck)) {
> -		if (PTR_ERR(port->pipe_ck) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -
> -		port->pipe_ck = NULL;
> -	}
> +	port->pipe_ck = devm_clk_get_optional(dev, name);
> +	if (IS_ERR(port->pipe_ck))
> +		return PTR_ERR(port->pipe_ck);
>  
>  	snprintf(name, sizeof(name), "pcie-rst%d", slot);
>  	port->reset = devm_reset_control_get_optional_exclusive(dev, name);
> -- 
> 2.21.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
