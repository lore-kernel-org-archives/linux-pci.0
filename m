Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
To: Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
 <5640A8AA.4000806@semihalf.com> <20151109171042.GA11909@red-moon>
 <6488357.xJV65iBRHq@wuerfel>
Cc: Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <564185B6.8040006@linux.intel.com>
Date: Tue, 10 Nov 2015 13:50:46 +0800
MIME-Version: 1.0
In-Reply-To: <6488357.xJV65iBRHq@wuerfel>
Content-Type: multipart/mixed;
 boundary="------------020604010309010902010902"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020604010309010902010902
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 2015/11/10 4:09, Arnd Bergmann wrote:
> On Monday 09 November 2015 17:10:43 Lorenzo Pieralisi wrote:
>> On Mon, Nov 09, 2015 at 03:07:38PM +0100, Tomasz Nowicki wrote:
>>> On 06.11.2015 14:22, Jiang Liu wrote:
>>>> On 2015/11/6 20:40, Tomasz Nowicki wrote:
>>>>> On 06.11.2015 12:46, Jiang Liu wrote:
>>>>>> On 2015/11/6 18:37, Tomasz Nowicki wrote:
>>>>>>> On 06.11.2015 09:52, Jiang Liu wrote:
>>>>>>> Sure, ARM64 (0-16M IO space) QEMU example:
>>>>>>> DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
>>>>>>>           0x00000000,         // Granularity
>>>>>>>           0x00000000,         // Range Minimum
>>>>>>>           0x0000FFFF,         // Range Maximum
>>>>>>>           0x3EFF0000,         // Translation Offset
>>>>>>>           0x00010000,         // Length
>>>>>>>           ,, , TypeStatic)
>>>>>> The above DWordIO resource descriptor doesn't confirm to the ACPI spec.
>>>>>> According to my understanding, ARM/ARM64 has no concept of IO port
>>>>>> address space, so the PCI host bridge will map IO port on PCI side
>>>>>> onto MMIO on host side. In other words, PCI host bridge on ARM64
>>>>>> implement a IO Port->MMIO translation instead of a IO Port->IO Port
>>>>>> translation. If that's true, it should use 'TypeTranslation' instead
>>>>>> of 'TypeStatic'. And kernel ACPI resource parsing interface doesn't
>>>>>> support 'TypeTranslation' yet, so we need to find a solution for it.
>>>>>
>>>>> I think you are right, we need TypeTranslation flag for ARM64 DWordIO
>>>>> descriptors and an extra kernel patch to support it.
>>>> How about the attached to patch to support TypeTranslation?
>>>> It only passes compilation:)
>>>
>>> Based on the further discussion, your draft patch looks good to me.
>>> Lorenzo, do you agree?
>>
>> No, because I still do not understand the difference between ia64 and
>> arm64 (they both drive IO ports cycles through MMIO so the resource
>> descriptors content must be the same or better they must mean the same
>> thing). On top of that, this is something that was heavily debated for DT:
>>
>> http://www.spinics.net/lists/arm-kernel/msg345633.html
>>
>> and I would like to get Arnd and Bjorn opinion on this because we
>> should not "interpret" ACPI specifications, we should understand
>> what they are supposed to describe and write kernel code accordingly.
>>
>> In particular, I would like to understand, for an eg DWordIO descriptor,
>> what Range Minimum, Range Maximum and Translation Offset represent,
>> they can't mean different things depending on the SW parsing them,
>> this totally defeats the purpose.
> 
> I have no clue about what those mean in ACPI though.
> 
> Generally speaking, each PCI domain is expected to have a (normally 64KB)
> range of CPU addresses that gets translated into PCI I/O space the same
> way that config space and memory space are handled.
> This is true for almost every architecture except for x86, which uses
> different CPU instructions for I/O space compared to the other spaces.
> 
>> By the way, ia64 ioremaps the translation_offset (ie new_space()), so
>> basically that's the CPU physical address at which the PCI host bridge
>> map the IO space transactions), I do not think ia64 is any different from
>> arm64 in this respect, if it is please provide an HW description here from
>> the PCI bus perspective here (also an example of ia64 ACPI PCI host bridge
>> tables would help).
> 
> The main difference between ia64 and a lot of the other architectures (e.g.
> sparc is different again) is that ia64 defines a logical address range
> in terms of having a small number for each I/O space followed by the
> offset within that space as a 'port number' and uses a mapping function
> that is defined as
> 
> static inline void *__ia64_mk_io_addr (unsigned long port)
> {
>         struct io_space *space = &io_space[IO_SPACE_NR(port)];
>         return (space->mmio_base | IO_SPACE_PORT(port););
> }
> static inline unsigned int inl(unsigned long port)
> {
>         return *__ia64_mk_io_addr(port);
> }
> 
> Most architectures allow only one I/O port range and put it at a fixed
> virtual address so that inl() simply becomes 
> 
> static inline u32 inl(unsigned long addr)
> {
>         return readl(PCI_IOBASE + addr);
> }
> 
> which noticeably reduces code size.
> 
> On some architectures (powerpc, arm, arm64), we then get the same simplified
> definition with a fixed virtual address, and use pci_ioremap_io() or
> something like that to to map a physical address range into this virtual
> address window at the correct io_offset;
Hi all,
	Thanks for explanation, I found a way to make the ACPI resource
