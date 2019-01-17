Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270D8C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 13:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B2D20855
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 13:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfAQNEL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:04:11 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:2143 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbfAQNEL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 08:04:11 -0500
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 17 Jan 2019 04:48:57 -0800
Received: from akaher-lnx-dev.eng.vmware.com (unknown [10.110.19.203])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 4007BB1341;
        Thu, 17 Jan 2019 07:49:05 -0500 (EST)
From:   Ajay Kaher <akaher@vmware.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>
CC:     <devel@linuxdriverproject.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ajay Kaher <akaher@vmware.com>,
        Long Li <longli@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] PCI: hv: Allocate physically contiguous hypercall params buffer
Date:   Fri, 18 Jan 2019 02:17:16 +0530
Message-ID: <1547758038-5255-2-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547758038-5255-1-git-send-email-akaher@vmware.com>
References: <1547758038-5255-1-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

hv_do_hypercall() assumes that we pass a segment from a physically
contiguous buffer.  A buffer allocated on the stack may not work if
CONFIG_VMAP_STACK=y is set.

Use kmalloc() to allocate this buffer.

Reported-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Ajay Kaher <akaher@vmware.com>
---
 drivers/pci/host/pci-hyperv.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index b4d8ccf..9e44adf 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -383,6 +383,8 @@ struct hv_pcibus_device {
 	struct msi_domain_info msi_info;
 	struct msi_controller msi_chip;
 	struct irq_domain *irq_domain;
+	struct retarget_msi_interrupt retarget_msi_interrupt_params;
+	spinlock_t retarget_msi_interrupt_lock;
 };
 
 /*
@@ -780,34 +782,40 @@ void hv_irq_unmask(struct irq_data *data)
 {
 	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
 	struct irq_cfg *cfg = irqd_cfg(data);
-	struct retarget_msi_interrupt params;
+	struct retarget_msi_interrupt *params;
 	struct hv_pcibus_device *hbus;
 	struct cpumask *dest;
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
 	int cpu;
+	unsigned long flags;
 
 	dest = irq_data_get_affinity_mask(data);
 	pdev = msi_desc_to_pci_dev(msi_desc);
 	pbus = pdev->bus;
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
 
-	memset(&params, 0, sizeof(params));
-	params.partition_id = HV_PARTITION_ID_SELF;
-	params.source = 1; /* MSI(-X) */
-	params.address = msi_desc->msg.address_lo;
-	params.data = msi_desc->msg.data;
-	params.device_id = (hbus->hdev->dev_instance.b[5] << 24) |
+	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
+
+	params = &hbus->retarget_msi_interrupt_params;
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
+
+	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, params, NULL);
 
-	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, &params, NULL);
+	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
 
 	pci_msi_unmask_irq(data);
 }
@@ -2212,6 +2220,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	INIT_LIST_HEAD(&hbus->resources_for_children);
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
+	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
 	sema_init(&hbus->enum_sem, 1);
 	init_completion(&hbus->remove_event);
 
-- 
2.7.4

