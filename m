Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V6 02/13] pci, acpi: Provide generic way to assign bus domain number.
Date: Fri, 15 Apr 2016 19:06:37 +0200
Message-Id: <1460740008-19489-3-git-send-email-tn@semihalf.com>
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As we now have valid PCI host bridge device reference we can
introduce code that is going to find its bus domain number using
ACPI _SEG method.

Note that _SEG method is optional, therefore _SEG absence means
that all PCI buses belong to domain 0.

While at it, for the sake of code clarity we put ACPI and DT domain
assign methods into the corresponding helpers.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_root.c  | 18 ++++++++++++++++++
 drivers/pci/pci.c        | 11 +++++++++--
 include/linux/pci-acpi.h |  2 ++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4581e0e..d9a70c4 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -419,6 +419,24 @@ out:
 }
 EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
+int acpi_pci_bus_domain_nr(struct device *parent)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(parent);
+	unsigned long long segment = 0;
+	acpi_status status;
+
+	/*
+	 * If _SEG method does not exist, following ACPI spec (6.5.6)
+	 * all PCI buses belong to domain 0.
+	 */
+	status = acpi_evaluate_integer(acpi_dev->handle, METHOD_NAME__SEG, NULL,
+				       &segment);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		dev_err(&acpi_dev->dev, "can't evaluate _SEG\n");
+
+	return segment;
+}
+
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 {
 	u32 support, control, requested;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 25e0327..1a74e87 100644
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
@@ -4779,7 +4780,7 @@ int pci_get_new_domain_nr(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+static int of_pci_bus_domain_nr(struct device *parent)
 {
 	static int use_dt_domains = -1;
 	int domain = -1;
@@ -4823,7 +4824,13 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 		domain = -1;
 	}
 
-	bus->domain_nr = domain;
+	return domain;
+}
+
+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	bus->domain_nr = acpi_disabled ? of_pci_bus_domain_nr(parent) :
+					 acpi_pci_bus_domain_nr(parent);
 }
 #endif
 #endif
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 89ab057..a72e22d 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -22,6 +22,7 @@ static inline acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 {
 	return acpi_remove_pm_notifier(dev);
 }
+extern int acpi_pci_bus_domain_nr(struct device *parent);
 extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
 
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
@@ -109,6 +110,7 @@ extern const u8 pci_acpi_dsm_uuid[];
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
+static inline int acpi_pci_bus_domain_nr(struct device *parent) { return -1; }
 #endif	/* CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_APEI
-- 
1.9.1

