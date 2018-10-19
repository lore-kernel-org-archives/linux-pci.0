Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA89ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EB221479
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OniIPY3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EB221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJSKPr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJSKPq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 06:15:46 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.90.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB6921476;
        Fri, 19 Oct 2018 02:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539915111;
        bh=gDfHFcT1tvEtfqc2+yETFJCZ3pXbiWpsG2CJkUPQW6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OniIPY3WtMx3mFmBBEIpA7tZz6YFVYCv05901h7bSUQp5HTcjjdbVDp2+b11G2dl1
         jZCH+zTmWWVerMD9MTGqm42O6Q+8Vs45L6QmmeCwdBLIBsD9FWAcHVI8gcBIzNaUDd
         ON6Fy4q0mLyYZ7oKTS4xVGRFKz5zd82Sqf5EwgCA=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v6 6/7] PCI: Expose reset type to users of pci_reset_bus()
Date:   Fri, 19 Oct 2018 02:11:26 +0000
Message-Id: <20181019021132.14743-6-okaya@kernel.org>
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

pci_reset_bus() calls different slot reset mechanisms based on given mask.
Slot based reset is prioritized over bus reset.

Users are expected to use PCI_RESET_SLOT mask by default.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci.c           | 12 +++++++++---
 drivers/vfio/pci/vfio_pci.c |  6 ++++--
 include/linux/pci.h         |  2 +-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a1a7dd6988be..1feecbb7f85d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5236,13 +5236,19 @@ static int __pci_reset_bus(struct pci_bus *bus)
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
+	if ((reset_type & PCI_RESET_SLOT) && !pci_probe_reset_slot(pdev->slot))
+		return __pci_reset_slot(pdev->slot);
+
+	if ((reset_type & PCI_RESET_BUS) && !pci_probe_reset_bus(pdev->bus))
+		return __pci_reset_bus(pdev->bus);
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
index cde63e0a85ea..8ee4e3c177fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1173,7 +1173,7 @@ int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
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

