Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622B0C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 07:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2453E20862
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 07:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InM7qxq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2453E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbeKFQgJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:36:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40870 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbeKFQgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 11:36:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so3525392pgp.7;
        Mon, 05 Nov 2018 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=dCdFuC5uq+nvBgO+o579iBw5Dpdn29R4tXUybtl7/1M=;
        b=InM7qxq0DLaTh+nCS0A8fmWxzn+AxelYcrqDCqfufxKsifjV5KXgypagI12elEwNBM
         HLKB/9rIDEh92jYEoI601g21bew/BE7TkeEH3BOKaZ6G8wpFk7Lko0+/NSwg8ZhPw2Ww
         bvLuS36ESJixaQGDJj4l0USB3mCWHybUd8Hy+WoHFxk9s2w9f5QiDh1JBogldNfRXHqX
         LVoARqZ6sLx5SG7+DFMJCspnYfjPGm8jJW7KV+irITBIpRJdRccPytbedyy2oq6PzIrY
         4wcAtVqMh/tQQ0vl819vKlfMkpnEUYcLK68mTmQ9lsc+irLqW9cxsZ0/3pMHyoRrn5x+
         zrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=dCdFuC5uq+nvBgO+o579iBw5Dpdn29R4tXUybtl7/1M=;
        b=t9UBoMTsAzRJDYz+BokhJT0ixvmUCsSykv7ChxrDPQfCdZ9JKjNnNIBG7lR45+7DjX
         q98PsKzfKQP17r1lDnLYZOv5rlScW/np7V+LpmI11FE5WS4+mjSy13HW7OvaMd7eTphx
         0X5M6CIbN3vstLmC8T7wCKzfpnp3ZvWUHHJsQwK6yJOX7UYHUm7AJ0ksy6Kt9OKjNR0O
         NyHLGoRZSDkVOf7z6mXb1RBLN/0akL/qSsKPP/6i/HdkEs/yWiNS2uvf/OrLPY1kJ8eF
         laeXlNdbiYG0CrLA/n+0Pq7afBV5ZD40e8gwl263vO+Mh0LL1od7kIHIaVuex1uDHY+L
         GH3A==
X-Gm-Message-State: AGRZ1gJeCxoWTGG4MVOQMULA5WN58/jK/wQKqNTDR54CY4EFmcvhHmDf
        haYXHdrCyWoWZswMNI31WezhiN84
X-Google-Smtp-Source: AJdET5cT53l4moNMe+/HaEUlSFW6hqXsHUlmfr9IRlbyf6oBB8YNM2Y8uvLsn+pq6trIyoKkFrshfw==
X-Received: by 2002:a63:4243:: with SMTP id p64-v6mr23138415pga.127.1541488339942;
        Mon, 05 Nov 2018 23:12:19 -0800 (PST)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id i189-v6sm36652213pfg.156.2018.11.05.23.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 23:12:19 -0800 (PST)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] nvme: add quirk to not call disable function when suspending
Date:   Tue,  6 Nov 2018 15:12:14 +0800
Message-Id: <20181106071214.12745-2-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106071214.12745-1-acelan.kao@canonical.com>
References: <20181106071214.12745-1-acelan.kao@canonical.com>
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

V2:
	- replace PCI_DEVICE with PCI_VDEVICE
	- replace 0x1c5c with SK_HYNIX

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
index c33bb201b884..13a2d6b2d047 100644
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
+	{ PCI_VDEVICE(SK_HYNIX, 0x1527),   /* Sk Hynix */
+		.driver_data = NVME_QUIRK_NO_DISABLE, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.17.1

