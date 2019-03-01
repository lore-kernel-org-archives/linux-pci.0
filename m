Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F273C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 01:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6331D218AE
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 01:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfCAB7X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:59:23 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53803 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725967AbfCAB7X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 20:59:23 -0500
X-UUID: 21cdcab5909a4bec87ce57119ebaf975-20190301
X-UUID: 21cdcab5909a4bec87ce57119ebaf975-20190301
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 699210403; Fri, 01 Mar 2019 09:59:17 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Mar
 2019 09:59:15 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Mar 2019 09:59:14 +0800
Message-ID: <1551405554.32061.19.camel@mhfsdcap03>
Subject: Re: [PATCH 7/8] PCI: mediatek: fix a leaked reference by adding
 missing of_node_put
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Wen Yang <wen.yang99@zte.com.cn>
CC:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <tyreld@linux.vnet.ibm.com>,
        <bhelgaas@google.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ryder.lee@mediatek.com>, <lorenzo.pieralisi@arm.com>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <thomas.petazzoni@bootlin.com>, <shawn.lin@rock-chips.com>,
        <heiko@sntech.de>, <linux-rockchip@lists.infradead.org>,
        <minghuan.Lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <hayashi.kunihiko@socionext.com>, <yamada.masahiro@socionext.com>,
        <kishon@ti.com>, <linux-omap@vger.kernel.org>,
        <wang.yi59@zte.com.cn>
Date:   Fri, 1 Mar 2019 09:59:14 +0800
In-Reply-To: <1551242443-27300-7-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
         <1551242443-27300-7-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-02-27 at 12:40 +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> irq_domain_add_linear also calls of_node_get to increase refcount,
> so irq_domain will not be affected when it is released.
> 
> Detected by coccinelle with the following warnings:
> ./drivers/pci/controller/pcie-mediatek.c:577:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 567, but without a corresponding object release within this function.
> ./drivers/pci/controller/pcie-mediatek.c:583:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 567, but without a corresponding object release within this function.
> ./drivers/pci/controller/pcie-mediatek.c:586:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 567, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/pci/controller/pcie-mediatek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 55e471c..e91716a 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -572,6 +572,7 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
>  
>  	port->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
>  						 &intx_domain_ops, port);
> +	of_node_put(pcie_intc_node);
>  	if (!port->irq_domain) {
>  		dev_err(dev, "failed to get INTx IRQ domain\n");
>  		return -ENODEV;

Thanks for fix this.

Acked-by: Honghui Zhang <honghui.zhang@mediatek.com>

