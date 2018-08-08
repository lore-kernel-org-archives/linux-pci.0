Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38995 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHHIGj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Aug 2018 04:06:39 -0400
From: AceLan Kao <acelan.kao@canonical.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Fix calculation of bridge window's size
Date: Wed,  8 Aug 2018 13:48:37 +0800
Message-Id: <20180808054837.19717-1-acelan.kao@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are some 0 resource size pci devices, and it leads to the
accumulator fails to maintain the correct value.
It results in a strange issue on my machine that xhci_hcd failed to init.
   [    2.437278] xhci_hcd 0000:05:00.0: init 0000:05:00.0 fail, -16
   [    2.437300] xhci_hcd: probe of 0000:05:00.0 failed with error -16

To fix this, check if the resource size equals to 0, doesn't increase size.

Fixes: c9c75143a596 ("PCI: Fix calculation of bridge window's size and alignment")
CC: stable@vger.kernel.org # 4.14+

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/pci/setup-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1824e83b4..ae05dde8c6e3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1061,7 +1061,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				r->flags = 0;
 				continue;
 			}
-			size += max(r_size, align);
+			if (r_size != 0)
+				size += max(r_size, align);
 			/* Exclude ranges with size > align from
 			   calculation of the alignment. */
 			if (r_size <= align)
-- 
2.17.1
