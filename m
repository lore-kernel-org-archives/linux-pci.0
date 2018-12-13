Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D6FC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C97C20870
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544712928;
	bh=eRsT+FTebEM5A+Z2Epuh/Cwylp3fEw/PfXsDT5bQwKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W5/lrTV9qHJanBUNWACTMZutvO1IR4Zxtcd5ffHpIRnnw8VgN19oCjeyUmn+FsYAf
	 5QAaNn783Fyn3yDCCM5uOhw62s4lmn35tx5pbpYTr8iumDdzka1EAznrJOT0qTEZ3f
	 tfJUVHiM0fr2NTmH7ksH9a5Voc6wJHqsmgR1L0rM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C97C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeLMOzV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbeLMOzU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 09:55:20 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D534A2086D;
        Thu, 13 Dec 2018 14:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544712919;
        bh=eRsT+FTebEM5A+Z2Epuh/Cwylp3fEw/PfXsDT5bQwKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atzM4i8s8LE3kAhJUzDsDBeLwF76bvcWEJUqJ8iutb/VeJ731m6z8w32QceCKLioQ
         yFRphuFRFa4yzFczTX1ieVLNyJMVDZLzVF/jOXKDJwCNYGH+k8K8RYLEaHlhf2W1Kv
         TwqBtGmoznb+LZjWNVOE/AVNtHcIzuUL45m1XdsU=
Date:   Thu, 13 Dec 2018 08:55:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     ryder.lee@mediatek.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, youlin.pei@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        honghui.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
Message-ID: <20181213145517.GB4701@google.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
 <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 06, 2018 at 09:09:13AM +0800, Jianjun Wang wrote:
> MT7629 is an arm platform SoC which has the same PCIe IP with MT7622.

s/arm/ARM/

> The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
> in arm64 but bogus alignment values at arm32, the pcie device and devices
> behind this bridge will not be enabled. Fix it's BAR0 resource size to
> guarantee the pcie devices will be enabled correctly.

So this is a hardware erratum?  Per spec, a memory BAR has bit 0 hardwired
to 0, and an IO BAR has bit 1 hardwired to 0.

> The HW default value of its device id is invalid, fix it's device id to
> match the hardware implementation.

s/pcie/PCIe/ (all places above)
s/it's/its/ (all places above)
s/device id/Device ID/

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

Add a blank line here.

> +	/* 32bit resource length will calculate size to 0, set it smaller */
> +	dev_res->end = 0xfffffffe;

Presumably you know the size of the BAR because that's fixed by the
hardware and documented in the spec.  You should do something like
this so you don't depend on what the BAR contains, e.g.,

  res->end = res->start + size - 1;

> +}
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
> -- 
> 2.19.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
