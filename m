Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:34334 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760557Ab3LIHNb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 02:13:31 -0500
Date: Mon, 9 Dec 2013 12:42:42 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Marek Vasut <marex@denx.de>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>
Subject: Re: [Query/Discussion]: IO translation with designware PCIe
 controller
Message-ID: <20131209071241.GA5760@pratyush-vbox>
References: <20131205050424.GA2298@pratyush-vbox>
 <201312052233.13169.arnd@arndb.de>
 <20131206091209.GC2298@pratyush-vbox>
 <201312061546.23981.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <201312061546.23981.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Fri, Dec 06, 2013 at 10:46:23PM +0800, Arnd Bergmann wrote:
> On Friday 06 December 2013, Pratyush Anand wrote:
> 
> > > 

[...]

> > > > For example in SPEAr1340, physically RAM is mapped on above addresses.
> > > > PCIe address translation unit can accept address only in the range of
> > > > core addresses which are assigned to PCIe RC ie 0x80000000-0x8FFFFFFF.
> > > 
> > > Since this is a physical address, it corresponds to address space 3 in
> > > my list above, and the address you pick here is what you pass to
> > > pci_ioremap_io.
> > 
> > This is what I was expecting. But currently designware driver does not
> > pass this address to pci_ioremap_io.
> > OK.. We will fix it and will send patch.
> 
> I think it does handle this correctly, look at
> 
> static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> {
> 	...
>         if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
>                 sys->io_offset = global_io_offset - pp->config.io_bus_addr;
>                 pci_ioremap_io(sys->io_offset, pp->io.start);
>                 global_io_offset += SZ_64K;
>                 pci_add_resource_offset(&sys->resources, &pp->io,
>                                         sys->io_offset);
>         }
> 	...
> }
> 
> I believe this does the right thing, but you have to put the correct
> translation into the 'ranges' property of the host bridge node in DT.

May be not exactly. pp->io is the  realio, and it is passed correctly
to pci_add_resource_offset. But, as you had also
said that pci_ioremap_io will receive cpu physical address space as
input, therefore I think following modification will be needed to work
io transaction properly.


diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index be6ce30..cf68632 100644
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
+		pci_ioremap_io(sys->io_offset, pp->io_base);
 		global_io_offset += SZ_64K;
 		pci_add_resource_offset(&sys->resources, &pp->io,
 					sys->io_offset);
Regards
Pratyush
> 
> 	Arnd
