Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog121.obsmtp.com ([207.126.144.151]:54722 "EHLO
	eu1sys200aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750751Ab3LJEe3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 23:34:29 -0500
Date: Tue, 10 Dec 2013 10:04:09 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>
Cc: Marek Vasut <marex@denx.de>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>
Subject: Re: [Query/Discussion]: IO translation with designware PCIe
 controller
Message-ID: <20131210043409.GA2734@pratyush-vbox>
References: <20131205050424.GA2298@pratyush-vbox>
 <201312061546.23981.arnd@arndb.de>
 <20131209071241.GA5760@pratyush-vbox>
 <201312091709.38013.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <201312091709.38013.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 10, 2013 at 12:09:37AM +0800, Arnd Bergmann wrote:
> On Monday 09 December 2013, Pratyush Anand wrote:
> > > I think it does handle this correctly, look at
> > > 
> > > static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> > > {
> > > 	...
> > >         if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> > >                 sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> > >                 pci_ioremap_io(sys->io_offset, pp->io.start);
> > >                 global_io_offset += SZ_64K;
> > >                 pci_add_resource_offset(&sys->resources, &pp->io,
> > >                                         sys->io_offset);
> > >         }
> > > 	...
> > > }
> > > 
> > > I believe this does the right thing, but you have to put the correct
> > > translation into the 'ranges' property of the host bridge node in DT.
> > 
> > May be not exactly. pp->io is the  realio, and it is passed correctly
> > to pci_add_resource_offset. But, as you had also
> > said that pci_ioremap_io will receive cpu physical address space as
> > input, therefore I think following modification will be needed to work
> > io transaction properly.
> 
> I see. I think you are right.
> 
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index be6ce30..cf68632 100644
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
> 
> This looks correct to me and it seems to also fix a bug in
> dw_pcie_prog_viewport_io_outbound if I read this correctly.

Yes, now outbound viewport for IO translation will get correct input
address.

> 
> > @@ -667,7 +667,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> >  
> >  	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> >  		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> > -		pci_ioremap_io(sys->io_offset, pp->io.start);
> > +		pci_ioremap_io(sys->io_offset, pp->io_base);
> >  		global_io_offset += SZ_64K;
> >  		pci_add_resource_offset(&sys->resources, &pp->io,
> >  					sys->io_offset);
> 
> I think there is still a related bug in here: we should pass global_io_offset rather
> than sys->io_offset to pci_ioremap_io, so we map the new window into the first
> available spot in the Linux view of the I/O space, rather than passing a number
> that might be zero for any bus, if the 'ranges' are set up to have an identity
> mapping between Linux I/O spaces and PCI I/O spaces. You should be able to verify
> this by setting the I/O range for the bus to a random 4KB multiple in DT and
> observe that Linux start allocating ports from 0x1000 but the raw BAR values
> would contain the value you have chosen.

OK.

@ Jingoo, Mohit

Is it possible for you to test following patch.

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

Regards
Pratyush
> 
> 	Arnd
