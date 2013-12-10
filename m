Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22171 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab3LJWWJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2013 17:22:09 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXM005YW3GWSZ40@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 11 Dec 2013 07:22:08 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Marek Vasut' <marex@denx.de>, 'Tim Harvey' <tharvey@gateworks.com>
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Richard Zhu' <Hong-Xing.Zhu@freescale.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <20131205050424.GA2298@pratyush-vbox>
 <201312061546.23981.arnd@arndb.de> <20131209071241.GA5760@pratyush-vbox>
 <201312101426.40614.marex@denx.de>
In-reply-to: <201312101426.40614.marex@denx.de>
Subject: Re: [Query/Discussion]: IO translation with designware PCIe controller
Date: Wed, 11 Dec 2013 07:22:07 +0900
Message-id: <001101cef5f6$4347c520$c9d74f60$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, December 10, 2013 10:27 PM, Marek Vasut wrote:
> On Monday, December 09, 2013 at 08:12:42 AM, Pratyush Anand wrote:

[.....]

> >
> > diff --git a/drivers/pci/host/pcie-designware.c
> > b/drivers/pci/host/pcie-designware.c index be6ce30..cf68632 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >  					   + global_io_offset);
> >  			pp->config.io_size = resource_size(&pp->io);
> >  			pp->config.io_bus_addr = range.pci_addr;
> > +			pp->io_base = range.cpu_addr;
> >  		}
> >  		if (restype == IORESOURCE_MEM) {
> >  			of_pci_range_to_resource(&range, np, &pp->mem);
> > @@ -403,7 +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >
> >  	pp->cfg0_base = pp->cfg.start;
> >  	pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
> > -	pp->io_base = pp->io.start;
> >  	pp->mem_base = pp->mem.start;
> >
> >  	pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> > @@ -667,7 +667,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data
> > *sys)
> >
> >  	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> >  		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> > -		pci_ioremap_io(sys->io_offset, pp->io.start);
> > +		pci_ioremap_io(sys->io_offset, pp->io_base);
> >  		global_io_offset += SZ_64K;
> >  		pci_add_resource_offset(&sys->resources, &pp->io,
> >  					sys->io_offset);
> 
> Tim, can you test if this patch fixes your SKY2 IOspace problem please ?

Above mentioned patch is NOT the latest patch.
Pratyush Anand already submitted the next patch as below.

Tim,
Would you test the following patch on i.MX6 platform?

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index be6ce30..b83f5e8 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 					   + global_io_offset);
 			pp->config.io_size = resource_size(&pp->io);
 			pp->config.io_bus_addr = range.pci_addr;
+			pp->io_base = range.cpu_addr;
 		}
 		if (restype == IORESOURCE_MEM) {
 			of_pci_range_to_resource(&range, np, &pp->mem);
@@ -403,7 +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 
 	pp->cfg0_base = pp->cfg.start;
 	pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
-	pp->io_base = pp->io.start;
 	pp->mem_base = pp->mem.start;
 
 	pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
@@ -667,7 +667,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 
 	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
 		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
-		pci_ioremap_io(sys->io_offset, pp->io.start);
+		pci_ioremap_io(global_io_offset, pp->io_base);
 		global_io_offset += SZ_64K;
 		pci_add_resource_offset(&sys->resources, &pp->io,
 					sys->io_offset);


Best regards,
Jingoo Han

