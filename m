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
	Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH V9 08/11] ARM64/PCI: Add ACPI hook to assign domain number
Date: Fri, 10 Jun 2016 21:55:16 +0200
Message-Id: <1465588519-11334-9-git-send-email-tn@semihalf.com>
In-Reply-To: <1465588519-11334-1-git-send-email-tn@semihalf.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

PCI core code provides a config option (CONFIG_PCI_DOMAINS_GENERIC)
that allows assigning the PCI bus domain number generically by
relying on device tree bindings, and falling back to a simple counter
when the respective DT properties (ie "linux,pci-domain") are not
specified in the host bridge device tree node.

In a similar way, when a system is booted through ACPI, architectures
that are selecting CONFIG_PCI_DOMAINS_GENERIC (ie ARM64) require kernel
hooks to retrieve the domain number so that the PCI bus domain number
set-up can be handled seamlessly with DT and ACPI in generic core code
when CONFIG_PCI_DOMAINS_GENERIC is selected.

Since currently it is not possible to retrieve a pointer to the PCI
host bridge ACPI device backing the host bridge from core PCI code
(which would allow retrieving the domain number in an arch agnostic
way through the ACPI _SEG method), an arch specific ACPI hook has to
be declared and implemented by all arches that rely on
CONFIG_PCI_DOMAINS_GENERIC to retrieve the domain number and set it
up in core PCI code.

For the aforementioned reasons, introduce acpi_pci_bus_find_domain_nr()
hook to retrieve the domain number on a per-arch basis when the system
boots through ACPI. ARM64 dummy implementation of the same is provided
in first place in preparation for ARM64 ACPI based PCI host controller
driver.

acpi_pci_bus_find_domain_nr() is called from generic
pci_bus_find_domain_nr() as an ACPI option to DT domain assignment.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/pci.c | 7 +++++++
 drivers/pci/pci.c       | 4 +++-
 include/linux/pci.h     | 7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 3c4e308..d5d3d26 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 
 /*
@@ -85,6 +86,12 @@ EXPORT_SYMBOL(pcibus_to_node);
 #endif
 
 #ifdef CONFIG_ACPI
+
+int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+{
+	return 0;
+}
+
 /* Root bridge scanning */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 327828d..4834cee 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -7,6 +7,7 @@
  *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
  */
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -4990,7 +4991,8 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
 {
-	return of_pci_bus_find_domain_nr(parent) ;
+	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
+			       acpi_pci_bus_find_domain_nr(bus);
 }
 #endif
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 48839e8..49ba8af 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1390,6 +1390,13 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 {
 	return bus->domain_nr;
 }
+/* Arch specific ACPI hook to set-up domain number */
+#ifdef CONFIG_ACPI
+int acpi_pci_bus_find_domain_nr(struct pci_bus *bus);
+#else
+static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+{ return 0; }
+#endif
 int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
 #endif
 
-- 
1.9.1
