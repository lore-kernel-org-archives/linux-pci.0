Return-Path: <SRS0=gDpg=OJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E206EC04EB8
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 11:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BDA2146D
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 11:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BDA2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeK3WJq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:09:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54424 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeK3WJq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Nov 2018 17:09:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40E6E80D;
        Fri, 30 Nov 2018 03:00:52 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 702F03F59C;
        Fri, 30 Nov 2018 03:00:50 -0800 (PST)
Date:   Fri, 30 Nov 2018 11:00:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     honghui.zhang@mediatek.com
Cc:     bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        devicetree@vger.kernel.org, youlin.pei@mediatek.com,
        jianjun.wang@mediatek.com
Subject: Re: [PATCH v3] PCI: mediatek: Use
 devm_of_pci_get_host_bridge_resources() to parse DT
Message-ID: <20181130102829.GA16394@e107981-ln.cambridge.arm.com>
References: <1543548780-3912-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543548780-3912-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 30, 2018 at 11:33:00AM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Use the devm_of_pci_get_host_bridge_resources() API in place of the PCI OF
> DT parser.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 101 +++++++++------------------------
>  1 file changed, 27 insertions(+), 74 deletions(-)

Applied to pci/mediatek for v4.21, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 2a1f97c..6917aec 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -197,29 +197,20 @@ struct mtk_pcie_port {
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
> + * @busnr: root bus number
>   */
>  struct mtk_pcie {
>  	struct device *dev;
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
> +	unsigned int busnr;
>  };
>  
>  static void mtk_pcie_subsys_powerdown(struct mtk_pcie *pcie)
> @@ -1045,55 +1036,43 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
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
> +			pcie->busnr = win->res->start;
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
> @@ -1125,28 +1104,6 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
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
> @@ -1169,11 +1126,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	err = mtk_pcie_request_resources(pcie);
> -	if (err)
> -		goto put_resources;
> -
> -	host->busnr = pcie->busn.start;
> +	host->busnr = pcie->busnr;
>  	host->dev.parent = pcie->dev;
>  	host->ops = pcie->soc->ops;
>  	host->map_irq = of_irq_parse_and_map_pci;
> -- 
> 2.6.4
> 
