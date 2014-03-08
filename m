Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:58291 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbaCHA0T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Mar 2014 19:26:19 -0500
Received: by mail-ig0-f176.google.com with SMTP id uy17so3376172igb.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Mar 2014 16:26:19 -0800 (PST)
Subject: [PATCH] lspci: Decode Interrupt Pin and Interrupt Line for PCI-PCI
 bridges
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Mar 2014 17:26:17 -0700
Message-ID: <20140308002617.1013.98008.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bridges can implement interrupt pins, so decode this information.  See
PCI-to-PCI Bridge spec r1.2, sec 3.2.5.17.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lspci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lspci.c b/lspci.c
index dbba678..dbecbe8 100644
--- a/lspci.c
+++ b/lspci.c
@@ -666,7 +666,7 @@ show_verbose(struct device *d)
     case PCI_HEADER_TYPE_BRIDGE:
       if ((class >> 8) != PCI_BASE_CLASS_BRIDGE)
 	printf("\t!!! Invalid class %04x for header type %02x\n", class, htype);
-      irq = int_pin = min_gnt = max_lat = 0;
+      min_gnt = max_lat = 0;
       break;
     case PCI_HEADER_TYPE_CARDBUS:
       if ((class >> 8) != PCI_BASE_CLASS_BRIDGE)

