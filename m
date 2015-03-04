Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48584 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757686AbbCDUCw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Mar 2015 15:02:52 -0500
Subject: [PATCH 2/5] vfio-pci: Add module option to disable VGA region access
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2015 13:02:49 -0700
Message-ID: <20150304200249.26766.14344.stgit@gimli.home>
In-Reply-To: <20150304194711.26766.75450.stgit@gimli.home>
References: <20150304194711.26766.75450.stgit@gimli.home>
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
 drivers/vfio/pci/vfio_pci.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b3bae4c..9c854b0 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -41,8 +41,24 @@ module_param_named(nointxmask, nointxmask, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(nointxmask,
 		  "Disable support for PCI 2.3 style INTx masking.  If this resolves problems for specific devices, report lspci -vvvxxx to linux-pci@vger.kernel.org so the device can be fixed automatically via the broken_intx_masking flag.");
 
+#ifdef CONFIG_VFIO_PCI_VGA
+static bool disable_vga;
+module_param_named(disable_vga, disable_vga, bool, S_IRUGO);
+MODULE_PARM_DESC(disable_vga,
+		 "Disable VGA resource access for VGA-capable devices");
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
@@ -97,10 +113,8 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 	} else
 		vdev->msix_bar = 0xFF;
 
-#ifdef CONFIG_VFIO_PCI_VGA
-	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
+	if (!vfio_vga_disabled() && (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vdev->has_vga = true;
-#endif
 
 	return 0;
 }

