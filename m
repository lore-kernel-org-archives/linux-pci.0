Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
 rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
 robert.richter@caviumnetworks.com, shijie.huang@arm.com,
 Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Subject: [PATCH V7 6/8] irqchip/gicv3-its: Probe ITS in the ACPI way
Date: Mon, 20 Jun 2016 13:02:19 +0200
Message-Id: <1466420541-20101-7-git-send-email-tn@semihalf.com>
In-Reply-To: <1466420541-20101-1-git-send-email-tn@semihalf.com>
References: <1466420541-20101-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: al.stone@linaro.org, graeme.gregory@linaro.org, Catalin.Marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, okaya@codeaurora.org,
 linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, linux-pci@vger.kernel.org,
 Tomasz Nowicki <tn@semihalf.com>, mw@semihalf.com, andrea.gallo@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
---
 drivers/irqchip/Kconfig          |  1 +
 drivers/irqchip/irq-gic-v3-its.c | 59 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5495a5b..fd4b8b8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -38,6 +38,7 @@ config ARM_GIC_V3
 config ARM_GIC_V3_ITS
 	bool
 	select PCI_MSI_IRQ_DOMAIN
+	select IORT_TABLE if ACPI
 
 config ARM_NVIC
 	bool
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1e0888d..c5c8616 100644
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
@@ -1792,6 +1800,55 @@ static int __init its_of_probe(struct device_node *node)
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
+	res.start = its_entry->base_address;
+	res.end = its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1;
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
@@ -1802,7 +1859,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	if (of_node)
 		its_of_probe(of_node);
 	else
-		return -ENODEV;
+		its_acpi_probe();
 
 	if (list_empty(&its_nodes)) {
 		pr_warn("ITS: No ITS available, not enabling LPIs\n");
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
