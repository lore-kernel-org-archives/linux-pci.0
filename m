Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39157 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964911AbcDYVBL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Apr 2016 17:01:11 -0400
Date: Mon, 25 Apr 2016 16:01:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [PATCH v11 02/60] alpha/PCI: Only check iomem_is_exclusive() for
 IORESOURCE_MEM, not IORESOURCE_IO
Message-ID: <20160425210106.GD1759@localhost>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
 <1460074573-7481-3-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460074573-7481-3-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 07, 2016 at 05:15:15PM -0700, Yinghai Lu wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The alpha pci_mmap_resource() is used for both IORESOURCE_MEM and
> IORESOURCE_IO resources, but iomem_is_exclusive() is only applicable for
> IORESOURCE_MEM.
> 
> Call iomem_is_exclusive() only for IORESOURCE_MEM resources, and do it
> earlier to match the generic version of pci_mmap_resource().
> 
> Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

I applied these first two patches to pci/resource for v4.7.

> ---
>  arch/alpha/kernel/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
> index 99e8d47..92c0d46 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -77,10 +77,10 @@ static int pci_mmap_resource(struct kobject *kobj,
>  	if (i >= PCI_ROM_RESOURCE)
>  		return -ENODEV;
>  
> -	if (!__pci_mmap_fits(pdev, i, vma, sparse))
> +	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
>  		return -EINVAL;
>  
> -	if (iomem_is_exclusive(res->start))
> +	if (!__pci_mmap_fits(pdev, i, vma, sparse))
>  		return -EINVAL;
>  
>  	pcibios_resource_to_bus(pdev->bus, &bar, res);
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
