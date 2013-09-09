Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f177.google.com ([209.85.213.177]:34185 "EHLO
	mail-ye0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab3IIXOb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2013 19:14:31 -0400
Received: by mail-ye0-f177.google.com with SMTP id q9so1713609yen.8
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2013 16:14:31 -0700 (PDT)
Subject: [PATCH 7/7] lspci: Decode PCIe LnkSta "Link Training" only for
 relevant functions
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 09 Sep 2013 17:14:28 -0600
Message-ID: <20130909231428.30095.22433.stgit@bhelgaas-glaptop>
In-Reply-To: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
References: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe Link Status "Link Training" bit is only valid for functions
at the upstream end of a link, i.e., Root Ports, Downstream Ports, and
PCI-to-PCIe Bridges.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index f192510..87b1a0d 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -786,11 +786,15 @@ static void cap_express_link(struct device *d, int where, int type)
 	FLAG(w, PCI_EXP_LNKCTL_AUTBWIE));
 
   w = get_conf_word(d, where + PCI_EXP_LNKSTA);
-  printf("\t\tLnkSta:\tSpeed %s, Width x%d, TrErr%c Train%c SlotClk%c DLActive%c BWMgmt%c ABWMgmt%c\n",
+  printf("\t\tLnkSta:\tSpeed %s, Width x%d, TrErr%c",
 	link_speed(w & PCI_EXP_LNKSTA_SPEED),
 	(w & PCI_EXP_LNKSTA_WIDTH) >> 4,
-	FLAG(w, PCI_EXP_LNKSTA_TR_ERR),
-	FLAG(w, PCI_EXP_LNKSTA_TRAIN),
+	FLAG(w, PCI_EXP_LNKSTA_TR_ERR));
+  if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_DOWNSTREAM) ||
+      (type == PCI_EXP_TYPE_PCIE_BRIDGE))
+    printf(" Train%c",
+	FLAG(w, PCI_EXP_LNKSTA_TRAIN));
+  printf(" SlotClk%c DLActive%c BWMgmt%c ABWMgmt%c\n",
 	FLAG(w, PCI_EXP_LNKSTA_SL_CLK),
 	FLAG(w, PCI_EXP_LNKSTA_DL_ACT),
 	FLAG(w, PCI_EXP_LNKSTA_BWMGMT),

