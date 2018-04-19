Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753011AbeDSUQt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Apr 2018 16:16:49 -0400
Subject: [PATCH 4/4] lspci: Use spec name for RCRB ((Root Complex Register
 Block)
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Date: Thu, 19 Apr 2018 15:16:47 -0500
Message-ID: <152416900767.71364.196905236944429194.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Extended Capability ID 0x000a is the RCRB (Root Complex Register Block)
capability.  Change the #define and the capability label to match the
terminology used in the specs.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/header.h |    2 +-
 ls-ecaps.c   |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 0a8a548..d785473 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -222,7 +222,7 @@
 #define PCI_EXT_CAP_ID_RCECOLL	0x07	/* Root Complex Event Collector */
 #define PCI_EXT_CAP_ID_MFVC	0x08	/* Multi-Function Virtual Channel */
 #define PCI_EXT_CAP_ID_VC2	0x09	/* Virtual Channel (2nd ID) */
-#define PCI_EXT_CAP_ID_RBCB	0x0a	/* Root Bridge Control Block */
+#define PCI_EXT_CAP_ID_RCRB	0x0a	/* Root Complex Register Block */
 #define PCI_EXT_CAP_ID_VNDR	0x0b	/* Vendor specific */
 #define PCI_EXT_CAP_ID_ACS	0x0d	/* Access Controls */
 #define PCI_EXT_CAP_ID_ARI	0x0e	/* Alternative Routing-ID Interpretation */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index a6ae751..5505948 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -768,8 +768,8 @@ show_ext_caps(struct device *d, int type)
 	  case PCI_EXT_CAP_ID_MFVC:
 	    printf("Multi-Function Virtual Channel <?>\n");
 	    break;
-	  case PCI_EXT_CAP_ID_RBCB:
-	    printf("Root Bridge Control Block <?>\n");
+	  case PCI_EXT_CAP_ID_RCRB:
+	    printf("Root Complex Register Block <?>\n");
 	    break;
 	  case PCI_EXT_CAP_ID_VNDR:
 	    cap_evendor(d, where);
