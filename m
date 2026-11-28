Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795858980;
	b=k/7J7HOYFyHv5q/uBb6SR+Px5aRmW5SmkjPMtJhr58ngusBvv/dAbecr44kbtbcS4jSb
	 i46dmkGXl7LdAV1u8RxfG8iFHWztSn9H2Y/qyByOa3PCjwh0x4e7g759Uy9XlBvUI6VEF
	 4iNPUou9uNTGZ/LuQh/zhm0bdGQLOdSa1xIMTIzQ1aNSpWNtWvRpmYFygkrmQ5seMtmtI
	 sh9wgV2lIzf377YFu2G6C7QwCGvN78ZSSHzcIfKCUIh6PdFE4nXmNxR3jTTGWY0aT8j1/
	 /bdfghaFwaXm4vWidkHnzzlbMtyIX8qctMMIlvH5GfD4HFFreWJ8s0ASPqm+AP23AXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795858980;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=S1hQEu5trwXKmGr1HfNKzlYezMNzp0YmSQ2509eW2SU=;
	b=BljaCyZR18ja3BR+8BNnIJzZfmHn03i1LjugCQqdnkC1J3Hi/l2oh4cMESHW0OFHv8D8
	 MEk3SsQFseRMzhhnz1PRKLBAesaWhKVoj+Uhn5niG9pHCiqW1VWAalFff4764gVxi2ApS
	 RilrJSdseKG/EGVoKRhApevqFlxrmSO19eyrXdvJBmE0PVrLxH6r1syou6JNDR0KGL+cu
	 LP+Ih6LD0bFUsmcba23IUdgcyBHyuFpJH3yztPooWLlBe8xkygDTWcJacLlvh9wRT3j7S
	 7mxn1CBJA2gXREY/jDOpbmuPIvoi33/HlDd8TYRY93kxWzEu9AQXgbSrXlsfoohzZXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=ZrUB12Qi;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68CF606A31C;
	Sat, 28 Nov 2026 09:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B68CF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=ZrUB12Qi
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5655b0821;
	Sat, 28 Nov 2026 17:42:53 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: vigneshr@ti.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	jg1.han@samsung.com,
	kishon@kernel.org
Cc: s-vadapalli@ti.com,
	robh@kernel.org,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: dra7xx: Remove the IRQ domain with the root port
Date: Sat, 28 Nov 2026 17:42:52 +0800
Message-ID: <20261128-f81b700d6c-u40-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa22189427003a1kunmb84ad43e451e5e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSx5OVhlPH0wZSEwZQx1NTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=ZrUB12Qi+AzWm4+5bS0ywAP1fEfYa3S3kRVuWRxpsLItr5XJFmu6mbMsSNF31380XzYS5PUIvjh0Tx1MUpHtmYR+qd0mo0Rx5+7RVdONg4XtNpi2561DjuuKZ+ZcIzCLEl/wXspPA+Y9BJ+ejScGDXPf4cJ5W9WE7/F8+TyVuMk=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=S1hQEu5trwXKmGr1HfNKzlYezMNzp0YmSQ2509eW2SU=;
	h=date:mime-version:subject:message-id:from;

The platform driver leaves its INTx domain and chained handler pointing
to released controller data. Create them in the host init callback and
remove them from its matching deinit callback. On driver removal, stop
the controller before releasing its PHY and runtime PM reference.

This issue was found by our static analysis tool under development.

Fixes: 47ff3de911a7 ("PCI: dra7xx: Add TI DRA7xx PCIe driver")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 60 ++++++++++++++++---------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 1d8eeb013769..509d0068ee3f 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -91,6 +91,7 @@ struct dra7xx_pcie {
 	struct phy		**phy;
 	struct irq_domain	*irq_domain;
 	struct clk              *clk;
+	int			main_irq;
 };
 
 struct dra7xx_pcie_of_data {
@@ -176,16 +177,6 @@ static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
 	dra7xx_pcie_enable_msi_interrupts(dra7xx);
 }
 
