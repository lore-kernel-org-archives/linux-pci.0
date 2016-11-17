Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] pci/xgene-msi: Convert to hotplug state machine
Date: Thu, 17 Nov 2016 19:35:28 +0100
Message-Id: <20161117183541.8588-8-bigeasy@linutronix.de>
In-Reply-To: <20161117183541.8588-1-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Duc Dang <dhdang@apm.com>,
 rt@linuxtronix.de, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Cc: Duc Dang <dhdang@apm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/pci/host/pci-xgene-msi.c | 69 +++++++++++-----------------------------
 include/linux/cpuhotplug.h       |  1 +
 2 files changed, 20 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index a6456b578269..1f38d0836751 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -360,16 +360,16 @@ static void xgene_msi_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static enum cpuhp_state pci_xgene_online;
+
 static int xgene_msi_remove(struct platform_device *pdev)
 {
-	int virq, i;
 	struct xgene_msi *msi = platform_get_drvdata(pdev);
 
-	for (i = 0; i < NR_HW_IRQS; i++) {
-		virq = msi->msi_groups[i].gic_irq;
-		if (virq != 0)
-			irq_set_chained_handler_and_data(virq, NULL, NULL);
-	}
+	if (pci_xgene_online)
+		cpuhp_remove_state(pci_xgene_online);
+	cpuhp_remove_state(CPUHP_PCI_XGENE_DEAD);
+
 	kfree(msi->msi_groups);
 
 	kfree(msi->bitmap);
@@ -427,7 +427,7 @@ static int xgene_msi_hwirq_alloc(unsigned int cpu)
 	return 0;
 }
 
-static void xgene_msi_hwirq_free(unsigned int cpu)
+static int xgene_msi_hwirq_free(unsigned int cpu)
 {
 	struct xgene_msi *msi = &xgene_msi_ctrl;
 	struct xgene_msi_group *msi_group;
@@ -441,33 +441,9 @@ static void xgene_msi_hwirq_free(unsigned int cpu)
 		irq_set_chained_handler_and_data(msi_group->gic_irq, NULL,
 						 NULL);
 	}
+	return 0;
 }
 
-static int xgene_msi_cpu_callback(struct notifier_block *nfb,
-				  unsigned long action, void *hcpu)
-{
-	unsigned cpu = (unsigned long)hcpu;
-
-	switch (action) {
-	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
-		xgene_msi_hwirq_alloc(cpu);
-		break;
-	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
-		xgene_msi_hwirq_free(cpu);
-		break;
-	default:
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block xgene_msi_cpu_notifier = {
-	.notifier_call = xgene_msi_cpu_callback,
-};
-
 static const struct of_device_id xgene_msi_match_table[] = {
 	{.compatible = "apm,xgene1-msi"},
 	{},
@@ -478,7 +454,6 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	struct resource *res;
 	int rc, irq_index;
 	struct xgene_msi *xgene_msi;
-	unsigned int cpu;
 	int virt_msir;
 	u32 msi_val, msi_idx;
 
@@ -540,28 +515,22 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		}
 	}
 
-	cpu_notifier_register_begin();
-
-	for_each_online_cpu(cpu)
-		if (xgene_msi_hwirq_alloc(cpu)) {
-			dev_err(&pdev->dev, "failed to register MSI handlers\n");
-			cpu_notifier_register_done();
-			goto error;
-		}
-
-	rc = __register_hotcpu_notifier(&xgene_msi_cpu_notifier);
-	if (rc) {
-		dev_err(&pdev->dev, "failed to add CPU MSI notifier\n");
-		cpu_notifier_register_done();
-		goto error;
-	}
-
-	cpu_notifier_register_done();
+	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "pci/xgene:online",
+			       xgene_msi_hwirq_alloc, NULL);
+	if (rc)
+		goto err_cpuhp;
+	pci_xgene_online = rc;
+	rc = cpuhp_setup_state(CPUHP_PCI_XGENE_DEAD, "pci/xgene:dead", NULL,
+			       xgene_msi_hwirq_free);
+	if (rc)
+		goto err_cpuhp;
 
 	dev_info(&pdev->dev, "APM X-Gene PCIe MSI driver loaded\n");
 
 	return 0;
 
+err_cpuhp:
+	dev_err(&pdev->dev, "failed to add CPU MSI notifier\n");
 error:
 	xgene_msi_remove(pdev);
 	return rc;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6506dce8343a..fd5598b8353a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -38,6 +38,7 @@ enum cpuhp_state {
 	CPUHP_RADIX_DEAD,
 	CPUHP_PAGE_ALLOC_DEAD,
 	CPUHP_NET_DEV_DEAD,
+	CPUHP_PCI_XGENE_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
