Return-Path: <SRS0=PiGp=3F=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=PiGp=3F=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 28 Mar 2017 15:50:03 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	John Garry <john.garry@huawei.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Jon Mason <jonmason@broadcom.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v2 08/22] lib: implement Devres ioremap_nopost() interface
Message-ID: <20170328145003.GB18046@red-moon>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-9-lorenzo.pieralisi@arm.com>
 <20170328014129.GJ25380@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170328014129.GJ25380@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 27, 2017 at 08:41:29PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 27, 2017 at 10:49:36AM +0100, Lorenzo Pieralisi wrote:
> > The introduction of the ioremap_nopost() interface allows
> > kernel drivers to map memory through a dedicated kernel
> > interface providing non-posted writes semantics.
> > 
> > Introduce two new functions in the Devres kernel layer and Devres
> > documentation:
> > 
> > - devm_ioremap_nopost()
> > - devm_ioremap_nopost_resource()
> > 
> > so that drivers can make use of devm_* interface to map memory
> > regions requiring non-posted writes memory attributes.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > ---
> >  Documentation/driver-model/devres.txt |  3 ++
> >  include/linux/device.h                |  2 +
> >  include/linux/io.h                    |  2 +
> >  lib/devres.c                          | 78 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 85 insertions(+)
> > 
> > diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> > index bf34d5b..9991a66 100644
> > --- a/Documentation/driver-model/devres.txt
> > +++ b/Documentation/driver-model/devres.txt
> > @@ -294,7 +294,10 @@ IOMAP
> >    devm_ioremap()
> >    devm_ioremap_nocache()
> >    devm_ioremap_wc()
> > +  devm_ioremap_nopost()
> >    devm_ioremap_resource() : checks resource, requests memory region, ioremaps
> > +  devm_ioremap_nopost_resource() : do devm_ioremap_resource() with nopost
> > +				   memory attributes
> >    devm_iounmap()
> >    pcim_iomap()
> >    pcim_iomap_regions()	: do request_region() and iomap() on multiple BARs
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 9ef518a..1dce865 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -689,6 +689,8 @@ extern unsigned long devm_get_free_pages(struct device *dev,
> >  extern void devm_free_pages(struct device *dev, unsigned long addr);
> >  
> >  void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
> > +void __iomem *devm_ioremap_nopost_resource(struct device *dev,
> > +					   struct resource *res);
> >  
> >  /* allows to add/remove a custom action to devres stack */
> >  int devm_add_action(struct device *dev, void (*action)(void *), void *data);
> > diff --git a/include/linux/io.h b/include/linux/io.h
> > index 82ef36e..e34d799 100644
> > --- a/include/linux/io.h
> > +++ b/include/linux/io.h
> > @@ -79,6 +79,8 @@ void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
> >  				   resource_size_t size);
> >  void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
> >  				   resource_size_t size);
> > +void __iomem *devm_ioremap_nopost(struct device *dev, resource_size_t offset,
> > +				   resource_size_t size);
> >  void devm_iounmap(struct device *dev, void __iomem *addr);
> >  int check_signature(const volatile void __iomem *io_addr,
> >  			const unsigned char *signature, int length);
> > diff --git a/lib/devres.c b/lib/devres.c
> > index cb1464c..4e05660 100644
> > --- a/lib/devres.c
> > +++ b/lib/devres.c
> > @@ -100,6 +100,34 @@ void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
> >  EXPORT_SYMBOL(devm_ioremap_wc);
> >  
> >  /**
> > + * devm_ioremap_nopost - Managed ioremap_nopost()
> > + * @dev: Generic device to remap IO address for
> > + * @offset: BUS offset to map
> 
> I know this comment was just copied from other devm_ioremap*()
> interfaces, but I think it's slightly misleading to call this the "BUS
> offset".  That suggests this is a bus address, but it is not.  Maybe
> it should be "resource address" or similar?
> 
> I propose a separate patch to update the existing comments, followed
> by this patch to add this new one.

I agree with you, maybe Tejun has more context on why that parameter
is called BUS offset ? Anyway, I can easily do what you suggest above,
just asking Tejun if there is something I am missing.

Tejun ?

Thanks !
Lorenzo

> 
> > + * @size: Size of map
> > + *
> > + * Managed ioremap_nopost().  Map is automatically unmapped on driver detach.
> > + */
> > +void __iomem *devm_ioremap_nopost(struct device *dev, resource_size_t offset,
> > +			      resource_size_t size)
> > +{
> > +	void __iomem **ptr, *addr;
> > +
> > +	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
> > +	if (!ptr)
> > +		return NULL;
> > +
> > +	addr = ioremap_nopost(offset, size);
> > +	if (addr) {
> > +		*ptr = addr;
> > +		devres_add(dev, ptr);
> > +	} else
> > +		devres_free(ptr);
> > +
> > +	return addr;
> > +}
> > +EXPORT_SYMBOL(devm_ioremap_nopost);
> > +
> > +/**
> >   * devm_iounmap - Managed iounmap()
> >   * @dev: Generic device to unmap for
> >   * @addr: Address to unmap
> > @@ -163,6 +191,56 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
> >  }
> >  EXPORT_SYMBOL(devm_ioremap_resource);
> >  
> > +/**
> > + * devm_ioremap_nopost_resource() - devm_ioremap_resource() nopost version
> > + * @dev: generic device to handle the resource for
> > + * @res: resource to be handled
> > + *
> > + * Checks that a resource is a valid memory region, requests the memory
> > + * region and ioremaps it with ioremap_nopost() interface.
> > + * All operations are managed and will be undone on driver detach.
> > + *
> > + * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
> > + * on failure. Usage example:
> > + *
> > + *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > + *	base = devm_ioremap_nopost_resource(&pdev->dev, res);
> > + *	if (IS_ERR(base))
> > + *		return PTR_ERR(base);
> > + */
> > +void __iomem *devm_ioremap_nopost_resource(struct device *dev,
> > +					   struct resource *res)
> > +{
> > +	resource_size_t size;
> > +	const char *name;
> > +	void __iomem *dest_ptr;
> > +
> > +	BUG_ON(!dev);
> > +
> > +	if (!res || resource_type(res) != IORESOURCE_MEM) {
> > +		dev_err(dev, "invalid resource\n");
> > +		return IOMEM_ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	size = resource_size(res);
> > +	name = res->name ?: dev_name(dev);
> > +
> > +	if (!devm_request_mem_region(dev, res->start, size, name)) {
> > +		dev_err(dev, "can't request region for resource %pR\n", res);
> > +		return IOMEM_ERR_PTR(-EBUSY);
> > +	}
> > +
> > +	dest_ptr = devm_ioremap_nopost(dev, res->start, size);
> > +	if (!dest_ptr) {
> > +		dev_err(dev, "ioremap failed for resource %pR\n", res);
> > +		devm_release_mem_region(dev, res->start, size);
> > +		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	return dest_ptr;
> > +}
> > +EXPORT_SYMBOL(devm_ioremap_nopost_resource);
> > +
> >  #ifdef CONFIG_HAS_IOPORT_MAP
> >  /*
> >   * Generic iomap devres
> > -- 
> > 2.10.0
> > 
