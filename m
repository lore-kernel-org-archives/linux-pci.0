Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751204AbeDQTns (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Apr 2018 15:43:48 -0400
Date: Tue, 17 Apr 2018 14:43:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
Message-ID: <20180417194344.GK28657@bhelgaas-glaptop.roam.corp.google.com>
References: <CAEdQ38GUhL0R4c7ZjEZv89TmqQ0cwhnvBawxuXonSb9On=+B6A@mail.gmail.com>
 <20180416215044.GE28657@bhelgaas-glaptop.roam.corp.google.com>
 <CAEdQ38EdxHigQiH_k=+4enbHAutbWOE6Kc5C81ghfsC3pwELjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEdQ38EdxHigQiH_k=+4enbHAutbWOE6Kc5C81ghfsC3pwELjw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 16, 2018 at 09:43:42PM -0700, Matt Turner wrote:
> On Mon, Apr 16, 2018 at 2:50 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Hi Matt,
> >
> > First of all, sorry about breaking Nautilus, and thanks very much for
> > tracking it down to this commit.
> 
> It's a particularly weird case, as far as I've been able to discern :)
> 
> > On Mon, Apr 16, 2018 at 07:33:57AM -0700, Matt Turner wrote:
> >> Commit f75b99d5a77d63f20e07bd276d5a427808ac8ef6 (PCI: Enforce bus
> >> address limits in resource allocation) broke Alpha systems using
> >> CONFIG_ALPHA_NAUTILUS. Alpha is 64-bit, but Nautilus systems use a
> >> 32-bit AMD 751/761 chipset. arch/alpha/kernel/sys_nautilus.c maps PCI
> >> into the upper addresses just below 4GB.
> >>
> >> I can get a working kernel by ifdef'ing out the code in
> >> drivers/pci/bus.c:pci_bus_alloc_resource. We can't tie
> >> PCI_BUS_ADDR_T_64BIT to ALPHA_NAUTILUS without breaking generic
> >> kernels.
> >>
> >> How can we get Nautilus working again?
> >
> > Can you collect a complete dmesg log, ideally both before and after
> > f75b99d5a77d?  I assume the problem is that after f75b99d5a77d? we
> > erroneously assign space for something above 4GB.  But if we know the
> > correct host bridge apertures, we shouldn't assign space outside them,
> > regardless of the PCI bus address size.
> 
> I made a mistake in my initial report. Commit f75b99d5a77d is actually
> the last *working* commit. My apologies. The next commit is
> d56dbf5bab8c (PCI: Allocate 64-bit BARs above 4G when possible) and it
> breaks Nautilus I've confirmed.
> 
> Please find attached dmesgs from those two commits, from the commit
> immediately before them, and another from 4.17-rc1 with my hack of #if
> 0'ing out the pci_bus_alloc_from_region(..., &pci_high) code.
> 
> Thanks for having a look!

We're telling the PCI core that the host bridge MMIO aperture is the
entire 64-bit address space, so when we assign BARs, some of them end
up above 4GB:

  pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffffffff]
  pci 0000:00:09.0: BAR 0: assigned [mem 0x100000000-0x10000ffff 64bit]

But it sounds like the MMIO aperture really ends at 0xffffffff, so
that's not going to work.

There's probably some register in the chipset that tells us where the
MMIO aperture starts.  The best thing to do would be to read that
register, use it to initialize irongate_mem, and use that as the MMIO
aperture.

But I don't know where to look in the chipset, and it looks like the
current strategy is to infer the base by looking at BAR assignments of
PCI devices.  Can you try the patch below (based on v4.17-rc1) and
save the dmesg and /proc/iomem and /proc/ioports contents?  I'm
guessing at some things here, so I added a few debug printks, too.


diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index ff4f54b86c7f..093ad6e5c75f 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -189,10 +189,14 @@ extern void pcibios_claim_one_bus(struct pci_bus *);
 
 static struct resource irongate_io = {
 	.name	= "Irongate PCI IO",
+	.start	= 0,
+	.end	= 0xffff,
 	.flags	= IORESOURCE_IO,
 };
 static struct resource irongate_mem = {
 	.name	= "Irongate PCI MEM",
+	.start	= 0,
+	.end	= 0xffffffff,
 	.flags	= IORESOURCE_MEM,
 };
 static struct resource busn_resource = {
@@ -208,7 +212,6 @@ nautilus_init_pci(void)
 	struct pci_controller *hose = hose_head;
 	struct pci_host_bridge *bridge;
 	struct pci_bus *bus;
-	struct pci_dev *irongate;
 	unsigned long bus_align, bus_size, pci_mem;
 	unsigned long memtop = max_low_pfn << PAGE_SHIFT;
 	int ret;
@@ -217,8 +220,8 @@ nautilus_init_pci(void)
 	if (!bridge)
 		return;
 
-	pci_add_resource(&bridge->windows, &ioport_resource);
-	pci_add_resource(&bridge->windows, &iomem_resource);
+	pci_add_resource(&bridge->windows, &irongate_io);
+	pci_add_resource(&bridge->windows, &irongate_mem);
 	pci_add_resource(&bridge->windows, &busn_resource);
 	bridge->dev.parent = NULL;
 	bridge->sysdata = hose;
@@ -237,33 +240,30 @@ nautilus_init_pci(void)
 	bus = hose->bus = bridge->bus;
 	pcibios_claim_one_bus(bus);
 
-	irongate = pci_get_domain_bus_and_slot(pci_domain_nr(bus), 0, 0);
-	bus->self = irongate;
-	bus->resource[0] = &irongate_io;
-	bus->resource[1] = &irongate_mem;
-
 	pci_bus_size_bridges(bus);
 
-	/* IO port range. */
-	bus->resource[0]->start = 0;
-	bus->resource[0]->end = 0xffff;
-
+	printk("bus->resource[1] %pR\n", &bus->resource[1]);
 	/* Set up PCI memory range - limit is hardwired to 0xffffffff,
 	   base must be at aligned to 16Mb. */
 	bus_align = bus->resource[1]->start;
 	bus_size = bus->resource[1]->end + 1 - bus_align;
 	if (bus_align < 0x1000000UL)
 		bus_align = 0x1000000UL;
+	printk("bus_align %#lx bus_size %#lx\n", bus_align, bus_size);
 
 	pci_mem = (0x100000000UL - bus_size) & -bus_align;
 
+	printk("memtop %#lx pci_mem %#lx\n", memtop, pci_mem);
+	irongate_mem.start = pci_mem;
 	bus->resource[1]->start = pci_mem;
-	bus->resource[1]->end = 0xffffffffUL;
-	if (request_resource(&iomem_resource, bus->resource[1]) < 0)
-		printk(KERN_ERR "Failed to request MEM on hose 0\n");
+	if (request_resource(&iomem_resource, &irongate_mem) < 0)
+		printk(KERN_ERR "Failed to request %pR on hose 0\n",
+		       &irongate_mem);
 
 	if (pci_mem < memtop)
 		memtop = pci_mem;
+	printk("memtop %#lx alpha_mv.min_mem_address %#lx\n", memtop,
+	       alpha_mv.min_mem_address);
 	if (memtop > alpha_mv.min_mem_address) {
 		free_reserved_area(__va(alpha_mv.min_mem_address),
 				   __va(memtop), -1, NULL);
