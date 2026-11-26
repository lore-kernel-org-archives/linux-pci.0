Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681728;
	b=R0QLUS6aDAldUW17dOXvZ4SyC+ooEnlxYHCfyI5WRZH2QTkToddGaKIoy+YEEVtsbqHy
	 jNsUnhkjj5ey29U9/p+qg6o5pJdygydWMHGaqdMzfmwL/M2mI9jQJ+zoK2TZ9buGBy8o5
	 RsnXG74EVuIaFrK+5by4pSF3zht81qwSHz0KLGJkOa6n/LRTWYua1Gytb6FZzAPs2UnJT
	 H+VCGWgh9FisraO7LitN0pv1U//P6oQxN864wfmB8R0Pl0misH1ElpiMmP0sM1wCccQ/G
	 g4qlbMDIMMCb8kz39yFG+6ioJkCHSWblZ5DbUYE2koUsMXe3qpRr/T1c7UACg3a9lJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681728;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=piYJUKGEmCSftueAu0U/orr6YZIagv8rzRG8GPXB5bc=;
	b=jnQxfZy1FqdXK9fbj/HVHYHDgiMZl5nnBr5sT6lclDNLzytJgtcjU6krYWSbyKzirtZB
	 Mqv7Q+0+Re2WeXKHz59pREpgGqLBogu0S4sw79npg+VB/3U2z1cQoeQ0BbbKtv5NmpNEJ
	 jOV0KWIe05zvdXffR+vlQOeHIQaW3eQfWZL6AGKzGZst9mmKTZfQjG0OodUmGe/wq4IVt
	 ZQx6UaU8lobORSZm8XAApSerZR1TAFCVLvOHlnugLb/0limlvPN8Mp5z/ojoLLV+3gxlM
	 RbkRDZQgP02T/vwh+dDUdvXDskM6WN2Zw7J8Mwi/kPrh85k72Vc1pRJx3DDimqvNKww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=OGCcotnr;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1F606A31C
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 08:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31F1F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=OGCcotnr
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5617269e5;
	Thu, 26 Nov 2026 16:28:42 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: maz@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: apple: Release port IRQs and domains on driver detach
Date: Thu, 26 Nov 2026 16:28:40 +0800
Message-ID: <20261126-a35bb25eb5-u39-0@mail.sdu.edu.cn>
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
X-HM-Tid: 0aa216f89ec603a1kunm6c3bbe903c2d62
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTB1NVkoYSEtNThpKSh1CSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=OGCcotnrTl7ezTKeIxPDtOrjUV0Xm+4dHFEINPsyYiJBrGxogj4t/nPRwagC4LCNTtMKnLbbSH962waQWcBMxAVyKjXrhsHTp/5kEqmp42FQMsQGei7L92oqk+jkBHJ11lyP3mEqSAWuYPOcQWzLafuh8+XLpQo6Qh7sWQbYSAQ=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=piYJUKGEmCSftueAu0U/orr6YZIagv8rzRG8GPXB5bc=;
	h=date:mime-version:subject:message-id:from;

The port handlers and interrupt domains remain registered after their
controller storage is freed on probe failure or module unload. Make the
link IRQ requests and domain teardown device-managed, and stop the PCI
bus before releasing the ports and their shared MSI parent.

This issue was found by our static analysis tool under development.

