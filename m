Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, niklas.cassel@axis.com,
        jesper.nilsson@axis.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [RFC 09/10] PCI: endpoint: functions/pci-epf-test: Replace lower into upper case characters
Date: Tue, 10 Apr 2018 18:14:48 +0100
Message-Id: <91e6911cd73a3a61b14b392591a124581085ace2.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replaces lower into upper case characters in comments and debug printks.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 5997c6e..e3d4af0 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -94,7 +94,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 
 	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
-		dev_err(dev, "failed to allocate source address\n");
+		dev_err(dev, "Failed to allocate source address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
 		ret = -ENOMEM;
 		goto err;
@@ -103,14 +103,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
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
@@ -119,7 +119,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
 			       reg->size);
 	if (ret) {
-		dev_err(dev, "failed to map destination address\n");
+		dev_err(dev, "Failed to map destination address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
 		goto err_dst_addr;
 	}
@@ -156,7 +156,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!src_addr) {
-		dev_err(dev, "failed to allocate address\n");
+		dev_err(dev, "Failed to allocate address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
 		ret = -ENOMEM;
 		goto err;
@@ -165,7 +165,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
 			       reg->size);
 	if (ret) {
-		dev_err(dev, "failed to map address\n");
+		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
 		goto err_addr;
 	}
@@ -208,7 +208,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 
 	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!dst_addr) {
-		dev_err(dev, "failed to allocate address\n");
+		dev_err(dev, "Failed to allocate address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
 		ret = -ENOMEM;
 		goto err;
@@ -217,7 +217,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
 			       reg->size);
 	if (ret) {
-		dev_err(dev, "failed to map address\n");
+		dev_err(dev, "Failed to map address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
 		goto err_addr;
 	}
@@ -422,7 +422,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
-			dev_err(dev, "failed to set BAR%d\n", bar);
+			dev_err(dev, "Failed to set BAR%d\n", bar);
 			if (bar == test_reg_bar)
 				return ret;
 		}
@@ -449,7 +449,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
 				   test_reg_bar);
 	if (!base) {
-		dev_err(dev, "failed to allocated register space\n");
+		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
 	}
 	epf_test->reg[test_reg_bar] = base;
@@ -459,7 +459,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			continue;
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
 		if (!base)
-			dev_err(dev, "failed to allocate space for BAR%d\n",
+			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
 		epf_test->reg[bar] = base;
 	}
@@ -480,7 +480,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 
 	ret = pci_epc_write_header(epc, epf->func_no, header);
 	if (ret) {
-		dev_err(dev, "configuration header write failed\n");
+		dev_err(dev, "Configuration header write failed\n");
 		return ret;
 	}
 
@@ -578,7 +578,7 @@ static int __init pci_epf_test_init(void)
 					     WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 	ret = pci_epf_register_driver(&test_driver);
 	if (ret) {
-		pr_err("failed to register pci epf test driver --> %d\n", ret);
+		pr_err("Failed to register pci epf test driver --> %d\n", ret);
 		return ret;
 	}
 
-- 
2.7.4
