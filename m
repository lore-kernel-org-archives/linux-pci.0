Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:53779 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab3IIXOD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2013 19:14:03 -0400
Received: by mail-yh0-f50.google.com with SMTP id a41so2579035yho.9
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2013 16:14:02 -0700 (PDT)
Subject: [PATCH 3/7] lspci: Decode PCIe DevCap/DevCtl FLReset only for
 Endpoints
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 09 Sep 2013 17:14:00 -0600
Message-ID: <20130909231400.30095.17089.stgit@bhelgaas-glaptop>
In-Reply-To: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
References: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe Device Capabilities and Control bits related to Function
Level Reset are valid only for Endpoints, so only decode them in
that case.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index 347f50a..7621010 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -673,11 +673,13 @@ static void cap_express_dev(struct device *d, int where, int type)
     printf(" AttnBtn%c AttnInd%c PwrInd%c",
 	FLAG(t, PCI_EXP_DEVCAP_ATN_BUT),
 	FLAG(t, PCI_EXP_DEVCAP_ATN_IND), FLAG(t, PCI_EXP_DEVCAP_PWR_IND));
-  printf(" RBE%c FLReset%c",
-	FLAG(t, PCI_EXP_DEVCAP_RBE),
+  printf(" RBE%c",
+	FLAG(t, PCI_EXP_DEVCAP_RBE));
+  if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_LEG_END))
+    printf(" FLReset%c",
 	FLAG(t, PCI_EXP_DEVCAP_FLRESET));
   if (type == PCI_EXP_TYPE_UPSTREAM)
-    printf("SlotPowerLimit %.3fW",
+    printf(" SlotPowerLimit %.3fW",
 	power_limit((t & PCI_EXP_DEVCAP_PWR_VAL) >> 18,
 		    (t & PCI_EXP_DEVCAP_PWR_SCL) >> 26));
   printf("\n");
@@ -696,7 +698,8 @@ static void cap_express_dev(struct device *d, int where, int type)
 	FLAG(w, PCI_EXP_DEVCTL_NOSNOOP));
   if (type == PCI_EXP_TYPE_PCI_BRIDGE || type == PCI_EXP_TYPE_PCIE_BRIDGE)
     printf(" BrConfRtry%c", FLAG(w, PCI_EXP_DEVCTL_BCRE));
-  if (type == PCI_EXP_TYPE_ENDPOINT && (t & PCI_EXP_DEVCAP_FLRESET))
+  if (((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_LEG_END)) &&
+      (t & PCI_EXP_DEVCAP_FLRESET))
     printf(" FLReset%c", FLAG(w, PCI_EXP_DEVCTL_FLRESET));
   printf("\n\t\t\tMaxPayload %d bytes, MaxReadReq %d bytes\n",
 	128 << ((w & PCI_EXP_DEVCTL_PAYLOAD) >> 5),

