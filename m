Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from p3plsmtps2ded01.prod.phx3.secureserver.net ([208.109.80.58]:59564
        "EHLO p3plsmtps2ded01.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752051AbcKAWdg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Nov 2016 18:33:36 -0400
From: Long Li <longli@exchange.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: [PATCH] pci-hyperv: move hypercall buffer from stack to heap
Date: Tue,  1 Nov 2016 17:26:16 -0700
Message-Id: <1478046376-7570-1-git-send-email-longli@exchange.microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Long Li <longli@microsoft.com>

We need to pass a segment from a physically continuous buffer to hv_do_hypercall. Buffer allocated on the stack may not work if CONFIG_VMAP_STACK=y is set. Moving the params buffer from stack to buffer returned by kmalloc.

Signed-off-by: Long Li <longli@microsoft.com>
Reported-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 763ff87..97e6daf 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -378,6 +378,7 @@ struct hv_pcibus_device {
 	struct msi_domain_info msi_info;
 	struct msi_controller msi_chip;
 	struct irq_domain *irq_domain;
+	struct retarget_msi_interrupt retarget_msi_interrupt_params;
 };
 
 /*
@@ -774,7 +775,7 @@ void hv_irq_unmask(struct irq_data *data)
 {
 	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
 	struct irq_cfg *cfg = irqd_cfg(data);
-	struct retarget_msi_interrupt params;
+	struct retarget_msi_interrupt *params;
 	struct hv_pcibus_device *hbus;
 	struct cpumask *dest;
 	struct pci_bus *pbus;
@@ -785,23 +786,24 @@ void hv_irq_unmask(struct irq_data *data)
 	pdev = msi_desc_to_pci_dev(msi_desc);
 	pbus = pdev->bus;
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
-
-	memset(&params, 0, sizeof(params));
-	params.partition_id = HV_PARTITION_ID_SELF;
-	params.source = 1; /* MSI(-X) */
-	params.address = msi_desc->msg.address_lo;
-	params.data = msi_desc->msg.data;
-	params.device_id = (hbus->hdev->dev_instance.b[5] << 24) |
+	params = &hbus->retarget_msi_interrupt_params;
+
+	memset(params, 0, sizeof(*params));
+	params->partition_id = HV_PARTITION_ID_SELF;
+	params->source = 1; /* MSI(-X) */
+	params->address = msi_desc->msg.address_lo;
+	params->data = msi_desc->msg.data;
+	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
 			   (hbus->hdev->dev_instance.b[4] << 16) |
 			   (hbus->hdev->dev_instance.b[7] << 8) |
 			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
 			   PCI_FUNC(pdev->devfn);
-	params.vector = cfg->vector;
+	params->vector = cfg->vector;
 
 	for_each_cpu_and(cpu, dest, cpu_online_mask)
-		params.vp_mask |= (1ULL << vmbus_cpu_number_to_vp_number(cpu));
+		params->vp_mask |= (1ULL << vmbus_cpu_number_to_vp_number(cpu));
 
-	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, &params, NULL);
+	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, params, NULL);
 
 	pci_msi_unmask_irq(data);
 }
-- 
2.7.4

