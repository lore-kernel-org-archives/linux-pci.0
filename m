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
Subject: [PATCH 1/2] thunderbolt: Fix resume quirk for Falcon Ridge 4C.
Date: Tue, 26 Jul 2016 18:40:37 +0200
Message-Id: <20160726164038.1481-1-andreas.noever@gmail.com>
List-ID: <linux-pci.vger.kernel.org>

The quirk 'quirk_apple_wait_for_thunderbolt' did not fire on Falcon
Ridge 4C controllers with subdevice/subvendor set to zero. This lead
to lost pci devices on system resume.

Older thunderbolt controllers (pre Falcon Ridge) used the same device id
for bridges and for the controller. On Apple hardware the subvendor- &
subdevice-ids were set for the controller, but not for bridges. So that
is what was used to differentiate between the two. Starting with Falcon
Ridge bridges and controllers received different device ids.
Additionally on some MacBookPro models (but not all) the
subvendor/subdevice was zeroed.

Starting with a42fb351c (thunderbolt: Allow loading of module on recent
Apple MacBooks with thunderbolt 2 controller) the thunderbolt driver
binds to all Falcon Ridge 4C controllers (irregardless of
subvendor/subdevice). The corresponding quirk was not updated.

This commit changes the quirk to check the device class instead of its
subvendor-/subdeviceids. This works for all generations of Thunderbolt
controllers.

Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
---
 drivers/pci/quirks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ee72ebe..75b2105 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3326,8 +3326,7 @@ static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
 		    || (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
 			nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
 			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
-		    || nhi->subsystem_vendor != 0x2222
-		    || nhi->subsystem_device != 0x1111)
+		    || nhi->class != PCI_CLASS_SYSTEM_OTHER << 8)
 		goto out;
 	dev_info(&dev->dev, "quirk: waiting for thunderbolt to reestablish PCI tunnels...\n");
 	device_pm_wait_for_dev(&dev->dev, &nhi->dev);
-- 
2.9.0
