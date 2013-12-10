Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:38363 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab3LJXZX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2013 18:25:23 -0500
From: Marek Vasut <marex@denx.de>
To: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [Query/Discussion]: IO translation with designware PCIe controller
Date: Wed, 11 Dec 2013 00:25:21 +0100
Cc: Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20131205050424.GA2298@pratyush-vbox> <001101cef5f6$4347c520$c9d74f60$%han@samsung.com> <CAJ+vNU1LCeSKBjr8ryrJZcPt2+6Xcv0de19FttdpTvSEmr1k_w@mail.gmail.com>
In-Reply-To: <CAJ+vNU1LCeSKBjr8ryrJZcPt2+6Xcv0de19FttdpTvSEmr1k_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201312110025.21570.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 11, 2013 at 12:23:47 AM, Tim Harvey wrote:
> On Tue, Dec 10, 2013 at 2:22 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Tuesday, December 10, 2013 10:27 PM, Marek Vasut wrote:
> >> On Monday, December 09, 2013 at 08:12:42 AM, Pratyush Anand wrote:
> > [.....]
> > 
> >> > diff --git a/drivers/pci/host/pcie-designware.c
> >> > b/drivers/pci/host/pcie-designware.c index be6ce30..cf68632 100644
> >> > --- a/drivers/pci/host/pcie-designware.c
> >> > +++ b/drivers/pci/host/pcie-designware.c
> >> > @@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >> > 
> >> >                                        + global_io_offset);
> >> >                     
> >> >                     pp->config.io_size = resource_size(&pp->io);
> >> >                     pp->config.io_bus_addr = range.pci_addr;
> >> > 
> >> > +                   pp->io_base = range.cpu_addr;
> >> > 
> >> >             }
> >> >             if (restype == IORESOURCE_MEM) {
> >> >             
> >> >                     of_pci_range_to_resource(&range, np, &pp->mem);
> >> > 
> >> > @@ -403,7 +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >> > 
> >> >     pp->cfg0_base = pp->cfg.start;
> >> >     pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
> >> > 
> >> > -   pp->io_base = pp->io.start;
> >> > 
> >> >     pp->mem_base = pp->mem.start;
> >> >     
> >> >     pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> >> > 
> >> > @@ -667,7 +667,7 @@ static int dw_pcie_setup(int nr, struct
> >> > pci_sys_data *sys)
> >> > 
> >> >     if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> >> >     
> >> >             sys->io_offset = global_io_offset -
> >> >             pp->config.io_bus_addr;
> >> > 
> >> > -           pci_ioremap_io(sys->io_offset, pp->io.start);
> >> > +           pci_ioremap_io(sys->io_offset, pp->io_base);
> >> > 
> >> >             global_io_offset += SZ_64K;
> >> >             pci_add_resource_offset(&sys->resources, &pp->io,
> >> >             
> >> >                                     sys->io_offset);
> >> 
> >> Tim, can you test if this patch fixes your SKY2 IOspace problem please ?
> > 
> > Above mentioned patch is NOT the latest patch.
> > Pratyush Anand already submitted the next patch as below.
> > 
> > Tim,
> > Would you test the following patch on i.MX6 platform?
> > 
> > diff --git a/drivers/pci/host/pcie-designware.c
> > b/drivers/pci/host/pcie-designware.c index be6ce30..b83f5e8 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -378,6 +378,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> > 
> >                                            + global_io_offset);
> >                         
> >                         pp->config.io_size = resource_size(&pp->io);
> >                         pp->config.io_bus_addr = range.pci_addr;
> > 
> > +                       pp->io_base = range.cpu_addr;
> > 
> >                 }
> >                 if (restype == IORESOURCE_MEM) {
> >                 
> >                         of_pci_range_to_resource(&range, np, &pp->mem);
> > 
> > @@ -403,7 +404,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> > 
> >         pp->cfg0_base = pp->cfg.start;
> >         pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
> > 
> > -       pp->io_base = pp->io.start;
> > 
> >         pp->mem_base = pp->mem.start;
> >         
> >         pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> > 
> > @@ -667,7 +667,7 @@ static int dw_pcie_setup(int nr, struct pci_sys_data
> > *sys)
> > 
> >         if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> >         
> >                 sys->io_offset = global_io_offset -
> >                 pp->config.io_bus_addr;
> > 
> > -               pci_ioremap_io(sys->io_offset, pp->io.start);
> > +               pci_ioremap_io(global_io_offset, pp->io_base);
> > 
> >                 global_io_offset += SZ_64K;
> >                 pci_add_resource_offset(&sys->resources, &pp->io,
> >                 
> >                                         sys->io_offset);
> > 
> > Best regards,
> > Jingoo Han
> 
> Yes, this patch resolves the issue and now I can use devices with io
> resources behind a bridge attached to the IMX6.
> 
> Thanks everyone for your efforts!

This is awesome, thanks guys!
