Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56905 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbbC3Ici (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Mar 2015 04:32:38 -0400
Date: Mon, 30 Mar 2015 10:32:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] pci.txt: clarify vendor ID policy
Message-ID: <1427704341-14125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Top of include/linux/pci_ids.h says:
	Do not add new entries to this file unless the definitions
	are shared between multiple drivers.
on the other hand, Documentation/PCI/pci.txt seems to imply that all
vendor IDs should be added in include/linux/pci_ids.h.

Clarify text pci.txt to avoid the apparent contradiction.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/PCI/pci.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/PCI/pci.txt b/Documentation/PCI/pci.txt
index 53da450..47b0e28 100644
--- a/Documentation/PCI/pci.txt
+++ b/Documentation/PCI/pci.txt
@@ -564,12 +564,15 @@ to be handled by platform and generic code, not individual drivers.
 8. Vendor and device identifications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-One is not required to add new device ids to include/linux/pci_ids.h.
-Please add PCI_VENDOR_ID_xxx for vendors and a hex constant for device ids.
+One is not required to add new device or vendor ids to include/linux/pci_ids.h.
+Please define PCI_VENDOR_ID_xxx for vendor ids and use a hex constant for
+device ids in your driver.
 
-PCI_VENDOR_ID_xxx constants are re-used. The device ids are arbitrary
-hex numbers (vendor controlled) and normally used only in a single
-location, the pci_device_id table.
+Only PCI_VENDOR_ID_xxx constant definitions that are re-used between multiple
+drivers should be added to include/linux/pci_ids.h.
+
+The device ids are arbitrary hex numbers (vendor controlled) and normally used
+only in a single location, the pci_device_id table.
 
 Please DO submit new vendor/device ids to pciids.sourceforge.net project.
 
-- 
MST
