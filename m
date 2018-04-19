Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753011AbeDSUQg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Apr 2018 16:16:36 -0400
Subject: [PATCH 2/4] lspci: Decode Null Capability
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Date: Thu, 19 Apr 2018 15:16:33 -0500
Message-ID: <152416899351.71364.17915245982467561819.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The PCI Code and ID Assignment spec, r1.9, sec 2, defines a "Null
Capability" containing no registers other than the 8-bit Capability ID
(00h) and an 8-bit Next Capability Pointer.

Some devices, e.g., the Intel [8086:2058] implement this Capability.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h |    2 ++
 ls-caps.c    |    3 +++
 ls-ecaps.c   |    3 +++
 3 files changed, 8 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 0b12b2c..1f0e460 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -185,6 +185,7 @@
 /* Capability lists */
 
 #define PCI_CAP_LIST_ID		0	/* Capability ID */
+#define  PCI_CAP_ID_NULL	0x00	/* Null Capability */
 #define  PCI_CAP_ID_PM		0x01	/* Power Management */
 #define  PCI_CAP_ID_AGP		0x02	/* Accelerated Graphics Port */
 #define  PCI_CAP_ID_VPD		0x03	/* Vital Product Data */
@@ -211,6 +212,7 @@
 
 /* Capabilities residing in the PCI Express extended configuration space */
 
+#define PCI_EXT_CAP_ID_NULL	0x00	/* Null Capability */
 #define PCI_EXT_CAP_ID_AER	0x01	/* Advanced Error Reporting */
 #define PCI_EXT_CAP_ID_VC	0x02	/* Virtual Channel */
 #define PCI_EXT_CAP_ID_DSN	0x03	/* Device Serial Number */
diff --git a/ls-caps.c b/ls-caps.c
index bc7829c..8b707c2 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1536,6 +1536,9 @@ show_caps(struct device *d, int where)
 	    }
 	  switch (id)
 	    {
+	    case PCI_CAP_ID_NULL:
+	      printf("Null\n");
+	      break;
 	    case PCI_CAP_ID_PM:
 	      cap_pm(d, where, cap);
 	      break;
diff --git a/ls-ecaps.c b/ls-ecaps.c
index cb3d46d..3f6a364 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -737,6 +737,9 @@ show_ext_caps(struct device *d, int type)
 	}
       switch (id)
 	{
+	  case PCI_EXT_CAP_ID_NULL:
+	    printf("Null\n");
+	    break;
 	  case PCI_EXT_CAP_ID_AER:
 	    cap_aer(d, where, type);
 	    break;
