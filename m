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
Subject: [PATCH V7 06/11] pci, acpi: Provide a way to assign bus domain number.
Date: Tue, 10 May 2016 17:19:56 +0200
Message-Id: <1462893601-8937-7-git-send-email-tn@semihalf.com>
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

This patch provides a way to set the ACPI domain number in PCI code.
pci_create_root_bus is called with NULL as parent in ACPI. This
ends up calling pci_bus_assign_domain_nr with a NULL parent.
So we define acpi_pci_bus_domain_nr() which is meant to retrieve
the PCI domain number based on 'struct pci_bus' in the ACPI way.
pci_bus_assign_domain_nr() is updated to call acpi_pci_bus_domain_nr()
and assign domain number on the root bus, in case of ACPI.

acpi_pci_bus_domain_nr function is stub for now.

While at it, for the sake of code clarity we put ACPI and DT domain
assign methods into the corresponding helpers.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/pci.c        | 11 +++++++++--
 include/linux/pci-acpi.h |  5 +++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ff97a0b..a1d7bcf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -19,6 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/log2.h>
+#include <linux/pci-acpi.h>
 #include <linux/pci-aspm.h>
 #include <linux/pm_wakeup.h>
 #include <linux/interrupt.h>
@@ -4918,7 +4919,7 @@ int pci_get_new_domain_nr(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+static int of_pci_bus_domain_nr(struct device *parent)
 {
 	static int use_dt_domains = -1;
 	int domain = -1;
@@ -4962,7 +4963,13 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
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
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 89ab057..09f9f02 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -111,6 +111,11 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
 #endif	/* CONFIG_ACPI */
 
+static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus)
+{
+	return 0;
+}
+
 #ifdef CONFIG_ACPI_APEI
 extern bool aer_acpi_firmware_first(void);
 #else
-- 
1.9.1
