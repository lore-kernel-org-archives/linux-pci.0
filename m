Return-Path: <SRS0=5WU8=EO=linux-mips.org=ladis@kernel.org>
Return-Path: <SRS0=5WU8=EO=linux-mips.org=ladis@kernel.org>
Date: Fri, 19 Jan 2018 10:58:57 +0100
Sender: Ladislav Michl <ladis@linux-mips.org>
From: Ladislav Michl <ladis@linux-mips.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dra7xx: Fix potential NULL dereference
Message-ID: <20180119095857.GA26765@lenoch>
References: <1516284037-81537-1-git-send-email-weiyongjun1@huawei.com>
 <20180118145420.GA21163@lenoch>
 <20180118183525.GG53542@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180118183525.GG53542@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 18, 2018 at 12:35:25PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 18, 2018 at 03:54:20PM +0100, Ladislav Michl wrote:
> > On Thu, Jan 18, 2018 at 02:00:37PM +0000, Wei Yongjun wrote:
> > > platform_get_resource_byname() may fail and return NULL, so we should
> > > better check it's return value to avoid a NULL pointer dereference a
> > > bit later in the code.
> > > 
> > > This is detected by Coccinelle semantic patch.
> > > 
> > > @@
> > > expression pdev, res, n, t, e, e1, e2;
> > > @@
> > > 
> > > res = platform_get_resource_byname(pdev, t, n);
> > > + if (!res)
> > > +   return -EINVAL;
> > > ... when != res == NULL
> > > e = devm_ioremap(e1, res->start, e2);
> > 
> > Well, then it should be replaced with devm_ioremap_resource()
> > which already checks for NULL and the right resource type
> > (IORESOURCE_MEM).
> 
> That's probably a better idea.  Maybe we should add a comment like this
> to help avoid this in the future:

That seems to spot another a bit more serious problem (given how late
release cycle is now).

Both devm_ioremap() and devm_ioremap_resource() shares the same release
function: devm_ioremap_release(). However this function is not aware of
memory region previously requested by devm_request_mem_region() called
from devm_ioremap_resource().

Bellow is just a quick hack, even untested as looking at devm_ioremap,
devm_ioremap_wc and devm_ioremap_wc, there is some room for optimization.

diff --git a/lib/devres.c b/lib/devres.c
index 5f2aedd58bc5..6315b07a608f 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -10,6 +10,15 @@ void devm_ioremap_release(struct device *dev, void *res)
 	iounmap(*(void __iomem **)res);
 }
 
+void devm_ioremap_release_region(struct device *dev, void *res)
+{
+	resource_size_t offset = ((struct resource *)res)->start;
+	resource_size_t size = resource_size((struct resource *)res);
+
+	iounmap(*(void __iomem **)res);
+	devm_release_mem_region(dev, offset, size);
+}
+
 static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
 {
 	return *(void **)res == match_data;
@@ -136,7 +145,7 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 {
 	resource_size_t size;
 	const char *name;
-	void __iomem *dest_ptr;
+	void __iomem *addr, **ptr;
 
 	BUG_ON(!dev);
 
@@ -153,14 +162,25 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 		return IOMEM_ERR_PTR(-EBUSY);
 	}
 
-	dest_ptr = devm_ioremap(dev, res->start, size);
-	if (!dest_ptr) {
+	ptr = devres_alloc(devm_ioremap_release_region, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr) {
+		dev_err(dev, "malloc failed for resource %pR\n", res);
+		devm_release_mem_region(dev, res->start, size);
+		return IOMEM_ERR_PTR(-ENOMEM);
+	}
+
+	addr = ioremap(res->start, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else {
 		dev_err(dev, "ioremap failed for resource %pR\n", res);
 		devm_release_mem_region(dev, res->start, size);
-		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
+		devres_free(ptr);
+		addr = IOMEM_ERR_PTR(-ENOMEM);
 	}
 
-	return dest_ptr;
+	return addr;
 }
 EXPORT_SYMBOL(devm_ioremap_resource);
 

> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -22,6 +22,8 @@ static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
>   * @size: Size of map
>   *
>   * Managed ioremap().  Map is automatically unmapped on driver detach.
> + *
> + * When possible, use devm_ioremap_resource() instead.
>   */
>  void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>  			   resource_size_t size)
> 
> > > Fixes: 608793e27b33 ("PCI: dwc: dra7xx: Add EP mode support")
> > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > > ---
> > >  drivers/pci/dwc/pci-dra7xx.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> > > index 8bf7c27..aafded8 100644
> > > --- a/drivers/pci/dwc/pci-dra7xx.c
> > > +++ b/drivers/pci/dwc/pci-dra7xx.c
> > > @@ -409,11 +409,15 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
> > >  	ep->ops = &pcie_ep_ops;
> > >  
> > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
> > > +	if (!res)
> > > +		return -EINVAL;
> > >  	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
> > >  	if (!pci->dbi_base)
> > >  		return -ENOMEM;
> > >  
> > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
> > > +	if (!res)
> > > +		return -EINVAL;
> > >  	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
> > >  	if (!pci->dbi_base2)
> > >  		return -ENOMEM;
> > > @@ -462,6 +466,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
> > >  		return ret;
> > >  
> > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
> > > +	if (!res)
> > > +		return -EINVAL;
> > >  	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
> > >  	if (!pci->dbi_base)
> > >  		return -ENOMEM;
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
