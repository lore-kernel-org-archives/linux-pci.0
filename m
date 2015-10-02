Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34175 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbbJBSXx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2015 14:23:53 -0400
Received: by wicfx3 with SMTP id fx3so44979219wic.1
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2015 11:23:52 -0700 (PDT)
From: Ruud <netwerkforens@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Ruud <netwerkforens@gmail.com>
Subject: [PATCH] Enumerate all undiscovered PCIe busses
Date: Fri,  2 Oct 2015 18:23:36 +0000
Message-Id: <1443810216-3215-1-git-send-email-netwerkforens@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Multiple root complexes have a different start busnumber.
Poll all undiscovered busses for a root complex

Signed-off-by: Ruud <netwerkforens@gmail.com>
---
 lib/generic.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib/generic.c b/lib/generic.c
index c219592..21b8022 100644
--- a/lib/generic.c
+++ b/lib/generic.c
@@ -69,9 +69,13 @@ void
 pci_generic_scan(struct pci_access *a)
 {
   byte busmap[256];
+  int basebus;
 
   memset(busmap, 0, sizeof(busmap));
-  pci_generic_scan_bus(a, busmap, 0);
+  for(basebus=0;basebus<256;basebus++) {
+      if (busmap[basebus]==0)
+          pci_generic_scan_bus(a, busmap, basebus);
+  }
 }
 
 int
-- 
1.7.0.4

