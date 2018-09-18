Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47647 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbeISFaf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:30:35 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 08/10] PCI/ERR: Report current recovery status for udev
Date: Tue, 18 Sep 2018 17:57:00 -0600
Message-Id: <20180918235702.26573-9-keith.busch@intel.com>
In-Reply-To: <20180918235702.26573-1-keith.busch@intel.com>
References: <20180918235702.26573-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A device still participates in error recovery even if it doesn't have
the error callbacks. This patch provides the status for user event
watchers.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/err.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 362a717c831a..31e8a4314384 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -70,9 +70,8 @@ static int report_error_detected(struct pci_dev *dev,
 	} else {
 		err_handler = dev->driver->err_handler;
 		vote = err_handler->error_detected(dev, state);
-		pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
 	}
-
+	pci_uevent_ers(dev, vote);
 	*result = merge_result(*result, vote);
 	device_unlock(&dev->dev);
 	return 0;
@@ -140,8 +139,8 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 	err_handler = dev->driver->err_handler;
 	err_handler->resume(dev);
-	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
 out:
+	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
 	device_unlock(&dev->dev);
 	return 0;
 }
-- 
2.14.4
