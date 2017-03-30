Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <robh+dt@kernel.org>,
 <frowand.list@gmail.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
 <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V8 2/6] PCI: Apply the new generic I/O management on PCI IO
 hosts
Date: Thu, 30 Mar 2017 23:26:55 +0800
Message-ID: <1490887619-61732-3-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 gabriele.paoloni@huawei.com, minyard@acm.org, benh@kernel.crashing.org,
 john.garry@huawei.com, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 linux-acpi@vger.kernel.org, zourongrong@gmail.com, linux-pci@vger.kernel.org,
 olof@lixom.net, zhichang.yuan02@gmail.com, kantyzc@163.com,
 brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

After introducing the new generic I/O space management(LIBIO), the original PCI
MMIO relevant helpers need to be updated based on the new interfaces defined in
LOGIC_IO.
This patch adapts the corresponding code to match the changes introduced by
LOGIC_IO.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>        #earlier draft
---
 drivers/acpi/pci_root.c |   8 ++--
 drivers/of/address.c    |   5 ++-
 drivers/pci/pci.c       | 104 +++++++++++-------------------------------------
 include/linux/pci.h     |   3 +-
 4 files changed, 34 insertions(+), 86 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 919be0a..4d8cc24 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -730,7 +730,8 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 	}
 }
 
-static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
+static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
+			struct resource_entry *entry)
 {
 #ifdef PCI_IOBASE
 	struct resource *res = entry->res;
@@ -739,7 +740,7 @@ static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
 	resource_size_t length = resource_size(res);
 	unsigned long port;
 
-	if (pci_register_io_range(cpu_addr, length))
+	if (pci_register_io_range(fwnode, cpu_addr, length))
 		goto err;
 
 	port = pci_address_to_pio(cpu_addr);
@@ -781,7 +782,8 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 	else {
 		resource_list_for_each_entry_safe(entry, tmp, list) {
 			if (entry->res->flags & IORESOURCE_IO)
-				acpi_pci_root_remap_iospace(entry);
+				acpi_pci_root_remap_iospace(&device->fwnode,
+						entry);
 
 			if (entry->res->flags & IORESOURCE_DISABLED)
 				resource_list_destroy_entry(entry);
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 02b2903..1693a6f 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -2,8 +2,10 @@
 #define pr_fmt(fmt)	"OF: " fmt
 
 #include <linux/device.h>
+#include <linux/fwnode.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/pci.h>
@@ -323,7 +325,8 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long port;
-		err = pci_register_io_range(range->cpu_addr, range->size);
+		err = pci_register_io_range(&np->fwnode, range->cpu_addr,
+				range->size);
 		if (err)
 			goto invalid_range;
 		port = pci_address_to_pio(range->cpu_addr);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02..c265f89 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3238,68 +3238,38 @@ int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
 }
 EXPORT_SYMBOL(pci_request_regions_exclusive);
 
-#ifdef PCI_IOBASE
-struct io_range {
-	struct list_head list;
-	phys_addr_t start;
-	resource_size_t size;
-};
-
-static LIST_HEAD(io_range_list);
-static DEFINE_SPINLOCK(io_range_lock);
-#endif
-
 /*
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
+			resource_size_t	size)
 {
-	int err = 0;
-
 #ifdef PCI_IOBASE
-	struct io_range *range;
-	resource_size_t allocated_size = 0;
-
-	/* check if the range hasn't been previously recorded */
-	spin_lock(&io_range_lock);
-	list_for_each_entry(range, &io_range_list, list) {
-		if (addr >= range->start && addr + size <= range->start + size) {
-			/* range already registered, bail out */
-			goto end_register;
-		}
-		allocated_size += range->size;
-	}
-
-	/* range not registed yet, check for available space */
-	if (allocated_size + size - 1 > IO_SPACE_LIMIT) {
-		/* if it's too big check if 64K space can be reserved */
-		if (allocated_size + SZ_64K - 1 > IO_SPACE_LIMIT) {
-			err = -E2BIG;
-			goto end_register;
-		}
+	struct logic_pio_hwaddr *range, *tmprange;
 
-		size = SZ_64K;
-		pr_warn("Requested IO range too big, new size set to 64K\n");
-	}
+	if (!size || addr + size < addr)
+		return -EINVAL;
 
-	/* add the range to the list */
-	range = kzalloc(sizeof(*range), GFP_ATOMIC);
-	if (!range) {
-		err = -ENOMEM;
-		goto end_register;
-	}
+	WARN_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(size));
 
-	range->start = addr;
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+	range->fwnode = fwnode;
 	range->size = size;
-
-	list_add_tail(&range->list, &io_range_list);
-
-end_register:
-	spin_unlock(&io_range_lock);
+	range->hw_start = addr;
+	range->flags = PIO_CPU_MMIO;
+
+	tmprange = logic_pio_register_range(range, PAGE_SIZE);
+	if (tmprange != range) {
+		kfree(range);
+		if (IS_ERR(tmprange))
+			return -EFAULT;
+	}
 #endif
 
-	return err;
+	return 0;
 }
 
 phys_addr_t pci_pio_to_address(unsigned long pio)
@@ -3307,21 +3277,10 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
 	phys_addr_t address = (phys_addr_t)OF_BAD_ADDR;
 
 #ifdef PCI_IOBASE
-	struct io_range *range;
-	resource_size_t allocated_size = 0;
-
-	if (pio > IO_SPACE_LIMIT)
+	if ((PIO_SECT_ID(pio)) != PIO_CPU_MMIO)
 		return address;
 
-	spin_lock(&io_range_lock);
-	list_for_each_entry(range, &io_range_list, list) {
-		if (pio >= allocated_size && pio < allocated_size + range->size) {
-			address = range->start + pio - allocated_size;
-			break;
-		}
-		allocated_size += range->size;
-	}
-	spin_unlock(&io_range_lock);
+	address = logic_pio_to_hwaddr(pio);
 #endif
 
 	return address;
@@ -3330,25 +3289,8 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
 unsigned long __weak pci_address_to_pio(phys_addr_t address)
 {
 #ifdef PCI_IOBASE
-	struct io_range *res;
-	resource_size_t offset = 0;
-	unsigned long addr = -1;
-
-	spin_lock(&io_range_lock);
-	list_for_each_entry(res, &io_range_list, list) {
-		if (address >= res->start && address < res->start + res->size) {
-			addr = address - res->start + offset;
-			break;
-		}
-		offset += res->size;
-	}
-	spin_unlock(&io_range_lock);
-
-	return addr;
+	return logic_pio_trans_cpuaddr(address);
 #else
-	if (address > IO_SPACE_LIMIT)
-		return (unsigned long)-1;
-
 	return (unsigned long) address;
 #endif
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a..6401327 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1194,7 +1194,8 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 			void *alignf_data);
 
 
-int pci_register_io_range(phys_addr_t addr, resource_size_t size);
+int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
+			resource_size_t size);
 unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
