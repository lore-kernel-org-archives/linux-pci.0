Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V8 4/9] acpi, pci: Support IO resources when parsing PCI host bridge resources.
Date: Mon, 30 May 2016 17:14:17 +0200
Message-Id: <1464621262-26770-5-git-send-email-tn@semihalf.com>
In-Reply-To: <1464621262-26770-1-git-send-email-tn@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Platforms that have memory mapped IO port (such as ARM64) need special
handling for PCI I/O resources. For host bridge's resource probing case
these resources need to be fixed up with pci_register_io_range/pci_remap_iospace etc.

The same I/O resources need to be released after hotplug
removal so that it can be re-added back by the pci_remap_iospace
function during insertion. As a consequence we unmap I/O resources
with pci_unmap_iospace when we release host bridge resources.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/pci_root.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ae3fe4e..ee3b728 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -720,6 +720,40 @@ next:
 	}
 }
 
+#ifdef PCI_IOBASE
+static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
+{
+	struct resource *res = entry->res;
+	resource_size_t cpu_addr = res->start;
+	resource_size_t pci_addr = cpu_addr - entry->offset;
+	resource_size_t length = resource_size(res);
+	unsigned long port;
+
+	if (pci_register_io_range(cpu_addr, length))
+		goto err;
+
+	port = pci_address_to_pio(cpu_addr);
+	if (port == (unsigned long)-1)
+		goto err;
+
+	res->start = port;
+	res->end = port + length - 1;
+	entry->offset = port - pci_addr;
+
+	if (pci_remap_iospace(res, cpu_addr) < 0)
+		goto err;
+
+	pr_info("Remapped I/O %pa to %pR\n", &cpu_addr, res);
+	return;
+err:
+	res->flags |= IORESOURCE_DISABLED;
+}
+#else
+static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
+{
+}
+#endif
+
 int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 {
 	int ret;
@@ -740,6 +774,9 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 			"no IO and memory resources present in _CRS\n");
 	else {
 		resource_list_for_each_entry_safe(entry, tmp, list) {
+			if (entry->res->flags & IORESOURCE_IO)
+				acpi_pci_root_remap_iospace(entry);
+
 			if (entry->res->flags & IORESOURCE_DISABLED)
 				resource_list_destroy_entry(entry);
 			else
@@ -811,6 +848,8 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
 
 	resource_list_for_each_entry(entry, &bridge->windows) {
 		res = entry->res;
+		if (res->flags & IORESOURCE_IO)
+			pci_unmap_iospace(res);
 		if (res->parent &&
 		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
 			release_resource(res);
-- 
1.9.1
