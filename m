Return-Path: <linux-kernel-owner@vger.kernel.org>
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>
Subject: [PATCH v14 3/9] PCI: Add fwnode handler as input param of pci_register_io_range()
Date: Tue, 20 Feb 2018 01:48:34 +0800
Message-ID: <1519062520-198902-4-git-send-email-john.garry@huawei.com>
In-Reply-To: <1519062520-198902-1-git-send-email-john.garry@huawei.com>
References: <1519062520-198902-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Gabriele Paoloni <gabriele.paoloni@huawei.com>

In preparation for having the PCI MMIO helpers to use the new generic
I/O space management(logical PIO) we need to add the fwnode handler as
extra input parameter.
This patch changes the signature of pci_register_io_range() and of
its callers as needed.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/acpi/pci_root.c | 8 +++++---
 drivers/of/address.c    | 4 +++-
 drivers/pci/pci.c       | 3 ++-
 include/linux/pci.h     | 3 ++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 6fc204a..1213479 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -729,7 +729,8 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 	}
 }
 
-static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
+static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
+			struct resource_entry *entry)
 {
 #ifdef PCI_IOBASE
 	struct resource *res = entry->res;
@@ -738,7 +739,7 @@ static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
 	resource_size_t length = resource_size(res);
 	unsigned long port;
 
-	if (pci_register_io_range(cpu_addr, length))
+	if (pci_register_io_range(fwnode, cpu_addr, length))
 		goto err;
 
 	port = pci_address_to_pio(cpu_addr);
@@ -780,7 +781,8 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 	else {
 		resource_list_for_each_entry_safe(entry, tmp, list) {
 			if (entry->res->flags & IORESOURCE_IO)
-				acpi_pci_root_remap_iospace(entry);
+				acpi_pci_root_remap_iospace(&device->fwnode,
+						entry);
 
 			if (entry->res->flags & IORESOURCE_DISABLED)
 				resource_list_destroy_entry(entry);
diff --git a/drivers/of/address.c b/drivers/of/address.c
index ce4d3d8..cdf047b 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt)	"OF: " fmt
 
 #include <linux/device.h>
+#include <linux/fwnode.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
@@ -333,7 +334,8 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long port;
-		err = pci_register_io_range(range->cpu_addr, range->size);
+		err = pci_register_io_range(&np->fwnode, range->cpu_addr,
+				range->size);
 		if (err)
 			goto invalid_range;
 		port = pci_address_to_pio(range->cpu_addr);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4666a01..07290a3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3455,7 +3455,8 @@ struct io_range {
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
+			resource_size_t	size)
 {
 	int err = 0;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 25b7a35..17cc998 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1221,7 +1221,8 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 			void *alignf_data);
 
 
-int pci_register_io_range(phys_addr_t addr, resource_size_t size);
+int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
+			resource_size_t size);
 unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
-- 
1.9.1
