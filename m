Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:53157
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750709AbcL1C1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Dec 2016 21:27:22 -0500
From: Satanand Burla <satananda.burla@caviumnetworks.com>
To: <mj@ucw.cz>, <linux-pci@vger.kernel.org>
CC: Satanand Burla <satananda.burla@caviumnetworks.com>
Subject: [PATCH v2] pciutils: Add decode for Atomic Ops in lspci
Date: Tue, 27 Dec 2016 15:52:36 -0800
Message-ID: <1482882756-12151-1-git-send-email-satananda.burla@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds support for decoding Atomic ops added in ECN
https://pcisig.com/sites/default/files/specification_documents/ECN_Atomic_Ops_080417.pdf

Signed-off-by: Satanand Burla <satananda.burla@caviumnetworks.com>
---
 lib/header.h |  6 ++++++
 ls-caps.c    | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index a556638..6d81cb7 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -859,7 +859,13 @@
 #define  PCI_EXP_DEV2_TIMEOUT_RANGE(x)	((x) & 0xf) /* Completion Timeout Ranges Supported */
 #define  PCI_EXP_DEV2_TIMEOUT_VALUE(x)	((x) & 0xf) /* Completion Timeout Value */
 #define  PCI_EXP_DEV2_TIMEOUT_DIS	0x0010	/* Completion Timeout Disable Supported */
+#define  PCI_EXP_DEV2_ATOMICOP_REQUESTER_EN	0x0040	/* AtomicOp RequesterEnable */
+#define  PCI_EXP_DEV2_ATOMICOP_EGRESS_BLOCK	0x0080	/* AtomicOp Egress Blocking */
 #define  PCI_EXP_DEV2_ARI		0x0020	/* ARI Forwarding */
+#define  PCI_EXP_DEVCAP2_ATOMICOP_ROUTING	0x0040	/* AtomicOp Routing Supported */
+#define  PCI_EXP_DEVCAP2_32BIT_ATOMICOP_COMP	0x0080	/* 32bit AtomicOp Completer Supported */
+#define  PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP	0x0100	/* 64bit AtomicOp Completer Supported */
+#define  PCI_EXP_DEVCAP2_128BIT_CAS_COMP	0x0200	/* 128bit CAS Completer Supported */
 #define  PCI_EXP_DEV2_LTR		0x0400	/* LTR enabled */
 #define  PCI_EXP_DEV2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
 #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
diff --git a/ls-caps.c b/ls-caps.c
index 7ff6c67..07e818f 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -961,11 +961,31 @@ static const char *cap_express_devctl2_obff(int obff)
     }
 }
 
+static int
+device_has_memory_space_bar(struct device *d)
+{
+  struct pci_dev *p = d->dev;
+  int i, found = 0;
+
+  for (i=0; i<6; i++)
+    if (p->base_addr[i] && p->size[i])
+      {
+        if (!(p->base_addr[i] & PCI_BASE_ADDRESS_SPACE_IO))
+          {
+            found = 1;
+            break;
+          }
+      }
+  return found;
+}
+
 static void cap_express_dev2(struct device *d, int where, int type)
 {
   u32 l;
   u16 w;
+  int has_mem_bar = 0;
 
+  has_mem_bar = device_has_memory_space_bar(d);
   l = get_conf_long(d, where + PCI_EXP_DEVCAP2);
   printf("\t\tDevCap2: Completion Timeout: %s, TimeoutDis%c, LTR%c, OBFF %s",
 	cap_express_dev2_timeout_range(PCI_EXP_DEV2_TIMEOUT_RANGE(l)),
@@ -976,6 +996,20 @@ static void cap_express_dev2(struct device *d, int where, int type)
     printf(" ARIFwd%c\n", FLAG(l, PCI_EXP_DEV2_ARI));
   else
     printf("\n");
+  if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
+      type == PCI_EXP_TYPE_DOWNSTREAM || has_mem_bar)
+    {
+       printf("\t\tAtomicOpsCap:");
+       if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
+           type == PCI_EXP_TYPE_DOWNSTREAM)
+         printf(" Routing%c", FLAG(l, PCI_EXP_DEVCAP2_ATOMICOP_ROUTING));
+       if (type == PCI_EXP_TYPE_ROOT_PORT || has_mem_bar)
+         printf(" 32bit%c 64bit%c 128bitCAS%c",
+		FLAG(l, PCI_EXP_DEVCAP2_32BIT_ATOMICOP_COMP),
+		FLAG(l, PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP),
+		FLAG(l, PCI_EXP_DEVCAP2_128BIT_CAS_COMP));
+       printf("\n");
+    }
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
   printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c, LTR%c, OBFF %s",
@@ -987,6 +1021,19 @@ static void cap_express_dev2(struct device *d, int where, int type)
     printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEV2_ARI));
   else
     printf("\n");
+  if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
+      type == PCI_EXP_TYPE_DOWNSTREAM || type == PCI_EXP_TYPE_ENDPOINT ||
+      type == PCI_EXP_TYPE_ROOT_INT_EP || type == PCI_EXP_TYPE_LEG_END)
+    {
+      printf("\t\tAtomicOpsCtl:");
+      if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ENDPOINT ||
+          type == PCI_EXP_TYPE_ROOT_INT_EP || type == PCI_EXP_TYPE_LEG_END)
+        printf(" ReqEn%c", FLAG(w, PCI_EXP_DEV2_ATOMICOP_REQUESTER_EN));
+      if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
+          type == PCI_EXP_TYPE_DOWNSTREAM)
+        printf(" EgressBlck%c", FLAG(w, PCI_EXP_DEV2_ATOMICOP_EGRESS_BLOCK));
+      printf("\n");
+    }
 }
 
 static const char *cap_express_link2_speed(int type)
-- 
2.7.4

