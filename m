Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47826 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbbDHAYi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 20:24:38 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH] sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in of parsing
Date: Tue,  7 Apr 2015 17:24:18 -0700
Message-Id: <1428452658-24787-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For device resource PREF bit setting under bridge 64-bit pref resource,
we need to make sure only set PREF for 64bit resource, so set IORESOUCE_MEM_64
for 64bit resource during of device resource flags parsing.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org

---
 arch/sparc/kernel/of_device_32.c |    5 +++--
 arch/sparc/kernel/of_device_64.c |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6/arch/sparc/kernel/of_device_32.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/of_device_32.c
+++ linux-2.6/arch/sparc/kernel/of_device_32.c
@@ -83,11 +83,12 @@ static unsigned long of_bus_pci_get_flag
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
Index: linux-2.6/arch/sparc/kernel/of_device_64.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/of_device_64.c
+++ linux-2.6/arch/sparc/kernel/of_device_64.c
@@ -146,11 +146,12 @@ static unsigned long of_bus_pci_get_flag
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