Fixes: d8fcbe52d7d3 ("PCI: apple: Add INTx and per-port interrupt support")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/pci/controller/pcie-apple.c | 50 ++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index dfd0e345bc56..79dac3fb9a05 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -199,6 +199,7 @@ struct apple_pcie_port {
 	void __iomem		*base;
 	void __iomem		*phy;
 	struct irq_domain	*domain;
+	unsigned int		irq;
 	struct list_head	entry;
 	unsigned long		*sid_map;
 	int			sid_map_sz;
@@ -396,6 +397,22 @@ static void apple_port_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static void apple_pcie_port_remove_irq(void *data)
+{
+	struct apple_pcie_port *port = data;
+	unsigned int i;
+
+	writel_relaxed(~0, port->base + PORT_INTMSK);
+	writel_relaxed(0, port->base + PORT_MSICFG);
+	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+	for (i = 0; i < 32; i++)
+		irq_dispose_mapping(irq_find_mapping(port->domain, i));
+	irq_domain_remove(port->domain);
+	irq_dispose_mapping(port->irq);
+	list_del(&port->entry);
+	of_node_put(port->np);
+}
+
 static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
 {
 	struct fwnode_handle *fwnode = &port->np->fwnode;
@@ -412,8 +429,11 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
 	port->domain = irq_domain_create_linear(fwnode, 32,
 						&apple_port_irq_domain_ops,
 						port);
-	if (!port->domain)
+	if (!port->domain) {
+		irq_dispose_mapping(irq);
 		return -ENOMEM;
+	}
+	port->irq = irq;
 
 	/* Disable all interrupts */
 	writel_relaxed(~0, port->base + PORT_INTMSK);
@@ -441,7 +461,8 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
 	}
 
 	writel_relaxed(val | PORT_MSICFG_EN, port->base + PORT_MSICFG);
-	return 0;
+	of_node_get(port->np);
+	return devm_add_action_or_reset(pcie->dev, apple_pcie_port_remove_irq, port);
 }
 
 static irqreturn_t apple_pcie_port_irq(int irq, void *data)
@@ -485,16 +506,15 @@ static int apple_pcie_port_register_irqs(struct apple_pcie_port *port)
 				[0]	= port_irqs[i].hwirq,
 			},
 		};
-		unsigned int irq;
-		int ret;
+		int irq, ret;
 
 		irq = irq_domain_alloc_irqs(port->domain, 1, NUMA_NO_NODE,
 					    &fwspec);
-		if (WARN_ON(!irq))
+		if (WARN_ON(irq <= 0))
 			continue;
 
-		ret = request_irq(irq, apple_pcie_port_irq, 0,
-				  port_irqs[i].name, port);
+		ret = devm_request_irq(port->pcie->dev, irq, apple_pcie_port_irq, 0,
+				       port_irqs[i].name, port);
 		WARN_ON(ret);
 	}
 
@@ -582,6 +602,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	port->idx = idx >> 11;
 	port->pcie = pcie;
 	port->np = np;
+	INIT_LIST_HEAD(&port->entry);
 
 	raw_spin_lock_init(&port->lock);
 
@@ -652,9 +673,6 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	list_add_tail(&port->entry, &pcie->ports);
 	init_completion(&pcie->event);
 
-	/* In the success path, we keep a reference to np around */
-	of_node_get(np);
-
 	ret = apple_pcie_port_register_irqs(port);
 	WARN_ON(ret);
 
@@ -678,6 +696,11 @@ static const struct msi_parent_ops apple_msi_parent_ops = {
 	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
+static void apple_msi_remove(void *data)
+{
+	irq_domain_remove(data);
+}
+
 static int apple_msi_init(struct apple_pcie *pcie)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
@@ -688,6 +711,7 @@ static int apple_msi_init(struct apple_pcie *pcie)
 		.host_data	= pcie,
 	};
 	struct of_phandle_args args = {};
+	struct irq_domain *domain;
 	int ret;
 
 	ret = of_parse_phandle_with_args(to_of_node(fwnode), "msi-ranges",
@@ -713,11 +737,12 @@ static int apple_msi_init(struct apple_pcie *pcie)
 		return -ENXIO;
 	}
 
-	if (!msi_create_parent_irq_domain(&info, &apple_msi_parent_ops)) {
+	domain = msi_create_parent_irq_domain(&info, &apple_msi_parent_ops);
+	if (!domain) {
 		dev_err(pcie->dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
-	return 0;
+	return devm_add_action_or_reset(pcie->dev, apple_msi_remove, domain);
 }
 
 static struct apple_pcie *apple_pcie_lookup(struct device *dev)
@@ -886,6 +911,7 @@ MODULE_DEVICE_TABLE(of, apple_pcie_of_match);
 
 static struct platform_driver apple_pcie_driver = {
 	.probe	= apple_pcie_probe,
+	.remove	= pci_host_common_remove,
 	.driver	= {
 		.name			= "pcie-apple",
 		.of_match_table		= apple_pcie_of_match,

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.43.0

