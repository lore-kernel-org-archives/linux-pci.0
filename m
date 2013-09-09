Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:34011 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3IIXNs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2013 19:13:48 -0400
Received: by mail-yh0-f53.google.com with SMTP id b20so1732678yha.26
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2013 16:13:48 -0700 (PDT)
Subject: [PATCH 1/7] lspci: Label PCIe LnkCap "L0s Exit Latency" as "L0s",
 not "L0"
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 09 Sep 2013 17:13:45 -0600
Message-ID: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe Link Capabilities "L0s Exit Latency" is the latency to exit
L0s, not L0, so label it "L0s" instead of "L0".  This matches the
way we label the Device Capabilities "Endpoint L0s Acceptable Latency"
field as "Latency L0s".  This also adds "Exit" to the description to
help distinguish it from the "Acceptable Latency" fields in the
Device Capabilities register.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ls-caps.c b/ls-caps.c
index be19d38..a1a1546 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -753,7 +753,7 @@ static void cap_express_link(struct device *d, int where, int type)
   u16 w;
 
   t = get_conf_long(d, where + PCI_EXP_LNKCAP);
-  printf("\t\tLnkCap:\tPort #%d, Speed %s, Width x%d, ASPM %s, Latency L0 %s, L1 %s\n",
+  printf("\t\tLnkCap:\tPort #%d, Speed %s, Width x%d, ASPM %s, Exit Latency L0s %s, L1 %s\n",
 	t >> 24,
 	link_speed(t & PCI_EXP_LNKCAP_SPEED), (t & PCI_EXP_LNKCAP_WIDTH) >> 4,
 	aspm_support((t & PCI_EXP_LNKCAP_ASPM) >> 10),

