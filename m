Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, x86@kernel.org
Subject: [PATCH v3 07/27] PCI, x86: Use for_each_pci_resource() with pci_allocate_dev_resources
Date: Wed, 13 Mar 2013 16:28:02 -0700
Message-Id: <1363217302-14383-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
References: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can replace two layer loop with for_each_pci_resource(), and make
the code more readable.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/pci/i386.c |   55 +++++++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 7c3395a..ed219c7 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -233,49 +233,34 @@ static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 		pcibios_allocate_bus_resources(child);
 }
 
-struct pci_check_idx_range {
-	int start;
-	int end;
-};
-
 static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
 {
-	int idx, disabled, i;
+	int idx, disabled;
 	u16 command;
 	struct resource *r;
 
-	struct pci_check_idx_range idx_range[] = {
-		{ PCI_STD_RESOURCES, PCI_STD_RESOURCE_END },
-#ifdef CONFIG_PCI_IOV
-		{ PCI_IOV_RESOURCES, PCI_IOV_RESOURCE_END },
-#endif
-	};
-
 	pci_read_config_word(dev, PCI_COMMAND, &command);
-	for (i = 0; i < ARRAY_SIZE(idx_range); i++)
-		for (idx = idx_range[i].start; idx <= idx_range[i].end; idx++) {
-			r = &dev->resource[idx];
-			if (r->parent)	/* Already allocated */
-				continue;
-			if (!r->start)	/* Address not assigned at all */
-				continue;
-			if (r->flags & IORESOURCE_IO)
-				disabled = !(command & PCI_COMMAND_IO);
-			else
-				disabled = !(command & PCI_COMMAND_MEMORY);
-			if (pass == disabled) {
-				dev_dbg(&dev->dev,
-					"BAR %d: reserving %pr (d=%d, p=%d)\n",
-					idx, r, disabled, pass);
-				if (pci_claim_resource(dev, idx) < 0) {
-					/* We'll assign a new address later */
-					pcibios_save_fw_addr(dev,
-							idx, r->start);
-					r->end -= r->start;
-					r->start = 0;
-				}
+	for_each_pci_resource(dev, r, idx, PCI_NOROM_RES & ~PCI_BRIDGE_RES) {
+		if (r->parent)	/* Already allocated */
+			continue;
+		if (!r->start)	/* Address not assigned at all */
+			continue;
+		if (r->flags & IORESOURCE_IO)
+			disabled = !(command & PCI_COMMAND_IO);
+		else
+			disabled = !(command & PCI_COMMAND_MEMORY);
+		if (pass == disabled) {
+			dev_dbg(&dev->dev,
+				"BAR %d: reserving %pr (d=%d, p=%d)\n",
+				idx, r, disabled, pass);
+			if (pci_claim_resource(dev, idx) < 0) {
+				/* We'll assign a new address later */
+				pcibios_save_fw_addr(dev, idx, r->start);
+				r->end -= r->start;
+				r->start = 0;
 			}
 		}
+	}
 	if (!pass) {
 		r = &dev->resource[PCI_ROM_RESOURCE];
 		if (r->flags & IORESOURCE_ROM_ENABLE) {
-- 
1.7.10.4

