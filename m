Return-Path: <SRS0=46+B=EP=linux-mips.org=ladis@kernel.org>
Return-Path: <SRS0=46+B=EP=linux-mips.org=ladis@kernel.org>
Date: Sat, 20 Jan 2018 01:16:45 +0100
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
Message-ID: <20180120001645.GA21343@lenoch>
References: <1516284037-81537-1-git-send-email-weiyongjun1@huawei.com>
 <20180118145420.GA21163@lenoch>
 <20180118183525.GG53542@bhelgaas-glaptop.roam.corp.google.com>
 <20180119095857.GA26765@lenoch>
 <20180119170657.GA27882@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119170657.GA27882@lenoch>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 19, 2018 at 06:06:57PM +0100, Ladislav Michl wrote:
> On Fri, Jan 19, 2018 at 10:58:57AM +0100, Ladislav Michl wrote:
> > On Thu, Jan 18, 2018 at 12:35:25PM -0600, Bjorn Helgaas wrote:
> > > That's probably a better idea.  Maybe we should add a comment like this
> > > to help avoid this in the future:
> > 
> > That seems to spot another a bit more serious problem (given how late
> > release cycle is now).
> > 
> > Both devm_ioremap() and devm_ioremap_resource() shares the same release
> > function: devm_ioremap_release(). However this function is not aware of
> > memory region previously requested by devm_request_mem_region() called
> > from devm_ioremap_resource().
> > 
> > Bellow is just a quick hack, even untested as looking at devm_ioremap,
> > devm_ioremap_wc and devm_ioremap_wc, there is some room for optimization.
> 
> Okay, forget it, above analysis is not correct, however there is a bug (and
> also in PCI version). To show it, let's make following modification:

I will never ever work in single tree for two different boards without full
recompile (which should save time and caused opposite) as it makes debugging
pointless - there is no bug.

As a request forgiveness, please accept following draft as proposed solution
for $subj

Subject: [PATCH] PCI: dra7xx: Use devm_ioremap_resource()

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 8bf7c2714db6..7f422ae258ac 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -409,14 +409,14 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
 	ep->ops = &pcie_ep_ops;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
-	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pci->dbi_base)
-		return -ENOMEM;
+	pci->dbi_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
-	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pci->dbi_base2)
-		return -ENOMEM;
+	pci->dbi_base2 = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pci->dbi_base2))
+		return PTR_ERR(pci->dbi_base2);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
