Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:46511 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab3IIXOK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2013 19:14:10 -0400
Received: by mail-yh0-f48.google.com with SMTP id f10so2588003yha.35
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2013 16:14:09 -0700 (PDT)
Subject: [PATCH 4/7] lspci: Clarify "PCIe-to-PCI/PCI-X" desc and Bridge
 Retry Config Enable
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 09 Sep 2013 17:14:07 -0600
Message-ID: <20130909231407.30095.68310.stgit@bhelgaas-glaptop>
In-Reply-To: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
References: <20130909231345.30095.61638.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI_EXP_TYPE_PCI_BRIDGE type is a PCIe to PCI/PCI-X bridge, so be a bit
more complete in the comment and printed device type.  Also, per PCIe spec
r3.0, Table 7-14, the PCIe Device Control "Bridge Configuration Retry
Enable" bit only applies to PCIe-to-PCI/PCI-X bridges; it does not apply to
PCI-to-PCIe bridges.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h |    4 ++--
 ls-caps.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 6608003..cb63d40 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -728,8 +728,8 @@
 #define  PCI_EXP_TYPE_ROOT_PORT 0x4	/* Root Port */
 #define  PCI_EXP_TYPE_UPSTREAM	0x5	/* Upstream Port */
 #define  PCI_EXP_TYPE_DOWNSTREAM 0x6	/* Downstream Port */
-#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCI/PCI-X Bridge */
-#define  PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIE Bridge */
+#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCIe to PCI/PCI-X Bridge */
+#define  PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIe Bridge */
 #define  PCI_EXP_TYPE_ROOT_INT_EP 0x9	/* Root Complex Integrated Endpoint */
 #define  PCI_EXP_TYPE_ROOT_EC 0xa	/* Root Complex Event Collector */
 #define PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
diff --git a/ls-caps.c b/ls-caps.c
index 7621010..de0d79e 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -696,7 +696,7 @@ static void cap_express_dev(struct device *d, int where, int type)
 	FLAG(w, PCI_EXP_DEVCTL_PHANTOM),
 	FLAG(w, PCI_EXP_DEVCTL_AUX_PME),
 	FLAG(w, PCI_EXP_DEVCTL_NOSNOOP));
-  if (type == PCI_EXP_TYPE_PCI_BRIDGE || type == PCI_EXP_TYPE_PCIE_BRIDGE)
+  if (type == PCI_EXP_TYPE_PCI_BRIDGE)
     printf(" BrConfRtry%c", FLAG(w, PCI_EXP_DEVCTL_BCRE));
   if (((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_LEG_END)) &&
       (t & PCI_EXP_DEVCAP_FLRESET))
@@ -1105,7 +1105,7 @@ cap_express(struct device *d, int where, int cap)
       printf("Downstream Port (Slot%c)", FLAG(cap, PCI_EXP_FLAGS_SLOT));
       break;
     case PCI_EXP_TYPE_PCI_BRIDGE:
-      printf("PCI/PCI-X Bridge");
+      printf("PCI-Express to PCI/PCI-X Bridge");
       break;
     case PCI_EXP_TYPE_PCIE_BRIDGE:
       printf("PCI/PCI-X to PCI-Express Bridge");

