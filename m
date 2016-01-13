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
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V3 13/21] pci, acpi: Provide generic way to assign bus domain number.
Date: Wed, 13 Jan 2016 14:20:59 +0100
Message-Id: <1452691267-32240-14-git-send-email-tn@semihalf.com>
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As we now have valid PCI host bridge device reference we can
introduce code that is going to find its bus domain number using
ACPI _SEG method.

Note that _SEG method is optional, therefore _SEG absence means
that all PCI buses belong to domain 0.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/pci/pci.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7274006..39a985b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -25,6 +25,7 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
+#include <linux/acpi.h>
 #include <asm-generic/pci-bridge.h>
 #include <asm/setup.h>
 #include <linux/aer.h>
@@ -4796,14 +4797,34 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 	 * API and update the use_dt_domains value to keep track of method we
 	 * are using to assign domain numbers (use_dt_domains = 0).
 	 *
+	 * IF ACPI, we expect non-DT method (use_dt_domains == -1)
+	 * and call _SEG method for corresponding host bridge device.
+	 * If _SEG method does not exist, following ACPI spec (6.5.6)
+	 * all PCI buses belong to domain 0.
+	 *
 	 * All other combinations imply we have a platform that is trying
-	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
-	 * which is a recipe for domain mishandling and it is prevented by
-	 * invalidating the domain value (domain = -1) and printing a
-	 * corresponding error.
+	 * to mix domain numbers obtained from DT, ACPI and
+	 * pci_get_new_domain_nr(), which is a recipe for domain mishandling and
+	 * it is prevented by invalidating the domain value (domain = -1) and
+	 * printing a corresponding error.
 	 */
+
 	if (domain >= 0 && use_dt_domains) {
 		use_dt_domains = 1;
+#ifdef CONFIG_ACPI
+	} else if (!acpi_disabled && use_dt_domains == -1) {
+		struct acpi_device *acpi_dev = to_acpi_device(parent);
+		unsigned long long segment = 0;
+		acpi_status status;
+
+		status = acpi_evaluate_integer(acpi_dev->handle,
+					       METHOD_NAME__SEG, NULL,
+					       &segment);
+		if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+			dev_err(&acpi_dev->dev,  "can't evaluate _SEG\n");
+
+		domain = segment;
+#endif
 	} else if (domain < 0 && use_dt_domains != 1) {
 		use_dt_domains = 0;
 		domain = pci_get_new_domain_nr();
-- 
1.9.1

