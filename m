Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:5354 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbHGGHB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Aug 2015 02:07:01 -0400
Message-ID: <55C44AF2.8040807@hisilicon.com>
Date: Fri, 7 Aug 2015 14:06:42 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, <linux@arm.linux.org.uk>,
	<thomas.petazzoni@free-electrons.com>,
	<gabriele.paoloni@huawei.com>, <lorenzo.pieralisi@arm.com>,
	James Morse <james.morse@arm.com>, <Liviu.Dudau@arm.com>,
	Jason Cooper <jason@lakedaemon.net>, <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liudongdong3@huawei.com>,
	<qiujiang@huawei.com>, <kangfenglong@huawei.com>,
	<xuwei5@hisilicon.com>, <liguozhu@hisilicon.com>,
	Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v6 2/6] ARM/PCI: remove align_resource in pci_sys_data
References: <1438848559-232109-1-git-send-email-wangzhou1@hisilicon.com> <1438848559-232109-3-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1438848559-232109-3-git-send-email-wangzhou1@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc jingoohan1@gmail.com]

On 2015/8/6 16:09, Zhou Wang wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> This patch is needed in order to unify the PCIe designware framework for ARM and
> ARM64 architectures. In the PCIe designware unification process we are calling
> pci_create_root_bus() passing a "sysdata" parameter that is the same for both
> ARM and ARM64 and is of type "struct pcie_port*". In the ARM case this will
> cause a problem with the function pcibios_align_resource(); in fact this will
> cast "dev->sysdata" to "struct pci_sys_data*", whereas designware had passed a
> "struct pcie_port*" pointer.
> 
> This patch solves the issue by removing "align_resource" from "pci_sys_data"
> struct and defining a static global function pointer in "bios32.c"
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  arch/arm/include/asm/mach/pci.h |  5 -----
>  arch/arm/kernel/bios32.c        | 12 ++++++++----
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 28b9bb3..8a4e4de 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -58,11 +58,6 @@ struct pci_sys_data {
>  					/* IRQ mapping				*/
>  	int		(*map_irq)(const struct pci_dev *, u8, u8);
>  					/* Resource alignement requirements	*/
> -	resource_size_t (*align_resource)(struct pci_dev *dev,
> -					  const struct resource *res,
> -					  resource_size_t start,
> -					  resource_size_t size,
> -					  resource_size_t align);
>  	void		*private_data;	/* platform controller private data	*/
>  };
>  
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index fcbbbb1..4cdc64d 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -17,6 +17,11 @@
>  #include <asm/mach/pci.h>
>  
>  static int debug_pci;
> +static resource_size_t (*align_resource)(struct pci_dev *dev,
> +		  const struct resource *res,
> +		  resource_size_t start,
> +		  resource_size_t size,
> +		  resource_size_t align) = NULL;
>  
>  #ifdef CONFIG_PCI_MSI
>  struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
> @@ -468,7 +473,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  		sys->busnr   = busnr;
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
> -		sys->align_resource = hw->align_resource;
> +		align_resource = hw->align_resource;
>  		INIT_LIST_HEAD(&sys->resources);
>  
>  		if (hw->private_data)
> @@ -589,7 +594,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				resource_size_t size, resource_size_t align)
>  {
>  	struct pci_dev *dev = data;
> -	struct pci_sys_data *sys = dev->sysdata;
>  	resource_size_t start = res->start;
>  
>  	if (res->flags & IORESOURCE_IO && start & 0x300)
> @@ -597,8 +601,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  
>  	start = (start + align - 1) & ~(align - 1);
>  
> -	if (sys->align_resource)
> -		return sys->align_resource(dev, res, start, size, align);
> +	if (align_resource)
> +		return align_resource(dev, res, start, size, align);
>  
>  	return start;
>  }
> 


