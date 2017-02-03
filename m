Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752245AbdBCUpe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 15:45:34 -0500
Date: Fri, 3 Feb 2017 14:45:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com, Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 3/3] PCI: generic: Fix the bug of pci_fixup_irqs() for
 arm64 platform.
Message-ID: <20170203204530.GH10291@bhelgaas-glaptop.roam.corp.google.com>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
 <1484202504-96686-4-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484202504-96686-4-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Tomasz, Lorenzo]

On Thu, Jan 12, 2017 at 02:28:24PM +0800, Dongdong Liu wrote:
> arch/arm64/pci.c pcibios_alloc_irq() has the same function as
> pci_fixup_irqs(), so we add condition #ifndef CONFIG_ARM64 for
> pci_fixup_irqs().
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/pci/host/pci-host-common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
> index e3c48b5..f160afc 100644
> --- a/drivers/pci/host/pci-host-common.c
> +++ b/drivers/pci/host/pci-host-common.c
> @@ -145,7 +145,9 @@ int pci_host_common_probe(struct platform_device *pdev,
>  		return -ENODEV;
>  	}
>  
> +#ifndef CONFIG_ARM64
>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +#endif

d8ed75d59332 ("ARM64: PCI: ACPI support for legacy IRQs parsing and
consolidation with DT code") added pcibios_alloc_irq() for arm64.

arm64 is the only arch that implements pcibios_alloc_irq().  And now
you want to add an ifdef here so arm64 is the only arch that doesn't
call pci_fixup_irqs().

I don't remember the details of why arm64 is so special here.
Obviously we'd prefer not to have the ifdef and not to have the
arm64-specific pcibios_alloc_irq().

>  	/*
>  	 * We insert PCI resources into the iomem_resource and
> -- 
> 1.9.1
> 
