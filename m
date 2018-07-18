Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeGRUY2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jul 2018 16:24:28 -0400
Subject: [PATCH v3 7/7] PCI/portdrv: Remove
 pcie_portdrv_err_handler.slot_reset
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
Date: Wed, 18 Jul 2018 14:45:04 -0500
Message-ID: <153194310441.191586.1465977925038330272.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Oza Pawandeep <poza@codeaurora.org>

The pci_error_handlers.slot_reset() callback is only used for non-bridge
devices (see broadcast_error_message()).  Since portdrv only binds to
bridges, we don't need pcie_portdrv_slot_reset(), so remove it.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[bhelgaas: changelog, remove pcie_portdrv_slot_reset() completely]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_pci.c |   25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 973f1b80a038..b78840f54a9b 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -42,17 +42,6 @@ __setup("pcie_ports=", pcie_port_setup);
 
 /* global data */
 
-static int pcie_portdrv_restore_config(struct pci_dev *dev)
-{
-	int retval;
-
-	retval = pci_enable_device(dev);
-	if (retval)
-		return retval;
-	pci_set_master(dev);
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int pcie_port_runtime_suspend(struct device *dev)
 {
@@ -160,19 +149,6 @@ static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
-{
-	/* If fatal, restore cfg space for possible link reset at upstream */
-	if (dev->error_state == pci_channel_io_frozen) {
-		dev->state_saved = true;
-		pci_restore_state(dev);
-		pcie_portdrv_restore_config(dev);
-		pci_enable_pcie_error_reporting(dev);
-	}
-
-	return PCI_ERS_RESULT_RECOVERED;
-}
-
 static int resume_iter(struct device *device, void *data)
 {
 	struct pcie_device *pcie_device;
@@ -208,7 +184,6 @@ static const struct pci_device_id port_pci_ids[] = { {
 static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.error_detected = pcie_portdrv_error_detected,
 	.mmio_enabled = pcie_portdrv_mmio_enabled,
-	.slot_reset = pcie_portdrv_slot_reset,
 	.resume = pcie_portdrv_err_resume,
 };
 
