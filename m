Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 12/27] PCI: Use for_each_pci_resource() in pci_reassigndev
Date: Wed, 13 Mar 2013 16:28:07 -0700
Message-Id: <1363217302-14383-13-git-send-email-yinghai@kernel.org>
In-Reply-To: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
References: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c0473dc..dca6c1a1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3782,7 +3782,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	command &= ~PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, command);
 
-	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+	for_each_pci_resource(dev, r, i, PCI_NOBRIDGE_RES) {
 		r = &dev->resource[i];
 		if (!(r->flags & IORESOURCE_MEM))
 			continue;
@@ -3802,8 +3802,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	 */
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
 	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
-		for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
-			r = &dev->resource[i];
+		for_each_pci_resource(dev, r, i, PCI_BRIDGE_RES) {
 			if (!(r->flags & IORESOURCE_MEM))
 				continue;
 			r->end = resource_size(r) - 1;
-- 
1.7.10.4

