Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35508 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbdDJMBa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2017 08:01:30 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so25440398pge.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Apr 2017 05:01:30 -0700 (PDT)
From: Yongji Xie <elohimes@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com,
        aik@ozlabs.ru, benh@kernel.crashing.org, mpe@ellerman.id.au,
        paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: [PATCH v10 1/4] PCI: A fix for caculating bridge window's size and alignment
Date: Mon, 10 Apr 2017 19:58:11 +0800
Message-Id: <1491825494-19331-2-git-send-email-elohimes@gmail.com>
In-Reply-To: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In case that one device's alignment is greater than its size,
we may get an incorrect size and alignment for its bus's memory
window in pbus_size_mem(). This patch fixes this case.

Signed-off-by: Yongji Xie <elohimes@gmail.com>
---
 drivers/pci/setup-bus.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index cb389277..958da7d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1066,10 +1066,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				r->flags = 0;
 				continue;
 			}
-			size += r_size;
+			size += max(r_size, align);
 			/* Exclude ranges with size > align from
 			   calculation of the alignment. */
-			if (r_size == align)
+			if (r_size <= align)
 				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
-- 
1.7.9.5
