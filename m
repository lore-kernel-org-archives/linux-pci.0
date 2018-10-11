Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E4C32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEDC20865
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMPXA4Jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEDC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJKMPy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeJKMPy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 08:15:54 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.87.4.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC912087A;
        Thu, 11 Oct 2018 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539233425;
        bh=o7OTh+ogjKMEY34Ww41kwnhbBc1CSDn6otmqFzfid2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMPXA4Jt9AGOKhqb3wraNCGJHVvvMN1K2IFIiBdDfFIUZhdYkSd6sCloPEN8FoAX8
         L2G5Mobx3riyZvjS9oSLO95qRlR813cVoQU2+cFR+vnGQolZVFejB9MtzWvDrHQA7J
         hXvuZdBxtQ3g8FRj5FFToPP0weIUzAPhgz4H4kfM=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v5 06/11] PCI: Expose reset type to users of pci_reset_bus()
Date:   Thu, 11 Oct 2018 04:49:58 +0000
Message-Id: <20181011045008.32212-6-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181011045008.32212-1-okaya@kernel.org>
References: <20181011045008.32212-1-okaya@kernel.org>
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
 drivers/pci/pci.c           | 17 ++++++++++++++---
 drivers/vfio/pci/vfio_pci.c |  6 ++++--
 include/linux/pci.h         |  2 +-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a1a7dd6988be..a3a1c2a5e0cf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5236,13 +5236,24 @@ static int __pci_reset_bus(struct pci_bus *bus)
 /**
  * pci_reset_bus - Try to reset a PCI bus
  * @pdev: top level PCI device to reset via slot/bus
+ * @reset_type: resets to try
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-int pci_reset_bus(struct pci_dev *pdev)
+int pci_reset_bus(struct pci_dev *pdev, u32 reset_type)
 {
-	return (!pci_probe_reset_slot(pdev->slot)) ?
-	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
+	if ((reset_type & PCI_RESET_LINK) == PCI_RESET_LINK)
+		return (!pci_probe_reset_slot(pdev->slot)) ?
+				__pci_reset_slot(pdev->slot) :
+				__pci_reset_bus(pdev->bus);
+
+	if ((reset_type & PCI_RESET_BUS) == PCI_RESET_BUS)
+		return __pci_reset_bus(pdev->bus);
+
+	if ((reset_type & PCI_RESET_SLOT) == PCI_RESET_SLOT)
+		return __pci_reset_slot(pdev->slot);
+
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(pci_reset_bus);
 
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index fe7ada997c51..0e80c72b1eaa 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1015,7 +1015,8 @@ static long vfio_pci_ioctl(void *device_data,
 						    &info, slot);
 		if (!ret)
 			/* User has access, do the reset */
-			ret = pci_reset_bus(vdev->pdev);
+			ret = pci_reset_bus(vdev->pdev,
+				slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);
 
 hot_reset_release:
 		for (i--; i >= 0; i--)
@@ -1390,7 +1391,8 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
 	}
 
 	if (needs_reset)
-		ret = pci_reset_bus(vdev->pdev);
+		ret = pci_reset_bus(vdev->pdev,
+				slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);
 
 put_devs:
 	for (i = 0; i < devs.cur_index; i++) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c120cf00dd8..cf1e847ea02e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1171,7 +1171,7 @@ int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-int pci_reset_bus(struct pci_dev *dev);
+int pci_reset_bus(struct pci_dev *dev, u32 reset_type);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
-- 
2.19.0

