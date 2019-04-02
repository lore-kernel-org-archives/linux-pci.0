Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F6C43381
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 06:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166AF20833
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 06:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfDBGzG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:55:06 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6382 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbfDBGzG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 02:55:06 -0400
X-UUID: 4197decf5e6a4d2bab0cbb5cc8fc6b77-20190402
X-UUID: 4197decf5e6a4d2bab0cbb5cc8fc6b77-20190402
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1763454159; Tue, 02 Apr 2019 14:55:01 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Apr 2019 14:54:59 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Apr 2019 14:54:59 +0800
Message-ID: <1554188098.2219.0.camel@mtkswgap22>
Subject: Re: [v2 PATCH] PCI: mediatek: get optional clock by
 devm_clk_get_optional()
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Honghui Zhang <honghui.zhang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 2 Apr 2019 14:54:58 +0800
In-Reply-To: <1554036063-1381-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1554036063-1381-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2019-03-31 at 20:41 +0800, Chunfeng Yun wrote:
> Use devm_clk_get_optional() to get optional clock
> 
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Honghui Zhang <honghui.zhang@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Ryder Lee <ryder.lee@mediatek.com>

> ---
> v2:
>   1. cc Ryder and Honghui
>   2. fix up omitted 'if (IS_ERR())'
> ---
>  drivers/pci/controller/pcie-mediatek.c | 50 ++++++++------------------
>  1 file changed, 15 insertions(+), 35 deletions(-)
> 
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


