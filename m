Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD7AC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 10:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08122086C
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 10:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfDAKD1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:03:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59782 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfDAKD1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 06:03:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F7E6A78;
        Mon,  1 Apr 2019 03:03:26 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC163F690;
        Mon,  1 Apr 2019 03:03:21 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:03:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        tyreld@linux.vnet.ibm.com, bhelgaas@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        thomas.petazzoni@bootlin.com, shawn.lin@rock-chips.com,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        hayashi.kunihiko@socionext.com, yamada.masahiro@socionext.com,
        kishon@ti.com, linux-omap@vger.kernel.org, wang.yi59@zte.com.cn
Subject: Re: [PATCH 1/8] PCI: dwc: pci-dra7xx: fix a leaked reference by
 adding missing of_node_put
Message-ID: <20190401100318.GB30501@e107981-ln.cambridge.arm.com>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 27, 2019 at 12:40:36PM +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> irq_domain_add_linear also calls of_node_get to increase refcount,
> so irq_domain will not be affected when it is released.
> 
> Detected by coccinelle with the following warnings:
> ./drivers/pci/controller/dwc/pci-dra7xx.c:252:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
> ./drivers/pci/controller/dwc/pci-dra7xx.c:255:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
>  1 file changed, 1 insertion(+)

Applied the series to pci/misc for v5.2, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index ae84a69..627c91d 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -247,6 +247,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
>  
>  	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
>  						   &intx_domain_ops, pp);
> +	of_node_put(pcie_intc_node);
>  	if (!dra7xx->irq_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
>  		return -ENODEV;
> -- 
> 2.9.5
> 
