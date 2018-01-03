Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0046.outbound.protection.outlook.com ([104.47.41.46]:58474
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbeACWao (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jan 2018 17:30:44 -0500
From: Veerasenareddy Burru <vburru@caviumnetworks.com>
To: linux-pci@vger.kernel.org
Cc: satananda.burla@cavium.com, vburru@caviumnetworks.com,
        mpanicker@caviumnetworks.com
Subject: [PATCH] pciutils: Extend pci_generic_scan() to scan all 256 buses.
Date: Wed,  3 Jan 2018 14:30:04 -0800
Message-Id: <1515018604-13008-1-git-send-email-vburru@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, pci_generic_scan() scans only bus 0 and its subordinate buses.
Due to this, 'lspci -H1' does not list the devices that are not under
root bus not 0 as shown below:
[root@caliobm11 pciutils]# lspci -n -s 84:00.0
84:00.0 0200: 177d:9702 (rev 02)
[root@caliobm11 pciutils]# lspci -H1 -n -s 84:00.0
[root@caliobm11 pciutils]#

Signed-off-by: Veerasenareddy Burru <vburru@caviumnetworks.com>
---
 lib/generic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/generic.c b/lib/generic.c
index c219592..9c5e267 100644
--- a/lib/generic.c
+++ b/lib/generic.c
@@ -69,9 +69,14 @@ void
 pci_generic_scan(struct pci_access *a)
 {
   byte busmap[256];
+  int bus;
 
   memset(busmap, 0, sizeof(busmap));
-  pci_generic_scan_bus(a, busmap, 0);
+  for (bus=0; bus<256; bus++)
+    {
+      if (!busmap[bus])
+        pci_generic_scan_bus(a, busmap, bus);
+    }
 }
 
 int
-- 
1.8.3.1
