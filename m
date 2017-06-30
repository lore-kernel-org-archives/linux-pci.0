Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:56318 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdF3KFu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2017 06:05:50 -0400
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz
Cc: rajatja@google.com, briannorris@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PCIUTILS PATCH] lspci: Fix wrong read size for RootSta/DevCtl2/LnkCtl2
Date: Fri, 30 Jun 2017 18:05:40 +0800
Message-Id: <1498817140-24614-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are reading wrong size(word) for these caps, since:

RootSta has:
PCI_EXP_RTSTA_PME_STATUS  0x00010000 /* PME Status */
PCI_EXP_RTSTA_PME_PENDING 0x00020000 /* PME is Pending */

DevCtl2 has:
PCI_EXP_DEV2_OBFF(x)           (((x) >> 13) & 3) /* OBFF enabled */

LnkCtl2 has:
PCI_EXP_LNKCTL2_MARGIN(x)      (((x) >> 7) & 7) /* Transmit Margin */
PCI_EXP_LNKCTL2_COM_DEEMPHASIS(x) (((x) >> 12) & 0xf) /* Compliance De-emphasis */

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 ls-caps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index 0ca46fb..e0493c7 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -879,7 +879,7 @@ static void cap_express_root(struct device *d, int where)
   printf("\t\tRootCap: CRSVisible%c\n",
 	FLAG(w, PCI_EXP_RTCAP_CRSVIS));
 
-  w = get_conf_word(d, where + PCI_EXP_RTSTA);
+  w = get_conf_long(d, where + PCI_EXP_RTSTA);
   printf("\t\tRootSta: PME ReqID %04x, PMEStatus%c PMEPending%c\n",
 	w & PCI_EXP_RTSTA_PME_REQID,
 	FLAG(w, PCI_EXP_RTSTA_PME_STATUS),
@@ -1021,7 +1021,7 @@ static void cap_express_dev2(struct device *d, int where, int type)
        printf("\n");
     }
 
-  w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
+  w = get_conf_long(d, where + PCI_EXP_DEVCTL2);
   printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c, LTR%c, OBFF %s",
 	cap_express_dev2_timeout_value(PCI_EXP_DEV2_TIMEOUT_VALUE(w)),
 	FLAG(w, PCI_EXP_DEV2_TIMEOUT_DIS),
@@ -1101,7 +1101,7 @@ static void cap_express_link2(struct device *d, int where, int type)
 
   if (!((type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_LEG_END) &&
 	(d->dev->dev != 0 || d->dev->func != 0))) {
-    w = get_conf_word(d, where + PCI_EXP_LNKCTL2);
+    w = get_conf_long(d, where + PCI_EXP_LNKCTL2);
     printf("\t\tLnkCtl2: Target Link Speed: %s, EnterCompliance%c SpeedDis%c",
 	cap_express_link2_speed(PCI_EXP_LNKCTL2_SPEED(w)),
 	FLAG(w, PCI_EXP_LNKCTL2_CMPLNC),
-- 
2.1.4
