Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Nov 2015 19:27:17 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Sekhar Nori <nsekhar@ti.com>
CC: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: keystone: fix crash with deferred probe
Message-ID: <20151123192717.4d4ddf06@xhacker>
In-Reply-To: <20151123192209.38e2c101@xhacker>
References: <866b2f1544f9d55fa932aa9f9cb5e7d523a23d05.1448017883.git.nsekhar@ti.com>
	<20151123192209.38e2c101@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 23 Nov 2015 19:22:09 +0800
Jisheng Zhang <jszhang@marvell.com> wrote:

> Dear Sekhar,
> 
> On Fri, 20 Nov 2015 16:47:02 +0530
> Sekhar Nori wrote:
> 
> > Drop __init annotations for functions called during
> > probe of keystone PCIe host.
> > 
> > This fixes kernel crashes seen because of init data
> > reclamation if the driver defer probes because of
> > phy unavailability.
> > 
> > While at it, drop the useless __refdata annotation
> > to driver structure. If its really needed, it should
> > be added back with a comment explaining why.
> > 
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > ---
> >  drivers/pci/host/pci-keystone-dw.c | 2 +-
> >  drivers/pci/host/pci-keystone.c    | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> > index ed34c9520a02..47ddbcce53ca 100644
> > --- a/drivers/pci/host/pci-keystone-dw.c
> > +++ b/drivers/pci/host/pci-keystone-dw.c
> > @@ -469,7 +469,7 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
> >   * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
> >   * PCI host controller.
> >   */
> > -int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
> > +int ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
> >  				struct device_node *msi_intc_np)  
> 
> when trying to add berlin pcie support and came up one patch
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384575.html
> 
> when build testing, I also realized this issue, but keystone relies on

I mean ks_dw_pcie_host_init() calls hook_fault_code()

> hook_fault_code() which is will be freed after boot, so your patch isn't
> completed.

And will introduce section mismatch warnings

> 
> And from the keystone driver implementation, it seems assume the driver won't
> be defer probed.
> 
> Thanks
> 
> >  {
> >  	struct pcie_port *pp = &ks_pcie->pp;
> > diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> > index 0aa81bd3de12..593a58834c7d 100644
> > --- a/drivers/pci/host/pci-keystone.c
> > +++ b/drivers/pci/host/pci-keystone.c
> > @@ -291,7 +291,7 @@ static struct pcie_host_ops keystone_pcie_host_ops = {
> >  	.scan_bus = ks_dw_pcie_v3_65_scan_bus,
> >  };
> >  
> > -static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
> > +static int ks_add_pcie_port(struct keystone_pcie *ks_pcie,
> >  			 struct platform_device *pdev)
> >  {
> >  	struct pcie_port *pp = &ks_pcie->pp;
> > @@ -340,7 +340,7 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > -static int __init ks_pcie_probe(struct platform_device *pdev)
> > +static int ks_pcie_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> >  	struct keystone_pcie *ks_pcie;
> > @@ -396,7 +396,7 @@ fail_clk:
> >  	return ret;
> >  }
> >  
> > -static struct platform_driver ks_pcie_driver __refdata = {
> > +static struct platform_driver ks_pcie_driver = {
> >  	.probe  = ks_pcie_probe,
> >  	.remove = __exit_p(ks_pcie_remove),
> >  	.driver = {  
> 

