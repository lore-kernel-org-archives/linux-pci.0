Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:52402 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806Ab2JLFf7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Oct 2012 01:35:59 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1145065dak.19
        for <linux-pci@vger.kernel.org>; Thu, 11 Oct 2012 22:35:59 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 3/3] PCI: Add new default PCI-E MPS bus state
Date: Thu, 11 Oct 2012 22:35:55 -0700
Message-Id: <1350020155-3782-4-git-send-email-jdmason@kudzu.us>
In-Reply-To: <1350020155-3782-1-git-send-email-jdmason@kudzu.us>
References: <1350020155-3782-1-git-send-email-jdmason@kudzu.us>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a new default state for the PCI-E MPS determination, PCIE_BUS_WARN.
This state notifies the user that a suboptimal configuration is
occurring (most likely due to incorrect configuration in the BIOS), and
provides them the boot parameter to enable this error to be corrected.
This provides the users an ability to detect an issue with MPS, without
forcing them to correct the issue (which may cause system hangs).  This
is a much more sane default for the distros.

Also, add debug output to show the default device MPS and MPSS.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
CC: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c    |    2 +-
 drivers/pci/probe.c  |   10 ++++++++++
 drivers/pci/quirks.c |    3 ++-
 include/linux/pci.h  |    1 +
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ab4bf5a..1723c81 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -78,7 +78,7 @@ unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
 unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
 
-enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
+enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_WARN;
 
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5a18652..64bb393 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1448,6 +1448,9 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
 	if (!pci_is_pcie(dev))
 		return 0;
 
+	dev_dbg(&dev->dev, "Device MPS %d and MPSS %d\n",
+		pcie_get_mps(dev), 128 << dev->pcie_mpss);
+
 	/* For PCIE hotplug enabled slots not connected directly to a
 	 * PCI-E root port, there can be problems when hotplugging
 	 * devices.  This is due to the possibility of hotplugging a
@@ -1588,6 +1591,7 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
 		smpss = 0;
 		break;
 
+	case PCIE_BUS_WARN:
 	case PCIE_BUS_SAFE:
 		smpss = mpss;
 
@@ -1600,6 +1604,12 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
 		return;
 	}
 
+	if (pcie_bus_config == PCIE_BUS_WARN) {
+		if (smpss != mpss)
+			dev_info(&bus->dev, "Non-optimal PCI-E Bus MPS value of %d being used instead of %d.\n"
+				 "Please use the pci=pcie_bus_safe boot parameter for better performance.\n",
+				 128 << smpss, 128 << mpss);
+		return;
 	}
 
 	pcie_bus_configure_set(bus->self, &smpss);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5155317..e4eede0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2787,7 +2787,8 @@ static void __devinit quirk_intel_mc_errata(struct pci_dev *dev)
 	int err;
 	u16 rcc;
 
-	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
+	if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
+	    pcie_bus_config == PCIE_BUS_WARN)
 		return;
 
 	/* Intel errata specifies bits to change but does not say what they are.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5faa831..410eaf9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -662,6 +662,7 @@ extern void pcie_bus_configure_settings(struct pci_bus *bus, u8 smpss);
 
 enum pcie_bus_config_types {
 	PCIE_BUS_TUNE_OFF,
+	PCIE_BUS_WARN,
 	PCIE_BUS_SAFE,
 	PCIE_BUS_PERFORMANCE,
 	PCIE_BUS_PEER2PEER,
-- 
1.7.9.5

