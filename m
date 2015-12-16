Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: [PATCH V2 20/23] ACPI, PCI: Refine the way to handle translation_offset for ACPI resources
Date: Wed, 16 Dec 2015 16:16:30 +0100
Message-Id: <1450278993-12664-21-git-send-email-tn@semihalf.com>
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Liu Jiang <jiang.liu@linux.intel.com>

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
 arch/ia64/pci/pci.c     | 26 ++++++++++++++++----------
 drivers/acpi/resource.c | 12 +++++-------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index c1e8ed5..d496976 100644
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
index cdc5c25..6578f68 100644
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
1.9.1