parsing interface arch neutral, it should help to address Lorenzo's
concern. Please refer to the attached patch. (It's still RFC, not tested
yet).
Thanks,
Gerry

--------------020604010309010902010902
Content-Type: text/plain; charset=UTF-8;
 name="0001-ACPI-PCI-Refine-the-way-to-handle-translation_offset.patch~"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ACPI-PCI-Refine-the-way-to-handle-translation_offset.pa";
 filename*1="tch~"

>From 6521d3c5303b1d9830eecede4c1b778deffe17b0 Mon Sep 17 00:00:00 2001
From: Liu Jiang <jiang.liu@linux.intel.com>
Date: Tue, 10 Nov 2015 10:59:11 +0800
Subject: [PATCH] ACPI, PCI: Refine the way to handle translation_offset for
 ACPI resources

Some architectures, such as IA64 and ARM64, have no instructions to
directly access PCI IO ports, so they map PCI IO ports into PCI MMIO
address space. Typically PCI host bridges on those architectures take
the responsibility to map (translate) PCI IO port transactions into
Memory-Mapped IO transactions. ACPI specification provides support
of such a usage case by using resource translation_offset.

But current ACPI resource parsing interface isn't neutral enough,
it still has some special logic for IA64. So refine the ACPI resource
parsing interface and IA64 code to neutrally handle translation_offset
by:
1) ACPI resource parsing interface doesn't do any translation, it just
   save the translation_offset to be used by arch code.
2) Arch code will do the mapping(translation) based on arch specific
   information. Typically it does:
2.a) Translate per PCI domain IO port address space into system global
   IO port address space.
