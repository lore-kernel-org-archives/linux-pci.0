Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60796 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbbJ0VMe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 27 Oct 2015 17:12:34 -0400
Date: Tue, 27 Oct 2015 16:12:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, jingoohan1@gmail.com,
	pratyush.anand@gmail.com, Arnd Bergmann <arnd@arndb.de>,
	linux@arm.linux.org.uk, thomas.petazzoni@free-electrons.com,
	gabriele.paoloni@huawei.com, lorenzo.pieralisi@arm.com,
	james.morse@arm.com, Liviu.Dudau@arm.com, jason@lakedaemon.net,
	robh@kernel.org, gabriel.fernandez@linaro.org,
	Minghuan.Lian@freescale.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangjukuo@huawei.com,
	qiuzhenfa@hisilicon.com, liudongdong3@huawei.com,
	qiujiang@huawei.com, xuwei5@hisilicon.com, liguozhu@hisilicon.com,
	Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH v12 2/8] ARM/PCI: remove align_resource in pci_sys_data
Message-ID: <20151027211229.GA27474@localhost>
References: <1445859350-26375-1-git-send-email-wangzhou1@hisilicon.com>
 <1445859350-26375-3-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445859350-26375-3-git-send-email-wangzhou1@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Russell]

On Mon, Oct 26, 2015 at 07:35:44PM +0800, Zhou Wang wrote:
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

It's not ideal to have the global function pointer.  Adding a pointer
to struct pci_ops would be another alternative, but I don't know that
this is worth that since there's only one user.

I added Russell just so he's aware; he merged 029baf14a027 ("ARM:
7683/1: pci: add a align_resource hook"), which added
pci_sys_data->align_resource in the first place.

I added some background to the changelog in the process of reviewing
this.

commit 7685ae4693bcd7b2fc02b1e0b957860b1638d31e
Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Date:   Mon Oct 26 19:35:44 2015 +0800

    ARM/PCI: Replace pci_sys_data->align_resource with global function pointer
    
    dw_pcie_host_init() creates the PCI host bridge with pci_common_init_dev(),
    an ARM-specific function that supplies the ARM-specific pci_sys_data
    structure as the PCI "sysdata".  To use dw_pcie_host_init() on other
    architectures, we will copy the internals of pci_common_init_dev() into
    pcie-designware.c instead of calling it, and dw_pcie_host_init() will
    supply the DesignWare pcie_port structure as "sysdata".
    
    Most ARM "sysdata" users are specific to non-DesignWare host bridges;
    they'll be unaffected because those bridges will continue to have the ARM
    pci_sys_data.  Most of the rest are ARM-generic functions called by
    pci_common_init_dev(); these will be unaffected because dw_pcie_host_init()
    will no longer call pci_common_init().
    
    But the ARM pcibios_align_resource() can be called by the PCI core for any
    bridge, so it can't depend on sysdata since it may be either pci_sys_data
    or pcie_port.
    
    Remove the pcibios_align_resource() dependency on sysdata by replacing the
    pci_sys_data->align_resource pointer with a global function pointer.
    
    This is less general (we can no longer have per-host bridge
    align_resource() methods), but the pci_sys_data->align_resource pointer was
    used only by Marvell (see mvebu_pcie_enable()), so this would only be a
    problem if we had a system with a combination of Marvell and other host
    bridges
    
    [bhelgaas: changelog]
    Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
    Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 8857d28..0070e85 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -52,12 +52,6 @@ struct pci_sys_data {
 	u8		(*swizzle)(struct pci_dev *, u8 *);
 					/* IRQ mapping				*/
 	int		(*map_irq)(const struct pci_dev *, u8, u8);
-					/* Resource alignement requirements	*/
-	resource_size_t (*align_resource)(struct pci_dev *dev,
-					  const struct resource *res,
-					  resource_size_t start,
-					  resource_size_t size,
-					  resource_size_t align);
 	void		*private_data;	/* platform controller private data	*/
 };
 
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 874e182..6551d28 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -17,6 +17,11 @@
 #include <asm/mach/pci.h>
 
 static int debug_pci;
+static resource_size_t (*align_resource)(struct pci_dev *dev,
+		  const struct resource *res,
+		  resource_size_t start,
+		  resource_size_t size,
+		  resource_size_t align) = NULL;
 
 /*
  * We can't use pci_get_device() here since we are
@@ -456,7 +461,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
-		sys->align_resource = hw->align_resource;
+		align_resource = hw->align_resource;
 		INIT_LIST_HEAD(&sys->resources);
 
 		if (hw->private_data)
@@ -572,7 +577,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
-	struct pci_sys_data *sys = dev->sysdata;
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
@@ -580,8 +584,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	start = (start + align - 1) & ~(align - 1);
 
-	if (sys->align_resource)
-		return sys->align_resource(dev, res, start, size, align);
+	if (align_resource)
+		return align_resource(dev, res, start, size, align);
 
 	return start;
 }


> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
> ---
>  arch/arm/include/asm/mach/pci.h |  6 ------
>  arch/arm/kernel/bios32.c        | 12 ++++++++----
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 8857d28..0070e85 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -52,12 +52,6 @@ struct pci_sys_data {
>  	u8		(*swizzle)(struct pci_dev *, u8 *);
>  					/* IRQ mapping				*/
>  	int		(*map_irq)(const struct pci_dev *, u8, u8);
> -					/* Resource alignement requirements	*/
> -	resource_size_t (*align_resource)(struct pci_dev *dev,
> -					  const struct resource *res,
> -					  resource_size_t start,
> -					  resource_size_t size,
> -					  resource_size_t align);
>  	void		*private_data;	/* platform controller private data	*/
>  };
>  
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 874e182..6551d28 100644
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
>  /*
>   * We can't use pci_get_device() here since we are
> @@ -456,7 +461,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  		sys->busnr   = busnr;
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
> -		sys->align_resource = hw->align_resource;
> +		align_resource = hw->align_resource;
>  		INIT_LIST_HEAD(&sys->resources);
>  
>  		if (hw->private_data)
> @@ -572,7 +577,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				resource_size_t size, resource_size_t align)
>  {
>  	struct pci_dev *dev = data;
> -	struct pci_sys_data *sys = dev->sysdata;
>  	resource_size_t start = res->start;
>  
>  	if (res->flags & IORESOURCE_IO && start & 0x300)
> @@ -580,8 +584,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
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
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
