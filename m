Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3598C001B0
	for <linux-pci@archiver.kernel.org>; Fri,  7 Jul 2023 15:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjGGPMV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Jul 2023 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGGPMU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 11:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EB22121
        for <linux-pci@vger.kernel.org>; Fri,  7 Jul 2023 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688742690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/vpgghRxsUnXsE3t1IVpXcHF3Kir76KUPEpQodsytdc=;
        b=d0iyv5jPnpJtODScQPik/87cvsBJteCer4VzqXvU1RTFYPDABfm3BlQa5fWFRFnRM+szmq
        3zcGilYPtOSQrUu/2SPaV9JyMJsk/f8HFDmVog/ZkwLJNcx80BJh+d/NjPRB6pJERDOaSX
        GKHkgL05vVxNRvxuPjE2oJbm2hy1FhI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-huiRPxb7MyqWJbXufgI7Jw-1; Fri, 07 Jul 2023 11:11:27 -0400
X-MC-Unique: huiRPxb7MyqWJbXufgI7Jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D28691C060C9;
        Fri,  7 Jul 2023 15:11:26 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.17.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70FCAC09A09;
        Fri,  7 Jul 2023 15:11:26 +0000 (UTC)
From:   Alex Williamson <alex.williamson@redhat.com>
To:     bhelgaas@google.com
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com
Subject: [PATCH] PCI/VPD: Add runtime power management to sysfs interface
Date:   Fri,  7 Jul 2023 09:10:44 -0600
Message-Id: <20230707151044.1311544-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unlike default access to config space through sysfs, the vpd read and
write function don't actively manage the runtime power management state
of the device during access.  Since commit 7ab5e10eda02 ("vfio/pci: Move
the unused device into low power state with runtime PM"), the vfio-pci
driver will use runtime power management and release unused devices to
make use of low power states.  Attempting to access VPD information in
this low power state can result in incorrect information or kernel
crashes depending on the system behavior.

Wrap the vpd read/write bin attribute handlers in runtime PM and take
into account the potential quirk to select the correct device to wake.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/vpd.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index a4fc4d0690fe..81217dd4789f 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -275,8 +275,23 @@ static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
 			size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_dev *vpd_dev = dev;
+	ssize_t ret;
+
+	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
+		vpd_dev = pci_get_func0_dev(dev);
+		if (!vpd_dev)
+			return -ENODEV;
+	}
+
+	pci_config_pm_runtime_get(vpd_dev);
+	ret = pci_read_vpd(vpd_dev, off, count, buf);
+	pci_config_pm_runtime_put(vpd_dev);
+
+	if (dev != vpd_dev)
+		pci_dev_put(vpd_dev);
 
-	return pci_read_vpd(dev, off, count, buf);
+	return ret;
 }
 
 static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
@@ -284,8 +299,23 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
 			 size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
+	struct pci_dev *vpd_dev = dev;
+	ssize_t ret;
+
+	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
+		vpd_dev = pci_get_func0_dev(dev);
+		if (!vpd_dev)
+			return -ENODEV;
+	}
+
+	pci_config_pm_runtime_get(vpd_dev);
+	ret = pci_write_vpd(vpd_dev, off, count, buf);
+	pci_config_pm_runtime_put(vpd_dev);
+
+	if (dev != vpd_dev)
+		pci_dev_put(vpd_dev);
 
-	return pci_write_vpd(dev, off, count, buf);
+	return ret;
 }
 static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
 
-- 
2.40.1

