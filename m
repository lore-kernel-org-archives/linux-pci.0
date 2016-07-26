Return-Path: <andreas.noever@gmail.com>
Return-Path: <andreas.noever@gmail.com>
From: Andreas Noever <andreas.noever@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	xavier.gnata@gmail.com,
	gregkh@linuxfoundation.org
Cc: lukas@wunner.de,
	helgaas@kernel.org,
	Andreas Noever <andreas.noever@gmail.com>
Subject: [PATCH 2/2] thunderbolt: Add support for INTEL_FALCON_RIDGE_2C controller.
Date: Tue, 26 Jul 2016 18:40:38 +0200
Message-Id: <20160726164038.1481-2-andreas.noever@gmail.com>
In-Reply-To: <20160726164038.1481-1-andreas.noever@gmail.com>
References: <20160726164038.1481-1-andreas.noever@gmail.com>
List-ID: <linux-pci.vger.kernel.org>

From: Xavier Gnata <xavier.gnata@gmail.com>

From: Xavier Gnata <xavier.gnata@gmail.com>

Add support to INTEL_FALCON_RIDGE_2C controller and corresponding quirk
to support suspend/resume.
Tested against 4.7 master on a MacBook Air 11" 2015.

Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
---
 drivers/pci/quirks.c      | 4 ++++
 drivers/thunderbolt/nhi.c | 6 ++++++
 2 files changed, 10 insertions(+)

Rebased version of Xavier's patch.

Xavier, could you verify that this still works on your system?

Thanks,
Andreas

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 75b2105..981f17d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3325,6 +3325,7 @@ static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
 	if (nhi->vendor != PCI_VENDOR_ID_INTEL
 		    || (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
 			nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
+			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI &&
 			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
 		    || nhi->class != PCI_CLASS_SYSTEM_OTHER << 8)
 		goto out;
@@ -3341,6 +3342,9 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
 			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
 			       quirk_apple_wait_for_thunderbolt);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
+			       PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE,
+			       quirk_apple_wait_for_thunderbolt);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
 			       PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE,
 			       quirk_apple_wait_for_thunderbolt);
 #endif
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 9c15344..a8c2041 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -651,6 +651,12 @@ static struct pci_device_id nhi_ids[] = {
 	{
 		.class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
 		.vendor = PCI_VENDOR_ID_INTEL,
+		.device = PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI,
+		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
+	},
+	{
+		.class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
+		.vendor = PCI_VENDOR_ID_INTEL,
 		.device = PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI,
 		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
 	},
-- 
2.9.0
