Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47914 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbbDHAYz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 20:24:55 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH] of/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
Date: Tue,  7 Apr 2015 17:24:40 -0700
Message-Id: <1428452680-24861-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For device resource PREF bit setting under bridge 64-bit pref resource,
we need to make sure only set PREF for 64bit resource, so set IORESOUCE_MEM_64
for 64bit resource during of device resource flags parsing.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org 

---
 drivers/of/address.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/of/address.c
===================================================================
--- linux-2.6.orig/drivers/of/address.c
+++ linux-2.6/drivers/of/address.c
@@ -128,9 +128,11 @@ static unsigned int of_bus_pci_get_flags
 		flags |= IORESOURCE_IO;
 		break;
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
