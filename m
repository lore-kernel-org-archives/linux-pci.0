Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: marc.zyngier@arm.com,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	rjw@rjwysocki.net,
	helgaas@kernel.org,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: will.deacon@arm.com,
	catalin.marinas@arm.com,
	hanjun.guo@linaro.org,
	shijie.huang@arm.com,
	robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org,
	andrea.gallo@linaro.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	al.stone@linaro.org,
	graeme.gregory@linaro.org,
	ddaney.cavm@gmail.com,
	okaya@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V10 8/8] irqchip/gicv3-its: Use MADT ITS subtable to do PCI/MSI domain initialization
Date: Tue,  6 Sep 2016 11:08:58 +0200
Message-Id: <1473152938-17388-9-git-send-email-tn@semihalf.com>
In-Reply-To: <1473152938-17388-1-git-send-email-tn@semihalf.com>
References: <1473152938-17388-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Let ACPI build ITS PCI MSI domain. ACPI code is responsible for retrieving
inner domain token and passing it on to its_pci_msi_init_one generic
init call.

IORT maintains list of registered domain tokens and allows to find
corresponding domain based on MADT ITS subtable ID info.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index d2c2496..aee1c60 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -144,9 +145,52 @@ static int __init its_pci_of_msi_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+
+static int __init
+its_pci_msi_parse_madt(struct acpi_subtable_header *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *dom_handle;
+	const char *node_name;
+	int err = -ENXIO;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
+			      (long)its_entry->base_address);
+	dom_handle = iort_find_domain_token(its_entry->translation_id);
+	if (!dom_handle) {
+		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
+		goto out;
+	}
+
+	err = its_pci_msi_init_one(dom_handle, node_name);
+	if (!err)
+		pr_info("PCI/MSI: %s domain created\n", node_name);
+
+out:
+	kfree(node_name);
+	return err;
+}
+
+static int __init its_pci_acpi_msi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+			      its_pci_msi_parse_madt, 0);
+	return 0;
+}
+#else
+static int __init its_pci_acpi_msi_init(void)
+{
+	return 0;
+}
+#endif
+
 static int __init its_pci_msi_init(void)
 {
 	its_pci_of_msi_init();
+	its_pci_acpi_msi_init();
 
 	return 0;
 }
-- 
1.9.1
