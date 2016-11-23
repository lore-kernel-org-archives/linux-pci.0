Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        T homas Petazzoni <thomas.petazzo.ni@free-electrons.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        John Garry <john.garry@huawei.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@go og le.com" <bhelgaas@google.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Thu, 24 Nov 2016 00:23:07 +0100
Message-ID: <4675465.4Qhqy6WU4X@wuerfel>
In-Reply-To: <2168980.T3HadihU3R@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <EE11001F9E5DDD47B7634E2F8A612F2E1F931E08@lhreml507-mbx> <2168980.T3HadihU3R@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 23, 2016 6:07:11 PM CET Arnd Bergmann wrote:
> On Wednesday, November 23, 2016 3:22:33 PM CET Gabriele Paoloni wrote:
> > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > > On Friday, November 18, 2016 5:03:11 PM CET Gabriele Paoloni wrote:
>
> Please don't proliferate the use of
> pci_pio_to_address/pci_address_to_pio here, computing the physical
> address from the logical address is trivial, you just need to
> subtract the start of the range that you already use when matching
> the port number range.
> 
> The only thing we need here is to make of_address_to_resource()
> return the correct logical port number that was registered for
> a given host device when asked to translate an address that
> does not have a CPU address associated with it.

Ok, I admit this was a little harder than I expected, but see below
for a rough outline of how I think it can be done.

This makes it possible to translate bus specific I/O port numbers
from device nodes into Linux port numbers, and gives a way to register
them. We could take this further and completely remove pci_pio_to_address
and pci_address_to_pio if we make the I/O port translation always
go through the io_range list, looking up up the hostbridge by fwnode,
but we don't have to do that now.

The patch is completely untested and probably buggy, it just seemed
easier to put out a prototype than to keep going in circles with the
discussion.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index bf601d4df8cf..6cadf0501bb0 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -730,7 +730,8 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 	}
 }
 
