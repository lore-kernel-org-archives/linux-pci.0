Return-Path: <SRS0=5Kpa=HM=jurassic.park.msu.ru=ink@kernel.org>
Return-Path: <SRS0=5Kpa=HM=jurassic.park.msu.ru=ink@kernel.org>
Date: Mon, 23 Apr 2018 18:34:23 +0100
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matt Turner <mattst88@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-alpha <linux-alpha@vger.kernel.org>,
	Richard Henderson <rth@twiddle.net>,
	Jay Estabrook <jay.estabrook@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
Message-ID: <20180423173423.GA9138@mail.rc.ru>
References: <CAEdQ38GUhL0R4c7ZjEZv89TmqQ0cwhnvBawxuXonSb9On=+B6A@mail.gmail.com>
 <20180416215044.GE28657@bhelgaas-glaptop.roam.corp.google.com>
 <CAEdQ38EdxHigQiH_k=+4enbHAutbWOE6Kc5C81ghfsC3pwELjw@mail.gmail.com>
 <20180417194344.GK28657@bhelgaas-glaptop.roam.corp.google.com>
 <20180418204808.GA2352@mail.rc.ru>
 <CAEdQ38H-SGfj5rijGv2iJYWGfwnn6iWc=xot+HFMbJSu5rEd0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEdQ38H-SGfj5rijGv2iJYWGfwnn6iWc=xot+HFMbJSu5rEd0Q@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 22, 2018 at 01:07:38PM -0700, Matt Turner wrote:
