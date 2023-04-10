Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C534C77B61
	for <linux-pci@archiver.kernel.org>; Mon, 10 Apr 2023 03:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjDJDRU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Apr 2023 23:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDJDRS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Apr 2023 23:17:18 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C6930C6;
        Sun,  9 Apr 2023 20:17:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VfeyoFa_1681096632;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VfeyoFa_1681096632)
          by smtp.aliyun-inc.com;
          Mon, 10 Apr 2023 11:17:13 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        xueshuai@linux.alibaba.com
Subject: [PATCH v2 3/3] MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
Date:   Mon, 10 Apr 2023 11:17:02 +0800
Message-Id: <20230410031702.68355-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add maintainers for Synopsys DesignWare PCIe PMU driver and driver
document.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e01e546f3a90..52e9b0b91272 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20278,6 +20278,12 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/dw_mmc*
 
+SYNOPSYS DESIGNWARE PCIE PMU DRIVER
+M:	Shuai Xue <xueshuai@linux.alibaba.com>
+S:	Supported
+F:	Documentation/admin-guide/perf/dwc_pcie_pmu.rst
+F:	drivers/perf/dwc_pcie_pmu.c
+
 SYNOPSYS HSDK RESET CONTROLLER DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Supported
-- 
2.20.1.12.g72788fdb

