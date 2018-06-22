Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v2 6/6] PCI/PORTDRV: Remove ERR_FATAL handling from pcie_portdrv_slot_reset()
Date: Fri, 22 Jun 2018 05:58:14 -0400
Message-Id: <1529661494-20936-7-git-send-email-poza@codeaurora.org>
In-Reply-To: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are handling ERR_FATAL by resetting the Link in software,skipping the
driver pci_error_handlers callbacks, removing the devices from the PCI
subsystem, and re-enumerating, because of, no need to handle
pci_channel_io_frozen case anymore.

Besides the walk on the bus is happening on subordinates, inside
broadcast_error_message(), which means that pcie_portdrv_slot_reset()
is never called for RP, and now since the all the devices are removed under
this downstream link, we can safely get rid of ERR_FATAL handling code
in pcie_portdrv_slot_reset().

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 973f1b8..b970a6d 100644
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
@@ -163,13 +152,6 @@ static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
 static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 {
 	/* If fatal, restore cfg space for possible link reset at upstream */
-	if (dev->error_state == pci_channel_io_frozen) {
-		dev->state_saved = true;
-		pci_restore_state(dev);
-		pcie_portdrv_restore_config(dev);
-		pci_enable_pcie_error_reporting(dev);
-	}
-
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-- 
2.7.4
