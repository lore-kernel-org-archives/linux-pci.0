Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdH0RlB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2017 13:41:01 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        alex.williamson@redhat.com
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V13 1/4] PCI: Don't ignore valid response before CRS timeout
Date: Sun, 27 Aug 2017 13:40:48 -0400
Message-Id: <1503855651-17409-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

While waiting for a device to become ready (i.e., to return a non-CRS
completion to a read of its Vendor ID), if we got a valid response to the
very last read before timing out, we printed a warning and gave up on the
device even though it was actually ready.

For a typical 60s timeout, we wait about 65s (it's not exact because of the
exponential backoff), but we treated devices that became ready between 33s
and 65s as though they failed.

Move the Device ID read later so we check whether the device is ready
immediately, before checking for a timeout.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
[okaya: reorder reads so that we check device presence after sleep]
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/probe.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c31310d..2849e0e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1847,17 +1847,18 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 		if (!crs_timeout)
 			return false;
 
-		msleep(delay);
-		delay *= 2;
-		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
-			return false;
-		/* Card hasn't responded in 60 seconds?  Must be stuck. */
 		if (delay > crs_timeout) {
 			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
 			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
 			       PCI_FUNC(devfn));
 			return false;
 		}
+
+		msleep(delay);
+		delay *= 2;
+
+		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
+			return false;
 	}
 
 	return true;
-- 
1.9.1
