Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36414 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbHUPHz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 11:07:55 -0400
Received: by pawq9 with SMTP id q9so54591863paw.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2015 08:07:55 -0700 (PDT)
Subject: [PATCH 2/3] PCI: Set MPS to match upstream bridge
To: Keith Busch <keith.busch@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Austin Bolen <Austin_Bolen@dell.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Myron Stowe <mstowe@redhat.com>, Jon Mason <jdmason@kudzu.us>
Date: Fri, 21 Aug 2015 10:07:51 -0500
Message-ID: <20150821150751.7525.81766.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Keith Busch <keith.busch@intel.com>

Firmware typically configures the PCIe fabric with a consistent Max Payload
Size setting based on the devices present at boot.  A hot-added device
typically has the power-on default MPS setting (128 bytes), which may not
match the fabric.

When adding a new device via pci_device_add(), set its Max Payload Size to
match the upstream bridge (unless PCIe bus tuning is disabled).  Note that
pcie_bus_configure_settings() may further change MPS based on the tuning
policy.

This makes it more likely that a hot-added device will work in a system
with optimized MPS configuration.

If we hot-add a device that only supports 128-byte MPS, it still likely
won't work because we don't reconfigure the rest of the fabric.  Booting
with "pci=pcie_bus_peer2peer" is a workaround for this because it sets MPS
to 128 for everything.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index eb32395..f73dd7a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1278,7 +1278,7 @@ int pci_setup_device(struct pci_dev *dev)
 static void pci_configure_mps(struct pci_dev *dev)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
-	int mps, p_mps;
+	int mps, p_mps, rc;
 
 	if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
 		return;
@@ -1294,6 +1294,16 @@ static void pci_configure_mps(struct pci_dev *dev)
 			 mps, pci_name(bridge), p_mps);
 		return;
 	}
+
+	rc = pcie_set_mps(dev, p_mps);
+	if (rc) {
+		dev_warn(&dev->dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
+			 p_mps);
+		return;
+	}
+
+	dev_info(&dev->dev, "Max Payload Size set to %d (was %d, max %d)\n",
+		 p_mps, mps, 128 << dev->pcie_mpss);
 }
 
 static struct hpp_type0 pci_default_type0 = {

