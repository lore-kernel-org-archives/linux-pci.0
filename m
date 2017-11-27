Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdK0GUm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 01:20:42 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 5/7] PCI: add a return type for pci_reset_bridge_secondary_bus()
Date: Mon, 27 Nov 2017 01:20:26 -0500
Message-Id: <1511763628-11856-6-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Getting ready to return an error from pci_reset_bridge_secondary_bus() when
device is unreachable.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c   | 4 +++-
 include/linux/pci.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 87e4688..0a9a696 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4031,9 +4031,11 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
  * Use the bridge control register to assert reset on the secondary bus.
  * Devices on the secondary bus are left in power-on state.
  */
-void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
+int pci_reset_bridge_secondary_bus(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 354b018..539b3af 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1103,7 +1103,7 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 int pci_try_reset_bus(struct pci_bus *bus);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
-void pci_reset_bridge_secondary_bus(struct pci_dev *dev);
+int pci_reset_bridge_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
-- 
1.9.1
