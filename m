Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36524 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbHUPIF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 11:08:05 -0400
Received: by pawq9 with SMTP id q9so54594397paw.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2015 08:08:04 -0700 (PDT)
Subject: [PATCH 3/3] PCI: Change MPS default to "match upstream bridge"
To: Keith Busch <keith.busch@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Austin Bolen <Austin_Bolen@dell.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Myron Stowe <mstowe@redhat.com>, Jon Mason <jdmason@kudzu.us>
Date: Fri, 21 Aug 2015 10:08:00 -0500
Message-ID: <20150821150800.7525.14750.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change the default MPS tuning policy to "default," which means we set every
device's MPS to match its upstream bridge.  Typically this means we'll
preserve the fabric configuration done by firmware, even for hot-added
devices.

N.B. This effectively re-enables quirk_intel_mc_errata(), which turns off
read completion coalescing on Intel 5000 and 5100 memory controllers.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   |    2 +-
 drivers/pci/probe.c |    3 ++-
 include/linux/pci.h |    9 +++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..b96b4cc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -81,7 +81,7 @@ unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
 unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
 
-enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
 
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f73dd7a..9da27af 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1831,7 +1831,8 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 	if (!pci_is_pcie(dev))
 		return 0;
 
-	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
+	if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
+	    pcie_bus_config == PCIE_BUS_DEFAULT)
 		return 0;
 
 	mps = 128 << *(u8 *)data;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4d4f9d2..faf06a1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -738,10 +738,11 @@ struct pci_driver {
 void pcie_bus_configure_settings(struct pci_bus *bus);
 
 enum pcie_bus_config_types {
-	PCIE_BUS_TUNE_OFF,
-	PCIE_BUS_SAFE,
-	PCIE_BUS_PERFORMANCE,
-	PCIE_BUS_PEER2PEER,
+	PCIE_BUS_TUNE_OFF,	/* don't touch MPS at all */
+	PCIE_BUS_DEFAULT,	/* MPS matches upstream bridge */
+	PCIE_BUS_SAFE,		/* largest MPS supported by boot-time devices */
+	PCIE_BUS_PERFORMANCE,	/* use MPS and MRRS for best performance */
+	PCIE_BUS_PEER2PEER,	/* MPS = 128 for all devices */
 };
 
 extern enum pcie_bus_config_types pcie_bus_config;

