Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:9894 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbcEJDP4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 May 2016 23:15:56 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: mj@ucw.cz
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	jonathan.yong@intel.com
Subject: [PATCH] lspci: Decode Precision Time Measurement capabiltity
Date: Tue, 10 May 2016 03:15:55 +0000
Message-Id: <1462850155-13790-2-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1462850155-13790-1-git-send-email-jonathan.yong@intel.com>
References: <1462850155-13790-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Section 7.32 Precision Time Management (or Measurement) from the
PCI Express Base 3.1 specification is an optional Extended Capability
for discovering and controlling the distribution of a PTM Hierarchy.

Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
---
 lib/header.h |  1 +
 ls-ecaps.c   | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index b8f7dc1..8463641 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -230,6 +230,7 @@
 #define PCI_EXT_CAP_ID_LTR	0x18	/* Latency Tolerance Reporting */
 #define PCI_EXT_CAP_ID_PASID	0x1b	/* Process Address Space ID */
 #define PCI_EXT_CAP_ID_L1PM	0x1e	/* L1 PM Substates */
+#define PCI_EXT_CAP_ID_PTM	0x1f	/* Precision Time Measurement */
 
 /*** Definitions of capabilities ***/
 
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 8298435..0273240 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -548,6 +548,65 @@ cap_l1pm(struct device *d, int where)
     }
 }
 
+static void
+cap_ptm(struct device *d, int where)
+{
+  u32 buff;
+  u16 clock;
+
+  printf("Precision Time Measurement\n");
+
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where + 4, 8))
+    {
+      printf("\t\t<unreadable>\n");
+      return;
+    }
+
+  buff = get_conf_long(d, where + 4);
+  printf("\t\tPTMCap: ");
+  printf("Requester:%c Responder:%c Root:%c\n",
+    FLAG(buff, 0x1),
+    FLAG(buff, 0x2),
+    FLAG(buff, 0x4));
+
+  clock = BITS(buff, 8, 8);
+  printf("\t\tPTMClockGranularity: ");
+  switch (clock)
+    {
+      case 0x00:
+        printf("Unimplemented\n");
+        break;
+      case 0xff:
+        printf("Greater than 254ns\n");
+        break;
+      default:
+        printf("%huns\n", clock);
+    }
+
+  buff = get_conf_long(d, where + 8);
+  printf("\t\tPTMControl: ");
+  printf("Enabled:%c RootSelected:%c\n",
+    FLAG(buff, 0x1),
+    FLAG(buff, 0x2));
+
+  clock = BITS(buff, 8, 8);
+  printf("\t\tPTMEffectiveGranularity: ");
+  switch (clock)
+    {
+      case 0x00:
+        printf("Unknown\n");
+        break;
+      case 0xff:
+        printf("Greater than 254ns\n");
+        break;
+      default:
+        printf("%huns\n", clock);
+    }
+}
+
 void
 show_ext_caps(struct device *d)
 {
@@ -635,6 +694,9 @@ show_ext_caps(struct device *d)
 	  case PCI_EXT_CAP_ID_L1PM:
 	    cap_l1pm(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_PTM:
+	    cap_ptm(d, where);
+	    break;
 	  default:
 	    printf("#%02x\n", id);
 	    break;
-- 
2.7.3