-static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
+static void acpi_pci_root_remap_iospace(struct fwnode_handle *node,
+					struct resource_entry *entry)
 {
 #ifdef PCI_IOBASE
 	struct resource *res = entry->res;
@@ -739,11 +740,7 @@ static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
 	resource_size_t length = resource_size(res);
 	unsigned long port;
 
-	if (pci_register_io_range(cpu_addr, length))
-		goto err;
-
-	port = pci_address_to_pio(cpu_addr);
-	if (port == (unsigned long)-1)
+	if (pci_register_io_range(node, cpu_addr, length, &port))
 		goto err;
 
 	res->start = port;
@@ -781,7 +778,8 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 	else {
 		resource_list_for_each_entry_safe(entry, tmp, list) {
 			if (entry->res->flags & IORESOURCE_IO)
-				acpi_pci_root_remap_iospace(entry);
+				acpi_pci_root_remap_iospace(&device->fwnode,
+							    entry);
 
 			if (entry->res->flags & IORESOURCE_DISABLED)
 				resource_list_destroy_entry(entry);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a50025a3777f..df96955a43f8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -760,8 +760,10 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		set_bit(NBD_RUNNING, &nbd->runtime_flags);
 		blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
 		args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
-		if (!args)
+		if (!args) {
+			error = -ENOMEM;
 			goto out_err;
+		}
 		nbd->task_recv = current;
 		mutex_unlock(&nbd->config_lock);
 
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 02b2903fe9d2..5decaba96eed 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt)	"OF: " fmt
 
 #include <linux/device.h>
+#include <linux/fwnode.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
@@ -323,14 +324,9 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long port;
-		err = pci_register_io_range(range->cpu_addr, range->size);
+		err = pci_register_io_range(&np->fwnode, range->cpu_addr, range->size, &port);
 		if (err)
 			goto invalid_range;
-		port = pci_address_to_pio(range->cpu_addr);
-		if (port == (unsigned long)-1) {
-			err = -EINVAL;
-			goto invalid_range;
-		}
 		res->start = port;
 	} else {
 		if ((sizeof(resource_size_t) < 8) &&
@@ -479,7 +475,7 @@ static int of_empty_ranges_quirk(struct device_node *np)
 	return false;
 }
 
-static int of_translate_one(struct device_node *parent, struct of_bus *bus,
+static u64 of_translate_one(struct device_node *parent, struct of_bus *bus,
 			    struct of_bus *pbus, __be32 *addr,
 			    int na, int ns, int pna, const char *rprop)
 {
@@ -507,7 +503,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	ranges = of_get_property(parent, rprop, &rlen);
 	if (ranges == NULL && !of_empty_ranges_quirk(parent)) {
 		pr_debug("no ranges; cannot translate\n");
-		return 1;
+		return OF_BAD_ADDR;
 	}
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_number(addr, na);
@@ -528,7 +524,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	}
 	if (offset == OF_BAD_ADDR) {
 		pr_debug("not found !\n");
-		return 1;
+		return offset;
 	}
 	memcpy(addr, ranges + na, 4 * pna);
 
@@ -537,7 +533,10 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	pr_debug("with offset: %llx\n", (unsigned long long)offset);
 
 	/* Translate it into parent bus space */
-	return pbus->translate(addr, offset, pna);
+	if (pbus->translate(addr, offset, pna))
+		return OF_BAD_ADDR;
+
+	return offset;
 }
 
 /*
@@ -549,9 +548,14 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
  * that translation is impossible (that is we are not dealing with a value
  * that can be mapped to a cpu physical address). This is not really specified
  * that way, but this is traditionally the way IBM at least do things
+ *
+ * Whenever the translation fails, the *host pointer will be set to the
+ * device that lacks a tranlation, and the return code is relative to
+ * that node.
  */
 static u64 __of_translate_address(struct device_node *dev,
-				  const __be32 *in_addr, const char *rprop)
+				  const __be32 *in_addr, const char *rprop,
+				  struct device_node **host)
 {
 	struct device_node *parent = NULL;
 	struct of_bus *bus, *pbus;
@@ -564,6 +568,7 @@ static u64 __of_translate_address(struct device_node *dev,
 	/* Increase refcount at current level */
 	of_node_get(dev);
 
+	*host = NULL;
 	/* Get parent & match bus type */
 	parent = of_get_parent(dev);
 	if (parent == NULL)
@@ -600,8 +605,9 @@ static u64 __of_translate_address(struct device_node *dev,
 		pbus = of_match_bus(parent);
 		pbus->count_cells(dev, &pna, &pns);
 		if (!OF_CHECK_COUNTS(pna, pns)) {
-			pr_err("Bad cell count for %s\n",
-			       of_node_full_name(dev));
+			pr_debug("Bad cell count for %s\n",
+				 of_node_full_name(dev));
+			*host = of_node_get(parent);
 			break;
 		}
 
@@ -609,7 +615,9 @@ static u64 __of_translate_address(struct device_node *dev,
 		    pbus->name, pna, pns, of_node_full_name(parent));
 
 		/* Apply bus translation */
-		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna, rprop))
+		result = of_translate_one(dev, bus, pbus, addr, na, ns,
+					  pna, rprop);
+		if (result == OF_BAD_ADDR)
 			break;
 
 		/* Complete the move up one level */
@@ -628,13 +636,32 @@ static u64 __of_translate_address(struct device_node *dev,
 
 u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
 {
-	return __of_translate_address(dev, in_addr, "ranges");
+	struct device_node *host;
+	u64 ret;
+
+	ret =  __of_translate_address(dev, in_addr, "ranges", &host);
+	if (host) {
+		of_node_put(host);
+		return OF_BAD_ADDR;
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(of_translate_address);
 
 u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 {
-	return __of_translate_address(dev, in_addr, "dma-ranges");
+	struct device_node *host;
+	u64 ret;
+
+	ret = __of_translate_address(dev, in_addr, "dma-ranges", &host);
+
+	if (host) {
+		of_node_put(host);
+		return OF_BAD_ADDR;
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(of_translate_dma_address);
 
@@ -676,29 +703,48 @@ const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
 }
 EXPORT_SYMBOL(of_get_address);
 
+extern unsigned long extio_translate(struct fwnode_handle *node, unsigned long offset);
+
+u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr)
+{
+	u64 taddr;
+	unsigned long port;
+	struct device_node *host;
+
+	taddr = __of_translate_address(dev, in_addr, "ranges", &host);
+	if (host) {
+		/* host specific port access */
+		port = extio_translate(&host->fwnode, taddr);
+		of_node_put(host);
+	} else {
+		/* memory mapped I/O range */
+		port = pci_address_to_pio(taddr);
+		if (port == (unsigned long)-1)
+			return OF_BAD_ADDR;
+	}
+
+	return port;
+}
+
 static int __of_address_to_resource(struct device_node *dev,
 		const __be32 *addrp, u64 size, unsigned int flags,
 		const char *name, struct resource *r)
 {
 	u64 taddr;
 
-	if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
+	if (flags & IORESOURCE_MEM)
+		taddr = of_translate_address(dev, addrp);
+	else if (flags & IORESOURCE_IO)
+		taddr = of_translate_ioport(dev, addrp);
+	else
 		return -EINVAL;
-	taddr = of_translate_address(dev, addrp);
+
 	if (taddr == OF_BAD_ADDR)
 		return -EINVAL;
 	memset(r, 0, sizeof(struct resource));
-	if (flags & IORESOURCE_IO) {
-		unsigned long port;
-		port = pci_address_to_pio(taddr);
-		if (port == (unsigned long)-1)
-			return -EINVAL;
-		r->start = port;
-		r->end = port + size - 1;
-	} else {
-		r->start = taddr;
-		r->end = taddr + size - 1;
-	}
+
+	r->start = taddr;
+	r->end = taddr + size - 1;
 	r->flags = flags;
 	r->name = name ? name : dev->full_name;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index eda6a7cf0e54..320ab9fbf6af 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3249,6 +3249,7 @@ EXPORT_SYMBOL(pci_request_regions_exclusive);
 #ifdef PCI_IOBASE
 struct io_range {
 	struct list_head list;
+	struct fwnode_handle *node;
 	phys_addr_t start;
 	resource_size_t size;
 };
@@ -3257,11 +3258,14 @@ static LIST_HEAD(io_range_list);
 static DEFINE_SPINLOCK(io_range_lock);
 #endif
 
+#define IO_RANGE_IOEXT (resource_size_t)(-1ull)
+
 /*
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int __weak pci_register_io_range(struct fwnode_handle *node, phys_addr_t addr,
+				 resource_size_t size, unsigned long *port)
 {
 	int err = 0;
 
@@ -3272,7 +3276,12 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
 	/* check if the range hasn't been previously recorded */
 	spin_lock(&io_range_lock);
 	list_for_each_entry(range, &io_range_list, list) {
-		if (addr >= range->start && addr + size <= range->start + size) {
+		if (node == range->node)
+			goto end_register;
+
+		if (addr != IO_RANGE_IOEXT &&
+		    addr >= range->start &&
+		    addr + size <= range->start + size) {
 			/* range already registered, bail out */
 			goto end_register;
 		}
@@ -3298,6 +3307,7 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
 		goto end_register;
 	}
 
+	range->node = node;
 	range->start = addr;
 	range->size = size;
 
@@ -3305,11 +3315,26 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
 
 end_register:
 	spin_unlock(&io_range_lock);
+
+	*port = allocated_size;
+#else
+	/*
+	 * powerpc and microblaze have their own registration,
+	 * just look up the value here
+	 */
+	*port = pci_address_to_pio(addr);
 #endif
 
 	return err;
 }
 
+#ifdef CONFIG_IOEXT
+int ioext_register_io_range
+{
+	return pci_register_io_range(node, IO_RANGE_IOEXT, size, port);
+}
+#endif
+
 phys_addr_t pci_pio_to_address(unsigned long pio)
 {
 	phys_addr_t address = (phys_addr_t)OF_BAD_ADDR;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6bd94a803e8f..b7a8fa3da3ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1192,7 +1192,8 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 			void *alignf_data);
 
 
-int pci_register_io_range(phys_addr_t addr, resource_size_t size);
+int pci_register_io_range(struct fwnode_handle *node, phys_addr_t addr,
+			  resource_size_t size, unsigned long *port);
 unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
