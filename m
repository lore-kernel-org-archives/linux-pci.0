Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:56886 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab2JaWGH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 18:06:07 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <arnd@arndb.de>;
	Wed, 31 Oct 2012 22:06:05 -0000
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q9VM5tsu61603946
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 22:05:55 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q9VM61Tm010174
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 16:06:02 -0600
From: Arnd Bergmann <arnd@arndb.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 04/15] SPEAr13xx: Add PCIe Root Complex driver support
Date: Wed, 31 Oct 2012 22:00:59 +0000
Cc: Shiraz HASHIM <shiraz.hashim@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"spear-devel" <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"olof@lixom.net" <olof@lixom.net>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1351492562.git.pratyush.anand@st.com> <201210302220.23690.arnd@arndb.de> <50910A64.7040306@st.com>
In-Reply-To: <50910A64.7040306@st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201210312200.59324.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 31 October 2012, Pratyush Anand wrote:
> On 10/31/2012 3:50 AM, Arnd Bergmann wrote:
> > On Monday 29 October 2012, Pratyush Anand wrote:
> >> SPEAr13xx has dual mode PCIe controller which can be used as Root
> >> Complex as well as Endpoint. This driver supports RC mode of the
> >> controller.
> >>
> >> If CONFIG_PCI_MSI is defined then support of MSI interrupt for
> >> downstream  PCIe devices will be enabled.
> >>
> >> If CONFIG_PM is defined then it supports suspend/resume functionality.
> >
> > I think I've seen the same hardware before used with another driver.
> > IMHO we should really make sure this does not get duplicated again and
> > move this stuff to a new subdirectory drivers/pci/host. We don't yet have
> > a completely architecture independent way of defining a PCIe root complex,
> > but we're getting there and given of how many ARM implementations we have,
> > we can just as well start with this one and adapt it to another arch if
> > necesary.
> >
> 
> Yes, I too wanted to put it into drivers/pci/host. But, still it would 
> be ARCH (arm) dependent, until we have a common solution for all 
> architecture. Let me know, if I can put it into drivers/pci/host even if 
> it works initially for ARM only.


This is ultimately up to Bjorn Helgaas as the PCI maintainer. I think
everybody would prefer to have an architecture independent interface between
PCI hosts and platform specific code, and we are progressing towards that
goal. I think it would be worthwhile to have this code already in
drivers/pci while it's still ARM specific, and then remove the ARM bits
over time by replacing them with generic interfaces as we get there.

> 
> >> +struct pcie_port {
> >> +	u8			controller;
> >> +	u8			root_bus_nr;
> >> +	void __iomem		*dbi_base;
> >> +	void __iomem		*va_dbi_base;
> >> +	void __iomem		*app_base;
> >> +	void __iomem		*va_app_base;
> >> +	void __iomem		*base;
> >> +	void __iomem		*phy_base;
> >> +	void __iomem		*va_phy_base;
> >> +	void __iomem		*cfg0_base;
> >> +	void __iomem		*va_cfg0_base;
> >> +	void __iomem		*cfg1_base;
> >> +	void __iomem		*va_cfg1_base;
> >> +	void __iomem		*mem_base;
> >> +	void __iomem		*io_base;
> >> +	spinlock_t		conf_lock;
> >> +	char			mem_space_name[16];
> >> +	char			io_space_name[16];
> >> +	struct resource		res[2];
> >> +	struct pcie_port_info	config;
> >> +	struct list_head	next;
> >> +	struct clk		*clk;
> >> +	int			irq;
> >> +	int			virt_irq_base;
> >> +	int			susp_state;
> >> +};
> >
> > Can you explain why you need a total of 13 virtual memory areas?
> >
> 
> Ah, its not 13, Its just 5 all va_xxxx.
> Probably, I have wrongly put __iomem annotation  with physical addresses 
> too. I will correct. Will keep physical address as normal void *.

Physical addresses should not be pointers at all, but they should be
phys_addr_t. If you have a system with LPAE enabled, the physical
address space may be 64 bit long, so pointers don't work on that.

> >> +static struct list_head	pcie_port_list;
> >
> > I'm pretty sure you don't need your own list of ports, since we already enumerate the
> > ports in the PCI code.
> >
> 
> This pcie_port_list is list of private data (struct pcie_port). 
> Callbacks defined in struct hw_pci such as setup, scan etc are called 
> with first argument as controller number. Now other option could have 
> been to use a simple array of struct pcie_port[MAX_PORT_NUM], as other 
> platforms has used. But I thought to keep list as better option, so that 
> we are not dependent on MAX_PORT_NUM.

A list is indeed better than a static array. However, the preferred way to
do kernel code is to not have any such global lists in a device driver at
all, but keep it inside of the subsystems. I don't remember how this is
done for PCIe ports, but I would assume that you can iterate over them
already. If not, it would be nice to add this feature to the PCI subsystem
so that nobody has to keep arrays or lists like this.

