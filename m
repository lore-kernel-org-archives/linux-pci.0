Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36217 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbaIFDTO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Sep 2014 23:19:14 -0400
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: bhelgaas@google.com
Cc: Megan Kamiya <megan.a.kamiya@intel.com>, linux-pci@vger.kernel.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH] pci: Parenthesize parameters in PCI_DEVID and PCI_VPD_LRDT_ID macros
Date: Fri,  5 Sep 2014 20:19:10 -0700
Message-Id: <1409973550-29434-1-git-send-email-jeffrey.t.kirsher@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Megan Kamiya <megan.a.kamiya@intel.com>

Add parentheses around parameters in PCI_DEVID and PCI_VPD_LRDT_ID
macros to prevent possible expansion errors as described by the CERT
Secure Coding Standard: PRE01-C: Use parentheses within macros around
parameter names

Signed-off-by: Megan Kamiya <megan.a.kamiya@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 include/linux/pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 61978a4..cb744f3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -45,7 +45,7 @@
  * In the interest of not exposing interfaces to user-space unnecessarily,
  * the following kernel-only defines are being added here.
  */
-#define PCI_DEVID(bus, devfn)  ((((u16)bus) << 8) | devfn)
+#define PCI_DEVID(bus, devfn)  ((((u16)(bus)) << 8) | (devfn))
 /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
 #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
 
@@ -1701,7 +1701,7 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 			  struct pci_dev *end, u16 acs_flags);
 
 #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
-#define PCI_VPD_LRDT_ID(x)		(x | PCI_VPD_LRDT)
+#define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
 
 /* Large Resource Data Type Tag Item Names */
 #define PCI_VPD_LTIN_ID_STRING		0x02	/* Identifier String */
-- 
1.9.3

