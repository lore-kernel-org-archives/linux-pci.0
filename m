Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Thu, 24 Nov 2016 11:24:58 +0100
Message-ID: <7064030.nCfbxY2Cn2@wuerfel>
In-Reply-To: <5836AF11.7060400@hisilicon.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <4675465.4Qhqy6WU4X@wuerfel> <5836AF11.7060400@hisilicon.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "liviu.dudau@arm.com" <liviu.dudau@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 T homas Petazzoni <thomas.petazzo.ni@free-electrons.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "minyard@acm.org" <minyard@acm.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 John Garry <john.garry@huawei.com>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@go og le.com" <bhelgaas@google.com>,
 "kantyzc@163.com" <kantyzc@163.com>,
 "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "olof@lixom.net" <olof@lixom.net>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, November 24, 2016 5:12:49 PM CET zhichang.yuan wrote:
> On 2016/11/24 7:23, Arnd Bergmann wrote:
> > On Wednesday, November 23, 2016 6:07:11 PM CET Arnd Bergmann wrote:
> >> On Wednesday, November 23, 2016 3:22:33 PM CET Gabriele Paoloni wrote:
> >>> From: Arnd Bergmann [mailto:arnd@arndb.de]
> >>>> On Friday, November 18, 2016 5:03:11 PM CET Gabriele Paoloni wrote:
> >>
> > @@ -781,7 +778,8 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
> >  	else {
> >  		resource_list_for_each_entry_safe(entry, tmp, list) {
> >  			if (entry->res->flags & IORESOURCE_IO)
> > -				acpi_pci_root_remap_iospace(entry);
> > +				acpi_pci_root_remap_iospace(&device->fwnode,
> > +							    entry);
> >  
> >  			if (entry->res->flags & IORESOURCE_DISABLED)
> >  				resource_list_destroy_entry(entry);
> 
> I think those changes in pci_root.c is only to match the new definition of
> pci_register_io_range() and work for PCI I/O. It doesn't make sense for LPC, is
> it right?

Right, we wouldn't call acpi_pci_probe_root_resources() for LPC,
the change is just that we always pass the fwnode pointer to allow
matching based on that for any I/O space that does not have a
physical memory address associated with it.

I tried to keep this part general, so in theory that allows us to
have more than one I/O space without a CPU mapping, even though
we don't strictly need that for supporting your LPC controller.

> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index a50025a3777f..df96955a43f8 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -760,8 +760,10 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
> >  		set_bit(NBD_RUNNING, &nbd->runtime_flags);
> >  		blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
> >  		args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
> > -		if (!args)
> > +		if (!args) {
> > +			error = -ENOMEM;
> >  			goto out_err;
> > +		}
> >  		nbd->task_recv = current;
> >  		mutex_unlock(&nbd->config_lock);
> >  
> I think change here is none of the business.:)

Right, sorry about that, I forgot to commit this bugfix before looking
at the I/O space stuff.

> > +	*host = NULL;
> >  	/* Get parent & match bus type */
> >  	parent = of_get_parent(dev);
> >  	if (parent == NULL)
> > @@ -600,8 +605,9 @@ static u64 __of_translate_address(struct device_node *dev,
> >  		pbus = of_match_bus(parent);
> >  		pbus->count_cells(dev, &pna, &pns);
> >  		if (!OF_CHECK_COUNTS(pna, pns)) {
> > -			pr_err("Bad cell count for %s\n",
> > -			       of_node_full_name(dev));
> > +			pr_debug("Bad cell count for %s\n",
> > +				 of_node_full_name(dev));
> > +			*host = of_node_get(parent);
> >  			break;
> >  		}
> I don't think here is the right place to fill *host. I think you want to return
> the parent where the of_translate_one() failed for the 'ranges' property
> missing. So, I think this seems better:
> 
> if (of_translate_one(dev, bus, pbus, addr, na, ns, pna, rprop)) {
> 			*host = of_node_get(dev);
> 			break;
> }

You are right, I got the wrong place. The parent node will have 
a #address-cells but won't have ranges for the I/O space.

> > @@ -3272,7 +3276,12 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> >  	/* check if the range hasn't been previously recorded */
> >  	spin_lock(&io_range_lock);
> >  	list_for_each_entry(range, &io_range_list, list) {
> > -		if (addr >= range->start && addr + size <= range->start + size) {
> > +		if (node == range->node)
> > +			goto end_register;
> > +
> I don't think it is safe to only check the node had been registered. For
> PCI/PCIE, there is only one I/O windows in bridge, it seems ok. But for non-pci
> devices, such as ISA/LPC, I wonder it is possible there are several disjoint I/O
> 'ranges' entries...

I think this part is completely safe, I can't imagine why you'd
have more than one range of I/O ports that have valid translations.

Do you have a specific example in mind where that would not be
the case, or are you just worried about the principle in general?

> What parameters are necessary for linux PIO allocation?
> 1) For those bus devices which have no MMIO( that is to say, indirectIO is
> using),  I think 'addr' is not needed, but 'size' is mandatory;

Agreed.

> I am thinking for our LPC, as there is no cpu address, we should not input
> 'addr' for the io range register. With 'size' as parameter, we implement a new
> io range register function where can assign an unique linux PIO for this
> register calling. The output linux PIO can allocate from a sub-range of whole
> I/O space of [0, IO_SPACE_LIMIT]. This sub-range is specific for indirectIO, I
> want to define a new macro, such as EXTIO_LIMIT, to represent the upper limit of
> indirect IO space.
> 
> #if defined(CONFIG_PCI) && defined(CONFIG_INDIRECT_PIO)
> #define EXTIO_LIMIT	PCIBIOS_MIN_IO
> #elif defined(CONFIG_INDIRECT_PIO)
> #define EXTIO_LIMIT	0x1000
> #else
> #define EXTIO_LIMIT 	0x00
> #end
> 
> We should do some checkings to ensure EXTIO_LIMIT < IO_SPACE_LIMIT.

I think we don't need to limit the EXTIO range at all. For your
specific case of LPC, we know it is limited, but my prototype
patch leaves this part generic enough to also allow using it
for a PCI host with indirect I/O space, and that can have a larger
size.

> Then when someone call pci_register_io_range() or a new function for the linux
> PIO register, we can allocate linux PIO from [0, EXTIO_LIMIT) for indirectIO
> bus, from [EXTIO_LIMIT, IO_SPACE_LIMIT] for MMIO;
> 
> But there are issues confused me yet. For example, how to know the IO size for
> the indirectIO bus? You known, there is no 'ranges' property for those buses....

Good point. We normally call pci_register_io_range() from
of_pci_range_to_resource and its ACPI equivalent.

When there is no ranges, we obviously won't call it, but there is
also no size associated with it. I think this is ok because
the host driver would already know the size based on the hardware
register layout, and it can just register that directly.

> 2) For PCI MMIO, I think 'addr' is needed

So far I assumed it was, but actually we can perhaps remove
the address if we manage to kill off pci_address_to_pio()
and pci_pio_to_address.

> As for the current pci_register_io_range()/pci_address_to_pio(), I have two doubts:
> 
> 2.1) If there are multiple PCI host bridges which support I/O transaction, I
> wonder whether the first host bridge can access the downstream devices with bus
> I/O address in [0, PCIBIOS_MIN_IO)
> 
> for the first host bridge, pci_address_to_pio() will return a linux PIO range
> start from 0.
> But when calling __pci_assign_resource() to allocate the linux PIO for PCI/PCIE
> devices/buses which are just children of first host bus, it can not allocate
> linux PIO less than PCIBIOS_MIN_IO, which means kernel can not called in/out()
> with port less than PCIBIOS_MIN_IO. But we had ioremap [PCI_IOBASE + 0,
> PCI_IOBASE + size) to [pci_ioadd, pci_ioadd + size) before.
> 
> 
> static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
> 		int resno, resource_size_t size, resource_size_t align)
> {
> 	struct resource *res = dev->resource + resno;
> 	resource_size_t min;
> 	int ret;
> 
> 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
> 
> 
> and in the later function:
> 
> static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
> 		resource_size_t size, resource_size_t align,
> 		resource_size_t min, unsigned long type_mask,
> 		resource_size_t (*alignf)(void *,
> 
> ....
> 	pci_bus_for_each_resource(bus, r, i) {
> 		resource_size_t min_used = min;
> ....
> 		if (avail.start)
> 			min_used = avail.start;
> 
> 		max = avail.end;
> 
> 		/* Ok, try it out.. */
> 		ret = allocate_resource(r, res, size, min_used, max,
> 					align, alignf, alignf_data);
> 
> After allocate_resource(), a IO resource is allocated, but whose 'start' is not
> less than min_used.( since avail.start is 0, min_used will keep the 'min'
> without change to avail.start; Should be PCIBIOS_MIN_IO).

I'm not completely sure I'm following here. Generally speaking, addresses
below PCIBIOS_MIN_IO are intended for PCI-ISA bridges and PCI devices with
hardcoded port numbers for ISA compatibility, while __pci_assign_resource
is meant to do dynamic assignment of I/O resources above PCIBIOS_MIN_IO
so it does not conflict with the legacy ISA ports.

Does that address your concern?

> 2.2) Is it possible the return linux PIO isn't page-aligned?
> 
> When calling pci_remap_iospace(const struct resource *res, phys_addr_t
> phys_addr), if res->start is not page-aligned, it seems that
> ioremap_page_range() will meet some issues for duplication iorempa for same
> virtual page.
> 
> of-course, if we always configure the I/O ranges size as page-aligned, it will
> be OK.
> 
> I found PowerPC will ensure the 'vaddress' and the 'size' are page-aligned
> before ioremap, do we need to improve the current handling in
> pci_register_io_range/pci_address_to_pio?

I think it would be a good idea to enforce page-alignment here, even
though everything could still work if it's not page-aligned.

The requirement for ioremap_page_range() is that the offset within
a page must be the same for the virtual and physical addresses.

Adding page-alignment to pci_register_io_range() could be an enhancement
that we can do independent of the other patches.

Thanks a lot for your detailed analysis and feedback.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
