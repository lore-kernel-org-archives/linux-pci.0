Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60609 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbbG1RnW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 13:43:22 -0400
Date: Tue, 28 Jul 2015 18:44:06 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
	James Morse <James.Morse@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"yuanzhichang@hisilicon.com" <yuanzhichang@hisilicon.com>,
	"zhudacai@hisilicon.com" <zhudacai@hisilicon.com>,
	"zhangjukuo@huawei.com" <zhangjukuo@huawei.com>,
	"qiuzhenfa@hisilicon.com" <qiuzhenfa@hisilicon.com>,
	"liudongdong3@huawei.com" <liudongdong3@huawei.com>,
	"qiujiang@huawei.com" <qiujiang@huawei.com>,
	"kangfenglong@huawei.com" <kangfenglong@huawei.com>,
	"liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
	linux@arm.linux.org.uk
Subject: Re: [PATCH v5 1/5] ARM/PCI: remove align_resource in pci_sys_data
Message-ID: <20150728174406.GB19909@red-moon>
References: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com>
 <1437794486-21134-2-git-send-email-wangzhou1@hisilicon.com>
 <55B72C7E.1020102@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B72C7E.1020102@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[CC'ing RMK]

On Tue, Jul 28, 2015 at 08:17:18AM +0100, Zhou Wang wrote:
> On 2015/7/25 11:21, Zhou Wang wrote:
> > From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > 
> > This patch is needed in order to unify the PCIe designware framework for ARM and
> > ARM64 architectures. In the PCIe designware unification process we are calling
> > pci_create_root_bus() passing a "sysdata" parameter that is the same for both
> > ARM and ARM64 and is of type "struct pcie_port*". In the ARM case this will
> > cause a problem with the function pcibios_align_resource(); in fact this will
> > cast "dev->sysdata" to "struct pci_sys_data*", whereas designware had passed a
> > "struct pcie_port*" pointer.
> > 
> > This patch solves the issue by removing "align_resource" from "pci_sys_data"
> > struct and defining a static global function pointer in "bios32.c"
> > 
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> 
> Hi Arnd and Rob,
> 
> What is your opinion about this patch? Gabriele adds a global pointer in bios32.c
> to store align_resource, so we could remove sys->align_resource in pcibios_align_resource.
> 
> As Lorenzo mentioned in v4 series, this is a temporary solution before moving
> align_resource to host bridge structure.
> 
> Any comments welcome.

The align_resource() pointer is just used in drivers/pci/host/pci-mvebu.c,
I would like the pci-mvebu.c maintainers to comment on this and test it, I
do not expect it to create any issue and might be a temporary solution to
make progress on ARM/ARM64 consolidation, it is a blocking point.

It would be good if Russell can have a look too, I do not see what
issue this can trigger given that is just used in:

drivers/pci/host/pci-mvebu.c

and a global pointer (not saying it is elegant, but it should work)
might be ok.

So yes, comments very welcome.

Thanks,
Lorenzo

> 
> Thanks,
> Zhou
> 
> > ---
> >  arch/arm/include/asm/mach/pci.h |  5 -----
> >  arch/arm/kernel/bios32.c        | 12 ++++++++----
> >  2 files changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> > index 28b9bb3..8a4e4de 100644
> > --- a/arch/arm/include/asm/mach/pci.h
> > +++ b/arch/arm/include/asm/mach/pci.h
> > @@ -58,11 +58,6 @@ struct pci_sys_data {
> >  					/* IRQ mapping				*/
> >  	int		(*map_irq)(const struct pci_dev *, u8, u8);
> >  					/* Resource alignement requirements	*/
> > -	resource_size_t (*align_resource)(struct pci_dev *dev,
> > -					  const struct resource *res,
> > -					  resource_size_t start,
> > -					  resource_size_t size,
> > -					  resource_size_t align);
> >  	void		*private_data;	/* platform controller private data	*/
> >  };
> >  
> > diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> > index fcbbbb1..4cdc64d 100644
> > --- a/arch/arm/kernel/bios32.c
> > +++ b/arch/arm/kernel/bios32.c
> > @@ -17,6 +17,11 @@
> >  #include <asm/mach/pci.h>
> >  
> >  static int debug_pci;
> > +static resource_size_t (*align_resource)(struct pci_dev *dev,
> > +		  const struct resource *res,
> > +		  resource_size_t start,
> > +		  resource_size_t size,
> > +		  resource_size_t align) = NULL;
> >  
> >  #ifdef CONFIG_PCI_MSI
> >  struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
> > @@ -468,7 +473,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
> >  		sys->busnr   = busnr;
> >  		sys->swizzle = hw->swizzle;
> >  		sys->map_irq = hw->map_irq;
> > -		sys->align_resource = hw->align_resource;
> > +		align_resource = hw->align_resource;
> >  		INIT_LIST_HEAD(&sys->resources);
> >  
> >  		if (hw->private_data)
> > @@ -589,7 +594,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >  				resource_size_t size, resource_size_t align)
> >  {
> >  	struct pci_dev *dev = data;
> > -	struct pci_sys_data *sys = dev->sysdata;
> >  	resource_size_t start = res->start;
> >  
> >  	if (res->flags & IORESOURCE_IO && start & 0x300)
> > @@ -597,8 +601,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >  
> >  	start = (start + align - 1) & ~(align - 1);
> >  
> > -	if (sys->align_resource)
> > -		return sys->align_resource(dev, res, start, size, align);
> > +	if (align_resource)
> > +		return align_resource(dev, res, start, size, align);
> >  
> >  	return start;
> >  }
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
