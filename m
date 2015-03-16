Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933075AbbCPRUi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Mar 2015 13:20:38 -0400
Date: Mon, 16 Mar 2015 18:20:28 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 1/4] pci: disable msi/msix at probe time
Message-ID: <1426526415-13299-2-git-send-email-mst@redhat.com>
References: <1426526415-13299-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426526415-13299-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit d52877c7b1afb8c37ebe17e2005040b79cb618b0
    pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2

attempted to address the problem of kexec getting
started after linux enabled msi/msix for a device,
and drivers being confused by msi being enabled,
by disabling msi at shutdown.

But arguably, it's better to disable msi/msix when kexec
starts - for example, kexec might run after a crash (kdump)
and shutdown callbacks are not always invoked in that case.

Cc: Yinghai Lu <yhlu.kernel.send@gmail.com>
Cc: Ulrich Obergfell <uobergfe@redhat.com>
Cc: Fam Zheng <famz@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/pci/pci-driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3cb2210..dac6d47 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -305,6 +305,12 @@ static long local_pci_probe(void *_ddi)
 	 */
 	pm_runtime_get_sync(dev);
 	pci_dev->driver = pci_drv;
+	/*
+	 * When using kexec, msi might be left enabled by the previous kernel,
+	 * this breaks things as some drivers assume msi/msi-x is off at boot.
+	 * Fix this by forcing msi off at startup.
+	 */
+	pci_msi_off(dev);
 	rc = pci_drv->probe(pci_dev, ddi->id);
 	if (!rc)
 		return rc;
-- 
MST

