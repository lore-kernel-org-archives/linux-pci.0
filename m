Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f74.google.com ([209.85.213.74]:56048 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab2AKVQU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2012 16:16:20 -0500
Received: by yhpp56 with SMTP id p56so152444yhp.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2012 13:16:20 -0800 (PST)
Subject: [PATCH] Correct the end of CardBus memory windows
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 11 Jan 2012 14:16:19 -0700
Message-ID: <20120111211619.10328.74664.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The low twelve bits of memory base/limit are assumed to be all zeros
and all ones, respectively.  Therefore, a window with base == limit
is a valid 4K window, which we should display by default, and the
true end of the window is ...fff, not ...000.  For example,

    05:07.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
	    ...
-	    Memory window 0: 88000000-8bfff000 (prefetchable)
+	    Memory window 0: 88000000-8bffffff (prefetchable)


Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lspci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lspci.c b/lspci.c
index bca1ccb..681ef6a 100644
--- a/lspci.c
+++ b/lspci.c
@@ -590,7 +590,8 @@ show_htype2(struct device *d)
       int p = 8*i;
       u32 base = get_conf_long(d, PCI_CB_MEMORY_BASE_0 + p);
       u32 limit = get_conf_long(d, PCI_CB_MEMORY_LIMIT_0 + p);
-      if (limit > base || verb)
+      limit = limit + 0xfff;
+      if (base <= limit || verb)
 	printf("\tMemory window %d: %08x-%08x%s%s\n", i, base, limit,
 	       (cmd & PCI_COMMAND_MEMORY) ? "" : " [disabled]",
 	       (brc & (PCI_CB_BRIDGE_CTL_PREFETCH_MEM0 << i)) ? " (prefetchable)" : "");

