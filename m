Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from webmail.solarflare.com ([12.187.104.25]:21090 "EHLO
	ocex02.SolarFlarecom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760893Ab2EQOOU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2012 10:14:20 -0400
Message-ID: <1337264056.2496.8.camel@bwh-desktop.uk.solarflarecom.com>
Subject: [PATCH] Only decode defined fields of PCI Express Link Control 2
From: Ben Hutchings <bhutchings@solarflare.com>
To: Martin Mares <mj@ucw.cz>
CC: <linux-pci@vger.kernel.org>
Date: Thu, 17 May 2012 15:14:16 +0100
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On a PCI Express multi-function device associated with an upstream
port, all bits of the Link Control 2 register are currently reserved
on functions > 0.

The Selectable De-emphasis field is reserved on all but downstream
ports.

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 ls-caps.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index 9645e5a..4a75ce7 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -991,22 +991,28 @@ static const char *cap_express_link2_transmargin(int type)
     }
 }
 
-static void cap_express_link2(struct device *d, int where, int type UNUSED)
+static void cap_express_link2(struct device *d, int where, int type)
 {
   u16 w;
 
-  w = get_conf_word(d, where + PCI_EXP_LNKCTL2);
-  printf("\t\tLnkCtl2: Target Link Speed: %s, EnterCompliance%c SpeedDis%c, Selectable De-emphasis: %s\n"
-	"\t\t\t Transmit Margin: %s, EnterModifiedCompliance%c ComplianceSOS%c\n"
-	"\t\t\t Compliance De-emphasis: %s\n",
+  if (!((type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_LEG_END) &&
+	(d->dev->dev != 0 || d->dev->func != 0))) {
+    w = get_conf_word(d, where + PCI_EXP_LNKCTL2);
+    printf("\t\tLnkCtl2: Target Link Speed: %s, EnterCompliance%c SpeedDis%c",
 	cap_express_link2_speed(PCI_EXP_LNKCTL2_SPEED(w)),
 	FLAG(w, PCI_EXP_LNKCTL2_CMPLNC),
-	FLAG(w, PCI_EXP_LNKCTL2_SPEED_DIS),
-	cap_express_link2_deemphasis(PCI_EXP_LNKCTL2_DEEMPHASIS(w)),
+	FLAG(w, PCI_EXP_LNKCTL2_SPEED_DIS));
+    if (type == PCI_EXP_TYPE_DOWNSTREAM)
+      printf(", Selectable De-emphasis: %s",
+	cap_express_link2_deemphasis(PCI_EXP_LNKCTL2_DEEMPHASIS(w)));
+    printf("\n"
+	"\t\t\t Transmit Margin: %s, EnterModifiedCompliance%c ComplianceSOS%c\n"
+	"\t\t\t Compliance De-emphasis: %s\n",
 	cap_express_link2_transmargin(PCI_EXP_LNKCTL2_MARGIN(w)),
 	FLAG(w, PCI_EXP_LNKCTL2_MOD_CMPLNC),
 	FLAG(w, PCI_EXP_LNKCTL2_CMPLNC_SOS),
 	cap_express_link2_deemphasis(PCI_EXP_LNKCTL2_COM_DEEMPHASIS(w)));
+  }
 
   w = get_conf_word(d, where + PCI_EXP_LNKSTA2);
   printf("\t\tLnkSta2: Current De-emphasis Level: %s, EqualizationComplete%c, EqualizationPhase1%c\n"
-- 
1.7.7.6


-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

