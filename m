Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44553 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbeHCXNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Aug 2018 19:13:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so6560557wrt.11
        for <linux-pci@vger.kernel.org>; Fri, 03 Aug 2018 14:15:55 -0700 (PDT)
To: Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: set flag IRQCHIP_ONESHOT_SAFE for PCI-MSI irqchip's
Message-ID: <9f18bc20-cf27-bc3c-71e5-4e24a6c983c7@gmail.com>
Date: Fri, 3 Aug 2018 23:15:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI-MSI is oneshot-safe, therefore set flag IRQCHIP_ONESHOT_SAFE to
avoid unneeded masking/unmasking. See also discussion here:
https://marc.info/?l=linux-pci&m=153332526101128&w=2

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4d88afdf..f2ef8964 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1446,6 +1446,9 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
+	/* PCI-MSI is oneshot-safe */
+	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
+
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (!domain)
 		return NULL;
-- 
2.18.0
