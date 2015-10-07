Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36365 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbJGS4M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 14:56:12 -0400
Received: by wicgb1 with SMTP id gb1so224705885wic.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2015 11:56:10 -0700 (PDT)
From: Ruud <netwerkforens@gmail.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz
Cc: Ruud <netwerkforens@gmail.com>
Subject: [PATCH] pciutil: Enumerate alternative PCIe bus
Date: Wed,  7 Oct 2015 18:55:46 +0000
Message-Id: <1444244146-714-1-git-send-email-netwerkforens@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Start enumerating at a specific bus number, this allows accessing root
complexes that do not start a busnumber 0. (e.g. Intel Corporation Xeon
E5/Core internal components and root complex on second CPU).
---
 lib/generic.c    |    3 ++-
 lib/i386-ports.c |   11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/generic.c b/lib/generic.c
index c219592..5ee37f5 100644
--- a/lib/generic.c
+++ b/lib/generic.c
@@ -69,9 +69,10 @@ void
 pci_generic_scan(struct pci_access *a)
 {
   byte busmap[256];
+  int basebus = strtol(pci_get_param(a, "i386.basebus"),NULL,16);
 
   memset(busmap, 0, sizeof(busmap));
-  pci_generic_scan_bus(a, busmap, 0);
+  pci_generic_scan_bus(a, busmap, basebus);
 }
 
 int
diff --git a/lib/i386-ports.c b/lib/i386-ports.c
index 421bbfd..1c70c58 100644
--- a/lib/i386-ports.c
+++ b/lib/i386-ports.c
@@ -32,6 +32,13 @@
 
 static int conf12_io_enabled = -1;		/* -1=haven't tried, 0=failed, 1=succeeded */
 
+static void
+conf12_config(struct pci_access *a)
+{
+  pci_define_param(a, "i386.basebus", "0", "Start busnumber for scanning");
+}
+
+
 static int
 conf12_setup_io(struct pci_access *a)
 {
@@ -261,7 +268,7 @@ conf2_write(struct pci_dev *d, int pos, byte *buf, int len)
 struct pci_methods pm_intel_conf1 = {
   "intel-conf1",
   "Raw I/O port access using Intel conf1 interface",
-  NULL,					/* config */
+  conf12_config,		/* config */
   conf1_detect,
   conf12_init,
   conf12_cleanup,
@@ -277,7 +284,7 @@ struct pci_methods pm_intel_conf1 = {
 struct pci_methods pm_intel_conf2 = {
   "intel-conf2",
   "Raw I/O port access using Intel conf2 interface",
-  NULL,					/* config */
+  conf12_config,		/* config */
   conf2_detect,
   conf12_init,
   conf12_cleanup,
-- 
1.7.0.4

