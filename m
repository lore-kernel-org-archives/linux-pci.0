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
Subject: [PATCH V8 5/9] pci, acpi: add acpi hook to assign domain number.
Date: Mon, 30 May 2016 17:14:18 +0200
Message-Id: <1464621262-26770-6-git-send-email-tn@semihalf.com>
In-Reply-To: <1464621262-26770-1-git-send-email-tn@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
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

For the aforementioned reasons, this patch introduces a dummy
acpi_pci_bus_domain_nr() hook in preparation for per-arch implementation
of the same to retrieve the domain number on a per-arch basis when
the system boots through ACPI.

For the sake of code clarity the current code implementing generic
domain number assignment (ie pci_bus_assign_domain_nr(), selected by
CONFIG_PCI_DOMAINS_GENERIC) is reshuffled so that the code implementing
the DT domain assignment function is stubbed out into a corresponding
helper, so that DT and ACPI functions are clearly separated in
preparation for arches acpi_pci_bus_domain_nr() implementations.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/pci.c   | 11 +++++++++--
 include/linux/pci.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index eb431b5..2b52178 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -7,6 +7,7 @@
  *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
  */
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -4941,7 +4942,7 @@ int pci_get_new_domain_nr(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+static int of_pci_bus_domain_nr(struct device *parent)
 {
 	static int use_dt_domains = -1;
 	int domain = -1;
@@ -4985,7 +4986,13 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 		domain = -1;
 	}
 
-	bus->domain_nr = domain;
+	return domain;
+}
+
+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	bus->domain_nr = acpi_disabled ? of_pci_bus_domain_nr(parent) :
+					 acpi_pci_bus_domain_nr(bus);
 }
 #endif
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 12349de..bba4053 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1390,6 +1390,7 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 {
 	return bus->domain_nr;
 }
+static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus) { return -1; }
 void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
 #else
 static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
-- 
1.9.1
