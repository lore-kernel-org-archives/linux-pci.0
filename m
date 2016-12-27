Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0066.outbound.protection.outlook.com ([104.47.42.66]:38492
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753815AbcL0AIR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Dec 2016 19:08:17 -0500
From: Satanand Burla <satananda.burla@caviumnetworks.com>
To: <mj@ucw.cz>, <linux-pci@vger.kernel.org>
CC: Satanand Burla <satananda.burla@caviumnetworks.com>
Subject: [PATCH] pciutils: Add decode for Atomic Ops in lspci
Date: Mon, 26 Dec 2016 16:07:12 -0800
Message-ID: <1482797232-13210-1-git-send-email-satananda.burla@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds support for decoding Atomic Ops added in the following ECN
https://pcisig.com/sites/default/files/specification_documents/ECN_Atomic_Ops_080417.pdf

Signed-off-by: Satanand Burla <satananda.burla@caviumnetworks.com>
---
 lib/header.h |  6 ++++++
 ls-caps.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index a556638..9bf980d 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -859,7 +859,13 @@
 #define  PCI_EXP_DEV2_TIMEOUT_RANGE(x)	((x) & 0xf) /* Completion Timeout Ranges Supported */
 #define  PCI_EXP_DEV2_TIMEOUT_VALUE(x)	((x) & 0xf) /* Completion Timeout Value */
 #define  PCI_EXP_DEV2_TIMEOUT_DIS	0x0010	/* Completion Timeout Disable Supported */
+#define  PCI_EXP_DEV2_ATOMICOP_REQUESTER_EN	0x0040	/*AtomicOp RequesterEnable */
+#define  PCI_EXP_DEV2_ATOMICOP_EGRESS_BLOCK	0x0080	/*AtomicOp Egress Blocking */
 #define  PCI_EXP_DEV2_ARI		0x0020	/* ARI Forwarding */
+#define  PCI_EXP_DEVCAP2_ATOMICOP_ROUTING	0x0040	/* AtomicOp Routing Supported */
+#define  PCI_EXP_DEVCAP2_32BIT_ATOMICOP_COMP	0x0080	/* 32bit AtomicOp Completer Supported */
+#define  PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP	0x0100	/* 64bit AtomicOp Completer Supported */
+#define  PCI_EXP_DEVCAP2_128BIT_CAS_COMP	0x0200	/* 128bit CAS  Completer Supported */
 #define  PCI_EXP_DEV2_LTR		0x0400	/* LTR enabled */
 #define  PCI_EXP_DEV2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
 #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
diff --git a/ls-caps.c b/ls-caps.c
index 7ff6c67..abed607 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -961,6 +961,46 @@ static const char *cap_express_devctl2_obff(int obff)
     }
 }
 
+static int
+device_has_memory_space_bar(struct device *d)
+{
+  struct pci_dev *p = d->dev;
+  int i,cnt = 0, found = 0;
+  byte htype = get_conf_byte(d, PCI_HEADER_TYPE) & 0x7f;
+
+  switch (htype)
+    {
+    case PCI_HEADER_TYPE_NORMAL:
+      cnt=6;
+      break;
+    case PCI_HEADER_TYPE_BRIDGE:
+      cnt=2;
+      break;
+    case PCI_HEADER_TYPE_CARDBUS:
+      cnt = 1;
+      break;
+    default:
+      return 0;
+    }
+
+  for (i=0; i<cnt; i++)
+    {
+      pciaddr_t pos = p->base_addr[i];
+      pciaddr_t len = (p->known_fields & PCI_FILL_SIZES) ? p->size[i] : 0;
+      u32 flg = get_conf_long(d, PCI_BASE_ADDRESS_0 + 4*i);
+      if (flg == 0xffffffff)
+        flg = 0;
+      if (!pos && !flg && !len)
+        continue;
+      if ((flg & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY)
+        {
+          found = 1;
+          break;
+	 }
+    }
+  return found;
+}
+
 static void cap_express_dev2(struct device *d, int where, int type)
 {
   u32 l;
@@ -973,9 +1013,18 @@ static void cap_express_dev2(struct device *d, int where, int type)
 	FLAG(l, PCI_EXP_DEVCAP2_LTR),
 	cap_express_devcap2_obff(PCI_EXP_DEVCAP2_OBFF(l)));
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
-    printf(" ARIFwd%c\n", FLAG(l, PCI_EXP_DEV2_ARI));
-  else
-    printf("\n");
+    printf(" ARIFwd%c", FLAG(l, PCI_EXP_DEV2_ARI));
+  printf("\n\t\t\t");
+  if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_UPSTREAM) ||
+      (type == PCI_EXP_TYPE_DOWNSTREAM))
+    printf(" AtomicOP Routing%c", FLAG(l, PCI_EXP_DEVCAP2_ATOMICOP_ROUTING));
+  if (type == PCI_EXP_TYPE_ROOT_PORT || device_has_memory_space_bar(d))
+    {
+      printf(" 32bit AtomicOP Completer%c", FLAG(l, PCI_EXP_DEVCAP2_32BIT_ATOMICOP_COMP));
+      printf(" 64bit AtomicOP Completer%c", FLAG(l, PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP));
+      printf(" 128bit CAS Completer%c", FLAG(l, PCI_EXP_DEVCAP2_128BIT_CAS_COMP));
+    }
+  printf("\n");
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
   printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c, LTR%c, OBFF %s",
@@ -984,9 +1033,14 @@ static void cap_express_dev2(struct device *d, int where, int type)
 	FLAG(w, PCI_EXP_DEV2_LTR),
 	cap_express_devctl2_obff(PCI_EXP_DEV2_OBFF(w)));
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
-    printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEV2_ARI));
-  else
-    printf("\n");
+    printf(" ARIFwd%c", FLAG(w, PCI_EXP_DEV2_ARI));
+  printf("\n\t\t\t");
+  if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ENDPOINT)
+    printf(" AtomicOp Requester En%c", FLAG(w, PCI_EXP_DEV2_ATOMICOP_REQUESTER_EN));
+  if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_UPSTREAM) ||
+      (type == PCI_EXP_TYPE_DOWNSTREAM))
+    printf(" AtomicOP Egress Blocking%c", FLAG(l, PCI_EXP_DEV2_ATOMICOP_EGRESS_BLOCK));
+  printf("\n");
 }
 
 static const char *cap_express_link2_speed(int type)
-- 
2.7.4

