Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:37788 "EHLO
        wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeFVJ6U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2018 05:58:20 -0400
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v2 3/6] PCI/ERR: Cleanup ERR_FATAL of error broadcast
Date: Fri, 22 Jun 2018 05:58:11 -0400
Message-Id: <1529661494-20936-4-git-send-email-poza@codeaurora.org>
In-Reply-To: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ERR_FATAL is handled by resetting the Link in software, skipping the
driver pci_error_handlers callbacks, removing the devices from the PCI
subsystem, and re-enumerating, so now no more ERR_FATAL handling is
required inside pci_broadcast_error_message()

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 00d2875..404bb69 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -259,15 +259,10 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		/*
 		 * If the error is reported by an end point, we think this
 		 * error is related to the upstream link of the end point.
+		 * the error is non fatal so the bus is ok, just invoke
+		 * the callback for the function that logged the error.
 		 */
-		if (state == pci_channel_io_normal)
-			/*
-			 * the error is non fatal so the bus is ok, just invoke
-			 * the callback for the function that logged the error.
-			 */
-			cb(dev, &result_data);
-		else
-			pci_walk_bus(dev->bus, cb, &result_data);
+		cb(dev, &result_data);
 	}
 
 	return result_data.result;
-- 
2.7.4
