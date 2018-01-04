Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0072.outbound.protection.outlook.com ([104.47.33.72]:34606
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751727AbeADBwU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jan 2018 20:52:20 -0500
From: Veerasenareddy Burru <vburru@caviumnetworks.com>
To: linux-pci@vger.kernel.org
Cc: satananda.burla@cavium.com, vburru@caviumnetworks.com,
        mpanicker@caviumnetworks.com
Subject: [PATCH V3] pciutils: Extend pci_generic_scan() to scan all 256 buses.
Date: Wed,  3 Jan 2018 17:52:14 -0800
Message-Id: <1515030734-22063-1-git-send-email-vburru@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, pci_generic_scan() scans only bus 0 and its subordinate buses.
Due to this, "lspci -H1" does not list the devices that are not under
root bus not 0 as shown below:
[root@caliobm11 pciutils]# lspci -n -s 84:00.0
84:00.0 0200: 177d:9702 (rev 02)
[root@caliobm11 pciutils]# lspci -H1 -n -s 84:00.0
[root@caliobm11 pciutils]#

Added a new flag "-S" to enable scanning all root buses.
Updated man pages for lspci and setpci.

Signed-off-by: Veerasenareddy Burru <vburru@caviumnetworks.com>
---
 common.c      | 3 +++
 lib/generic.c | 9 ++++++++-
 lib/pci.h     | 1 +
 lspci.man     | 6 ++++++
 pciutils.h    | 3 ++-
 setpci.man    | 6 ++++++
 6 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/common.c b/common.c
index 8ea52fa..bfa2030 100644
--- a/common.c
+++ b/common.c
@@ -125,6 +125,9 @@ parse_generic_option(int i, struct pci_access *pacc, char *optarg)
     case 'G':
       pacc->debugging++;
       break;
+    case 'S':
+      pacc->scan_all_buses++;
+      break;
     case 'O':
       set_pci_option(pacc, optarg);
       break;
diff --git a/lib/generic.c b/lib/generic.c
index c219592..61817ae 100644
--- a/lib/generic.c
+++ b/lib/generic.c
@@ -69,9 +69,16 @@ void
 pci_generic_scan(struct pci_access *a)
 {
   byte busmap[256];
+  int bus;
+  int num_buses;
 
+  num_buses = a->scan_all_buses ? 256 : 0;
   memset(busmap, 0, sizeof(busmap));
-  pci_generic_scan_bus(a, busmap, 0);
+  for (bus=0; bus<num_buses; bus++)
+    {
+      if (!busmap[bus])
+        pci_generic_scan_bus(a, busmap, bus);
+    }
 }
 
 int
diff --git a/lib/pci.h b/lib/pci.h
index 81bdab3..1c8381e 100644
--- a/lib/pci.h
+++ b/lib/pci.h
@@ -58,6 +58,7 @@ struct pci_access {
 					/* Default: PCI_LOOKUP_CACHE */
 
   int debugging;			/* Turn on debugging messages */
+  int scan_all_buses;
 
   /* Functions you can override: */
   void (*error)(char *msg, ...) PCI_PRINTF(1,2);	/* Write error message and quit */
diff --git a/lspci.man b/lspci.man
index 9348cfc..3e32775 100644
--- a/lspci.man
+++ b/lspci.man
@@ -201,6 +201,12 @@ requests for more dumps.
 .TP
 .B -G
 Increase debug level of the library.
+.TP
+.B -S
+Scan all root buses, not just root bus 0 to get device list.
+Without this option, only the devices under root bus 0 are listed when a
+direct hardware access method is used. Use this flag to list a device that is
+not under root bus 0, when direct hardware access method is used.
 
 .SH MACHINE READABLE OUTPUT
 If you intend to process the output of lspci automatically, please use one of the
diff --git a/pciutils.h b/pciutils.h
index e433e6b..9cb5e05 100644
--- a/pciutils.h
+++ b/pciutils.h
@@ -40,9 +40,10 @@ int parse_generic_option(int i, struct pci_access *pacc, char *optarg);
 #define GENHELP_DUMP
 #endif
 
-#define GENERIC_OPTIONS "A:GO:" GENOPT_INTEL GENOPT_DUMP
+#define GENERIC_OPTIONS "A:GSO:" GENOPT_INTEL GENOPT_DUMP
 #define GENERIC_HELP \
 	"-A <method>\tUse the specified PCI access method (see `-A help' for a list)\n" \
 	"-O <par>=<val>\tSet PCI access parameter (see `-O help' for a list)\n" \
 	"-G\t\tEnable PCI access debugging\n" \
+	"-S\t\tScan all root buses\n" \
 	GENHELP_INTEL GENHELP_DUMP
diff --git a/setpci.man b/setpci.man
index d71628a..31f5528 100644
--- a/setpci.man
+++ b/setpci.man
@@ -84,6 +84,12 @@ Use direct hardware access via Intel configuration mechanism 2.
 .TP
 .B -G
 Increase debug level of the library.
+.TP
+.B -S
+Scan all root buses, not just root bus 0 to get device list.
+Without this option, only the devices under root bus 0 are listed when a
+direct hardware access method is used. Use this flag to access a device that is
+not under root bus 0, when direct hardware access method is used.
 
 .SH DEVICE SELECTION
 .PP
-- 
1.8.3.1
