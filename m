Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-Id: <d30491f2c4c1c6d28c78c5883820f9dc28c010d9.1458126755.git.lukas@wunner.de>
In-Reply-To: <cover.1458126755.git.lukas@wunner.de>
References: <cover.1458126755.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 16 Mar 2016 15:50:35 +0100
Subject: [RFC 1/4] PCI: Add Thunderbolt device IDs
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Gen 1 and 2 chips use the same ID for NHI, bridges and switch.
Gen 3 chips and onward use a distinct ID for the NHI.

Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/quirks.c         | 16 ++++++++++------
 drivers/thunderbolt/nhi.c    |  8 +++++---
 drivers/thunderbolt/switch.c |  9 +++++----
 include/linux/pci_ids.h      | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0575a1e..d1e3956 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3203,7 +3203,8 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 	acpi_execute_simple_method(SXIO, NULL, 0);
 	acpi_execute_simple_method(SXLV, NULL, 0);
 }
-DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL, 0x1547,
+DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
+			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 			       quirk_apple_poweroff_thunderbolt);
 
 /*
@@ -3237,9 +3238,10 @@ static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
 	if (!nhi)
 		goto out;
 	if (nhi->vendor != PCI_VENDOR_ID_INTEL
-			|| (nhi->device != 0x1547 && nhi->device != 0x156c)
-			|| nhi->subsystem_vendor != 0x2222
-			|| nhi->subsystem_device != 0x1111)
+		    || (nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
+			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
+		    || nhi->subsystem_vendor != 0x2222
+		    || nhi->subsystem_device != 0x1111)
 		goto out;
 	dev_info(&dev->dev, "quirk: waiting for thunderbolt to reestablish PCI tunnels...\n");
 	device_pm_wait_for_dev(&dev->dev, &nhi->dev);
@@ -3247,9 +3249,11 @@ out:
 	pci_dev_put(nhi);
 	pci_dev_put(sibling);
 }
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL, 0x1547,
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
+			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 			       quirk_apple_wait_for_thunderbolt);
-DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL, 0x156d,
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
+			       PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE,
 			       quirk_apple_wait_for_thunderbolt);
 #endif
 
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 20a41f7..36be23b 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -633,16 +633,18 @@ static const struct dev_pm_ops nhi_pm_ops = {
 static struct pci_device_id nhi_ids[] = {
 	/*
 	 * We have to specify class, the TB bridges use the same device and
-	 * vendor (sub)id.
+	 * vendor (sub)id on gen 1 and gen 2 controllers.
 	 */
 	{
 		.class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
-		.vendor = PCI_VENDOR_ID_INTEL, .device = 0x1547,
+		.vendor = PCI_VENDOR_ID_INTEL,
+		.device = PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 		.subvendor = 0x2222, .subdevice = 0x1111,
 	},
 	{
 		.class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
-		.vendor = PCI_VENDOR_ID_INTEL, .device = 0x156c,
+		.vendor = PCI_VENDOR_ID_INTEL,
+		.device = PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI,
 		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
 	},
 	{ 0,}
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index aeb9829..db73ffe 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -293,9 +293,9 @@ static int tb_plug_events_active(struct tb_switch *sw, bool active)
 	if (active) {
 		data = data & 0xFFFFFF83;
 		switch (sw->config.device_id) {
-		case 0x1513:
-		case 0x151a:
-		case 0x1549:
+		case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
+		case PCI_DEVICE_ID_INTEL_EAGLE_RIDGE:
+		case PCI_DEVICE_ID_INTEL_PORT_RIDGE:
 			break;
 		default:
 			data |= 4;
@@ -370,7 +370,8 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, u64 route)
 		tb_sw_warn(sw, "unknown switch vendor id %#x\n",
 			   sw->config.vendor_id);
 
-	if (sw->config.device_id != 0x1547 && sw->config.device_id != 0x1549)
+	if (sw->config.device_id != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
+	    sw->config.device_id != PCI_DEVICE_ID_INTEL_PORT_RIDGE)
 		tb_sw_warn(sw, "unsupported switch device id %#x\n",
 			   sw->config.device_id);
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 37f05cb..bec46b7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2599,6 +2599,24 @@
 #define PCI_DEVICE_ID_INTEL_82441	0x1237
 #define PCI_DEVICE_ID_INTEL_82380FB	0x124b
 #define PCI_DEVICE_ID_INTEL_82439	0x1250
+#define PCI_DEVICE_ID_INTEL_LIGHT_RIDGE             0x1513 /* Tbt 1 Gen 1 */
+#define PCI_DEVICE_ID_INTEL_EAGLE_RIDGE             0x151a
+#define PCI_DEVICE_ID_INTEL_LIGHT_PEAK              0x151b
+#define PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C         0x1547 /* Tbt 1 Gen 2 */
+#define PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_2C         0x1548
+#define PCI_DEVICE_ID_INTEL_PORT_RIDGE              0x1549
+#define PCI_DEVICE_ID_INTEL_REDWOOD_RIDGE_2C_NHI    0x1566 /* Tbt 1 Gen 3 */
+#define PCI_DEVICE_ID_INTEL_REDWOOD_RIDGE_2C_BRIDGE 0x1567
+#define PCI_DEVICE_ID_INTEL_REDWOOD_RIDGE_4C_NHI    0x1568
+#define PCI_DEVICE_ID_INTEL_REDWOOD_RIDGE_4C_BRIDGE 0x1569
+#define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI     0x156a /* Thunderbolt 2 */
+#define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE  0x156b
+#define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI     0x156c
+#define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE  0x156d
+#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_NHI     0x1575 /* Thunderbolt 3 */
+#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE  0x1576
+#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
+#define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
 #define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
 #define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
-- 
2.7.0

