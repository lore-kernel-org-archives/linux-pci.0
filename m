Return-Path: <SRS0=MCOJ=OA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2824AC43441
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 05:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC8421479
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 05:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC8421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbeKUQVH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:21:07 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:3748 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725939AbeKUQVH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2018 11:21:07 -0500
X-UUID: 9100305099a6491d92486c4fb7afafb4-20181121
X-UUID: 9100305099a6491d92486c4fb7afafb4-20181121
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 610551348; Wed, 21 Nov 2018 13:47:53 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 21 Nov 2018 13:47:52 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 21 Nov 2018 13:47:51 +0800
Message-ID: <1542779271.2401.0.camel@mtkswgap22>
Subject: Re: [PATCH v2] PCI: mediatek: Use
 devm_of_pci_get_host_bridge_resources() to parse DT
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <honghui.zhang@mediatek.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <youlin.pei@mediatek.com>, <jianjun.wang@mediatek.com>
Date:   Wed, 21 Nov 2018 13:47:51 +0800
In-Reply-To: <1541645815-30340-1-git-send-email-honghui.zhang@mediatek.com>
References: <1541645815-30340-1-git-send-email-honghui.zhang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2018-11-08 at 10:56 +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Use the devm_of_pci_get_host_bridge_resources() API in place of the PCI OF
> DT parser.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 98 +++++++++-------------------------
>  1 file changed, 24 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 2a1f97c..0590a93 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -197,11 +197,7 @@ struct mtk_pcie_port {
>   * @dev: pointer to PCIe device
>   * @base: IO mapped register base
>   * @free_ck: free-run reference clock
> - * @io: IO resource
> - * @pio: PIO resource
>   * @mem: non-prefetchable memory resource
> - * @busn: bus range
> - * @offset: IO / Memory offset
>   * @ports: pointer to PCIe port information
>   * @soc: pointer to SoC-dependent operations
>   */
> @@ -210,14 +206,7 @@ struct mtk_pcie {
>  	void __iomem *base;
>  	struct clk *free_ck;
>  
> -	struct resource io;
> -	struct resource pio;
>  	struct resource mem;
> -	struct resource busn;
> -	struct {
> -		resource_size_t mem;
> -		resource_size_t io;
> -	} offset;
>  	struct list_head ports;
>  	const struct mtk_pcie_soc *soc;
>  };
> @@ -1045,55 +1034,43 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  	struct device_node *node = dev->of_node, *child;
> -	struct of_pci_range_parser parser;
> -	struct of_pci_range range;
> -	struct resource res;
>  	struct mtk_pcie_port *port, *tmp;
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +	struct list_head *windows = &host->windows;
> +	struct resource_entry *win, *tmp_win;
> +	resource_size_t io_base;
>  	int err;
>  
> -	if (of_pci_range_parser_init(&parser, node)) {
> -		dev_err(dev, "missing \"ranges\" property\n");
> -		return -EINVAL;
> -	}
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> +						    windows, &io_base);
> +	if (err)
> +		return err;
>  
> -	for_each_of_pci_range(&parser, &range) {
> -		err = of_pci_range_to_resource(&range, node, &res);
> -		if (err < 0)
> -			return err;
> +	err = devm_request_pci_bus_resources(dev, windows);
> +	if (err < 0)
> +		return err;
>  
> -		switch (res.flags & IORESOURCE_TYPE_BITS) {
> +	/* Get the I/O and memory ranges from DT */
> +	resource_list_for_each_entry_safe(win, tmp_win, windows) {
> +		switch (resource_type(win->res)) {
>  		case IORESOURCE_IO:
> -			pcie->offset.io = res.start - range.pci_addr;
> -
> -			memcpy(&pcie->pio, &res, sizeof(res));
> -			pcie->pio.name = node->full_name;
> -
> -			pcie->io.start = range.cpu_addr;
> -			pcie->io.end = range.cpu_addr + range.size - 1;
> -			pcie->io.flags = IORESOURCE_MEM;
> -			pcie->io.name = "I/O";
> -
> -			memcpy(&res, &pcie->io, sizeof(res));
> +			err = devm_pci_remap_iospace(dev, win->res, io_base);
> +			if (err) {
> +				dev_warn(dev, "error %d: failed to map resource %pR\n",
> +					 err, win->res);
> +				resource_list_destroy_entry(win);
> +			}
>  			break;
> -
>  		case IORESOURCE_MEM:
> -			pcie->offset.mem = res.start - range.pci_addr;
> -
> -			memcpy(&pcie->mem, &res, sizeof(res));
> +			memcpy(&pcie->mem, win->res, sizeof(*win->res));
>  			pcie->mem.name = "non-prefetchable";
>  			break;
> +		case IORESOURCE_BUS:
> +			host->busnr = win->res->start;
> +			break;
>  		}
>  	}
>  
> -	err = of_pci_parse_bus_range(node, &pcie->busn);
> -	if (err < 0) {
> -		dev_err(dev, "failed to parse bus ranges property: %d\n", err);
> -		pcie->busn.name = node->name;
> -		pcie->busn.start = 0;
> -		pcie->busn.end = 0xff;
> -		pcie->busn.flags = IORESOURCE_BUS;
> -	}
> -
>  	for_each_available_child_of_node(node, child) {
>  		int slot;
>  
> @@ -1125,28 +1102,6 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
>  	return 0;
>  }
>  
> -static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
> -{
> -	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> -	struct list_head *windows = &host->windows;
> -	struct device *dev = pcie->dev;
> -	int err;
> -
> -	pci_add_resource_offset(windows, &pcie->pio, pcie->offset.io);
> -	pci_add_resource_offset(windows, &pcie->mem, pcie->offset.mem);
> -	pci_add_resource(windows, &pcie->busn);
> -
> -	err = devm_request_pci_bus_resources(dev, windows);
> -	if (err < 0)
> -		return err;
> -
> -	err = devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
> -	if (err < 0)
> -		return err;
> -
> -	return 0;
> -}
> -
>  static int mtk_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1169,11 +1124,6 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	err = mtk_pcie_request_resources(pcie);
> -	if (err)
> -		goto put_resources;
> -
> -	host->busnr = pcie->busn.start;
>  	host->dev.parent = pcie->dev;
>  	host->ops = pcie->soc->ops;
>  	host->map_irq = of_irq_parse_and_map_pci;

Acked-by: Ryder Lee <ryder.lee@mediatek.com>

