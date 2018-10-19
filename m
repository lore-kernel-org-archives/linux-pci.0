Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D3DC67863
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542FC21477
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeCDyJ46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542FC21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeJSKPn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJSKPm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 06:15:42 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.90.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F2520C0E;
        Fri, 19 Oct 2018 02:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539915107;
        bh=y4r3AvkjjrZMBQE2Q3H97tXiGtUujmmkQe62oub6yxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HeCDyJ46wNo7TptAl8mu14Te0KTLi6BU5JFRe+7z/YHbjk0fROiB2CyYj4/bLSfpj
         XQRipNWMJ5rj9gXBCt3a3BJxa6MOfUkVwL7ugMd4RdBs4x2zhmlY20nj5VQXDxnG1O
         KfwJbEH1SIF6bMCeqqfXU3grSkM7H9Aezm9snyEo=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v6 4/7] PCI: Expose reset type to users of pci_try_reset_function()
Date:   Fri, 19 Oct 2018 02:11:24 +0000
Message-Id: <20181019021132.14743-4-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181019021132.14743-1-okaya@kernel.org>
References: <20181019021132.14743-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looking to have more control between the users of the API vs. what the API
can do internally. The new reset_type tells the PCI core about the bounds
of the request.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci.c                  | 5 +++--
 drivers/vfio/pci/vfio_pci.c        | 7 ++++---
 drivers/vfio/pci/vfio_pci_config.c | 4 ++--
 include/linux/pci.h                | 2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9a649d1adb13..7739f28988ae 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4851,10 +4851,11 @@ EXPORT_SYMBOL_GPL(pci_reset_function_locked);
 /**
  * pci_try_reset_function - quiesce and reset a PCI device function
  * @dev: PCI device to reset
+ * @reset_type: reset type to apply
  *
  * Same as above, except return -EAGAIN if unable to lock device.
  */
-int pci_try_reset_function(struct pci_dev *dev)
+int pci_try_reset_function(struct pci_dev *dev, u32 reset_type)
 {
 	int rc;
 
@@ -4865,7 +4866,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 		return -EAGAIN;
 
 	pci_dev_save_and_disable(dev);
-	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
+	rc = __pci_reset_function_locked(dev, reset_type);
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
 
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index cddb453a1ba5..fe7ada997c51 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -228,7 +228,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 		return ret;
 
 	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
+	ret = pci_try_reset_function(pdev, PCI_RESET_ANY);
 	if (ret == -EAGAIN) {
 		pci_disable_device(pdev);
 		return ret;
@@ -376,7 +376,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 	 * Try to reset the device.  The success of this is dependent on
 	 * being able to lock the device, which is not always possible.
 	 */
-	if (vdev->reset_works && !pci_try_reset_function(pdev))
+	if (vdev->reset_works && !pci_try_reset_function(pdev, PCI_RESET_ANY))
 		vdev->needs_reset = false;
 
 	pci_restore_state(pdev);
@@ -844,7 +844,8 @@ static long vfio_pci_ioctl(void *device_data,
 
 	} else if (cmd == VFIO_DEVICE_RESET) {
 		return vdev->reset_works ?
-			pci_try_reset_function(vdev->pdev) : -EINVAL;
+			pci_try_reset_function(vdev->pdev, PCI_RESET_ANY) :
+			 -EINVAL;
 
 	} else if (cmd == VFIO_DEVICE_GET_PCI_HOT_RESET_INFO) {
 		struct vfio_pci_hot_reset_info hdr;
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 115a36f6f403..0d66bac66211 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -831,7 +831,7 @@ static int vfio_exp_config_write(struct vfio_pci_device *vdev, int pos,
 						 &cap);
 
 		if (!ret && (cap & PCI_EXP_DEVCAP_FLR))
-			pci_try_reset_function(vdev->pdev);
+			pci_try_reset_function(vdev->pdev, PCI_RESET_ANY);
 	}
 
 	/*
@@ -910,7 +910,7 @@ static int vfio_af_config_write(struct vfio_pci_device *vdev, int pos,
 						&cap);
 
 		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP))
-			pci_try_reset_function(vdev->pdev);
+			pci_try_reset_function(vdev->pdev, PCI_RESET_ANY);
 	}
 
 	return count;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9103ac1b3c31..cde63e0a85ea 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1170,7 +1170,7 @@ int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
-int pci_try_reset_function(struct pci_dev *dev);
+int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_dev *dev);
-- 
2.19.0

