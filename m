Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:47962 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab2KIEbM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2012 23:31:12 -0500
Received: from G4W3011G.americas.hpqcorp.net (g4w3011g.houston.hp.com [16.234.25.125])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g4t0015.houston.hp.com (Postfix) with ESMTPS id 323EE84BC
	for <linux-pci@vger.kernel.org>; Fri,  9 Nov 2012 04:31:12 +0000 (UTC)
From: "Pandarathil, Vijaymohan R" <vijaymohan.pandarathil@hp.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [ PATCH ] PCI-AER: Do not report successful error recovery for
 devices with AER-unaware drivers
Date: Fri, 9 Nov 2012 04:28:31 +0000
Message-ID: <F9E001219150CB45BEDC82A650F360C9014674B9@G9W0717.americas.hpqcorp.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When an error is detected on a PCIe device which does not have an
AER-aware driver, prevent AER infrastructure from reporting
successful error recovery.

This is because the report_error_detected() function that gets
called in the first phase of recovery process allows forward
progress even when the driver for the device does not have AER
capabilities. It seems that all callbacks (in pci_error_handlers
structure) registered by drivers that gets called during error
recovery are not mandatory. So the intention of the infrastructure
design seems to be to allow forward progress even when a specific
callback has not been registered by a driver. However, if error
handler structure itself has not been registered, it doesn't make
sense to allow forward progress.

As a result of the current design, in the case of a single device
having an AER-unaware driver or in the case of any function in a
multi-function card having an AER-unaware driver, a successful
recovery is reported.

Typical scenario this happens is when a PCI device is detached
from a KVM host and the pci-stub driver on the host claims the
device. The pci-stub driver does not have error handling capabilities
but the AER infrastructure still reports that the device recovered
successfully.

The changes proposed here leaves the device in an unrecovered state
if the driver for the device or for any function in a multi-function
card does not have error handler structure registered. This reflects
the true state of the device and prevents any partial recovery (or no
recovery at all) reported as successful.

Please also see comments from Linas Vepstas at the following link
http://www.spinics.net/lists/linux-pci/msg18572.html

Signed-off-by: Linas Vepstas <linasvepstas <at> gmail.com>
Signed-off-by: Myron Stowe <mstowe <at> redhat.com>
Signed-off-by: Vijay Mohan Pandarathil <vijaymohan.pandarathil <at> hp.com>

---

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 06bad96..030b229 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -215,6 +215,12 @@ static int report_error_detected(struct pci_dev *dev, void *data)
 
 	dev->error_state = result_data->state;
 
+	if ((!dev->driver || !dev->driver->err_handler) &&
+		!(dev->hdr_type & PCI_HEADER_TYPE_BRIDGE)) {
+		dev_info(&dev->dev, "AER: Error detected but no driver has claimed this device or the driver is AER-unaware\n");
+		result_data->result = PCI_ERS_RESULT_NONE;
+		return 1;
+	}
 	if (!dev->driver ||
 		!dev->driver->err_handler ||
 		!dev->driver->err_handler->error_detected) {
