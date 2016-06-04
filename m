Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:48117 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcFDAJL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2016 20:09:11 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH v12 06/15] sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
Date: Fri,  3 Jun 2016 17:06:33 -0700
Message-Id: <20160604000642.28162-7-yinghai@kernel.org>
In-Reply-To: <20160604000642.28162-1-yinghai@kernel.org>
References: <20160604000642.28162-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For device resource with PREF bit setting under bridge 64-bit pref resource,
we need to make sure only set PREF for 64bit resource.

so this patch set IORESOUCE_MEM_64 for 64bit resource during OF device resource
flags parsing.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/sparc/kernel/of_device_32.c | 5 +++--
 arch/sparc/kernel/of_device_64.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 185aa96..3e9f273 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -83,11 +83,12 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
 	case 0x01:
 		flags |= IORESOURCE_IO;
 		break;
-
 	case 0x02: /* 32 bits */
-	case 0x03: /* 64 bits */
 		flags |= IORESOURCE_MEM;
 		break;
+	case 0x03: /* 64 bits */
+		flags |= IORESOURCE_MEM | IORESOURCE_MEM_64;
+		break;
 	}
 	if (w & 0x40000000)
 		flags |= IORESOURCE_PREFETCH;
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 7bbdc26..defee61 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -146,11 +146,12 @@ static unsigned long of_bus_pci_get_flags(const u32 *addr, unsigned long flags)
 	case 0x01:
 		flags |= IORESOURCE_IO;
 		break;
-
 	case 0x02: /* 32 bits */
-	case 0x03: /* 64 bits */
 		flags |= IORESOURCE_MEM;
 		break;
+	case 0x03: /* 64 bits */
+		flags |= IORESOURCE_MEM | IORESOURCE_MEM_64;
+		break;
 	}
 	if (w & 0x40000000)
 		flags |= IORESOURCE_PREFETCH;
-- 
2.8.3

