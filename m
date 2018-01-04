Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46039 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbeADVMU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jan 2018 16:12:20 -0500
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frank Rowand <frowand.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] powerpc/pci: use of_irq_parse_and_map_pci helper
Date: Thu,  4 Jan 2018 15:12:14 -0600
Message-Id: <20180104211215.11344-3-robh@kernel.org>
In-Reply-To: <20180104211215.11344-1-robh@kernel.org>
References: <20180104211215.11344-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of calling both of_irq_parse_pci and irq_create_of_mapping, call
of_irq_parse_and_map_pci instead which does the same thing. This will
allow making of_irq_parse_pci a private, static function.

This changes the logic slightly in that the fallback path will also be
taken if irq_create_of_mapping fails internally.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/kernel/pci-common.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0ac7aa346c69..f65c07dec23e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -339,7 +339,6 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
  */
 static int pci_read_irq_line(struct pci_dev *pci_dev)
 {
-	struct of_phandle_args oirq;
 	unsigned int virq;
 
 	pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
@@ -348,7 +347,7 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 	memset(&oirq, 0xff, sizeof(oirq));
 #endif
 	/* Try to get a mapping from the device-tree */
-	if (of_irq_parse_pci(pci_dev, &oirq)) {
+	if (!of_irq_parse_and_map_pci(pci_dev, 0, 0)) {
 		u8 line, pin;
 
 		/* If that fails, lets fallback to what is in the config
@@ -372,11 +371,6 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 		virq = irq_create_mapping(NULL, line);
 		if (virq)
 			irq_set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
-	} else {
-		pr_debug(" Got one, spec %d cells (0x%08x 0x%08x...) on %pOF\n",
-			 oirq.args_count, oirq.args[0], oirq.args[1], oirq.np);
-
-		virq = irq_create_of_mapping(&oirq);
 	}
 
 	if (!virq) {
-- 
2.14.1
