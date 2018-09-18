Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47633 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbeISFaa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:30:30 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 01/10] PCI/portdrv: Use subsys_init for service drivers
Date: Tue, 18 Sep 2018 17:56:53 -0600
Message-Id: <20180918235702.26573-2-keith.busch@intel.com>
In-Reply-To: <20180918235702.26573-1-keith.busch@intel.com>
References: <20180918235702.26573-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI port driver saves the PCI state after initializing all the
service devices. This was, however, before the service drivers were even
registered. The config space state that the service drivers were setting
up were not being saved.

This patch fixes this by changing the service drivers use the
subsys_init, which gets the service drivers registered after the pci bus
system is initialized, but before the pci devices are probed. This gets
the state saved as expected.

Note, 70626d88385 ("PCI: pciehp: Make explicitly non-modular") already
mentioned this exact change should be done, but declined to at the time
until there was a real need for it.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_core.c | 2 +-
 drivers/pci/pcie/aer.c            | 2 +-
 drivers/pci/pcie/dpc.c            | 2 +-
 drivers/pci/pcie/pme.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ccaf01e6eced..334044814dbe 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -322,4 +322,4 @@ static int __init pcied_init(void)
 
 	return retval;
 }
-device_initcall(pcied_init);
+subsys_initcall(pcied_init);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 83180edd6ed4..1d2159409b01 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1575,4 +1575,4 @@ static int __init aer_service_init(void)
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
-device_initcall(aer_service_init);
+subsys_initcall(aer_service_init);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f03279fc87cd..aacfb50eccfc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -286,4 +286,4 @@ static int __init dpc_service_init(void)
 {
 	return pcie_port_service_register(&dpcdriver);
 }
-device_initcall(dpc_service_init);
+subsys_initcall(dpc_service_init);
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 3ed67676ea2a..cd8c1adb9b0a 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -450,4 +450,4 @@ static int __init pcie_pme_service_init(void)
 {
 	return pcie_port_service_register(&pcie_pme_driver);
 }
-device_initcall(pcie_pme_service_init);
+subsys_initcall(pcie_pme_service_init);
-- 
2.14.4
