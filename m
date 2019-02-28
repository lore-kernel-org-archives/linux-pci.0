Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1093C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 19:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8359218CD
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 19:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfB1TOZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:14:25 -0500
Received: from ns.lynxeye.de ([87.118.118.114]:45767 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726093AbfB1TOY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Feb 2019 14:14:24 -0500
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Feb 2019 14:14:24 EST
Received: by lynxeye.de (Postfix, from userid 501)
        id 2F7A3E7421F; Thu, 28 Feb 2019 20:04:16 +0100 (CET)
Received: from antimon (unknown [46.183.103.8])
        by lynxeye.de (Postfix) with ESMTPSA id 3042BE74214;
        Thu, 28 Feb 2019 20:02:55 +0100 (CET)
Message-ID: <247102e57e067d1477f3260bdeaa3ea011d0f3ed.camel@lynxeye.de>
Subject: Re: [PATCH] PCI: tegra: Do not allocate MSI target memory
From:   Lucas Stach <dev@lynxeye.de>
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, treding@nvidia.com, swarren@nvidia.com,
        mperttunen@nvidia.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com
Date:   Thu, 28 Feb 2019 20:02:09 +0100
In-Reply-To: <1551366004-32547-1-git-send-email-vidyas@nvidia.com>
References: <1551366004-32547-1-git-send-email-vidyas@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, den 28.02.2019, 20:30 +0530 schrieb Vidya Sagar:
> The PCI host bridge found on Tegra SoCs doesn't require the MSI target
> address to be backed by physical system memory. Writes are intercepted
> within the controller and never make it to the memory pointed to.
> 
> Since no actual system memory is required, remove the allocation of a
> single page and hardcode the MSI target address with a special address
> on a per-SoC basis. Ideally this would be an address to an MMIO memory
> region (such as where the controller's register are located). However,
> those addresses don't work reliably across all Tegra generations. The
> only set of addresses that work consistently are those that point to
> external memory.
> 
> This is not ideal, since those addresses could technically be used for
> DMA and hence be confusing. However, the first page of external memory
> is unlikely to be used and special enough to avoid confusion.

So you are trading a slight memory waste of a single page against a
sporadic (and probably hard to debug) DMA failure if any device happens
to initiate DMA to the first page of physical memory? That does not
sound like a good deal...

Also why would the first page of external memory be unlikely to be
used?

Regards,
Lucas

> Original base patch was posted by Thierry Reding <treding@nvidia.com>
> ( http://patchwork.ozlabs.org/patch/848569/ )
> Current patch removes hardcoding of external RAM starting address instead
> gets it using memblock_start_of_DRAM() API
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index f4f53d092e00..b33de7c78425 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -23,6 +23,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/memblock.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
> @@ -231,9 +232,8 @@ struct tegra_msi {
>  	struct msi_controller chip;
>  	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>  	struct irq_domain *domain;
> -	unsigned long pages;
>  	struct mutex lock;
> -	u64 phys;
> +	phys_addr_t phys;
>  	int irq;
>  };
>  
> @@ -1548,9 +1548,7 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
>  		goto err;
>  	}
>  
> -	/* setup AFI/FPCI range */
> -	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> -	msi->phys = virt_to_phys((void *)msi->pages);
> +	msi->phys = memblock_start_of_DRAM();
>  	host->msi = &msi->chip;
>  
>  	return 0;
> @@ -1592,8 +1590,6 @@ static void tegra_pcie_msi_teardown(struct tegra_pcie *pcie)
>  	struct tegra_msi *msi = &pcie->msi;
>  	unsigned int i, irq;
>  
> -	free_pages(msi->pages, 0);
> -
>  	if (msi->irq > 0)
>  		free_irq(msi->irq, pcie);
>  