2.b) Setup MMIO address mapping for IO ports.
void handle_io_resource(struct resource_entry *io_entry)
{
	struct resource *mmio_res;

	mmio_res = kzalloc(sizeof(*mmio_res), GFP_KERNEL);
	mmio_res->flags = IORESOURCE_MEM;
	mmio_res->start = io_entry->offset + io_entry->res->start;
	mmio_res->end = io_entry->offset + io_entry->res->end;
	insert_resource(&iomem_resource, mmio_res)

	base = map_to_system_ioport_address(entry);
	io_entry->offset = base;
	io_entry->res->start += base;
	io_entry->res->end += base;
}

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/ia64/pci/pci.c     |   26 ++++++++++++++++----------
 drivers/acpi/resource.c |   12 +++++-------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 8f6ac2f8ae4c..ee84300797d8 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -154,7 +154,7 @@ static int add_io_space(struct device *dev, struct pci_root_info *info,
 	struct resource_entry *iospace;
 	struct resource *resource, *res = entry->res;
 	char *name;
-	unsigned long base, min, max, base_port;
+	unsigned long base_mmio, base_port;
 	unsigned int sparse = 0, space_nr, len;
 
 	len = strlen(info->common.name) + 32;
@@ -172,12 +172,10 @@ static int add_io_space(struct device *dev, struct pci_root_info *info,
 		goto free_resource;
 
 	name = (char *)(iospace + 1);
-	min = res->start - entry->offset;
-	max = res->end - entry->offset;
-	base = __pa(io_space[space_nr].mmio_base);
+	base_mmio = __pa(io_space[space_nr].mmio_base);
 	base_port = IO_SPACE_BASE(space_nr);
 	snprintf(name, len, "%s I/O Ports %08lx-%08lx", info->common.name,
-		 base_port + min, base_port + max);
+		 base_port + res->start, base_port + res->end);
 
 	/*
 	 * The SDM guarantees the legacy 0-64K space is sparse, but if the
@@ -190,19 +188,27 @@ static int add_io_space(struct device *dev, struct pci_root_info *info,
 	resource = iospace->res;
 	resource->name  = name;
 	resource->flags = IORESOURCE_MEM;
-	resource->start = base + (sparse ? IO_SPACE_SPARSE_ENCODING(min) : min);
-	resource->end   = base + (sparse ? IO_SPACE_SPARSE_ENCODING(max) : max);
+	resource->start = base_mmio;
+	resource->end = base_mmio;
+	if (sparse) {
+		resource->start += IO_SPACE_SPARSE_ENCODING(res->start);
+		resource->end += IO_SPACE_SPARSE_ENCODING(res->end);
+	} else {
+		resource->start += res->start;
+		resource->end += res->end;
+	}
 	if (insert_resource(&iomem_resource, resource)) {
 		dev_err(dev,
 			"can't allocate host bridge io space resource  %pR\n",
 			resource);
 		goto free_resource;
 	}
+	resource_list_add_tail(iospace, &info->io_resources);
 
+	/* Adjust base of original IO port resource descriptor */
 	entry->offset = base_port;
-	res->start = min + base_port;
-	res->end = max + base_port;
-	resource_list_add_tail(iospace, &info->io_resources);
+	res->start += base_port;
+	res->end += base_port;
 
 	return 0;
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index cdc5c2599beb..6578f68b17be 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -190,8 +190,7 @@ static bool acpi_decode_space(struct resource_win *win,
 {
 	u8 iodec = attr->granularity == 0xfff ? ACPI_DECODE_10 : ACPI_DECODE_16;
 	bool wp = addr->info.mem.write_protect;
-	u64 len = attr->address_length;
-	u64 start, end, offset = 0;
+	u64 len = attr->address_length, offset = 0;
 	struct resource *res = &win->res;
 
 	/*
@@ -215,14 +214,13 @@ static bool acpi_decode_space(struct resource_win *win,
 	else if (attr->translation_offset)
 		pr_debug("ACPI: translation_offset(%lld) is invalid for non-bridge device.\n",
 			 attr->translation_offset);
-	start = attr->minimum + offset;
-	end = attr->maximum + offset;
 
 	win->offset = offset;
-	res->start = start;
-	res->end = end;
+	res->start = attr->minimum;
+	res->end = attr->maximum;
 	if (sizeof(resource_size_t) < sizeof(u64) &&
-	    (offset != win->offset || start != res->start || end != res->end)) {
+	    (offset != win->offset || attr->minimum != res->start ||
+	     attr->maximum != res->end)) {
 		pr_warn("acpi resource window ([%#llx-%#llx] ignored, not CPU addressable)\n",
 			attr->minimum, attr->maximum);
 		return false;
-- 
1.7.10.4


--------------020604010309010902010902--
