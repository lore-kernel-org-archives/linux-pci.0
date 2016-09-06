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
Subject: [PATCH V10 7/8] irqchip/gicv3-its: Factor out PCI-MSI part that might be reused for ACPI
Date: Tue,  6 Sep 2016 11:08:57 +0200
Message-Id: <1473152938-17388-8-git-send-email-tn@semihalf.com>
In-Reply-To: <1473152938-17388-1-git-send-email-tn@semihalf.com>
References: <1473152938-17388-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Firmware agnostic code lands in common functions which do necessary
domain initialization based on unique domain handler. DT specific
code goes to DT specific init call.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 44 +++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index aee60ed..d2c2496 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -106,34 +106,48 @@ static struct of_device_id its_device_id[] = {
 	{},
 };
 
-static int __init its_pci_msi_init(void)
+static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
+				       const char *name)
 {
-	struct device_node *np;
 	struct irq_domain *parent;
 
+	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		pr_err("%s: Unable to locate ITS domain\n", name);
+		return -ENXIO;
+	}
+
+	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
+				       parent)) {
+		pr_err("%s: Unable to create PCI domain\n", name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int __init its_pci_of_msi_init(void)
+{
+	struct device_node *np;
+
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
-		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
-		if (!parent || !msi_get_domain_info(parent)) {
-			pr_err("%s: unable to locate ITS domain\n",
-			       np->full_name);
+		if (its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name))
 			continue;
-		}
-
-		if (!pci_msi_create_irq_domain(of_node_to_fwnode(np),
-					       &its_pci_msi_domain_info,
-					       parent)) {
-			pr_err("%s: unable to create PCI domain\n",
-			       np->full_name);
-			continue;
-		}
 
 		pr_info("PCI/MSI: %s domain created\n", np->full_name);
 	}
 
 	return 0;
 }
+
+static int __init its_pci_msi_init(void)
+{
+	its_pci_of_msi_init();
+
+	return 0;
+}
 early_initcall(its_pci_msi_init);
-- 
1.9.1
