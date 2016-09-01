Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34404 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753428AbcIAQ1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2016 12:27:53 -0400
Received: by mail-pf0-f169.google.com with SMTP id p64so32921312pfb.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Sep 2016 09:27:52 -0700 (PDT)
From: Rajat Jain <rajatja@google.com>
To: Martin Mares <mj@ucw.cz>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, David Box <david.e.box@linux.intel.com>
Cc: Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        briannorris@google.com
Subject: [PATCH] lspci: Parse all the L1 PM substate capability regs
Date: Thu,  1 Sep 2016 09:27:28 -0700
Message-Id: <1472747248-60993-1-git-send-email-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Parse the control registers to display all the L1 PM
substate configuration information.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
I tested it on my Rockchip hardware that shows it correctly.
I couldn't figure out how to "test" the tests (is there a
documentation / example on running tests?), and hence left
tests/cap-l1-pm unchanged.

 lib/header.h | 14 +++++++++
 ls-ecaps.c   | 92 ++++++++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 78 insertions(+), 28 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 1c5968b..0341ec6 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1117,6 +1117,20 @@
 #define  PCI_DPC_STS_PIO_FEP(x) (((x) >> 8) & 0x1f) /* DPC PIO First Error Pointer */
 #define PCI_DPC_SOURCE		10	/* DPC Source ID */
 
+/* L1 PM Substates Extended Capability */
+#define PCI_L1PM_SUBSTAT_CAP	0x4	/* L1 PM Substate Capability */
+#define  PCI_L1PM_SUBSTAT_CAP_PM_L12	0x1	/* PCI-PM L1.2 Supported */
+#define  PCI_L1PM_SUBSTAT_CAP_PM_L11	0x2	/* PCI-PM L1.1 Supported */
+#define  PCI_L1PM_SUBSTAT_CAP_ASPM_L12	0x4	/* ASPM L1.2 Supported */
+#define  PCI_L1PM_SUBSTAT_CAP_ASPM_L11	0x8	/* ASPM L1.1 Supported */
+#define  PCI_L1PM_SUBSTAT_CAP_L1PM_SUPP	0x16	/* L1 Pm Substates supported */
+#define PCI_L1PM_SUBSTAT_CTL1	0x8	/* L1 PM Substate Control 1 */
+#define  PCI_L1PM_SUBSTAT_CTL1_PM_L12	0x1	/* PCI-PM L1.2 Enable */
+#define  PCI_L1PM_SUBSTAT_CTL1_PM_L11	0x2	/* PCI-PM L1.1 Enable */
+#define  PCI_L1PM_SUBSTAT_CTL1_ASPM_L12	0x4	/* ASPM L1.2 Enable */
+#define  PCI_L1PM_SUBSTAT_CTL1_ASPM_L11	0x8	/* ASPM L1.1 Enable */
+#define PCI_L1PM_SUBSTAT_CTL2	0xC	/* L1 PM Substate Control 2 */
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 5e18e06..7705930 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -527,55 +527,91 @@ cap_evendor(struct device *d, int where)
     BITS(hdr, 20, 12));
 }
 
