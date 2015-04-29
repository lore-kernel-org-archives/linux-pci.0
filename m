Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35312 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbbD2PZV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2015 11:25:21 -0400
Received: by iejt8 with SMTP id t8so44969979iej.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2015 08:25:21 -0700 (PDT)
Subject: [PATCH] lspci: Decode only supported ASPM exit latencies
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 29 Apr 2015 10:25:18 -0500
Message-ID: <20150429152518.27141.52630.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per the PCIe spec (r3.0, sec 7.8.6), the L0s Exit Latency is only valid
when L0s is supported, and similarly the L1 Exit Latency is only valid when
L1 is supported.

Only decode the L0s and L1 Exit Latencies if they are defined.

Correct the comments on the PCI_EXP_LNKCAP_L0S and PCI_EXP_LNKCAP_L1
definitions.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h |    4 ++--
 ls-caps.c    |   14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 8ee7565..47c7bc2 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -772,8 +772,8 @@
 #define  PCI_EXP_LNKCAP_SPEED	0x0000f	/* Maximum Link Speed */
 #define  PCI_EXP_LNKCAP_WIDTH	0x003f0	/* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPM	0x00c00	/* Active State Power Management */
-#define  PCI_EXP_LNKCAP_L0S	0x07000	/* L0s Acceptable Latency */
-#define  PCI_EXP_LNKCAP_L1	0x38000	/* L1 Acceptable Latency */
+#define  PCI_EXP_LNKCAP_L0S	0x07000	/* L0s Exit Latency */
+#define  PCI_EXP_LNKCAP_L1	0x38000	/* L1 Exit Latency */
 #define  PCI_EXP_LNKCAP_CLOCKPM	0x40000	/* Clock Power Management */
 #define  PCI_EXP_LNKCAP_SURPRISE 0x80000 /* Surprise Down Error Reporting */
 #define  PCI_EXP_LNKCAP_DLLA	0x100000 /* Data Link Layer Active Reporting */
diff --git a/ls-caps.c b/ls-caps.c
index c145ed6..24d6a29 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -755,16 +755,22 @@ static const char *aspm_enabled(int code)
 
 static void cap_express_link(struct device *d, int where, int type)
 {
-  u32 t;
+  u32 t, aspm;
   u16 w;
 
   t = get_conf_long(d, where + PCI_EXP_LNKCAP);
-  printf("\t\tLnkCap:\tPort #%d, Speed %s, Width x%d, ASPM %s, Exit Latency L0s %s, L1 %s\n",
+  aspm = (t & PCI_EXP_LNKCAP_ASPM) >> 10;
+  printf("\t\tLnkCap:\tPort #%d, Speed %s, Width x%d, ASPM %s",
 	t >> 24,
 	link_speed(t & PCI_EXP_LNKCAP_SPEED), (t & PCI_EXP_LNKCAP_WIDTH) >> 4,
-	aspm_support((t & PCI_EXP_LNKCAP_ASPM) >> 10),
-	latency_l0s((t & PCI_EXP_LNKCAP_L0S) >> 12),
+	aspm_support(aspm));
+  if (aspm & 1)
+    printf(", L0s Exit Latency %s",
+	latency_l0s((t & PCI_EXP_LNKCAP_L0S) >> 12));
+  if (aspm & 2)
+    printf(", L1 Exit Latency %s",
 	latency_l1((t & PCI_EXP_LNKCAP_L1) >> 15));
+  printf("\n");
   printf("\t\t\tClockPM%c Surprise%c LLActRep%c BwNot%c ASPMOptComp%c\n",
 	FLAG(t, PCI_EXP_LNKCAP_CLOCKPM),
 	FLAG(t, PCI_EXP_LNKCAP_SURPRISE),

