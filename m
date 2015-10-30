Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59740 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbbJ3BzP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 21:55:15 -0400
Subject: Re: [PATCH v4 4/7] PCI: Add fwnode_handle to pci_sysdata
To: jakeo@microsoft.com, gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@redhat.com, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
 <1446162376-43419-5-git-send-email-jakeo@microsoft.com>
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <5632CDF5.1000402@linux.intel.com>
Date: Fri, 30 Oct 2015 09:55:01 +0800
MIME-Version: 1.0
In-Reply-To: <1446162376-43419-5-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2015/10/30 7:46, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This patch adds an fwnode_handle to struct pci_sysdata, which is
> used by the next patch in the series when trying to locate an
> IRQ domain associated with a root PCI bus.
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> ---
>  arch/x86/include/asm/pci.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 4625943..10213a1 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -20,6 +20,9 @@ struct pci_sysdata {
>  #ifdef CONFIG_X86_64
>  	void		*iommu;		/* IOMMU private data */
>  #endif
> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> +	void		*fwnode;	/* IRQ domain for MSI assignment */
> +#endif
>  };
>  
>  extern int pci_routeirq;
> @@ -41,6 +44,14 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  }
>  #endif
>  
> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> +static inline void *pci_fwnode(struct pci_bus *bus)
> +{
> +	struct pci_sysdata *sd = bus->sysdata;
> +	return sd->fwnode;
> +}
> +#endif
Hi Jakeo,
	I would be better that if the function name indicates
that we are getting PCI host bridge(root bus) firmware node.
And you also need some magic here to avoid breaking compilation
on other archs:
in arch/x86/include/asm/pci.h
#define pci_fwnode		pci_fwnode

in include/asm-generic/pci.h
#ifndef pci_fwnode
#define pci_fwnode(bus)         ((void)(bus),NULL)
#endif

Thanks,
Gerry
> +
>  /* Can be used to override the logic in pci_scan_bus for skipping
>     already-configured bus numbers - to be used for buggy BIOSes
>     or architectures with incomplete PCI setup by the loader */
> 
