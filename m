Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36291 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbbJWFGL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:06:11 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 28/29] of/pci: Fix comment for pci_fixup_irqs changing to pci_assign_irq
Date: Fri, 23 Oct 2015 06:04:01 +0100
Message-Id: <1445576642-29624-29-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/of/of_pci_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
index 2306313..a742447 100644
--- a/drivers/of/of_pci_irq.c
+++ b/drivers/of/of_pci_irq.c
@@ -105,7 +105,7 @@ EXPORT_SYMBOL_GPL(of_irq_parse_pci);
  * @pin: PCI irq pin number; passed when used as map_irq callback. Unused
  *
  * @slot and @pin are unused, but included in the function so that this
- * function can be used directly as the map_irq callback to pci_fixup_irqs().
+ * function can be used directly as the map_irq callback to pci_assign_irq().
  */
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-- 
2.6.2

