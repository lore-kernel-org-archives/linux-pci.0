Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A38EC04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 05:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCDB214C1
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 05:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCDB214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeLFFyI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:54:08 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:60021 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728294AbeLFFyI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 00:54:08 -0500
X-UUID: e899e5154b84451297bbb2e5e49e94bd-20181206
X-UUID: e899e5154b84451297bbb2e5e49e94bd-20181206
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 877240392; Thu, 06 Dec 2018 13:53:55 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 6 Dec
 2018 13:53:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 6 Dec 2018 13:53:53 +0800
Message-ID: <1544075633.3753.11.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
CC:     <ryder.lee@mediatek.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <matthias.bgg@gmail.com>, <linux-pci@vger.kernel.org>,
        <mark.rutland@arm.com>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>
Date:   Thu, 6 Dec 2018 13:53:53 +0800
In-Reply-To: <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
         <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2018-12-06 at 09:09 +0800, Jianjun Wang wrote:
> MT7629 is an arm platform SoC which has the same PCIe IP with MT7622.
> 
> The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
> in arm64 but bogus alignment values at arm32, the pcie device and devices

:s /the pcie device /the bridge device

> behind this bridge will not be enabled. Fix it's BAR0 resource size to
> guarantee the pcie devices will be enabled correctly.
> 
> The HW default value of its device id is invalid, fix it's device id to
> match the hardware implementation.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 26 ++++++++++++++++++++++++++
>  include/linux/pci_ids.h                |  1 +
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index d20cf461ba00..f8937cc3c87c 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -73,6 +73,7 @@
>  #define PCIE_MSI_VECTOR		0x0c0
>  
>  #define PCIE_CONF_VEND_ID	0x100
> +#define PCIE_CONF_DEVICE_ID	0x102
>  #define PCIE_CONF_CLASS_ID	0x106
>  
>  #define PCIE_INT_MASK		0x420
> @@ -135,12 +136,14 @@ struct mtk_pcie_port;
>  /**
>   * struct mtk_pcie_soc - differentiate between host generations
>   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> + * @need_fix_device_id: whether this host's device ID needed to be fixed or not
>   * @ops: pointer to configuration access functions
>   * @startup: pointer to controller setting functions
>   * @setup_irq: pointer to initialize IRQ functions
>   */
>  struct mtk_pcie_soc {
>  	bool need_fix_class_id;
> +	bool need_fix_device_id;
>  	struct pci_ops *ops;
>  	int (*startup)(struct mtk_pcie_port *port);
>  	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> @@ -692,6 +695,11 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		writew(val, port->base + PCIE_CONF_CLASS_ID);
>  	}
>  
> +	if (soc->need_fix_device_id) {
> +		val = PCI_DEVICE_ID_MEDIATEK_7629;
> +		writew(val, port->base + PCIE_CONF_DEVICE_ID);
> +	}
> +
>  	/* 100ms timeout value should be enough for Gen1/2 training */
>  	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
>  				 !!(val & PCIE_PORT_LINKUP_V2), 20,
> @@ -1238,11 +1246,29 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
>  	.setup_irq = mtk_pcie_setup_irq,
>  };
>  
> +static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
> +	.need_fix_class_id = true,
> +	.need_fix_device_id = true,
> +	.ops = &mtk_pcie_ops_v2,
> +	.startup = mtk_pcie_startup_port_v2,
> +	.setup_irq = mtk_pcie_setup_irq,
> +};
> +
> +static void mtk_fixup_bar_size(struct pci_dev *dev)
> +{
> +	struct resource *dev_res = &dev->resource[0];
> +	/* 32bit resource length will calculate size to 0, set it smaller */
> +	dev_res->end = 0xfffffffe;
> +}

I'm not sure assign the BAR0 size in driver to fit in the bogus
alignment is a good idea. Seems the size value of 0xffff_fffe also is an
arbitrary value.
Do we have a chance to change the resource framework code to make it
adopt this scenario?

Thanks.

> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MEDIATEK, PCI_DEVICE_ID_MEDIATEK_7629,
> +			 mtk_fixup_bar_size);
> +
>  static const struct of_device_id mtk_pcie_ids[] = {
>  	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
>  	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
>  	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
>  	{ .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_mt7622 },
> +	{ .compatible = "mediatek,mt7629-pcie", .data = &mtk_pcie_soc_mt7629 },
>  	{},
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 69f0abe1ba1a..77b278bac3a8 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2126,6 +2126,7 @@
>  #define PCI_VENDOR_ID_MYRICOM		0x14c1
>  
>  #define PCI_VENDOR_ID_MEDIATEK		0x14c3
> +#define PCI_DEVICE_ID_MEDIATEK_7629	0x7629
>  
>  #define PCI_VENDOR_ID_TITAN		0x14D2
>  #define PCI_DEVICE_ID_TITAN_010L	0x8001


