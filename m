Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f171.google.com ([209.85.213.171]:63969 "EHLO
	mail-ye0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612Ab3IIXOR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2013 19:14:17 -0400
Received: by mail-ye0-f171.google.com with SMTP id q3so2204204yen.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2013 16:14:16 -0700 (PDT)
Subject: [PATCH 5/7] lspci: Decode PCIe LnkCtl "Read Completion Boundary"
 for PCIe-to-PCI bridges
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 09 Sep 2013 17:14:14 -0600
Message-ID: <20130909231414.30095.72172.stgit@bhelgaas-glaptop>
In-Reply-To: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
References: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe spec (r3.0, Table 7-16) says the Read Completion Boundary is valid
for Root Ports, Endpoints, and Bridges.  I only added decoding for PCIe-to-
PCI/PCI-X bridges because the RCB of a Bridge indicates the RCB of the
upstream Root Port, so I don't think it makes sense for PCI-to-PCIe
bridges.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ls-caps.c b/ls-caps.c
index de0d79e..3b554fe 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -774,7 +774,7 @@ static void cap_express_link(struct device *d, int where, int type)
   w = get_conf_word(d, where + PCI_EXP_LNKCTL);
   printf("\t\tLnkCtl:\tASPM %s;", aspm_enabled(w & PCI_EXP_LNKCTL_ASPM));
   if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_ENDPOINT) ||
-      (type == PCI_EXP_TYPE_LEG_END))
+      (type == PCI_EXP_TYPE_LEG_END) || (type == PCI_EXP_TYPE_PCI_BRIDGE))
     printf(" RCB %d bytes", w & PCI_EXP_LNKCTL_RCB ? 128 : 64);
   printf(" Disabled%c Retrain%c CommClk%c\n\t\t\tExtSynch%c ClockPM%c AutWidDis%c BWInt%c AutBWInt%c\n",
 	FLAG(w, PCI_EXP_LNKCTL_DISABLE),

