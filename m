Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19225 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbaHHFhP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Aug 2014 01:37:15 -0400
From: Ethan Zhao <ethan.zhao@oracle.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, gleb@kernel.org, pbonzini@redhat.com,
	kvm@vger.kernel.org, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com, david.vrabel@citrix.com,
	xen-devel@lists.xenproject.org
Cc: alex.williamson@redhat.com, alexander.h.duyck@intel.com,
	ethan.kernel@gmail.com
Subject: [PATCH 3/4] xen-pciback: use pci device flag operation helper function
Date: Fri,  8 Aug 2014 13:36:06 +0800
Message-Id: <1407476167-18935-4-git-send-email-ethan.zhao@oracle.com>
In-Reply-To: <1407476167-18935-1-git-send-email-ethan.zhao@oracle.com>
References: <1407476167-18935-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use pci device flag operation helper functions when set device
to assigned or deassigned state.

Acked-by: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
---
 drivers/xen/xen-pciback/pci_stub.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index d57a173..e593921 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -133,7 +133,7 @@ static void pcistub_device_release(struct kref *kref)
 	xen_pcibk_config_free_dyn_fields(dev);
 	xen_pcibk_config_free_dev(dev);
 
-	dev->dev_flags &= ~PCI_DEV_FLAGS_ASSIGNED;
+	pci_clear_dev_assigned(dev);
 	pci_dev_put(dev);
 
 	kfree(psdev);
@@ -413,7 +413,7 @@ static int pcistub_init_device(struct pci_dev *dev)
 	dev_dbg(&dev->dev, "reset device\n");
 	xen_pcibk_reset_device(dev);
 
-	dev->dev_flags |= PCI_DEV_FLAGS_ASSIGNED;
+	pci_set_dev_assigned(dev);
 	return 0;
 
 config_release:
-- 
1.7.1