> On Wed, Apr 18, 2018 at 1:48 PM, Ivan Kokshaysky
> <ink@jurassic.park.msu.ru> wrote:
> > On Tue, Apr 17, 2018 at 02:43:44PM -0500, Bjorn Helgaas wrote:
> >> On Mon, Apr 16, 2018 at 09:43:42PM -0700, Matt Turner wrote:
> >> > On Mon, Apr 16, 2018 at 2:50 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > > Hi Matt,
> >> > >
> >> > > First of all, sorry about breaking Nautilus, and thanks very much for
> >> > > tracking it down to this commit.
> >> >
> >> > It's a particularly weird case, as far as I've been able to discern :)
> >> >
> >> > > On Mon, Apr 16, 2018 at 07:33:57AM -0700, Matt Turner wrote:
> >> > >> Commit f75b99d5a77d63f20e07bd276d5a427808ac8ef6 (PCI: Enforce bus
> >> > >> address limits in resource allocation) broke Alpha systems using
> >> > >> CONFIG_ALPHA_NAUTILUS. Alpha is 64-bit, but Nautilus systems use a
> >> > >> 32-bit AMD 751/761 chipset. arch/alpha/kernel/sys_nautilus.c maps PCI
> >> > >> into the upper addresses just below 4GB.
> >> > >>
> >> > >> I can get a working kernel by ifdef'ing out the code in
> >> > >> drivers/pci/bus.c:pci_bus_alloc_resource. We can't tie
> >> > >> PCI_BUS_ADDR_T_64BIT to ALPHA_NAUTILUS without breaking generic
> >> > >> kernels.
> >> > >>
> >> > >> How can we get Nautilus working again?
> >> > >
> >> > > Can you collect a complete dmesg log, ideally both before and after
> >> > > f75b99d5a77d?  I assume the problem is that after f75b99d5a77d? we
> >> > > erroneously assign space for something above 4GB.  But if we know the
> >> > > correct host bridge apertures, we shouldn't assign space outside them,
> >> > > regardless of the PCI bus address size.
> >> >
> >> > I made a mistake in my initial report. Commit f75b99d5a77d is actually
> >> > the last *working* commit. My apologies. The next commit is
> >> > d56dbf5bab8c (PCI: Allocate 64-bit BARs above 4G when possible) and it
> >> > breaks Nautilus I've confirmed.
> >> >
> >> > Please find attached dmesgs from those two commits, from the commit
> >> > immediately before them, and another from 4.17-rc1 with my hack of #if
> >> > 0'ing out the pci_bus_alloc_from_region(..., &pci_high) code.
> >> >
> >> > Thanks for having a look!
> >>
> >> We're telling the PCI core that the host bridge MMIO aperture is the
> >> entire 64-bit address space, so when we assign BARs, some of them end
> >> up above 4GB:
> >>
> >>   pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffffffff]
> >>   pci 0000:00:09.0: BAR 0: assigned [mem 0x100000000-0x10000ffff 64bit]
> >>
> >> But it sounds like the MMIO aperture really ends at 0xffffffff, so
> >> that's not going to work.
> >
> > Correct... This would do as a quick fix, I think:
> >
> > diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
> > index ff4f54b..477ba65 100644
> > --- a/arch/alpha/kernel/sys_nautilus.c
> > +++ b/arch/alpha/kernel/sys_nautilus.c
> > @@ -193,6 +193,8 @@ static struct resource irongate_io = {
> >  };
> >  static struct resource irongate_mem = {
> >         .name   = "Irongate PCI MEM",
> > +       .start  = 0,
> > +       .end    = 0xffffffff,
> >         .flags  = IORESOURCE_MEM,
> >  };
> >  static struct resource busn_resource = {
> > @@ -218,7 +220,7 @@ nautilus_init_pci(void)
> >                 return;
> >
> >         pci_add_resource(&bridge->windows, &ioport_resource);
> > -       pci_add_resource(&bridge->windows, &iomem_resource);
> > +       pci_add_resource(&bridge->windows, &irongate_mem);
> >         pci_add_resource(&bridge->windows, &busn_resource);
> >         bridge->dev.parent = NULL;
> >         bridge->sysdata = hose;
> 
> Thanks. But with that I get
> 
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci 0000:00:10.0: [Firmware Bug]: reg 0x10: invalid BAR (can't size)
> pci 0000:00:10.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
> pci 0000:00:10.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
> pci 0000:00:10.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
> pci 0000:00:10.0: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> pci 0000:00:10.0: legacy IDE quirk: reg 0x14: [io  0x03f6]
> pci 0000:00:10.0: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> pci 0000:00:10.0: legacy IDE quirk: reg 0x1c: [io  0x0376]
> pci 0000:00:11.0: quirk: [io  0x4000-0x403f] claimed by ali7101 ACPI
> pci 0000:00:11.0: quirk: [io  0x5000-0x501f] claimed by ali7101 SMB
> pci 0000:00:01.0: BAR 9: assigned [mem 0xc0000000-0xc2ffffff pref]
> pci 0000:00:01.0: BAR 8: assigned [mem 0xc3000000-0xc3bfffff]
> pci 0000:00:0b.0: BAR 6: assigned [mem 0xc3c00000-0xc3c3ffff pref]
> pci 0000:00:08.0: BAR 6: assigned [mem 0xc3c40000-0xc3c5ffff pref]
> pci 0000:00:09.0: BAR 0: assigned [mem 0xc3c60000-0xc3c6ffff 64bit]
> pci 0000:00:03.0: BAR 0: assigned [mem 0xc3c70000-0xc3c70fff]
> pci 0000:00:06.0: BAR 1: assigned [mem 0xc3c71000-0xc3c71fff]
> pci 0000:00:08.0: BAR 1: assigned [mem 0xc3c72000-0xc3c72fff 64bit]
> pci 0000:00:14.0: BAR 0: assigned [mem 0xc3c73000-0xc3c73fff]
> pci 0000:00:0b.0: BAR 1: assigned [mem 0xc3c74000-0xc3c743ff]
> pci 0000:00:03.0: BAR 1: assigned [io  0x8000-0x80ff]
> pci 0000:00:06.0: BAR 0: assigned [io  0x8400-0x84ff]
> pci 0000:00:08.0: BAR 0: assigned [io  0x8800-0x88ff]
> pci 0000:00:0b.0: BAR 0: assigned [io  0x8c00-0x8c7f]
> pci 0000:00:10.0: BAR 4: assigned [io  0x8c80-0x8c8f]
> pci 0000:01:05.0: BAR 0: assigned [mem 0xc0000000-0xc1ffffff pref]
> pci 0000:01:05.0: BAR 2: assigned [mem 0xc3000000-0xc37fffff]
> pci 0000:01:05.0: BAR 6: assigned [mem 0xc2000000-0xc200ffff pref]
> pci 0000:01:05.0: BAR 1: assigned [mem 0xc3800000-0xc3803fff]
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:00:01.0:   bridge window [mem 0xc3000000-0xc3bfffff]
> pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xc2ffffff pref]
> 
> Looks like the bridge window is overlapping with some previously assigned BARs?

No, there are no overlaps. This is AGP bridge window with AGP card BARs
inside it.

> The result is the SCSI card failing to work:
> 
> scsi host0: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
>         <Adaptec 29160 Ultra160 SCSI adapter>
>         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> 
> scsi0: ahc_intr - referenced scb not valid during SELTO scb(0, 255)
> >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
> scsi0: Dumping Card State while idle, at SEQADDR 0x18
> [snip endless spew]

It looks like Irongate PCI memory window setting is completely wrong,
perhaps it starts at zero, so that PCI DMA doesn't work at all.

Please try the patch below. It tries to fix things properly, but if
PCI bus sizing fails for some reason, it falls back to a "safe" PCI
memory window placement at 3GB.

Ivan.

diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index ff4f54b..b1fb9fd 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -187,10 +187,6 @@ nautilus_machine_check(unsigned long vector, unsigned long la_ptr)
 
 extern void pcibios_claim_one_bus(struct pci_bus *);
 
-static struct resource irongate_io = {
-	.name	= "Irongate PCI IO",
-	.flags	= IORESOURCE_IO,
-};
 static struct resource irongate_mem = {
 	.name	= "Irongate PCI MEM",
 	.flags	= IORESOURCE_MEM,
@@ -218,7 +214,7 @@ nautilus_init_pci(void)
 		return;
 
 	pci_add_resource(&bridge->windows, &ioport_resource);
-	pci_add_resource(&bridge->windows, &iomem_resource);
+	pci_add_resource(&bridge->windows, &irongate_mem);
 	pci_add_resource(&bridge->windows, &busn_resource);
 	bridge->dev.parent = NULL;
 	bridge->sysdata = hose;
@@ -238,20 +234,25 @@ nautilus_init_pci(void)
 	pcibios_claim_one_bus(bus);
 
 	irongate = pci_get_domain_bus_and_slot(pci_domain_nr(bus), 0, 0);
+	/* Pretend that it's not a root bus to allow sizing. */
+	bus->parent = bus;
 	bus->self = irongate;
-	bus->resource[0] = &irongate_io;
-	bus->resource[1] = &irongate_mem;
 
 	pci_bus_size_bridges(bus);
-
-	/* IO port range. */
-	bus->resource[0]->start = 0;
-	bus->resource[0]->end = 0xffff;
+	bus->parent = NULL;
 
 	/* Set up PCI memory range - limit is hardwired to 0xffffffff,
 	   base must be at aligned to 16Mb. */
-	bus_align = bus->resource[1]->start;
-	bus_size = bus->resource[1]->end + 1 - bus_align;
+	if (bus->resource[1]->end) {
+		bus_align = bus->resource[1]->start;
+		bus_size = bus->resource[1]->end + 1 - bus_align;
+		printk(KERN_INFO "PCI MEM size 0x%08lx, align 0x%08lx\n",
+			bus_size, bus_align);
+	} else {
+		bus_size = 0x100000000UL - memtop;
+		bus_align = bus_size;
+		printk(KERN_ERR "PCI MEM sizing failed, using 3GB limit\n");
+	}
 	if (bus_align < 0x1000000UL)
 		bus_align = 0x1000000UL;
 
