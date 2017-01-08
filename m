Return-Path: <SRS0=aNbu=YW=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=aNbu=YW=wunner.de=lukas@kernel.org>
Message-Id: <dbb277a11a08c515fe518447ad496dfbffc3e1d8.1483806825.git.lukas@wunner.de>
In-Reply-To: <cover.1483806825.git.lukas@wunner.de>
References: <cover.1483806825.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 8 Jan 2017 09:41:45 +0100
Subject: [PATCH v4 1/8] PCI: Recognize Thunderbolt devices
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Tomas Winkler <tomas.winkler@intel.com>, Amir Levy <amir.jer.levy@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
List-ID: <linux-pci.vger.kernel.org>

We're about to allow runtime PM on Thunderbolt ports in
pci_bridge_d3_possible() and unblock runtime PM for Thunderbolt host
hotplug ports in pci_dev_check_d3cold().  In both cases we need to
uniquely identify if a PCI device belongs to a Thunderbolt controller.

We also have the need to detect presence of a Thunderbolt controller in
drivers/platform/x86/apple-gmux.c because dual GPU MacBook Pros cannot
switch external DP/HDMI ports between GPUs if they have Thunderbolt.

Furthermore, in multiple places in the DRM subsystem we need to detect
whether a GPU is on-board or attached with Thunderbolt.  As an example,
Thunderbolt-attached GPUs shall not be registered with vga_switcheroo.

Intel uses a Vendor-Specific Extended Capability (VSEC) with ID 0x1234
on devices belonging to a Thunderbolt controller which allows us to
recognize them.

Detect presence of this VSEC on device probe and cache it in a newly
added is_thunderbolt bit in struct pci_dev which can then be queried by
pci_bridge_d3_possible(), pci_dev_check_d3cold(), apple-gmux and others.

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Amir Levy <amir.jer.levy@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.h   |  2 ++
 drivers/pci/probe.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 3 files changed, 37 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cb17db2..45c2b81 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -3,6 +3,8 @@
 
 #define PCI_FIND_CAP_TTL	48
 
+#define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
+
 extern const unsigned char pcie_link_speed[];
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e164b5c..891a8fa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1206,6 +1206,37 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 		pdev->is_hotplug_bridge = 1;
 }
 
+static void set_pcie_vendor_specific(struct pci_dev *dev)
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
+		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT)
+			dev->is_thunderbolt = 1;
+	}
+
+	/*
+	 * Is the device attached with Thunderbolt?  Walk upwards and check for
+	 * each encountered bridge if it's part of a Thunderbolt controller.
+	 * Reaching the host bridge means dev is soldered to the mainboard.
+	 */
+	if (!dev->is_thunderbolt) {
+		struct pci_dev *parent = dev;
+
+		while ((parent = pci_upstream_bridge(parent)))
+			if (parent->is_thunderbolt) {
+				dev->is_thunderbolt = 1;
+				break;
+			}
+	}
+}
+
 /**
  * pci_ext_cfg_is_aliased - is ext config space just an alias of std config?
  * @dev: PCI device
@@ -1358,6 +1389,9 @@ int pci_setup_device(struct pci_dev *dev)
 	/* need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
 
+	/* need to have dev->cfg_size ready */
+	set_pcie_vendor_specific(dev);
+
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a12..3c775e8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -358,6 +358,7 @@ struct pci_dev {
 	unsigned int	is_virtfn:1;
 	unsigned int	reset_fn:1;
 	unsigned int    is_hotplug_bridge:1;
+	unsigned int	is_thunderbolt:1; /* part of Thunderbolt daisy chain */
 	unsigned int    __aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
 	unsigned int	broken_intx_masking:1;
-- 
2.11.0
