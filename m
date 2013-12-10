Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:48483 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750726Ab3LJGba convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Dec 2013 01:31:30 -0500
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Jingoo Han <jg1.han@samsung.com>,
	Pratyush ANAND <pratyush.anand@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Marek Vasut' <marex@denx.de>,
	'Richard Zhu' <Hong-Xing.Zhu@freescale.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	'Tim Harvey' <tharvey@gateworks.com>
Date: Tue, 10 Dec 2013 14:31:08 +0800
Subject: RE: [Query/Discussion]: IO translation with designware PCIe
 controller
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189F9536CE2@EAPEX1MAIL1.st.com>
References: <20131205050424.GA2298@pratyush-vbox>
 <201312061546.23981.arnd@arndb.de> <20131209071241.GA5760@pratyush-vbox>
 <201312091709.38013.arnd@arndb.de> <20131210043409.GA2734@pratyush-vbox>
 <000101cef568$3cd0e4d0$b672ae70$%han@samsung.com>
In-Reply-To: <000101cef568$3cd0e4d0$b672ae70$%han@samsung.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Pratyush,

> -----Original Message-----
> From: Jingoo Han [mailto:jg1.han@samsung.com]
> Sent: Tuesday, December 10, 2013 10:55 AM
> To: Pratyush ANAND; 'Arnd Bergmann'; Mohit KUMAR DCG
> Cc: 'Marek Vasut'; 'Richard Zhu'; 'Kishon Vijay Abraham I'; linux-
> pci@vger.kernel.org; 'Tim Harvey'; 'Jingoo Han'
> Subject: Re: [Query/Discussion]: IO translation with designware PCIe
> controller
> 
> On Tuesday, December 10, 2013 1:34 PM, Pratyush Anand wrote:
> > On Tue, Dec 10, 2013 at 12:09:37AM +0800, Arnd Bergmann wrote:
> > > On Monday 09 December 2013, Pratyush Anand wrote:
> > > > > I think it does handle this correctly, look at
> > > > >
> > > > > static int dw_pcie_setup(int nr, struct pci_sys_data *sys) {
> > > > > 	...
> > > > >         if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> > > > >                 sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> > > > >                 pci_ioremap_io(sys->io_offset, pp->io.start);
> > > > >                 global_io_offset += SZ_64K;
> > > > >                 pci_add_resource_offset(&sys->resources, &pp->io,
> > > > >                                         sys->io_offset);
> > > > >         }
> > > > > 	...
> > > > > }
> > > > >
> > > > > I believe this does the right thing, but you have to put the
> > > > > correct translation into the 'ranges' property of the host bridge node
> in DT.
> > > >
> > > > May be not exactly. pp->io is the  realio, and it is passed
> > > > correctly to pci_add_resource_offset. But, as you had also said
> > > > that pci_ioremap_io will receive cpu physical address space as
> > > > input, therefore I think following modification will be needed to
> > > > work io transaction properly.
> > >
> > > I see. I think you are right.
> > >
> > > > diff --git a/drivers/pci/host/pcie-designware.c
> > > > b/drivers/pci/host/pcie-designware.c
> > > > index be6ce30..cf68632 100644
> > > > --- a/drivers/pci/host/pcie-designware.c
> > > > +++ b/drivers/pci/host/pcie-designware.c
> > > > @@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct pcie_port
> *pp)
> > > >  					   + global_io_offset);
> > > >  			pp->config.io_size = resource_size(&pp->io);
> > > >  			pp->config.io_bus_addr = range.pci_addr;
> > > > +			pp->io_base = range.cpu_addr;
> > > >  		}
> > > >  		if (restype == IORESOURCE_MEM) {
> > > >  			of_pci_range_to_resource(&range, np, &pp->mem);
> @@ -403,7
> > > > +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> > > >
> > > >  	pp->cfg0_base = pp->cfg.start;
> > > >  	pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
> > > > -	pp->io_base = pp->io.start;
> > > >  	pp->mem_base = pp->mem.start;
> > > >
> > > >  	pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> > >
> > > This looks correct to me and it seems to also fix a bug in
> > > dw_pcie_prog_viewport_io_outbound if I read this correctly.
> >
> > Yes, now outbound viewport for IO translation will get correct input
> > address.
> >
> > >
> > > > @@ -667,7 +667,7 @@ static int dw_pcie_setup(int nr, struct
> > > > pci_sys_data *sys)
> > > >
> > > >  	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> > > >  		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> > > > -		pci_ioremap_io(sys->io_offset, pp->io.start);
> > > > +		pci_ioremap_io(sys->io_offset, pp->io_base);
> > > >  		global_io_offset += SZ_64K;
> > > >  		pci_add_resource_offset(&sys->resources, &pp->io,
> > > >  					sys->io_offset);
> > >
> > > I think there is still a related bug in here: we should pass
> > > global_io_offset rather than sys->io_offset to pci_ioremap_io, so we
> > > map the new window into the first available spot in the Linux view
> > > of the I/O space, rather than passing a number that might be zero
> > > for any bus, if the 'ranges' are set up to have an identity mapping
> > > between Linux I/O spaces and PCI I/O spaces. You should be able to
> > > verify this by setting the I/O range for the bus to a random 4KB
> > > multiple in DT and observe that Linux start allocating ports from 0x1000
> but the raw BAR values would contain the value you have chosen.
> >
> > OK.
> >
> > @ Jingoo, Mohit

-  Now its working properly for SPEAr1310 tested with directly connected EP(xhc cards) as well as EP
 Connected through switch(Lecroy PTC in AIC mode). Without this patch my EP devices were not working when
 connected through Switch.

Thanks
Mohit


> >
> > Is it possible for you to test following patch.
> 
> Hi Pratyush Anand,
> 
> This patch works properly on Exynos platform with two different NICs. Also, I
> am tracing this discussion.
> Thank you for sending your patch.
> 
> Best regards,
> Jingoo Han
> 
> >
> > diff --git a/drivers/pci/host/pcie-designware.c
> > b/drivers/pci/host/pcie-designware.c
> > index be6ce30..b83f5e8 100644
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
> @@ -403,7 +404,6
> > @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >
> >  	pp->cfg0_base = pp->cfg.start;
> >  	pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
> > -	pp->io_base = pp->io.start;
> >  	pp->mem_base = pp->mem.start;
> >
> >  	pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base, @@ -
> 667,7
> > +667,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> >
> >  	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> >  		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> > -		pci_ioremap_io(sys->io_offset, pp->io.start);
> > +		pci_ioremap_io(global_io_offset, pp->io_base);
> >  		global_io_offset += SZ_64K;
> >  		pci_add_resource_offset(&sys->resources, &pp->io,
> >  					sys->io_offset);
> 

