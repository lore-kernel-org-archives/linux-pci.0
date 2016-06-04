Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@samba.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v12 09/15] powerpc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
Date: Fri,  3 Jun 2016 17:06:36 -0700
Message-Id: <20160604000642.28162-10-yinghai@kernel.org>
In-Reply-To: <20160604000642.28162-1-yinghai@kernel.org>
References: <20160604000642.28162-1-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For device resource PREF bit setting under bridge 64-bit pref resource,
we need to make sure only set PREF for 64bit resource.

This patch set IORESOUCE_MEM_64 for 64bit resource during OF device resource
flags parsing.

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
 arch/powerpc/kernel/pci_of_scan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 719f225..476b8ac5 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -44,8 +44,10 @@ static unsigned int pci_parse_of_flags(u32 addr0, int bridge)
 
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
-- 
2.8.3
