Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeIABer (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:47 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 09/16] PCI/ERR: Report current recovery status for udev
Date: Fri, 31 Aug 2018 15:26:32 -0600
Message-Id: <20180831212639.10196-10-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A device still participates in error recovery even if it doesn't have
the error callbacks. This patch provides the status for user event
watchers.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/err.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index ee9014615add..a42a17a851fb 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -67,12 +67,12 @@ static int report_error_detected(struct pci_dev *dev,
 			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
 		else
 			vote = PCI_ERS_RESULT_NONE;
-	} else {
-		err_handler = dev->driver->err_handler;
-		vote = err_handler->error_detected(dev, state);
-		pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
+		goto out;
 	}
-
+	err_handler = dev->driver->err_handler;
+	vote = err_handler->error_detected(dev, state);
+out:
+	pci_uevent_ers(dev, vote);
 	*result = merge_result(*result, vote);
 	device_unlock(&dev->dev);
 	return 0;
@@ -140,8 +140,8 @@ static int report_resume(struct pci_dev *dev, void *data)
 
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
