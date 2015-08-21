Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35343 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbHUPHq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 11:07:46 -0400
Received: by pacdd16 with SMTP id dd16so46202331pac.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2015 08:07:46 -0700 (PDT)
Subject: [PATCH 1/3] PCI: Move MPS configuration check to
 pci_configure_device()
To: Keith Busch <keith.busch@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Austin Bolen <Austin_Bolen@dell.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Myron Stowe <mstowe@redhat.com>, Jon Mason <jdmason@kudzu.us>
Date: Fri, 21 Aug 2015 10:07:42 -0500
Message-ID: <20150821150742.7525.57280.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we checked for invalid MPS settings, i.e., a device with MPS
different than its upstream bridge, in pcie_bus_detect_mps().  We only did
this if the arch or hotplug driver called pcie_bus_configure_settings(),
and then only if PCIe bus tuning was disabled (PCIE_BUS_TUNE_OFF).

Move the MPS checking code to pci_configure_device(), so we do it in the
pci_device_add() path for every device.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9ff4df0..eb32395 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1275,6 +1275,27 @@ int pci_setup_device(struct pci_dev *dev)
 	return 0;
 }
 
+static void pci_configure_mps(struct pci_dev *dev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
+	int mps, p_mps;
+
+	if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
+		return;
+
+	mps = pcie_get_mps(dev);
+	p_mps = pcie_get_mps(bridge);
+
+	if (mps == p_mps)
+		return;
+
+	if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
+		dev_warn(&dev->dev, "Max Payload Size %d, but upstream %s set to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
+			 mps, pci_name(bridge), p_mps);
+		return;
+	}
+}
+
 static struct hpp_type0 pci_default_type0 = {
 	.revision = 1,
 	.cache_line_size = 8,
@@ -1396,6 +1417,8 @@ static void pci_configure_device(struct pci_dev *dev)
 	struct hotplug_params hpp;
 	int ret;
 
+	pci_configure_mps(dev);
+
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
 	if (ret)
@@ -1791,22 +1814,6 @@ static void pcie_write_mrrs(struct pci_dev *dev)
 		dev_err(&dev->dev, "MRRS was unable to be configured with a safe value.  If problems are experienced, try running with pci=pcie_bus_safe\n");
 }
 
-static void pcie_bus_detect_mps(struct pci_dev *dev)
-{
-	struct pci_dev *bridge = dev->bus->self;
-	int mps, p_mps;
-
-	if (!bridge)
-		return;
-
-	mps = pcie_get_mps(dev);
-	p_mps = pcie_get_mps(bridge);
-
-	if (mps != p_mps)
-		dev_warn(&dev->dev, "Max Payload Size %d, but upstream %s set to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
-			 mps, pci_name(bridge), p_mps);
-}
-
 static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 {
 	int mps, orig_mps;
@@ -1814,10 +1821,8 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 	if (!pci_is_pcie(dev))
 		return 0;
 
-	if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
-		pcie_bus_detect_mps(dev);
+	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
 		return 0;
-	}
 
 	mps = 128 << *(u8 *)data;
 	orig_mps = pcie_get_mps(dev);

