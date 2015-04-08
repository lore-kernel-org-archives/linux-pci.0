Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:48141 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbbDHAZ6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 20:25:58 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@samba.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in of parsing
Date: Tue,  7 Apr 2015 17:24:29 -0700
Message-Id: <1428452669-24824-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For device resource PREF bit setting under bridge 64-bit pref resource,
we need to make sure only set PREF for 64bit resource, so set IORESOUCE_MEM_64
for 64bit resource during of device resource flags parsing.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Yijing Wang <wangyijing@huawei.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org

---
 arch/powerpc/kernel/pci_of_scan.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/powerpc/kernel/pci_of_scan.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci_of_scan.c
+++ linux-2.6/arch/powerpc/kernel/pci_of_scan.c
@@ -44,8 +44,10 @@ static unsigned int pci_parse_of_flags(u
 
 	if (addr0 & 0x02000000) {
 		flags = IORESOURCE_MEM | PCI_BASE_ADDRESS_SPACE_MEMORY;
-		flags |= (addr0 >> 22) & PCI_BASE_ADDRESS_MEM_TYPE_64;
 		flags |= (addr0 >> 28) & PCI_BASE_ADDRESS_MEM_TYPE_1M;
+		if (addr0 & 0x01000000)
+			flags |= IORESOURCE_MEM_64
+				 | PCI_BASE_ADDRESS_MEM_TYPE_64;
 		if (addr0 & 0x40000000)
 			flags |= IORESOURCE_PREFETCH
 				 | PCI_BASE_ADDRESS_MEM_PREFETCH;
