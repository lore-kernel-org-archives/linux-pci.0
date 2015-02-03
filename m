Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:3833 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933302AbbBCB3a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 20:29:30 -0500
Message-ID: <54D02465.2040800@huawei.com>
Date: Tue, 3 Feb 2015 09:29:09 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <boris.ostrovsky@oracle.com>,
	<yinghai@kernel.org>, <xen-devel@lists.xenproject.org>,
	<konrad.wilk@oracle.com>, <david.vrabel@citrix.com>,
	<alex.williamson@redhat.com>, <kvm@vger.kernel.org>,
	Jan Beulich <JBeulich@suse.com>
Subject: Re: [PATCH v3] PCI: Add guard to avoid mapping a invalid msix base
 address
References: <1422503683-19709-1-git-send-email-wangyijing@huawei.com> <20150202210626.GC5176@google.com>
In-Reply-To: <20150202210626.GC5176@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> I applied this to pci/msi for v3.20, thanks!  I reworked the changelog as
> follows; let me know if it still doesn't make things clear:
> 

It's more clear, thanks for your improvement very much!

Thanks!
Yijing.

> 
> commit 6a878e5085fe97bd1e222b7883a1b815fcbbe4ed
> Author: Yijing Wang <wangyijing@huawei.com>
> Date:   Wed Jan 28 09:52:17 2015 +0800
> 
>     PCI: Fail MSI-X mappings if there's no space assigned to MSI-X BAR
>     
>     Unlike MSI, which is configured via registers in the MSI capability in
>     Configuration Space, MSI-X is configured via tables in Memory Space.
>     These MSI-X tables are mapped by a device BAR, and if no Memory Space
>     has been assigned to the BAR, MSI-X cannot be used.
>     
>     Fail MSI-X setup if no space has been assigned for the BAR.
>     
>     Previously, we ioremapped the MSI-X table even if the resource hadn't been
>     assigned.  In this case, the resource address is undefined (and is often
>     zero), which may lead to warnings or oopses in this path:
>     
>       pci_enable_msix
>         msix_capability_init
>           msix_map_region
>             ioremap_nocache
>     
>     The PCI core sets resource flags to zero when it can't assign space for the
>     resource (see reset_resource()).  There are also some cases where it sets
>     the IORESOURCE_UNSET flag, e.g., pci_reassigndev_resource_alignment(),
>     pci_assign_resource(), etc.  So we must check for both cases.
>     
>     [bhelgaas: changelog]
>     Reported-by: Zhang Jukuo <zhangjukuo@huawei.com>
>     Tested-by: Zhang Jukuo <zhangjukuo@huawei.com>
>     Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index c489ef2c1a39..34fc4189ebf0 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -298,12 +298,16 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  			map_irq.entry_nr = nvec;
>  		} else if (type == PCI_CAP_ID_MSIX) {
>  			int pos;
> +			unsigned long flags;
>  			u32 table_offset, bir;
>  
>  			pos = dev->msix_cap;
>  			pci_read_config_dword(dev, pos + PCI_MSIX_TABLE,
>  					      &table_offset);
>  			bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
> +			flags = pci_resource_flags(dev, bir);
> +			if (!flags || (flags & IORESOURCE_UNSET))
> +				return -EINVAL;
>  
>  			map_irq.table_base = pci_resource_start(dev, bir);
>  			map_irq.entry_nr = msidesc->msi_attrib.entry_nr;
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index fd60806d3fd0..c3e7dfcf9ff5 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -694,11 +694,16 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
>  {
>  	resource_size_t phys_addr;
>  	u32 table_offset;
> +	unsigned long flags;
>  	u8 bir;
>  
>  	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
>  			      &table_offset);
>  	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
> +	flags = pci_resource_flags(dev, bir);
> +	if (!flags || (flags & IORESOURCE_UNSET))
> +		return NULL;
> +
>  	table_offset &= PCI_MSIX_TABLE_OFFSET;
>  	phys_addr = pci_resource_start(dev, bir) + table_offset;
>  
> 
> .
> 


-- 
Thanks!
Yijing

