Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:51781 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdBXTTy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2017 14:19:54 -0500
Message-Id: <c42a235e126f273e9b8712a7154f813f757db507.1487938188.git.lukas@wunner.de>
In-Reply-To: <cover.1487938188.git.lukas@wunner.de>
References: <cover.1487938188.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Feb 2017 20:19:45 +0100
Subject: [PATCH 1/5] PCI: Recognize Thunderbolt devices
To: dri-devel@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Detect on probe whether a PCI device is part of a Thunderbolt controller.

Intel uses a Vendor-Specific Extended Capability (VSEC) with ID 0x1234
on such devices.  Detect presence of this VSEC and cache it in a newly
added is_thunderbolt bit in struct pci_dev.  Add a helper to check
whether a given PCI device is situated on a Thunderbolt daisy chain.

The necessity arises from the following:

* To power off Thunderbolt controllers on Macs even if their BIOS is
  older than 2015, their PCIe ports need to be whitelisted for runtime
  PM.  For this we need a way to recognize them.

* Dual GPU MacBook Pros introduced 2011+ can no longer switch external
  DisplayPort ports between GPUs.  (They're no longer just used for DP
  but have become combined DP/Thunderbolt ports.)  The driver to switch
  the ports, drivers/platform/x86/apple-gmux.c, needs to detect presence
  of a Thunderbolt controller and, if found, keep external ports
  permanently switched to the discrete GPU.

* If an external Thunderbolt GPU is connected to a dual GPU laptop (Mac
  or not), that GPU is currently registered with vga_switcheroo even
  though it can neither drive the laptop's panel nor be powered off by
  the platform.  To vga_switcheroo it will appear as if two discrete
  GPUs are present.  As a result, when the external GPU is runtime
  suspended, vga_switcheroo will cut power to the internal discrete GPU
  which may not be runtime suspended at all at this moment.  The
  solution is to not register external GPUs with vga_switcheroo, which
  necessitates a way to recognize if they're on a Thunderbolt daisy
  chain.

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Amir Levy <amir.jer.levy@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.h   |  2 ++
 drivers/pci/probe.c | 21 +++++++++++++++++++++
 include/linux/pci.h | 23 +++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cb17db242f30..45c2b8144911 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -3,6 +3,8 @@
 
 #define PCI_FIND_CAP_TTL	48
 
+#define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
+
 extern const unsigned char pcie_link_speed[];
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 204960e70333..7963ecc6d85f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1208,6 +1208,24 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 		pdev->is_hotplug_bridge = 1;
 }
 
+static void set_pcie_thunderbolt(struct pci_dev *dev)
+{
+	int vsec = 0;
+	u32 header;
+
+	while ((vsec = pci_find_next_ext_capability(dev, vsec,
+						    PCI_EXT_CAP_ID_VNDR))) {
+		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
+
+		/* Is the device part of a Thunderbolt controller? */
+		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
+		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT) {
+			dev->is_thunderbolt = 1;
+			return;
+		}
+	}
+}
+
 /**
  * pci_ext_cfg_is_aliased - is ext config space just an alias of std config?
  * @dev: PCI device
@@ -1360,6 +1378,9 @@ int pci_setup_device(struct pci_dev *dev)
 	/* need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
 
+	/* need to have dev->cfg_size ready */
+	set_pcie_thunderbolt(dev);
+
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a124216a..36dfcfd946f4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -358,6 +358,7 @@ struct pci_dev {
 	unsigned int	is_virtfn:1;
 	unsigned int	reset_fn:1;
 	unsigned int    is_hotplug_bridge:1;
+	unsigned int	is_thunderbolt:1; /* Thunderbolt controller */
 	unsigned int    __aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
 	unsigned int	broken_intx_masking:1;
@@ -2171,6 +2172,28 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 	return bus->self && bus->self->ari_enabled;
 }
 
+/**
+ * pci_is_thunderbolt_attached - whether device is on a Thunderbolt daisy chain
+ * @pdev: PCI device to check
+ *
+ * Walk upwards from @pdev and check for each encountered bridge if it's
+ * part of a Thunderbolt controller.  Reaching the host bridge means @pdev
+ * is soldered to the mainboard.
+ */
+static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pdev;
+
+	if (pdev->is_thunderbolt)
+		return true;
+
+	while ((parent = pci_upstream_bridge(parent)))
+		if (parent->is_thunderbolt)
+			return true;
+
+	return false;
+}
+
 /* provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
-- 
2.11.0
