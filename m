Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59489 "EHLO
	mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753542AbcHRH3j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2016 03:29:39 -0400
From: Ilya Lesokhin <ilyal@mellanox.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com, ilyal@mellanox.com
Subject: [PATCH V3 2/3] vfio/pci: Allow control SR-IOV through sysfs interface
Date: Thu, 18 Aug 2016 10:29:16 +0300
Message-Id: <1471505357-78110-3-git-send-email-ilyal@mellanox.com>
In-Reply-To: <1471505357-78110-1-git-send-email-ilyal@mellanox.com>
References: <1471505357-78110-1-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch allows enabling and disabling SR-IOV for
devices probed by vfio-pci.
Since the devices might be assigned to an untrusted entities
we use driver_override to make sure the VFs are also
probed by the the vfio-pci driver.

Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
---
 drivers/vfio/pci/vfio_pci.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index d624a52..6a203a7 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -297,6 +297,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	int i, bar;
 
+	pci_disable_sriov(pdev);
 	/* Stop the device from further DMA */
 	pci_clear_master(pdev);
 
@@ -1314,12 +1315,25 @@ static const struct pci_error_handlers vfio_err_handlers = {
 	.error_detected = vfio_pci_aer_err_detected,
 };
 
+static int vfio_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	if (!num_vfs) {
+		pci_disable_sriov(pdev);
+		return 0;
+	}
+
+	return pci_enable_sriov_with_override(pdev,
+					      num_vfs,
+					     "vfio-pci");
+}
+
 static struct pci_driver vfio_pci_driver = {
-	.name		= "vfio-pci",
-	.id_table	= NULL, /* only dynamic ids */
-	.probe		= vfio_pci_probe,
-	.remove		= vfio_pci_remove,
-	.err_handler	= &vfio_err_handlers,
+	.name		 = "vfio-pci",
+	.id_table	 = NULL, /* only dynamic ids */
+	.probe		 = vfio_pci_probe,
+	.remove		 = vfio_pci_remove,
+	.err_handler	 = &vfio_err_handlers,
+	.sriov_configure = vfio_pci_sriov_configure,
 };
 
 struct vfio_devices {
-- 
1.8.3.1

