Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:55104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeHBJkq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2018 05:40:46 -0400
Date: Thu, 2 Aug 2018 00:50:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH 1/3] PCI: xilinx-nwl: Save error IRQ number in
 device_node private data
Message-ID: <20180802075051.GA17566@infradead.org>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-2-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533141889-19962-2-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> +#ifdef CONFIG_PCIEAER
> +	struct device_node *node = dev->of_node;
> +#endif
>  
>  	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
>  	if (!breg_val) {
> @@ -744,6 +747,9 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  			pcie->irq_misc);
>  		return err;
>  	}
> +#ifdef CONFIG_PCIEAER
> +	node->data =  &pcie->irq_misc;
> +#endif

Is there any good reason for these ifdefs?  Always assigning the node
data would seem harmless and much cleaner to me.
