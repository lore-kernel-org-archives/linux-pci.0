Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41050 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbdHKQ4q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2017 12:56:46 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        alex.williamson@redhat.com
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 2/3] PCI: handle CRS returned by device after FLR
Date: Fri, 11 Aug 2017 12:56:35 -0400
Message-Id: <1502470596-4112-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
References: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sporadic reset issues have been observed with Intel 750 NVMe drive while
assigning the physical function to the guest machine. The sequence of
events observed is as follows:

- perform a Function Level Reset (FLR)
- sleep up to 1000ms total
- read ~0 from PCI_COMMAND
- warn that the device didn't return from FLR
- touch the device before it's ready
- drop register read and writes performing register settings restore
- incomplete reset operation and partial register restoration
- second time device probe fails in the guest machine as HW is left in
limbo.

An endpoint is allowed to issue Configuration Request Retry Status (CRS)
following a FLR request to indicate that it is not ready to accept new
requests. CRS is defined in PCIe r3.1, sec 2.3.1. Request Handling Rules
and CRS usage in FLR context is mentioned in PCIe r3.1, sec 6.6.2.
Function-Level Reset.

A CRS indication will only be given if the address to be read is vendor ID
register. pci_bus_read_dev_vendor_id() knows how to deal with CRS returned
0xFFFF0001 value and will continue polling until a value other than
0xFFFF0001 is returned within a given timeout.

Try to discover device presence via CRS first. If device is not found, fall
through to old behavior.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..c853551 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3821,17 +3821,36 @@ static void pci_flr_wait(struct pci_dev *dev)
 {
 	int i = 0;
 	u32 id;
+	bool ret;
+
+	/*
+	 * Don't touch the HW before waiting 100ms. HW has to finish
+	 * within 100ms according to PCI Express Base Specification
+	 * Revision 3.1 Section 6.6.2: Function-Level Reset (FLR).
+	 */
+	msleep(100);
+
+	if (pci_bus_read_config_dword(dev->bus, dev->devfn, PCI_VENDOR_ID,
+				      &id))
+		return;
+
+	/* See if we can find a device via CRS first. */
+	if ((id & 0xffff) == 0x0001) {
+		ret = pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);
+		if (ret)
+			return;
+	}
 
 	do {
 		msleep(100);
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
-	} while (i++ < 10 && id == ~0);
+	} while (i++ < 9 && id == ~0);
 
 	if (id == ~0)
 		dev_warn(&dev->dev, "Failed to return from FLR\n");
 	else if (i > 1)
 		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
-			 (i - 1) * 100);
+			 i * 100);
 }
 
 /**
-- 
1.9.1
