Return-Path: <SRS0=w8ZT=EN=linux-mips.org=ladis@kernel.org>
Return-Path: <SRS0=w8ZT=EN=linux-mips.org=ladis@kernel.org>
Date: Thu, 18 Jan 2018 22:34:17 +0100
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
Message-ID: <20180118213417.GA30723@lenoch>
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
> 
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

Yes, please. It would be nice first patch in the serie converting existing
users of devm_ioremap into devm_ioremap_resource:
find drivers -name "*.c" | xargs grep "devm_ioremap(" | grep resource_size | wc -l
82
I know, that was dumb, Coccinelle would certainly do better job.
And from a quick look a lot of
if (!res) {
	print error
	return -EINVAL;
}
code blocks could be deleted (and many cases where check for NULL resource
is missing fixed).

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
