Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4151DC0044C
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 02:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076EE20862
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 02:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZZb7Qv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076EE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeKFL0x (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:26:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35446 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbeKFL0x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 06:26:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id v9-v6so3038448pff.2;
        Mon, 05 Nov 2018 18:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=q1iCaObEwHgNndGc+IQ2osgW1NSsAor6JGa6GWHzAjI=;
        b=dZZb7Qv8iGNz116jBljeafsTgUke4MGb++eS36R2NpsyYZMX+dG8LtxyGs+/fU3ULT
         gDDfodxu7e229UDpblC6SmU3JRc9lL5kJKZsmfmqf7w8BVohxZ1r2f8IzFvJ1Uut3L5b
         lynYPz01FKEY8eaVI9WZKDQIV8frB+XNyI94GDr539SVvN3OopJcteugo2LNgXa46Q6L
         dXqhuzID3lGxzInLt0sxzDxZ72jr52roLRhndFKx+MUFGlexHTZIkMemAKNqt9wqqtxC
         vslyqGgWZFnY/evt7lUJZH96SVsV1BdBzsSbaQ84nyEPBvZfOXSHA3mtWpZ6c/YJ9w67
         TTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=q1iCaObEwHgNndGc+IQ2osgW1NSsAor6JGa6GWHzAjI=;
        b=Ras3qwU7zrM7bT40rDDRG8jYWHuvjK5inFLd6wE9C/nnNQK4UhlEn5FEtuVwyF1Bcm
         1Sb3jrDn/Q6FM4WYu5nM6Gmv7AUatHCkJkLxZLUARWUhN/8RIlV8Yw1KddAkxUPkfYpn
         JqCvBbV75XV2x6U/KmG2H1roAlgEzeXimUqdsSIfdB4wNs/amjKt8om9/oDtNAa2oPVN
         VWOcQ0GQK9R1KO+H6YKg1rlWialW0UKhgcY8OT8pB/ch2uIjNZ9plYzFEDabDiPXjh4k
         KQVvryQHTBB/D/vZExUqxoMmfsQRX428OUcXfu5wway8o/M+J08MDrRZG6yqS7PA8Nu8
         ZgSQ==
X-Gm-Message-State: AGRZ1gI5ADRnGAw312E9Qv1+92Dh+NbdnERoI1rWg4vyJD0JBlpnMdFd
        ah/ADlUzqeE/5cHkXelbCZ8=
X-Google-Smtp-Source: AJdET5daG9t1xJkmSRzpif4lKnsWw7H+0IaiNx/01cEGo3RhZU2iNgah+uTrlv+36d6JFBFPwwuwwQ==
X-Received: by 2002:a62:5904:: with SMTP id n4-v6mr10465640pfb.174.1541469848604;
        Mon, 05 Nov 2018 18:04:08 -0800 (PST)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id 188-v6sm27858805pfy.87.2018.11.05.18.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 18:04:07 -0800 (PST)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/2] nvme: add quirk to not call disable function when suspending
Date:   Tue,  6 Nov 2018 10:04:02 +0800
Message-Id: <20181106020402.21120-2-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106020402.21120-1-acelan.kao@canonical.com>
References: <20181106020402.21120-1-acelan.kao@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call nvme_dev_disable() function leads to the power consumption goes
up to 2.2 Watt during suspend-to-idle, and from SK hynix FE, they
suggest us to use its own APST feature to do the power management during
s2idle.
After D3 is diabled and nvme_dev_disable() is not called while
suspending, the power consumption drops to 0.77 Watt during s2idle.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/nvme/host/nvme.h | 5 +++++
 drivers/nvme/host/pci.c  | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cee79cb388af..35d260a4cf46 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -90,6 +90,11 @@ enum nvme_quirks {
 	 * Set MEDIUM priority on SQ creation
 	 */
 	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
+
+	/*
+	 * Do not disable nvme when suspending(s2idle)
+	 */
+	NVME_QUIRK_NO_DISABLE			= (1 << 8),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb201b884..586f3516e36b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -31,6 +31,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/suspend.h>
 
 #include "nvme.h"
 
@@ -2612,8 +2613,11 @@ static int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct nvme_ctrl *ctrl = &ndev->ctrl;
+
+	if (!(pm_suspend_via_s2idle() && (ctrl->quirks & NVME_QUIRK_NO_DISABLE)))
+		nvme_dev_disable(ndev, true);
 
-	nvme_dev_disable(ndev, true);
 	return 0;
 }
 
@@ -2716,6 +2720,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
+	{ PCI_DEVICE(0x1c5c, 0x1527),   /* Sk Hynix */
+		.driver_data = NVME_QUIRK_NO_DISABLE, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.17.1

