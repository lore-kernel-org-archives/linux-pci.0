Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.139]:34794 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbdF3KJF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2017 06:09:05 -0400
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz
Cc: rajatja@google.com, briannorris@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PCIUTILS PATCH v2] lspci: Fix wrong read size for RootSta
Date: Fri, 30 Jun 2017 18:09:00 +0800
Message-Id: <1498817340-24918-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are reading wrong size(word) for this cap, since:

RootSta has:
PCI_EXP_RTSTA_PME_STATUS  0x00010000 /* PME Status */
PCI_EXP_RTSTA_PME_PENDING 0x00020000 /* PME is Pending */

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Sorry, DevCtl2/LnkCtl2 are correct, remove wrong modifies for them...

 ls-caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ls-caps.c b/ls-caps.c
index 0ca46fb..d4aebc8 100644
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
-- 
2.1.4
