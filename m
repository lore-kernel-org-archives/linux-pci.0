Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19976 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472Ab3FKBLj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Jun 2013 21:11:39 -0400
From: "David E. Box" <david.e.box@linux.intel.com>
To: mj@ucw.cz
Cc: kristen.c.accardi@intel.com, linux-pci@vger.kernel.org,
	David Box <david.e.box@linux.intel.com>
Subject: [PATCH v3] lspci: Add L1 PM Substate capability reporting
Date: Mon, 10 Jun 2013 18:09:59 -0700
Message-Id: <1370912999-11261-1-git-send-email-david.e.box@linux.intel.com>
In-Reply-To: <mj+md-20130610.130955.16386.albireo@ucw.cz>
References: <mj+md-20130610.130955.16386.albireo@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Box <david.e.box@linux.intel.com>

Expose available L1 substate capabilities that can enable lower power
consumption when a PCIe Link is idle.

Signed-off-by: David Box <david.e.box@linux.intel.com>
---
v3: reformatted to match document coding style

Sample lspci -vvxxxx output showing first 8 bytes of extended config space for
the L1 Substate Capability. Cannot show more since hardware is unreleased:

00:1c.0 PCI bridge:
        Capabilities: [200 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+, PCI-PM_L1.1+, ASPM_L1.2+, ASPM_L1.1+, L1_PM_Substates+
                          PortCommonModeRestoreTime=40us, PortTPowerOnTime=10us
200: 1e 00 01 00 1f 28 28 00

 lib/header.h |    1 +
 ls-ecaps.c   |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 69518fd..6608003 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -226,6 +226,7 @@
 #define PCI_EXT_CAP_ID_SRIOV	0x10	/* Single Root I/O Virtualization */
 #define PCI_EXT_CAP_ID_TPH	0x17	/* Transaction processing hints */
 #define PCI_EXT_CAP_ID_LTR	0x18	/* Latency Tolerance Reporting */
+#define PCI_EXT_CAP_ID_L1PM	0x1e	/* L1 PM Substates */
 
 /*** Definitions of capabilities ***/
 
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 161c275..1a9b6c5 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -448,6 +448,58 @@ cap_evendor(struct device *d, int where)
     BITS(hdr, 20, 12));
 }
 
+static void
+cap_l1pm(struct device *d, int where)
+{
+  u32 l1_cap;
+  int power_on_scale;
+
+  printf("L1 PM Substates\n");
+
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where + 4, 4))
+    {
+      printf("\t\t<unreadable>\n");
+      return;
+    }
+
+  l1_cap = get_conf_long(d, where + 4);
+  printf("\t\tL1SubCap: ");
+  printf("PCI-PM_L1.2%c, PCI-PM_L1.1%c, ASPM_L1.2%c, ASPM_L1.1%c, L1_PM_Substates%c\n",
+    FLAG(l1_cap, 1),
+    FLAG(l1_cap, 2),
+    FLAG(l1_cap, 4),
+    FLAG(l1_cap, 8),
+    FLAG(l1_cap, 16));
+
+  if (BITS(l1_cap, 0, 1) || BITS(l1_cap, 2, 1))
+    {
+      printf("\t\t\t  PortCommonModeRestoreTime=%dus, ",
+	BITS(l1_cap, 8,8));
+
+      power_on_scale = BITS(l1_cap, 16, 2);
+
+      printf("PortTPowerOnTime=");
+      switch (power_on_scale)
+	{
+	  case 0:
+	    printf("%dus\n", BITS(l1_cap, 19, 5) * 2);
+	    break;
+	  case 1:
+	    printf("%dus\n", BITS(l1_cap, 19, 5) * 10);
+	    break;
+	  case 2:
+	    printf("%dus\n", BITS(l1_cap, 19, 5) * 100);
+	    break;
+	  default:
+	    printf("<error>\n");
+	    break;
+	}
+    }
+}
+
 void
 show_ext_caps(struct device *d)
 {
@@ -526,6 +578,9 @@ show_ext_caps(struct device *d)
 	  case PCI_EXT_CAP_ID_LTR:
 	    cap_ltr(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_L1PM:
+	    cap_l1pm(d, where);
+	    break;
 	  default:
 	    printf("#%02x\n", id);
 	    break;
-- 
1.7.10.4

