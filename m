Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12344 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762050Ab2FHJ6a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jun 2012 05:58:30 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: mj@ucw.cz, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PCIUTILS PATCH] Display whether LTR/OBFF are supported and enabled
Date: Fri,  8 Jun 2012 13:00:04 +0300
Message-Id: <1339149604-5653-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DEVCAP2 and DEVCTL2 capabilities contain information whether LTR and OBFF
are supported and enabled. Make sure this is displayed to user as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 lib/header.h |    4 ++++
 ls-caps.c    |   44 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 85b8b9f..b418982 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -845,11 +845,15 @@
 #define  PCI_EXP_RTSTA_PME_STATUS  0x00010000 /* PME Status */
 #define  PCI_EXP_RTSTA_PME_PENDING 0x00020000 /* PME is Pending */
 #define PCI_EXP_DEVCAP2			0x24	/* Device capabilities 2 */
+#define  PCI_EXP_DEVCAP2_LTR		0x0800	/* LTR supported */
+#define  PCI_EXP_DEVCAP2_OBFF(x)	(((x) >> 18) & 3) /* OBFF supported */
 #define PCI_EXP_DEVCTL2			0x28	/* Device Control */
 #define  PCI_EXP_DEV2_TIMEOUT_RANGE(x)	((x) & 0xf) /* Completion Timeout Ranges Supported */
 #define  PCI_EXP_DEV2_TIMEOUT_VALUE(x)	((x) & 0xf) /* Completion Timeout Value */
 #define  PCI_EXP_DEV2_TIMEOUT_DIS	0x0010	/* Completion Timeout Disable Supported */
 #define  PCI_EXP_DEV2_ARI		0x0020	/* ARI Forwarding */
+#define  PCI_EXP_DEV2_LTR		0x0400	/* LTR enabled */
+#define  PCI_EXP_DEV2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
 #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
 #define PCI_EXP_LNKCAP2			0x2c	/* Link Capabilities */
 #define PCI_EXP_LNKCTL2			0x30	/* Link Control */
diff --git a/ls-caps.c b/ls-caps.c
index 4a75ce7..0f6fab3 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -920,24 +920,60 @@ static const char *cap_express_dev2_timeout_value(int type)
     }
 }
 
+static const char *cap_express_devcap2_obff(int obff)
+{
+  switch (obff)
+    {
+      case 1:
+        return "Via message";
+      case 2:
+        return "Via WAKE#";
+      case 3:
+        return "Via message/WAKE#";
+      default:
+        return "Not Supported";
+    }
+}
+
+static const char *cap_express_devctl2_obff(int obff)
+{
+  switch (obff)
+    {
+      case 0:
+        return "Disabled";
+      case 1:
+        return "Via message A";
+      case 2:
+        return "Via message B";
+      case 3:
+        return "Via WAKE#";
+      default:
+        return "Unknown";
+    }
+}
+
 static void cap_express_dev2(struct device *d, int where, int type)
 {
   u32 l;
   u16 w;
 
   l = get_conf_long(d, where + PCI_EXP_DEVCAP2);
-  printf("\t\tDevCap2: Completion Timeout: %s, TimeoutDis%c",
+  printf("\t\tDevCap2: Completion Timeout: %s, TimeoutDis%c, LTR%c, OBFF %s",
 	cap_express_dev2_timeout_range(PCI_EXP_DEV2_TIMEOUT_RANGE(l)),
-	FLAG(l, PCI_EXP_DEV2_TIMEOUT_DIS));
+	FLAG(l, PCI_EXP_DEV2_TIMEOUT_DIS),
+	FLAG(l, PCI_EXP_DEVCAP2_LTR),
+	cap_express_devcap2_obff(PCI_EXP_DEVCAP2_OBFF(l)));
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
     printf(" ARIFwd%c\n", FLAG(l, PCI_EXP_DEV2_ARI));
   else
     printf("\n");
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
-  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c",
+  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c, LTR%c, OBFF %s",
 	cap_express_dev2_timeout_value(PCI_EXP_DEV2_TIMEOUT_VALUE(w)),
-	FLAG(w, PCI_EXP_DEV2_TIMEOUT_DIS));
+	FLAG(w, PCI_EXP_DEV2_TIMEOUT_DIS),
+	FLAG(w, PCI_EXP_DEV2_LTR),
+	cap_express_devctl2_obff(PCI_EXP_DEV2_OBFF(w)));
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
     printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEV2_ARI));
   else
-- 
1.7.9.1

