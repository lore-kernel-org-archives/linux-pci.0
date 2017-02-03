Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbdBCVAY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 16:00:24 -0500
Date: Fri, 3 Feb 2017 15:00:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH 1/3] PCI:hisi: Add DT almost ECAM support for HiSilicon
 Hip06/Hip07 host controllers
Message-ID: <20170203210020.GA24162@bhelgaas-glaptop.roam.corp.google.com>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
 <1484202504-96686-2-git-send-email-liudongdong3@huawei.com>
 <20170203204042.GF10291@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170203204042.GF10291@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 03, 2017 at 02:40:42PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 12, 2017 at 02:28:22PM +0800, Dongdong Liu wrote:
> > The PCIe controller in Hip06/Hip07 SoCs is not completely
> > ECAM-compliant. It is non-ECAM only for the RC bus config space; for
> > any other bus underneath the root bus it does support ECAM access.
> > This is to add the almost ECAM support in DT way.
> > 
> > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> > Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> 
> Applied to pci/host-hisi for v4.11, thanks!

Oops, I take this back, see below.

> > @@ -262,17 +264,23 @@ static int hisi_pcie_probe(struct platform_device *pdev)
> >  	const struct of_device_id *match;
> >  	struct resource *reg;
> >  	struct device_driver *driver;
> > +	struct pci_ecam_ops *ops;
> >  	int ret;
> >  
> > +	driver = dev->driver;
> > +	match = of_match_device(driver->of_match_table, dev);
> > +	if (!strcmp(match->compatible, "hisilicon,pcie-almost-ecam")) {
> > +		ops = (struct pci_ecam_ops *)match->data;
> > +		return pci_host_common_probe(pdev, ops);
> > +	}

Please make this a separate probe function() with a separate struct
platform_driver.

That way you won't have to strcmp() for "hisilicon,pcie-almost-ecam",
and you can use of_device_get_match_data() to get "ops", so you won't
need to use of_match_device() at all.

> >  	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
> >  	if (!hisi_pcie)
> >  		return -ENOMEM;
> >  
> >  	pp = &hisi_pcie->pp;
> >  	pp->dev = dev;
> > -	driver = dev->driver;
> >  
> > -	match = of_match_device(driver->of_match_table, dev);
> >  	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
> >  
> >  	hisi_pcie->subctrl =
> > @@ -302,6 +310,40 @@ static int hisi_pcie_probe(struct platform_device *pdev)
> >  		&hisi_pcie_link_up_hip06
> >  };
> >  
> > +static int hisi_pcie_platform_init(struct pci_config_window *cfg)
> > +{
> > +	struct device *dev = cfg->parent;
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct resource *res;
> > +	void __iomem *reg_base;
> > +
> > +	if (!dev->of_node)
> > +		return -EINVAL;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +	if (!res) {
> > +		dev_err(dev, "missing \"reg[1]\"property\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	reg_base = devm_ioremap(dev, res->start, resource_size(res));
> > +	if (!reg_base)
> > +		return -ENOMEM;
> > +
> > +	cfg->priv = reg_base;
> > +	return 0;
> > +}
> > +
> > +struct pci_ecam_ops hisi_pcie_platform_ops = {
> > +	.bus_shift    = 20,
> > +	.init         =  hisi_pcie_platform_init,
> > +	.pci_ops      = {
> > +		.map_bus    = hisi_pcie_map_bus,
> > +		.read       = hisi_pcie_acpi_rd_conf,
> > +		.write      = hisi_pcie_acpi_wr_conf,
> > +	}
> > +};
> > +
> >  static const struct of_device_id hisi_pcie_of_match[] = {
> >  	{
> >  			.compatible = "hisilicon,hip05-pcie",
> > @@ -311,6 +353,11 @@ static int hisi_pcie_probe(struct platform_device *pdev)
> >  			.compatible = "hisilicon,hip06-pcie",
> >  			.data	    = (void *) &hip06_ops,
> >  	},
> > +
> > +	{
> > +			.compatible = "hisilicon,pcie-almost-ecam",
> > +			.data	    = (void *) &hisi_pcie_platform_ops,
> > +	},
> >  	{},
> >  };
> >  
> > @@ -324,3 +371,4 @@ static int hisi_pcie_probe(struct platform_device *pdev)
> >  builtin_platform_driver(hisi_pcie_driver);
> >  
> >  #endif
> > +#endif
> > -- 
> > 1.9.1
> > 
