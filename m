Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E491EC28D13
	for <linux-pci@archiver.kernel.org>; Thu, 25 Aug 2022 09:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiHYJCI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Aug 2022 05:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiHYJBx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 05:01:53 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 475CF11C04;
        Thu, 25 Aug 2022 02:01:51 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Aug 2022 18:01:50 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 0B25E2059027;
        Thu, 25 Aug 2022 18:01:50 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 25 Aug 2022 18:01:50 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 9F60CB62AE;
        Thu, 25 Aug 2022 18:01:49 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Om Prakash Singh <omp@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3] PCI: pci-epf-test: Register notifier if only core_init_notifier is enabled
Date:   Thu, 25 Aug 2022 18:01:01 +0900
Message-Id: <20220825090101.20474-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Need to register pci_epf_test_notifier function event if only
core_init_notifier is enabled.

Fixes: 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer core initialization")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Om Prakash Singh <omp@nvidia.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This patch is a part of series "PCI: endpoint: Fix core_init_notifier feature".
The rest of the patches have been withdrawn.

Changes since v2:
- Add Acked-by lines

Changes since v1:
- Add Acked-by lines

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 36b1801a061b..55283d2379a6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -979,7 +979,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		epf_test->dma_supported = false;
 
-	if (linkup_notifier) {
+	if (linkup_notifier || core_init_notifier) {
 		epf->nb.notifier_call = pci_epf_test_notifier;
 		pci_epc_register_notifier(epc, &epf->nb);
 	} else {
-- 
2.17.1

