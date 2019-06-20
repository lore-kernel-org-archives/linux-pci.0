Return-Path: <SRS0=HNSb=UT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CBFC48BE3
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 10:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7CE2083B
	for <linux-pci@archiver.kernel.org>; Thu, 20 Jun 2019 10:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFTKdw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:33:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbfFTKdg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 06:33:36 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E24B49282C1C1A264A80;
        Thu, 20 Jun 2019 18:33:32 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Jun 2019 18:33:26 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <joe@perches.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 3/5] bus: hisi_lpc: Unregister logical PIO range to avoid potential use-after-free
Date:   Thu, 20 Jun 2019 18:31:54 +0800
Message-ID: <1561026716-140537-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
References: <1561026716-140537-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If, after registering a logical PIO range, the driver probe later fails,
the logical PIO range memory will be released automatically.

This causes an issue, in that the logical PIO range is not unregistered
and the released range memory may be later referenced.

Fix by unregistering the logical PIO range.

And since we now unregister the logical PIO range for probe failure, avoid
the special ordering of setting logical PIO range ops, which was a
previous (poor) attempt at a safeguard against this.

Fixes: adf38bb0b595 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 19d7b6ff2f17..6d301aafcad2 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -606,24 +606,25 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	range->fwnode = dev->fwnode;
 	range->flags = LOGIC_PIO_INDIRECT;
 	range->size = PIO_INDIRECT_SIZE;
+	range->hostdata = lpcdev;
+	range->ops = &hisi_lpc_ops;
+	lpcdev->io_host = range;
 
 	ret = logic_pio_register_range(range);
 	if (ret) {
 		dev_err(dev, "register IO range failed (%d)!\n", ret);
 		return ret;
 	}
-	lpcdev->io_host = range;
 
 	/* register the LPC host PIO resources */
 	if (acpi_device)
 		ret = hisi_lpc_acpi_probe(dev);
 	else
 		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
-	if (ret)
+	if (ret) {
+		logic_pio_unregister_range(range);
 		return ret;
-
-	lpcdev->io_host->hostdata = lpcdev;
-	lpcdev->io_host->ops = &hisi_lpc_ops;
+	}
 
 	io_end = lpcdev->io_host->io_start + lpcdev->io_host->size;
 	dev_info(dev, "registered range [%pa - %pa]\n",
-- 
2.17.1

