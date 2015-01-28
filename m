Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:43478 "EHLO
	userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbbA2B1X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jan 2015 20:27:23 -0500
Message-ID: <54C94F0E.5020901@oracle.com>
Date: Wed, 28 Jan 2015 16:05:18 -0500
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>
CC: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	David Vrabel <david.vrabel@citrix.com>,
	xen-devel@lists.xenproject.org, yinghai@kernel.org
Subject: Re: [Xen-devel] [PATCH v2] PCI: Add guard to avoid mapping a invalid
 msix base address
References: <1422409937-1875-1-git-send-email-wangyijing@huawei.com> <20150128181358.GA17623@google.com>
In-Reply-To: <20150128181358.GA17623@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/28/2015 01:13 PM, Bjorn Helgaas wrote:
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index fd60806..c3e7dfc 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -694,11 +694,16 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
>   {
>   	resource_size_t phys_addr;
>   	u32 table_offset;
> +	unsigned long flags;
>   	u8 bir;
>   
>   	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
>   			      &table_offset);
>   	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
> +	flags = pci_resource_flags(dev, bir);
> +	if (!flags || (flags & IORESOURCE_UNSET))
> +		return NULL;
> Thanks, this looks better.
>
> There's similar code in xen_initdom_setup_msi_irqs() that looks like it
> might require a similar fix.

Right, I think it does.

One question: do we need to check flags for IORESOURCE_DISABLED as well? 
Currently IORESOURCE_DISABLED and IORESOURCE_UNSET are set together for 
PCI so it probably doesn't matter right now but if this changes we won't 
want to use BAR that's disabled, will we?


-boris


