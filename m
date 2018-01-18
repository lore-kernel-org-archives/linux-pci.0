Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756038AbeARSf1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jan 2018 13:35:27 -0500
Date: Thu, 18 Jan 2018 12:35:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dra7xx: Fix potential NULL dereference
Message-ID: <20180118183525.GG53542@bhelgaas-glaptop.roam.corp.google.com>
References: <1516284037-81537-1-git-send-email-weiyongjun1@huawei.com>
 <20180118145420.GA21163@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180118145420.GA21163@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 18, 2018 at 03:54:20PM +0100, Ladislav Michl wrote:
> On Thu, Jan 18, 2018 at 02:00:37PM +0000, Wei Yongjun wrote:
> > platform_get_resource_byname() may fail and return NULL, so we should
> > better check it's return value to avoid a NULL pointer dereference a
> > bit later in the code.
> > 
> > This is detected by Coccinelle semantic patch.
> > 
> > @@
> > expression pdev, res, n, t, e, e1, e2;
> > @@
> > 
> > res = platform_get_resource_byname(pdev, t, n);
> > + if (!res)
> > +   return -EINVAL;
> > ... when != res == NULL
> > e = devm_ioremap(e1, res->start, e2);
> 
> Well, then it should be replaced with devm_ioremap_resource()
> which already checks for NULL and the right resource type
> (IORESOURCE_MEM).

That's probably a better idea.  Maybe we should add a comment like this
to help avoid this in the future:

--- a/lib/devres.c
+++ b/lib/devres.c
@@ -22,6 +22,8 @@ static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
  * @size: Size of map
  *
  * Managed ioremap().  Map is automatically unmapped on driver detach.
+ *
+ * When possible, use devm_ioremap_resource() instead.
  */
 void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 			   resource_size_t size)

> > Fixes: 608793e27b33 ("PCI: dwc: dra7xx: Add EP mode support")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/pci/dwc/pci-dra7xx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> > index 8bf7c27..aafded8 100644
> > --- a/drivers/pci/dwc/pci-dra7xx.c
> > +++ b/drivers/pci/dwc/pci-dra7xx.c
> > @@ -409,11 +409,15 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
> >  	ep->ops = &pcie_ep_ops;
> >  
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
> > +	if (!res)
> > +		return -EINVAL;
> >  	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
> >  	if (!pci->dbi_base)
> >  		return -ENOMEM;
> >  
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
> > +	if (!res)
> > +		return -EINVAL;
> >  	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
> >  	if (!pci->dbi_base2)
> >  		return -ENOMEM;
> > @@ -462,6 +466,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
> >  		return ret;
> >  
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
> > +	if (!res)
> > +		return -EINVAL;
> >  	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
> >  	if (!pci->dbi_base)
> >  		return -ENOMEM;
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
