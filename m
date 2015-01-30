Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0141.outbound.protection.outlook.com ([157.56.110.141]:56352
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753031AbbA3J5Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 30 Jan 2015 04:57:16 -0500
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <benh@kernel.crashing.org>, Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [PATCH] powerpc/pci: Fix the initial value of hose->first_busno
Date: Fri, 30 Jan 2015 17:48:22 +0800
Message-ID: <1422611302-309-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When use "Intel PRO/1000 PT Quad Port Low Profile Server Adapter"
card on P5040DS and T1040RDB, 32-bit kernel does not identify this
card. This card has the four RJ-45 ports.

The bus range of every pci is "bus-range = <0 0xff>" in dts file.
So the first bus number of every pci should start from 0, and it
does not start from next_busno. The next_busno is used to count
the bus sum of all pci devices. So the value of next_busno is
accumulated.

This patch fixes this issue, and "Intel PRO/1000 PT Quad Port Low
Profile Server Adapter" card can work rightly.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 arch/powerpc/kernel/pci_32.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 432459c..a194685 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -236,13 +236,13 @@ static int __init pcibios_init(void)
 
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		if (pci_assign_all_buses)
-			hose->first_busno = next_busno;
+		hose->first_busno = 0;
 		hose->last_busno = 0xff;
 		pcibios_scan_phb(hose);
 		pci_bus_add_devices(hose->bus);
 		if (pci_assign_all_buses || next_busno <= hose->last_busno)
-			next_busno = hose->last_busno + pcibios_assign_bus_offset;
+			next_busno += hose->last_busno +
+					pcibios_assign_bus_offset;
 	}
 	pci_bus_count = next_busno;
 
-- 
1.7.6.5

