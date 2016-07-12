Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Xavier Gnata <xavier.gnata@gmail.com>
Subject: [PATCH] thunderbolt: Add support for INTEL_FALCON_RIDGE_2C controller
To: linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>
Cc: linux-pci@vger.kernel.org
Message-ID: <5785474B.6070608@gmail.com>
Date: Tue, 12 Jul 2016 21:38:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support to INTEL_FALCON_RIDGE_2C controller and corresponding quirk 
to support suspend/resume.
Tested against 4.7 master on a MacBook Air 11" 2015

---
drivers/thunderbolt/nhi.c | 6 ++++++
1 file changed, 6 insertions(+)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 9c15344..b3d55ec 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -654,6 +654,12 @@ static struct pci_device_id nhi_ids[] = {
.device = PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI,
.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
},
+ {
+ .class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
+ .vendor = PCI_VENDOR_ID_INTEL,
+ .device = PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI,
+ .subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
+ },
{ 0,}
};

-- 
2.7.4


---
  drivers/pci/quirks.c | 23 +++++++++++++++--------
  1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ee72ebe..e280351 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3320,15 +3320,19 @@ static void 
quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
         if (!sibling || !sibling->subordinate)
                 goto out;
         nhi = pci_get_slot(sibling->subordinate, 0x0);
-       if (!nhi)
-               goto out;
-       if (nhi->vendor != PCI_VENDOR_ID_INTEL
-                   || (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
-                       nhi->device != 
PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
-                       nhi->device != 
PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
-                   || nhi->subsystem_vendor != 0x2222
-                   || nhi->subsystem_device != 0x1111)
+       if (!nhi || nhi->vendor != PCI_VENDOR_ID_INTEL)
                 goto out;
+       if (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
+               nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
+               nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI &&
+               nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI)
+        goto out;
+       if((nhi->device == PCI_DEVICE_ID_INTEL_LIGHT_RIDGE ||
+               nhi->device == PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C ||
+               nhi->device == PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
+               && (nhi->subsystem_vendor != 0x222
+               || nhi->subsystem_device != 0x1111))
+        goto out;
         dev_info(&dev->dev, "quirk: waiting for thunderbolt to 
reestablish PCI tunnels...\n");
         device_pm_wait_for_dev(&dev->dev, &nhi->dev);
  out:
@@ -3344,6 +3348,9 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
                                PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE,
                                quirk_apple_wait_for_thunderbolt);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
+                              PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE,
+                              quirk_apple_wait_for_thunderbolt);
  #endif

  static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
-- 
2.7.4
