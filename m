Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:37022 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758822AbaLKGEQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Dec 2014 01:04:16 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 11 Dec 2014 16:04:14 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 969B42BB0057
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2014 17:04:10 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sBB642D737486592
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2014 17:04:10 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sBB63bKl012945
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2014 17:03:38 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, rjw@sisk.pl,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH RFC] PCI: Turn off BARs when disabling device
Date: Thu, 11 Dec 2014 17:03:12 +1100
Message-Id: <1418277792-4090-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When unbinding PCI device mlx4 from its driver, the PCI device is
disabled by pci_disable_device() and the BARs (IO and memory) should
be disabled at the point. However, the memory BARs are still active
after the mlx4_core driver is unloaded as following logs show.

 # lspci -vv -s 0003:0f:00.0
 0003:0f:00.0 Network controller: Mellanox Technologies \
              MT27500 Family [ConnectX-3]
 Subsystem: Mellanox Technologies Device 0061
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- \
          ParErr+ Stepping- SERR+ FastB2B- DisINTx+
    :
 Kernel driver in use: mlx4_core
 # echo 0003:0f:00.0 > /sys/bus/pci/drivers/mlx4_core/unbind
 # lspci -vv -s 0003:0f:00.0
 0003:0f:00.0 Network controller: Mellanox Technologies \
              MT27500 Family [ConnectX-3]
 Subsystem: Mellanox Technologies Device 0061
 Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- \
          ParErr+ Stepping- SERR+ FastB2B- DisINTx-

The patch turns off all BARs (IO and memory) in do_pci_disable_device().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/pci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 625a4ac..8d2924b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1496,12 +1496,14 @@ void __weak pcibios_penalize_isa_irq(int irq, int active) {}
 
 static void do_pci_disable_device(struct pci_dev *dev)
 {
-	u16 pci_command;
+	u16 cmd, flags = (PCI_COMMAND_IO |
+			  PCI_COMMAND_MEMORY |
+			  PCI_COMMAND_MASTER);
 
-	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_MASTER) {
-		pci_command &= ~PCI_COMMAND_MASTER;
-		pci_write_config_word(dev, PCI_COMMAND, pci_command);
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	if (cmd & flags) {
+		cmd &= ~flags;
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 
 	pcibios_disable_device(dev);
-- 
1.8.3.2

