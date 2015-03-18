Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35101 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbbCRUNU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Mar 2015 16:13:20 -0400
Subject: [PATCH v2 2/6] vfio-pci: Add module option to disable VGA region
 access
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, bsd@redhat.com,
	linux-kernel@vger.kernel.org
Date: Wed, 18 Mar 2015 14:13:18 -0600
Message-ID: <20150318201318.24807.57900.stgit@gimli.home>
In-Reply-To: <20150318200053.24807.74115.stgit@gimli.home>
References: <20150318200053.24807.74115.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a module option so that we don't require a CONFIG change and
kernel rebuild to disable VGA support.  Not only can VGA support be
troublesome in itself, but by disabling it we can reduce the impact
to host devices by doing a VGA arbitration opt-out.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 2f865d07..7053110 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -37,8 +37,23 @@ module_param_named(nointxmask, nointxmask, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(nointxmask,
 		  "Disable support for PCI 2.3 style INTx masking.  If this resolves problems for specific devices, report lspci -vvvxxx to linux-pci@vger.kernel.org so the device can be fixed automatically via the broken_intx_masking flag.");
 
+#ifdef CONFIG_VFIO_PCI_VGA
+static bool disable_vga;
+module_param(disable_vga, bool, S_IRUGO);
+MODULE_PARM_DESC(disable_vga, "Disable VGA resource access through vfio-pci");
+#endif
+
 static DEFINE_MUTEX(driver_lock);
 
+static inline bool vfio_vga_disabled(void)
+{
+#ifdef CONFIG_VFIO_PCI_VGA
+	return disable_vga;
+#else
+	return true;
+#endif
+}
+
 static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev);
 
 static int vfio_pci_enable(struct vfio_pci_device *vdev)
@@ -93,10 +108,8 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 	} else
 		vdev->msix_bar = 0xFF;
 
-#ifdef CONFIG_VFIO_PCI_VGA
-	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
+	if (!vfio_vga_disabled() && (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vdev->has_vga = true;
-#endif
 
 	return 0;
 }