-static int dra7xx_pcie_host_init(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
-
-	dra7xx_pcie_enable_interrupts(dra7xx);
-
-	return 0;
-}
-
 static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 				irq_hw_number_t hwirq)
 {
@@ -342,7 +333,7 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int dra7xx_pcie_init_irq_domain(struct dw_pcie_rp *pp)
+static int dra7xx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
@@ -355,8 +346,6 @@ static int dra7xx_pcie_init_irq_domain(struct dw_pcie_rp *pp)
 		return -ENODEV;
 	}
 
-	irq_set_chained_handler_and_data(pp->irq, dra7xx_pcie_msi_irq_handler,
-					 pp);
 	dra7xx->irq_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node),
 						      PCI_NUM_INTX, &intx_domain_ops, pp);
 	of_node_put(pcie_intc_node);
@@ -365,11 +354,25 @@ static int dra7xx_pcie_init_irq_domain(struct dw_pcie_rp *pp)
 		return -ENODEV;
 	}
 
+	irq_set_chained_handler_and_data(pp->irq, dra7xx_pcie_msi_irq_handler, pp);
+	dra7xx_pcie_enable_interrupts(dra7xx);
 	return 0;
 }
 
+static void dra7xx_pcie_host_deinit(struct dw_pcie_rp *pp)
+{
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(to_dw_pcie_from_pp(pp));
+	unsigned int i;
+
+	irq_set_chained_handler_and_data(pp->irq, NULL, NULL);
+	for (i = 0; i < PCI_NUM_INTX; i++)
+		irq_dispose_mapping(irq_find_mapping(dra7xx->irq_domain, i));
+	irq_domain_remove(dra7xx->irq_domain);
+}
+
 static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
 	.init = dra7xx_pcie_host_init,
+	.deinit = dra7xx_pcie_host_deinit,
 };
 
 static int dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -490,10 +493,6 @@ static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	/* MSI IRQ is muxed */
 	pp->msi_irq[0] = -ENODEV;
 
-	ret = dra7xx_pcie_init_irq_domain(pp);
-	if (ret < 0)
-		return ret;
-
 	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "rc_dbics");
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
@@ -671,6 +670,14 @@ static int dra7xx_pcie_configure_two_lane(struct device *dev,
 	return 0;
 }
 
+static void dra7xx_pcie_deinit(struct dra7xx_pcie *dra7xx)
+{
+	if (dra7xx->pci->mode == DW_PCIE_RC_TYPE)
+		dw_pcie_host_deinit(&dra7xx->pci->pp);
+	else
+		dw_pcie_ep_deinit(&dra7xx->pci->ep);
+}
+
 static int dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -814,6 +821,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 		dev_err(dev, "INVALID device type %d\n", mode);
 	}
 	dra7xx->pci->mode = mode;
+	dra7xx->main_irq = irq;
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
 					IRQF_SHARED | IRQF_ONESHOT,
@@ -826,10 +834,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 err_deinit:
-	if (dra7xx->pci->mode == DW_PCIE_RC_TYPE)
-		dw_pcie_host_deinit(&dra7xx->pci->pp);
-	else
-		dw_pcie_ep_deinit(&dra7xx->pci->ep);
+	dra7xx_pcie_deinit(dra7xx);
 
 err_gpio:
 err_get_sync:
@@ -840,6 +845,18 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void dra7xx_pcie_remove(struct platform_device *pdev)
+{
+	struct dra7xx_pcie *dra7xx = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	devm_free_irq(dev, dra7xx->main_irq, dra7xx);
+	dra7xx_pcie_deinit(dra7xx);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	dra7xx_pcie_disable_phy(dra7xx);
+}
+
 static int dra7xx_pcie_suspend(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
@@ -923,6 +940,7 @@ static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
 
 static struct platform_driver dra7xx_pcie_driver = {
 	.probe = dra7xx_pcie_probe,
+	.remove = dra7xx_pcie_remove,
 	.driver = {
 		.name	= "dra7-pcie",
 		.of_match_table = of_dra7xx_pcie_match,

base-commit: 647e1e846730c6aad27e9b858df292f5d4377f63
-- 
2.43.0

