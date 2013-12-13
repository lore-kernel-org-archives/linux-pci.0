Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:1158
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750830Ab3LMHgN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2013 02:36:13 -0500
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Jingoo Han <jg1.han@samsung.com>, 'Marek Vasut' <marex@denx.de>
CC: 'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Pratyush ANAND' <pratyush.anand@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	'Tim Harvey' <tharvey@gateworks.com>
Subject: RE: [Query/Discussion]: IO translation with designware PCIe
 controller
Date: Fri, 13 Dec 2013 07:36:10 +0000
Message-ID: <b07bcbcd816141b0971c18dc0cf2036c@BLUPR03MB136.namprd03.prod.outlook.com>
References: <20131205050424.GA2298@pratyush-vbox>
 <201312061546.23981.arnd@arndb.de> <20131209071241.GA5760@pratyush-vbox>
 <201312091709.38013.arnd@arndb.de> <20131210043409.GA2734@pratyush-vbox>
 <000101cef568$3cd0e4d0$b672ae70$%han@samsung.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189F9536CE2@EAPEX1MAIL1.st.com>
 <001201cef575$cd4fc960$67ef5c20$%han@samsung.com>
In-Reply-To: <001201cef575$cd4fc960$67ef5c20$%han@samsung.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jinhoo:

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> On Behalf Of Jingoo Han
> Sent: Tuesday, December 10, 2013 3:03 PM
> To: 'Marek Vasut'; Zhu Richard-R65037
> Cc: 'Mohit KUMAR DCG'; 'Pratyush ANAND'; 'Arnd Bergmann'; 'Kishon Vijay
> Abraham I'; linux-pci@vger.kernel.org; 'Tim Harvey'; 'Jingoo Han'
> Subject: Re: [Query/Discussion]: IO translation with designware PCIe
> controller
> 
> On Tuesday, December 10, 2013 3:31 PM, Mohit KUMAR DCG wrote:
> > On Tuesday, December 10, 2013 10:55 AM, Jingoo Han wrote:
> > > On Tuesday, December 10, 2013 1:34 PM, Pratyush Anand wrote:
> > > > On Tue, Dec 10, 2013 at 12:09:37AM +0800, Arnd Bergmann wrote:
> > > > > On Monday 09 December 2013, Pratyush Anand wrote:
> > > > > > > I think it does handle this correctly, look at
> > > > > > >
> > > > > > > static int dw_pcie_setup(int nr, struct pci_sys_data *sys) {
> > > > > > > 	...
> > > > > > >         if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> > > > > > >                 sys->io_offset = global_io_offset - pp-
> >config.io_bus_addr;
> > > > > > >                 pci_ioremap_io(sys->io_offset, pp->io.start);
> > > > > > >                 global_io_offset += SZ_64K;
> > > > > > >                 pci_add_resource_offset(&sys->resources, &pp->io,
> > > > > > >                                         sys->io_offset);
> > > > > > >         }
> > > > > > > 	...
> > > > > > > }
> > > > > > >
> > > > > > > I believe this does the right thing, but you have to put the
> > > > > > > correct translation into the 'ranges' property of the host
> > > > > > > bridge node
> > > in DT.
> > > > > >
> > > > > > May be not exactly. pp->io is the  realio, and it is passed
> > > > > > correctly to pci_add_resource_offset. But, as you had also
> > > > > > said that pci_ioremap_io will receive cpu physical address
> > > > > > space as input, therefore I think following modification will
> > > > > > be needed to work io transaction properly.
> > > > >
> > > > > I see. I think you are right.
> > > > >
> > > > > > diff --git a/drivers/pci/host/pcie-designware.c
> > > > > > b/drivers/pci/host/pcie-designware.c
> > > > > > index be6ce30..cf68632 100644
> > > > > > --- a/drivers/pci/host/pcie-designware.c
> > > > > > +++ b/drivers/pci/host/pcie-designware.c
> > > > > > @@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct
> > > > > > pcie_port
> > > *pp)
> > > > > >  					   + global_io_offset);
> > > > > >  			pp->config.io_size = resource_size(&pp->io);
> > > > > >  			pp->config.io_bus_addr = range.pci_addr;
> > > > > > +			pp->io_base = range.cpu_addr;
> > > > > >  		}
> > > > > >  		if (restype == IORESOURCE_MEM) {
> > > > > >  			of_pci_range_to_resource(&range, np, &pp->mem);
> > > @@ -403,7
> > > > > > +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> > > > > >
> > > > > >  	pp->cfg0_base = pp->cfg.start;
> > > > > >  	pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
> > > > > > -	pp->io_base = pp->io.start;
> > > > > >  	pp->mem_base = pp->mem.start;
> > > > > >
> > > > > >  	pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> > > > >
> > > > > This looks correct to me and it seems to also fix a bug in
> > > > > dw_pcie_prog_viewport_io_outbound if I read this correctly.
> > > >
> > > > Yes, now outbound viewport for IO translation will get correct
> > > > input address.
> > > >
> > > > >
> > > > > > @@ -667,7 +667,7 @@ static int dw_pcie_setup(int nr, struct
> > > > > > pci_sys_data *sys)
> > > > > >
> > > > > >  	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> > > > > >  		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> > > > > > -		pci_ioremap_io(sys->io_offset, pp->io.start);
> > > > > > +		pci_ioremap_io(sys->io_offset, pp->io_base);
> > > > > >  		global_io_offset += SZ_64K;
> > > > > >  		pci_add_resource_offset(&sys->resources, &pp->io,
> > > > > >  					sys->io_offset);
> > > > >
> > > > > I think there is still a related bug in here: we should pass
> > > > > global_io_offset rather than sys->io_offset to pci_ioremap_io,
> > > > > so we map the new window into the first available spot in the
> > > > > Linux view of the I/O space, rather than passing a number that
> > > > > might be zero for any bus, if the 'ranges' are set up to have an
> > > > > identity mapping between Linux I/O spaces and PCI I/O spaces.
> > > > > You should be able to verify this by setting the I/O range for
> > > > > the bus to a random 4KB multiple in DT and observe that Linux
> > > > > start allocating ports from 0x1000
> > > but the raw BAR values would contain the value you have chosen.
> > > >
> > > > OK.
> > > >
> > > > @ Jingoo, Mohit
> >
> > -  Now its working properly for SPEAr1310 tested with directly
> > connected EP(xhc cards) as well as EP  Connected through switch(Lecroy
> > PTC in AIC mode). Without this patch my EP devices were not working
> > when  connected through Switch.
> 
> Hi Marek, Richard,
> 
> How about testing the following Pratyush's patch on imx6 platform with the
> Pericom PI7C9X2G303EL PCIe switch?
> 
> As Mohit tested, it looks to resolve the i.MX6 problem when the PCIe switch is
> connected to the i.MX6 platform.
> 
> Best regards,
> Jingoo Han
> 
[Richard] Sorry to reply late, I went to hospital in the past two days.
This patch is great, I tested at my side, it works, thanks a lot.
> [.....]
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> designware.c
> index be6ce30..b83f5e8 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  					   + global_io_offset);
>  			pp->config.io_size = resource_size(&pp->io);
>  			pp->config.io_bus_addr = range.pci_addr;
> +			pp->io_base = range.cpu_addr;
>  		}
>  		if (restype == IORESOURCE_MEM) {
>  			of_pci_range_to_resource(&range, np, &pp->mem); @@ -403,7
> +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> 
>  	pp->cfg0_base = pp->cfg.start;
>  	pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
> -	pp->io_base = pp->io.start;
>  	pp->mem_base = pp->mem.start;
> 
>  	pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base, @@ -667,7 +667,7
> @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> 
>  	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
>  		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> -		pci_ioremap_io(sys->io_offset, pp->io.start);
> +		pci_ioremap_io(global_io_offset, pp->io_base);
>  		global_io_offset += SZ_64K;
>  		pci_add_resource_offset(&sys->resources, &pp->io,
>  					sys->io_offset);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 

Best Regards
Richard Zhu

