Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f180.google.com ([209.85.213.180]:35238 "EHLO
	mail-ye0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712Ab3IIXOY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2013 19:14:24 -0400
Received: by mail-ye0-f180.google.com with SMTP id m15so2207933yen.39
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2013 16:14:23 -0700 (PDT)
Subject: [PATCH 6/7] lspci: Drop PCIe LnkCtl "Retrain Link" decoding
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 09 Sep 2013 17:14:21 -0600
Message-ID: <20130909231421.30095.57889.stgit@bhelgaas-glaptop>
In-Reply-To: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
References: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per PCIe spec r3.0, Table 7-16, the Retrain Link bit is writable but
always returns 0 when read, so decoding it gives no useful information.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index 3b554fe..f192510 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -776,9 +776,8 @@ static void cap_express_link(struct device *d, int where, int type)
   if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_ENDPOINT) ||
       (type == PCI_EXP_TYPE_LEG_END) || (type == PCI_EXP_TYPE_PCI_BRIDGE))
     printf(" RCB %d bytes", w & PCI_EXP_LNKCTL_RCB ? 128 : 64);
-  printf(" Disabled%c Retrain%c CommClk%c\n\t\t\tExtSynch%c ClockPM%c AutWidDis%c BWInt%c AutBWInt%c\n",
+  printf(" Disabled%c CommClk%c\n\t\t\tExtSynch%c ClockPM%c AutWidDis%c BWInt%c AutBWInt%c\n",
 	FLAG(w, PCI_EXP_LNKCTL_DISABLE),
-	FLAG(w, PCI_EXP_LNKCTL_RETRAIN),
 	FLAG(w, PCI_EXP_LNKCTL_CLOCK),
 	FLAG(w, PCI_EXP_LNKCTL_XSYNCH),
 	FLAG(w, PCI_EXP_LNKCTL_CLOCKPM),

