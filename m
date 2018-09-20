Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDE1ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159C62147D
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159C62147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbeITWKt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:10:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:21046 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbeITWKs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 18:10:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 09:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="258918193"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2018 09:26:31 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 08/12] PCI: ERR: Always use the first downstream port
Date:   Thu, 20 Sep 2018 10:27:13 -0600
Message-Id: <20180920162717.31066-9-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180920162717.31066-1-keith.busch@intel.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The link reset always used the first bridge device, but AER broadcast
error handling may have reported an end device. This means the reset may
hit devices that were never notified of the impending error recovery.

This patch uses the first downstream port in the hierarchy considered
reliable. An error detected by a switch upstream port should mean it
occurred on its upstream link, so the patch selects the parent device
if the error is not a root or downstream port.

This allows two other clean-ups. First, error handling can only run
on bridges so this patch removes checks for end devices. Second, the
first accessible port does not inherit the channel error state since we
can access it, so the special cases for error detect and resume are no
longer necessary.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/err.c | 85 +++++++++++++-------------------------------------
 1 file changed, 21 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 644f3f725ef0..0fa5e1417a4a 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -63,30 +63,12 @@ static int report_error_detected(struct pci_dev *dev, void *data)
 	if (!dev->driver ||
 		!dev->driver->err_handler ||
 		!dev->driver->err_handler->error_detected) {
-		if (result_data->state == pci_channel_io_frozen &&
-			dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
-			/*
-			 * In case of fatal recovery, if one of down-
-			 * stream device has no driver. We might be
-			 * unable to recover because a later insmod
-			 * of a driver for this device is unaware of
-			 * its hw state.
-			 */
-			pci_printk(KERN_DEBUG, dev, "device has %s\n",
-				   dev->driver ?
-				   "no AER-aware driver" : "no driver");
-		}
-
 		/*
-		 * If there's any device in the subtree that does not
-		 * have an error_detected callback, returning
-		 * PCI_ERS_RESULT_NO_AER_DRIVER prevents calling of
-		 * the subsequent mmio_enabled/slot_reset/resume
-		 * callbacks of "any" device in the subtree. All the
-		 * devices in the subtree are left in the error state
-		 * without recovery.
+		 * If any device in the subtree does not have an error_detected
+		 * callback, PCI_ERS_RESULT_NO_AER_DRIVER prevents subsequent
+		 * error callbacks of "any" device in the subtree, and will
+		 * exit in the disconnected error state.
 		 */
-
 		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
 			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
 		else
@@ -184,34 +166,23 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 
 static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 {
-	struct pci_dev *udev;
 	pci_ers_result_t status;
 	struct pcie_port_service_driver *driver = NULL;
 
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		/* Reset this port for all subordinates */
-		udev = dev;
-	} else {
-		/* Reset the upstream component (likely downstream port) */
-		udev = dev->bus->self;
-	}
-
-	/* Use the aer driver of the component firstly */
-	driver = pcie_port_find_service(udev, service);
-
+	driver = pcie_port_find_service(dev, service);
 	if (driver && driver->reset_link) {
-		status = driver->reset_link(udev);
-	} else if (udev->has_secondary_link) {
-		status = default_reset_link(udev);
+		status = driver->reset_link(dev);
+	} else if (dev->has_secondary_link) {
+		status = default_reset_link(dev);
 	} else {
 		pci_printk(KERN_DEBUG, dev, "no link-reset support at upstream device %s\n",
-			pci_name(udev));
+			pci_name(dev));
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED) {
 		pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s failed\n",
-			pci_name(udev));
+			pci_name(dev));
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -243,31 +214,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	else
 		result_data.result = PCI_ERS_RESULT_RECOVERED;
 
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		/*
-		 * If the error is reported by a bridge, we think this error
-		 * is related to the downstream link of the bridge, so we
-		 * do error recovery on all subordinates of the bridge instead
-		 * of the bridge and clear the error status of the bridge.
-		 */
-		if (cb == report_error_detected)
-			dev->error_state = state;
-		pci_walk_bus(dev->subordinate, cb, &result_data);
-		if (cb == report_resume) {
-			pci_aer_clear_device_status(dev);
-			pci_cleanup_aer_uncorrect_error_status(dev);
-			dev->error_state = pci_channel_io_normal;
-		}
-	} else {
-		/*
-		 * If the error is reported by an end point, we think this
-		 * error is related to the upstream link of the end point.
-		 * The error is non fatal so the bus is ok; just invoke
-		 * the callback for the function that logged the error.
-		 */
-		cb(dev, &result_data);
-	}
-
+	pci_walk_bus(dev->subordinate, cb, &result_data);
 	return result_data.result;
 }
 
@@ -276,6 +223,14 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 {
 	pci_ers_result_t status;
 
+	/*
+	 * Error recovery runs on all subordinates of the first downstream port.
+	 * If the downstream port detected the error, it is cleared at the end.
+	 */
+	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
+		dev = dev->bus->self;
+
 	status = broadcast_error_message(dev,
 			state,
 			"error_detected",
@@ -311,6 +266,8 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 				"resume",
 				report_resume);
 
+	pci_aer_clear_device_status(dev);
+	pci_cleanup_aer_uncorrect_error_status(dev);
 	pci_info(dev, "AER: Device recovery successful\n");
 	return;
 
-- 
2.14.4

