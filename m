Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH v5 3/5] ACPI: PCI: Support platforms that need pci_remap_iospace
Date: Mon, 4 Jan 2016 10:43:21 +0530
Message-ID: <1451884403-21437-4-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1451884403-21437-1-git-send-email-jchandra@broadcom.com>
References: <1451884403-21437-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms (in this case ARM64), the PCI iospace needs to
be mapped with pci_remap_iospace and the resources have to be
adjusted for the iospace physical address.

This has to be done before acpi_pci_root_validate_resources()
checks and removes resource windows. Handle this by adding
a function acpi_pci_root_remap_iospace that is called in
acpi_pci_probe_root_resources(), before the validate call.

Also fix the address check in acpi_dev_ioresource_flags for
similar platforms.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/acpi/pci_root.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/acpi/resource.c |  2 ++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 850d7bf..58093ba 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -720,6 +720,61 @@ next:
 	}
 }
 
+#ifdef PCI_IOBASE
+/*
+ * The IO ports are mapped to a memory range, fixup IO resources to
+ * handle that
+ */
+static int acpi_pci_root_remap_iospace(struct acpi_pci_root_info *ci)
+{
+	struct resource_entry *entry;
+	struct resource iores;
+	resource_size_t iostart;
+	int err;
+
+	iores.flags = IORESOURCE_IO;
+	iores.start = (resource_size_t)-1;
+	iores.end = 0;
+	resource_list_for_each_entry(entry, &ci->resources) {
+		if (entry->res->flags & IORESOURCE_IO) {
+			iores.start = min(entry->res->start, iores.start);
+			iores.end = max(entry->res->end, iores.end);
+		}
+	}
+	if (iores.end == 0)
+		return 0;
+	iostart = iores.start;
+
+	resource_list_for_each_entry(entry, &ci->resources) {
+		if (entry->res->flags & IORESOURCE_IO) {
+			entry->res->start -= iostart;
+			entry->res->end -= iostart;
+			entry->offset -= iostart;
+		}
+	}
+	iores.start -= iostart;
+	iores.end -= iostart;
+
+	err = pci_remap_iospace(&iores, iostart);
+	if (err) {
+		pr_err("PCI: ACPI: err %d mapping IO %pR\n", err, &iores);
+		return -ENODEV;
+	}
+	pr_info(PREFIX "Mapped %pR at %#lx for IO.\n",
+			&iores, (unsigned long)iostart);
+	return 0;
+}
+#else
+/*
+ * The IO ports are mapped to a memory range, fixup IO resources to
+ * handle that
+ */
+static int acpi_pci_root_remap_iospace(struct acpi_pci_root_info *ci)
+{
+	return 0;
+}
+#endif /* PCI_IOBASE */
+
 int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 {
 	int ret;
@@ -745,10 +800,13 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 			else
 				entry->res->name = info->name;
 		}
-		acpi_pci_root_validate_resources(&device->dev, list,
+		ret = acpi_pci_root_remap_iospace(info);
+		if (ret >= 0) {
+			acpi_pci_root_validate_resources(&device->dev, list,
 						 IORESOURCE_MEM);
-		acpi_pci_root_validate_resources(&device->dev, list,
+			acpi_pci_root_validate_resources(&device->dev, list,
 						 IORESOURCE_IO);
+		}
 	}
 
 	return ret;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index cdc5c25..530cad4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -126,8 +126,10 @@ static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
 	if (!acpi_dev_resource_len_valid(res->start, res->end, len, true))
 		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
 
+#ifndef PCI_IOBASE
 	if (res->end >= 0x10003)
 		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
+#endif
 
 	if (io_decode == ACPI_DECODE_16)
 		res->flags |= IORESOURCE_IO_16BIT_ADDR;
-- 
1.9.1

