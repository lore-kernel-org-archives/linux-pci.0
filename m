Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbeGRUYI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jul 2018 16:24:08 -0400
Subject: [PATCH v3 4/7] PCI/AER: Remove ERR_FATAL code from ERR_NONFATAL path
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 18 Jul 2018 14:44:44 -0500
Message-ID: <153194308474.191586.9278078670184747650.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Oza Pawandeep <poza@codeaurora.org>

broadcast_error_message() is only used for ERR_NONFATAL events, when the
state is always pci_channel_io_normal, so remove the unused alternate path.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/err.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 0539518f9861..638eda5c1d79 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -259,15 +259,10 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		/*
 		 * If the error is reported by an end point, we think this
 		 * error is related to the upstream link of the end point.
+		 * The error is non fatal so the bus is ok; just invoke
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