> >> +static struct hw_pci pci;
> >
> > Why is this not statically initialized?
> 
> Ok, ll take care in next version.

I noticed later that it does get statically initialized below, so my comment wasn't
actually correct. However, you should try to order the symbols so that you don't
need forward declarations.

> > This function looks completely bogus. Subtracting PCIBIOS_MIN_IO means that
> > everything is shifted by 0x1000 ports, since secondary bridges don't
> > have this offset. The I/O spaces are just mapped linearly into the virtual
> > address space anyway, so looking up the I/O base like this is pointless.
> >
> 
> Frankly speaking, I do not have clear understanding of PCIe IO 
> transaction. I did not test any PCIe device with my host which might 
> need IO resource. Since , my host controller does support IO 
> transaction, I want to support it in driver. Let me explain my 
> requirement, please correct my understanding where I am wrong.
> 
> -- I can program one my viewport to generate IO transaction on PCIe bus, 
> if CPU writes between AHB address 0x80000000-0x80007FFF.
> 
> -- Now, lets say a PCIe device needs 100 io ports, then address range 
> 0x80000000-0x80000064 will be allocated to this device by pci stack. It 
> will also write 0x80000000 to IO_BAR register of its configuration 
> address space. Now, if my CPU writes at ahb address 0x80000010 then 16th 
> IO port of this device will be written.

The number space for I/O ports is usually 16 bits, which is a hardware
limitation on x86. Practically all PCI implementations on non-x86
architecture have the I/O access directly mapped into the physical
address space, like you have at phys address 0x80000000. However, the
port number for the first port in there is still "0", not "0x80000000",
and the I/O window in you PCI host registers should be set up so that
an access to address 0x80000000 gets translated into a I/O transfer
at address 0 on the PCI bus. This is different from the memory window,
which is typically set up so that the physical addresses are the
same as the bus address in PCI memory space accesses.

> -- Probably, I need something like following and it will remove 
> mach/io.h , hence spear13xx_pcie_io_base too.
> 
> --- a/arch/arm/mach-spear13xx/pcie.c
> +++ b/arch/arm/mach-spear13xx/pcie.c
> @@ -414,7 +414,7 @@ static int __init pcie_setup(int nr, struct 
> pci_sys_data *sys)
>          pp->res[1].flags = IORESOURCE_IO;
>          if (request_resource(&ioport_resource, &pp->res[1]))
>                  panic("can't allocate PCIe IO space");
> -       pci_add_resource_offset(&sys->resources, &pp->res[1], 
> sys->io_offset);
> +       pci_add_resource_offset(&sys->resources, &pp->res[1], 0x80000000);

The io_offset should be zero on all modern implementations, we just have a few
legacy cases that we carry around mostly because of interactions with older
PCMCIA drivers that can get fixed over time.

If you have multiple root buses, you can choose to make the offset for the
second bus 0x10000.

> >> +static void pcie_host_init(struct pcie_port *pp)
> >> +{
> >> +	struct pcie_port_info *config = &pp->config;
> >> +	void __iomem *dbi_base = pp->va_dbi_base;
> >> +	struct pcie_app_reg *app_reg = pp->va_app_base;
> >> +	u32 exp_cap_off = PCI_CAP_ID_EXP_OFFSET;
> >> +	u32 val;
> >> +
> >> +	/* Keep first 64K for IO */
> >> +	pp->io_base = pp->base;
> >> +	pp->mem_base = pp->io_base + config->io_size;
> >> +	pp->cfg0_base = pp->mem_base + config->mem_size;
> >> +	pp->cfg1_base = pp->cfg0_base + config->cfg0_size;
> >
> > Why is the memory space part of the virtual bus address range here?
> 
> Sorry, its not virtual address. I will remove __iomem from all physical 
> address pointer.

Ok. I suspect that you don't actually need to store the physicall address
then, because it's not needed after setting up the devices, and you can easily
retrieve it from the resources.

> >> +	pp->config.io_size = IO_SIZE_PER_PORT;
> >> +	of_property_read_u32(np, "pcie-host,is_host", &pp->config.is_host);
> >> +	of_property_read_u32(np, "pcie-host,is_gen1", &pp->config.is_gen1);
> >
> > These should probably be derived from the "compatible" value.
> 
> Yes, about is_host I think, I will go with "compatible".
> 
> Let me explain why I have provided is_gen1: There are few buggy PCIe 
> cards which links up only if host is gen1. My host is by default gen2. 
> It does work with gen1 as well as gen2 devices except some buggy gen1 
> devices. I provided this flag, to force controller to linkup at gen1 
> only so that it can work with those buggy cards too.

Ok, makes sense.

Thanks for the quick replies. I hope I managed to explain the I/O space accesses
now.

	Arnd

