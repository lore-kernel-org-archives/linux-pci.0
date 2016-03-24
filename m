Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50975 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbcCXTFT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Mar 2016 15:05:19 -0400
Subject: [PATCH] vfio/pci: Hide broken INTx support from user
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: linux-pci@vger.kernel.org, john.ronciak@intel.com,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	jesse.brandeburg@intel.com
Date: Thu, 24 Mar 2016 13:05:18 -0600
Message-ID: <20160324190507.4089.41546.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

INTx masking has two components, the first is that we need the ability
to prevent the device from continuing to assert INTx.  This is
provided via the DisINTx bit in the command register and is the only
thing we can really probe for when testing if INTx masking is
supported.  The second component is that the device needs to indicate
if INTx is asserted via the interrupt status bit in the device status
register.  With these two features we can generically determine if one
of the devices we own is asserting INTx, signal the user, and mask the
interrupt while the user services the device.

Generally if one or both of these components is broken we resort to
APIC level interrupt masking, which requires an exclusive interrupt
since we have no way to determine the source of the interrupt in a
shared configuration.  This often makes it difficult or impossible to
configure the system for userspace use of the device, for an interrupt
mode that the user may not need.

One possible configuration of broken INTx masking is that the DisINTx
support is fully functional, but the interrupt status bit never
signals interrupt assertion.  In this case we do have the ability to
prevent the device from asserting INTx, but lack the ability to
identify the interrupt source.  For this case we can simply pretend
that the device lacks INTx support entirely, keeping DisINTx set on
the physical device, virtualizing this bit for the user, and
virtualizing the interrupt pin register to indicate no INTx support.
We already support virtualization of the DisINTx bit and already
virtualize the interrupt pin for platforms without INTx support.  By
tying these components together, setting DisINTx on open and reset,
and identifying devices broken in this particular way, we can provide
support for them w/o the handicap of APIC level INTx masking.

Intel i40e (XL710/X710) 10/20/40GbE NICs have been identified as being
broken in this specific way.  We leave the vfio-pci.nointxmask option
as a mechanism to bypass this support, enabling INTx on the device
with all the requirements of APIC level masking.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: John Ronciak <john.ronciak@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/vfio/pci/vfio_pci.c         |   55 +++++++++++++++++++++++++++++------
 drivers/vfio/pci/vfio_pci_config.c  |    9 +++++-
 drivers/vfio/pci/vfio_pci_private.h |    1 +
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 712a849..188b1ff 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -113,6 +113,35 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev);
 static void vfio_pci_disable(struct vfio_pci_device *vdev);
 
+/*
+ * INTx masking requires the ability to disable INTx signaling via PCI_COMMAND
+ * _and_ the ability detect when the device is asserting INTx via PCI_STATUS.
+ * If a device implements the former but not the latter we would typically
+ * expect broken_intx_masking be set and require an exclusive interrupt.
+ * However since we do have control of the device's ability to assert INTx,
+ * we can instead pretend that the device does not implement INTx, virtualizing
+ * the pin register to report zero and maintaining DisINTx set on the host.
+ */
+static bool vfio_pci_nointx(struct pci_dev *pdev)
+{
+	switch (pdev->vendor) {
+	case PCI_VENDOR_ID_INTEL:
+		switch (pdev->device) {
+		/* All i40e (XL710/X710) 10/20/40GbE NICs */
+		case 0x1572:
+		case 0x1574:
+		case 0x1580 ... 0x1581:
+		case 0x1583 ... 0x1589:
+		case 0x37d0 ... 0x37d2:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return false;
+}
+
 static int vfio_pci_enable(struct vfio_pci_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -136,23 +165,29 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 		pr_debug("%s: Couldn't store %s saved state\n",
 			 __func__, dev_name(&pdev->dev));
 
-	ret = vfio_config_init(vdev);
-	if (ret) {
-		kfree(vdev->pci_saved_state);
-		vdev->pci_saved_state = NULL;
-		pci_disable_device(pdev);
-		return ret;
+	if (likely(!nointxmask)) {
+		if (vfio_pci_nointx(pdev)) {
+			dev_info(&pdev->dev, "Masking broken INTx support\n");
+			vdev->nointx = true;
+			pci_intx(pdev, 0);
+		} else
+			vdev->pci_2_3 = pci_intx_mask_supported(pdev);
 	}
 
-	if (likely(!nointxmask))
-		vdev->pci_2_3 = pci_intx_mask_supported(pdev);
-
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
 	if (vdev->pci_2_3 && (cmd & PCI_COMMAND_INTX_DISABLE)) {
 		cmd &= ~PCI_COMMAND_INTX_DISABLE;
 		pci_write_config_word(pdev, PCI_COMMAND, cmd);
 	}
 
+	ret = vfio_config_init(vdev);
+	if (ret) {
+		kfree(vdev->pci_saved_state);
+		vdev->pci_saved_state = NULL;
+		pci_disable_device(pdev);
+		return ret;
+	}
+
 	msix_pos = pdev->msix_cap;
 	if (msix_pos) {
 		u16 flags;
@@ -304,7 +339,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
 	if (irq_type == VFIO_PCI_INTX_IRQ_INDEX) {
 		u8 pin;
 		pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
-		if (IS_ENABLED(CONFIG_VFIO_PCI_INTX) && pin)
+		if (IS_ENABLED(CONFIG_VFIO_PCI_INTX) && !vdev->nointx && pin)
 			return 1;
 
 	} else if (irq_type == VFIO_PCI_MSI_IRQ_INDEX) {
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 142c533..c9bb229 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -408,6 +408,7 @@ static void vfio_bar_restore(struct vfio_pci_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	u32 *rbar = vdev->rbar;
+	u16 cmd;
 	int i;
 
 	if (pdev->is_virtfn)
@@ -420,6 +421,12 @@ static void vfio_bar_restore(struct vfio_pci_device *vdev)
 		pci_user_write_config_dword(pdev, i, *rbar);
 
 	pci_user_write_config_dword(pdev, PCI_ROM_ADDRESS, *rbar);
+
+	if (vdev->nointx) {
+		pci_user_read_config_word(pdev, PCI_COMMAND, &cmd);
+		cmd |= PCI_COMMAND_INTX_DISABLE;
+		pci_user_write_config_word(pdev, PCI_COMMAND, cmd);
+	}
 }
 
 static __le32 vfio_generate_bar_flags(struct pci_dev *pdev, int bar)
@@ -1545,7 +1552,7 @@ int vfio_config_init(struct vfio_pci_device *vdev)
 		*(__le16 *)&vconfig[PCI_DEVICE_ID] = cpu_to_le16(pdev->device);
 	}
 
-	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX))
+	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx)
 		vconfig[PCI_INTERRUPT_PIN] = 0;
 
 	ret = vfio_cap_init(vdev);
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 8a7d546..016c14a 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -83,6 +83,7 @@ struct vfio_pci_device {
 	bool			bardirty;
 	bool			has_vga;
 	bool			needs_reset;
+	bool			nointx;
 	struct pci_saved_state	*pci_saved_state;
 	int			refcnt;
 	struct eventfd_ctx	*err_trigger;

