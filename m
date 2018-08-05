Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37553 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeHEWhA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Aug 2018 18:37:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so10416408wrr.4
        for <linux-pci@vger.kernel.org>; Sun, 05 Aug 2018 13:31:11 -0700 (PDT)
Subject: [PATCH v2] PCI: set flag IRQCHIP_ONESHOT_SAFE for PCI-MSI irqchip's
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9f18bc20-cf27-bc3c-71e5-4e24a6c983c7@gmail.com>
Message-ID: <70984d26-1d35-d925-f67b-698ed85bbab5@gmail.com>
Date: Sun, 5 Aug 2018 22:31:03 +0200
MIME-Version: 1.0
In-Reply-To: <9f18bc20-cf27-bc3c-71e5-4e24a6c983c7@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If flag IRQCHIP_ONESHOT_SAFE isn't set for an irqchip and we have a
threaded interrupt with no primary handler, then flag IRQF_ONESHOT
needs to be set for the interrupt, causing some overhead in the
threaded interrupt handler. For more detailed explanation also check
following comment in __setup_irq():

The interrupt was requested with handler = NULL, so we use the default
primary handler for it. But it does not have the oneshot flag set.
In combination with level interrupts this is deadly, because the
default primary handler just wakes the thread, then the irq lines is
reenabled, but the device still has the level irq asserted.
Rinse and repeat....
While this works for edge type interrupts, we play it safe and reject
unconditionally because we can't say for sure which type this interrupt
really has. The type flags are unreliable as the underlying chip
implementation can override them.

Another comment in __setup_irq() gives a hint already that this
overhead can be avoided for PCI-MSI:

Some irq chips like MSI based interrupts are per se one shot safe.
Check the chip flags, so we can avoid the unmask dance at the end
of the threaded handler for those.

Following this let's mark all PCI-MSI irqchip's as oneshot-safe.

See also discussion here:
https://marc.info/?l=linux-pci&m=153332526101128&w=2

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- extended commit message
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
