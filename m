Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:47448 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1766015AbcJaLER (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Oct 2016 07:04:17 -0400
From: Tobias Klauser <tklauser@distanz.ch>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, devel@linuxdriverproject.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: hv: Make unnecessarily global IRQ masking functions static
Date: Mon, 31 Oct 2016 12:04:09 +0100
Message-Id: <20161031110409.27300-1-tklauser@distanz.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make hv_irq_mask and hv_irq_unmask static as they are only used in
pci-hyperv.c

This fixes a sparse warning.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/pci/host/pci-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 763ff8745828..06c98695c06c 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -755,7 +755,7 @@ static int hv_set_affinity(struct irq_data *data, const struct cpumask *dest,
 	return parent->chip->irq_set_affinity(parent, dest, force);
 }
 
-void hv_irq_mask(struct irq_data *data)
+static void hv_irq_mask(struct irq_data *data)
 {
 	pci_msi_mask_irq(data);
 }
@@ -770,7 +770,7 @@ void hv_irq_mask(struct irq_data *data)
  * is built out of this PCI bus's instance GUID and the function
  * number of the device.
  */
-void hv_irq_unmask(struct irq_data *data)
+static void hv_irq_unmask(struct irq_data *data)
 {
 	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
 	struct irq_cfg *cfg = irqd_cfg(data);
-- 
2.9.0