+static inline int l1pm_scale_value(int scale, int value)
+{
+  switch (scale)
+    {
+      case 0:
+	return 2 * value;
+      case 1:
+	return 10 * value;
+      case 2:
+	return 100 * value;
+    }
+  return -1;
+}
+
 static void
 cap_l1pm(struct device *d, int where)
 {
-  u32 l1_cap;
-  int power_on_scale;
+  u32 l1_cap, val;
+  int time;
 
   printf("L1 PM Substates\n");
 
   if (verbose < 2)
     return;
 
-  if (!config_fetch(d, where + 4, 4))
+  if (!config_fetch(d, where + PCI_L1PM_SUBSTAT_CAP, 12))
     {
       printf("\t\t<unreadable>\n");
       return;
     }
 
-  l1_cap = get_conf_long(d, where + 4);
+  l1_cap = get_conf_long(d, where + PCI_L1PM_SUBSTAT_CAP);
   printf("\t\tL1SubCap: ");
   printf("PCI-PM_L1.2%c PCI-PM_L1.1%c ASPM_L1.2%c ASPM_L1.1%c L1_PM_Substates%c\n",
-    FLAG(l1_cap, 1),
-    FLAG(l1_cap, 2),
-    FLAG(l1_cap, 4),
-    FLAG(l1_cap, 8),
-    FLAG(l1_cap, 16));
-
-  if (BITS(l1_cap, 0, 1) || BITS(l1_cap, 2, 1))
+    FLAG(l1_cap, PCI_L1PM_SUBSTAT_CAP_PM_L12),
+    FLAG(l1_cap, PCI_L1PM_SUBSTAT_CAP_PM_L11),
+    FLAG(l1_cap, PCI_L1PM_SUBSTAT_CAP_ASPM_L12),
+    FLAG(l1_cap, PCI_L1PM_SUBSTAT_CAP_ASPM_L11),
+    FLAG(l1_cap, PCI_L1PM_SUBSTAT_CAP_L1PM_SUPP));
+
+  if (l1_cap & PCI_L1PM_SUBSTAT_CAP_PM_L12 ||
+      l1_cap & PCI_L1PM_SUBSTAT_CAP_ASPM_L12)
     {
       printf("\t\t\t  PortCommonModeRestoreTime=%dus ",
 	BITS(l1_cap, 8,8));
 
-      power_on_scale = BITS(l1_cap, 16, 2);
+      time = l1pm_scale_value(BITS(l1_cap, 16, 2), BITS(l1_cap, 19, 5));
+      if (time != -1)
+	printf("PortTPowerOnTime=%dus\n", time);
+      else
+	printf("PortTPowerOnTime=<error>\n");
+    }
 
-      printf("PortTPowerOnTime=");
-      switch (power_on_scale)
-	{
-	  case 0:
-	    printf("%dus\n", BITS(l1_cap, 19, 5) * 2);
-	    break;
-	  case 1:
-	    printf("%dus\n", BITS(l1_cap, 19, 5) * 10);
-	    break;
-	  case 2:
-	    printf("%dus\n", BITS(l1_cap, 19, 5) * 100);
-	    break;
-	  default:
-	    printf("<error>\n");
-	    break;
-	}
+  val = get_conf_long(d, where + PCI_L1PM_SUBSTAT_CTL1);
+  printf("\t\tL1SubCtl1: ");
+  printf("PCI-PM_L1.2%c PCI-PM_L1.1%c ASPM_L1.2%c ASPM_L1.1%c\n",
+    FLAG(val, PCI_L1PM_SUBSTAT_CTL1_PM_L12),
+    FLAG(val, PCI_L1PM_SUBSTAT_CTL1_PM_L11),
+    FLAG(val, PCI_L1PM_SUBSTAT_CTL1_ASPM_L12),
+    FLAG(val, PCI_L1PM_SUBSTAT_CTL1_ASPM_L11));
+
+  if (l1_cap & PCI_L1PM_SUBSTAT_CAP_PM_L12 ||
+      l1_cap & PCI_L1PM_SUBSTAT_CAP_ASPM_L12)
+      printf("\t\t\t   T_CommonMode=%dus ",
+	BITS(val, 8,8));
+
+  if (l1_cap & PCI_L1PM_SUBSTAT_CAP_ASPM_L12)
+    {
+      time = l1pm_scale_value(BITS(val, 29, 3), BITS(val, 16, 10));
+      if (time != -1)
+	printf("LTR1.2_Threshhold=%dus\n", time);
+      else
+	printf("LTR1.2_Threshhold=<error>\n");
+    }
+
+  val = get_conf_long(d, where + PCI_L1PM_SUBSTAT_CTL2);
+  printf("\t\tL1SubCtl2: ");
+  if (l1_cap & PCI_L1PM_SUBSTAT_CAP_PM_L12 ||
+      l1_cap & PCI_L1PM_SUBSTAT_CAP_ASPM_L12)
+    {
+      time = l1pm_scale_value(BITS(val, 0, 2), BITS(val, 3, 5));
+      if (time != -1)
+	printf("T_PwrOn=%dus\n", time);
+      else
+	printf("T_PwrOn=<error>\n");
     }
 }
 
-- 
2.8.0.rc3.226.g39d4020

