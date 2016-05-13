Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:41330 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbcEMLPv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:15:51 -0400
Message-Id: <0d326baadc1f81e338ca628b64b330f1f84f889e.1463134231.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 01/13] PCI: Recognize Thunderbolt devices
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We're about to add a Thunderbolt port service in pcie/portdrv_core.c,
allow runtime PM for Thunderbolt ports on Macs in pcie/portdrv_pci.c
and allow power state D3 for Thunderbolt ports in pci.c.  In each case
we need to uniquely identify if a PCI device belongs to a Thunderbolt
controller.

We also have the need to detect presence of a Thunderbolt controller in
drivers/platform/x86/apple-gmux.c because dual GPU MacBook Pros cannot
switch external DP/HDMI ports between GPUs if they have Thunderbolt.

Intel uses a Vendor-Specific Extended Capability (VSEC) with ID 0x1234
on all Thunderbolt devices which allows us to recognize them.

Detect presence of this VSEC on device probe and cache it in a newly
added is_thunderbolt bit in struct pci_dev which can then be queried by
pci.c, portdrv, apple-gmux and possibly others.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.h   |  2 ++
 drivers/pci/probe.c | 17 +++++++++++++++++
 include/linux/pci.h |  1 +
 3 files changed, 20 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9730c47..14ceed7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -6,6 +6,8 @@
 
 #define PCI_FIND_CAP_TTL	48
 
+#define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
+
 extern const unsigned char pcie_link_speed[];
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ae7daeb..57f175e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1078,6 +1078,20 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 		pdev->is_hotplug_bridge = 1;
 }
 
+static void parse_pcie_vendor_specific_caps(struct pci_dev *dev)
+{
+	int vsec = 0;
+	u32 header;
+
+	while ((vsec = pci_find_next_ext_capability(dev, vsec,
+						    PCI_EXT_CAP_ID_VNDR))) {
+		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
+		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
+		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT)
+			dev->is_thunderbolt = 1;
+	}
+}
+
 /**
  * pci_ext_cfg_is_aliased - is ext config space just an alias of std config?
  * @dev: PCI device
@@ -1230,6 +1244,9 @@ int pci_setup_device(struct pci_dev *dev)
 	/* need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
 
+	/* need to have dev->cfg_size ready */
+	parse_pcie_vendor_specific_caps(dev);
+
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7081db3f..267564d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -346,6 +346,7 @@ struct pci_dev {
 	unsigned int	is_virtfn:1;
 	unsigned int	reset_fn:1;
 	unsigned int    is_hotplug_bridge:1;
+	unsigned int	is_thunderbolt:1;
 	unsigned int    __aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
 	unsigned int	broken_intx_masking:1;
-- 
2.8.1

