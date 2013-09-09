Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f182.google.com ([209.85.213.182]:45276 "EHLO
	mail-ye0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab3IIXN4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2013 19:13:56 -0400
Received: by mail-ye0-f182.google.com with SMTP id l10so1794009yen.13
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2013 16:13:55 -0700 (PDT)
Subject: [PATCH 2/7] lspci: Decode PCIe DevCap "Acceptable Latencies" only
 for Endpoints
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 09 Sep 2013 17:13:53 -0600
Message-ID: <20130909231353.30095.44801.stgit@bhelgaas-glaptop>
In-Reply-To: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
References: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe Device Capabilities "Endpoint L0s Acceptable Latency" and
"Endpoint L1 Acceptable Latency" are defined only for Endpoint functions,
so don't display them unless this is an endpoint.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index a1a1546..347f50a 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -659,11 +659,14 @@ static void cap_express_dev(struct device *d, int where, int type)
   u16 w;
 
   t = get_conf_long(d, where + PCI_EXP_DEVCAP);
-  printf("\t\tDevCap:\tMaxPayload %d bytes, PhantFunc %d, Latency L0s %s, L1 %s\n",
+  printf("\t\tDevCap:\tMaxPayload %d bytes, PhantFunc %d",
 	128 << (t & PCI_EXP_DEVCAP_PAYLOAD),
-	(1 << ((t & PCI_EXP_DEVCAP_PHANTOM) >> 3)) - 1,
+	(1 << ((t & PCI_EXP_DEVCAP_PHANTOM) >> 3)) - 1);
+  if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_LEG_END))
+    printf(", Latency L0s %s, L1 %s",
 	latency_l0s((t & PCI_EXP_DEVCAP_L0S) >> 6),
 	latency_l1((t & PCI_EXP_DEVCAP_L1) >> 9));
+  printf("\n");
   printf("\t\t\tExtTag%c", FLAG(t, PCI_EXP_DEVCAP_EXT_TAG));
   if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_LEG_END) ||
       (type == PCI_EXP_TYPE_UPSTREAM) || (type == PCI_EXP_TYPE_PCI_BRIDGE))

