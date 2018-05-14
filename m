Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:38577 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeENR7S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 13:59:18 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BBC491E073A
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 19:59:16 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 2/2] PCI: endpoint: functions/pci-epf-test: Replace lower into upper case characters
Date: Mon, 14 May 2018 18:59:12 +0100
Message-Id: <352708f123b5578edee442bed23d0ae8ce328dd2.1526311733.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
References: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
References: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace all initial lower case character into upper case in comments
and debug printks.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7cef851..8d31113 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -87,7 +87,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 
 	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
-		dev_err(dev, "failed to allocate source address\n");
+		dev_err(dev, "Failed to allocate source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
 		ret = -ENOMEM;
 		goto err;
@@ -96,14 +96,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
 			       reg->size);
 	if (ret) {
-		dev_err(dev, "failed to map source address\n");
+		dev_err(dev, "Failed to map source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
 		goto err_src_addr;
 	}
 
 	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
 	if (!dst_addr) {
-		dev_err(dev, "failed to allocate destination address\n");
+		dev_err(dev, "Failed to allocate destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
 		ret = -ENOMEM;
 		goto err_src_map_addr;
@@ -112,7 +112,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
 			       reg->size);
 	if (ret) {
-		dev_err(dev, "failed to map destination address\n");
+		dev_err(dev, "Failed to map destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
 		goto err_dst_addr;
 	}
@@ -149,7 +149,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!src_addr) {
-		dev_err(dev, "failed to allocate address\n");
+		dev_err(dev, "Failed to allocate address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
 		ret = -ENOMEM;
 		goto err;
@@ -158,7 +158,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
 			       reg->size);
 	if (ret) {
-		dev_err(dev, "failed to map address\n");
+		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
 		goto err_addr;
 	}
@@ -201,7 +201,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 
 	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!dst_addr) {
-		dev_err(dev, "failed to allocate address\n");
+		dev_err(dev, "Failed to allocate address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
 		ret = -ENOMEM;
 		goto err;
@@ -210,7 +210,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
 			       reg->size);
 	if (ret) {
-		dev_err(dev, "failed to map address\n");
+		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
 		goto err_addr;
 	}
@@ -379,7 +379,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
-			dev_err(dev, "failed to set BAR%d\n", bar);
+			dev_err(dev, "Failed to set BAR%d\n", bar);
 			if (bar == test_reg_bar)
 				return ret;
 		}
@@ -406,7 +406,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
 				   test_reg_bar);
 	if (!base) {
-		dev_err(dev, "failed to allocated register space\n");
+		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
 	}
 	epf_test->reg[test_reg_bar] = base;
@@ -416,7 +416,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			continue;
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
 		if (!base)
-			dev_err(dev, "failed to allocate space for BAR%d\n",
+			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
 		epf_test->reg[bar] = base;
 	}
@@ -437,7 +437,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 
 	ret = pci_epc_write_header(epc, epf->func_no, header);
 	if (ret) {
-		dev_err(dev, "configuration header write failed\n");
+		dev_err(dev, "Configuration header write failed\n");
 		return ret;
 	}
 
@@ -519,7 +519,7 @@ static int __init pci_epf_test_init(void)
 					     WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 	ret = pci_epf_register_driver(&test_driver);
 	if (ret) {
-		pr_err("failed to register pci epf test driver --> %d\n", ret);
+		pr_err("Failed to register pci epf test driver --> %d\n", ret);
 		return ret;
 	}
 
-- 
2.7.4
