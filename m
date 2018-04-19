Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752507AbeDSUQ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Apr 2018 16:16:28 -0400
Subject: [PATCH 1/4] lspci: Clarify unknown capability IDs
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Date: Thu, 19 Apr 2018 15:16:26 -0500
Message-ID: <152416898648.71364.15417323482028209640.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152416880512.71364.16029919502694064334.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

For capabilities we don't know how to decode, we print the config address,
version, and capability ID:

  Capabilities: [220 v1] #19

This doesn't clearly identify the capability ID ("19"), whether it is a
PCI-compatible Capability ID or an Extended Capability ID (although you can
infer this by whether the address is 2 or 3 digits), or the fact that the
ID is printed in hex, which makes it hard to parse this manually.

Add a label ("Capability ID" or "Extended Capability ID") and print a "0x"
prefix so it's clear the value is in hex:

  Capabilities: [220 v1] Extended Capability ID 0x19

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c  |    2 +-
 ls-ecaps.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index 3135224..bc7829c 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1599,7 +1599,7 @@ show_caps(struct device *d, int where)
 	      cap_ea(d, where, cap);
 	      break;
 	    default:
-	      printf("#%02x [%04x]\n", id, cap);
+	      printf("Capability ID %#02x [%04x]\n", id, cap);
 	    }
 	  where = next;
 	}
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 800a032..cb3d46d 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -802,7 +802,7 @@ show_ext_caps(struct device *d, int type)
 	    cap_ptm(d, where);
 	    break;
 	  default:
-	    printf("#%02x\n", id);
+	    printf("Extended Capability ID %#02x\n", id);
 	    break;
 	}
       where = (header >> 20) & ~3;
