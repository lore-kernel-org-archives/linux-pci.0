Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34726 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbdBCRrX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 12:47:23 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv5 5/5] pci: Quick return for pci_device_is_present
Date: Fri,  3 Feb 2017 12:55:55 -0500
Message-Id: <1486144555-5526-6-git-send-email-keith.busch@intel.com>
In-Reply-To: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
References: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the pci device is disconnected, return false immediately for checking
presence. We can't rely on the pci device config accessors since
this function uses the bus accessors, so this patch has the explicit
disconnected check first.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a881c0d..b8d37e7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4932,6 +4932,8 @@ bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
 
+	if (pci_dev_is_disconnected(pdev))
+		return false;
 	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
 }
 EXPORT_SYMBOL_GPL(pci_device_is_present);
-- 
2.7.2
