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
Subject: [PATCH V9 6/8] irqchip/gicv3-its: Probe ITS in the ACPI way
Date: Mon,  5 Sep 2016 22:05:38 +0200
Message-Id: <1473105940-9761-7-git-send-email-tn@semihalf.com>
In-Reply-To: <1473105940-9761-1-git-send-email-tn@semihalf.com>
References: <1473105940-9761-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

ITS is prepared for being initialized different than DT,
therefore we can initialize it in ACPI way. We collect register base
address from MADT table and pass mandatory info to firmware-agnostic
ITS init call.

Use here IORT lib to register ITS domain which then can be found and
used on to build another PCI MSI domain in hierarchical stack domain.

NOTE: Waiting for proper ITS and NUMA node relation description in IORT
table, we pass around NUMA_NO_NODE to the its_probe_one init call.
This means that Cavium ThunderX erratum 23144 (pass1.1 only)
is not supported for ACPI boot method yet.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/Kconfig          |  1 +
 drivers/irqchip/irq-gic-v3-its.c | 61 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7f87289..9aeea1d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -39,6 +39,7 @@ config ARM_GIC_V3_ITS
 	bool
 	depends on PCI
 	depends on PCI_MSI
+	select ACPI_IORT if ACPI
 
 config ARM_NVIC
 	bool
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c7518c7..7c0089f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -15,10 +15,13 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/iort.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
@@ -1438,6 +1441,11 @@ static int its_irq_gic_domain_alloc(struct irq_domain *domain,
 		fwspec.param[0] = GIC_IRQ_TYPE_LPI;
 		fwspec.param[1] = hwirq;
 		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+	} else if (is_fwnode_irqchip(domain->parent->fwnode)) {
+		fwspec.fwnode = domain->parent->fwnode;
+		fwspec.param_count = 2;
+		fwspec.param[0] = hwirq;
+		fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
 	} else {
 		return -EINVAL;
 	}
@@ -1797,6 +1805,57 @@ static int __init its_of_probe(struct device_node *node)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+
+#define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
+
+static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
+					  const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *dom_handle;
+	struct resource res;
+	int err;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	memset(&res, 0, sizeof(res));
+	res.start = its_entry->base_address;
+	res.end = its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1;
+	res.flags = IORESOURCE_MEM;
+
+	dom_handle = irq_domain_alloc_fwnode((void *)its_entry->base_address);
+	if (!dom_handle) {
+		pr_err("ITS@%pa: Unable to allocate GICv3 ITS domain token\n",
+		       &res.start);
+		return -ENOMEM;
+	}
+
+	err = iort_register_domain_token(its_entry->translation_id, dom_handle);
+	if (err) {
+		pr_err("ITS@%pa: Unable to register GICv3 ITS domain token (ITS ID %d) to IORT\n",
+		       &res.start, its_entry->translation_id);
+		goto dom_err;
+	}
+
+	err = its_probe_one(&res, dom_handle, NUMA_NO_NODE);
+	if (!err)
+		return 0;
+
+	iort_deregister_domain_token(its_entry->translation_id);
+dom_err:
+	irq_domain_free_fwnode(dom_handle);
+	return err;
+}
+
+static void __init its_acpi_probe(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+			      gic_acpi_parse_madt_its, 0);
+}
+#else
+static void __init its_acpi_probe(void) { }
+#endif
+
 int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		    struct irq_domain *parent_domain)
 {
@@ -1807,7 +1866,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	if (of_node)
 		its_of_probe(of_node);
 	else
-		return -ENODEV;
+		its_acpi_probe();
 
 	if (list_empty(&its_nodes)) {
 		pr_warn("ITS: No ITS available, not enabling LPIs\n");
-- 
1.9.1
