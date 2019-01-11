Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A38FC43613
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B4D20874
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="YQXI5HeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbfAKPn4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:43:56 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:40068 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731848AbfAKPnz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 10:43:55 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3CB3B419CD
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1547221050; x=1549035451; bh=eYWE39w4hGy8un3UayYgMccd5gwYJbSuq1b
        mpqjMrAc=; b=YQXI5HeFdsEECo/c7v5arHS0VJSXBZHQNkO58t0rjvacOsnYq56
        KgZsWu+VcGReezwbyS30tcckIViBRj97EBvJTRuDXrYQrhdNKMRgnDqNrxIe63lr
        zlf7NvNw3TeURilu1XMqnbxAkYra7to0UoO/fRaT3w3auWwRQEjIzwr4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4t0uZFZChqAM for <linux-pci@vger.kernel.org>;
        Fri, 11 Jan 2019 18:37:30 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 24C13419C1
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 18:37:25 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 18:37:24 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v2 18/21] nvme-pci: Handle movable BARs
Date:   Fri, 11 Jan 2019 18:37:04 +0300
Message-ID: <20190111153707.10140-19-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111153707.10140-1-s.miroshnichenko@yadro.com>
References: <20190111153707.10140-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hotplugged devices can affect the existing ones by moving their BARs.
PCI subsystem will inform the NVME driver about this by invoking
reset_prepare()+reset_done(), then iounmap()+ioremap() must be called.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/nvme/host/pci.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a0bf6a24d50..bf72f934f20c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -113,6 +113,7 @@ struct nvme_dev {
 	unsigned int num_vecs;
 	int q_depth;
 	u32 db_stride;
+	resource_size_t current_phys_bar;
 	void __iomem *bar;
 	unsigned long bar_mapped_size;
 	struct work_struct remove_work;
@@ -1667,13 +1668,16 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	if (size <= dev->bar_mapped_size)
+	if (dev->bar &&
+	    dev->current_phys_bar == pci_resource_start(pdev, 0) &&
+	    size <= dev->bar_mapped_size)
 		return 0;
 	if (size > pci_resource_len(pdev, 0))
 		return -ENOMEM;
 	if (dev->bar)
 		iounmap(dev->bar);
-	dev->bar = ioremap(pci_resource_start(pdev, 0), size);
+	dev->current_phys_bar = pci_resource_start(pdev, 0);
+	dev->bar = ioremap(dev->current_phys_bar, size);
 	if (!dev->bar) {
 		dev->bar_mapped_size = 0;
 		return -ENOMEM;
@@ -2520,6 +2524,8 @@ static void nvme_reset_work(struct work_struct *work)
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
 		goto out;
 
+	nvme_remap_bar(dev, db_bar_size(dev, 0));
+
 	/*
 	 * If we're called to reset a live controller first shut it down before
 	 * moving on.
@@ -2922,6 +2928,23 @@ static void nvme_error_resume(struct pci_dev *pdev)
 	flush_work(&dev->ctrl.reset_work);
 }
 
+void nvme_rescan_prepare(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_disable(dev, false);
+	nvme_dev_unmap(dev);
+	dev->bar = NULL;
+}
+
+void nvme_rescan_done(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_map(dev);
+	nvme_reset_ctrl_sync(&dev->ctrl);
+}
+
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
 	.slot_reset	= nvme_slot_reset,
@@ -2984,6 +3007,8 @@ static struct pci_driver nvme_driver = {
 	},
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
+	.rescan_prepare	= nvme_rescan_prepare,
+	.rescan_done	= nvme_rescan_done,
 };
 
 static int __init nvme_init(void)
-- 
2.20.1

