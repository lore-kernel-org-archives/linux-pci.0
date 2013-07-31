Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34658 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758476Ab3GaDcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Jul 2013 23:32:16 -0400
Subject: [RFC PATCH 7/7] pci: Wake-up devices before save for reset
To: linux-pci@vger.kernel.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, indou.takao@jp.fujitsu.com
Date: Tue, 30 Jul 2013 21:32:12 -0600
Message-ID: <20130731033212.31931.94340.stgit@bling.home>
In-Reply-To: <20130731031316.31931.56751.stgit@bling.home>
References: <20130731031316.31931.56751.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Devices come out of reset in D0.  Restoring a device to a different
post-reset state takes more smarts than our simple config space
restore, which can leave devices in an inconsistent state.  For
example, if a device is reset in D3, but the restore doesn't
successfully return the device to D3, then the actual state of the
device and dev->current_state are contradictory.  Put everything
in D0 going into the reset, then we don't need to do anything
special on the way out.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 91f7bc4..3e71887 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3393,6 +3393,13 @@ static void pci_dev_unlock(struct pci_dev *dev)
 
 static void pci_dev_save_and_disable(struct pci_dev *dev)
 {
+	/*
+	 * Wake-up device prior to save.  PM registers default to D0 after
+	 * reset and a simple register restore doesn't reliably return
+	 * to a non-D0 state anyway.
+	 */
+	pci_set_power_state(dev, PCI_D0);
+
 	pci_save_state(dev);
 	/*
 	 * both INTx and MSI are disabled after the Interrupt Disable bit

