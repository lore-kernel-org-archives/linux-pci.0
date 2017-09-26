Return-Path: <SRS0=sCe6=A3=free.fr=marc.w.gonzalez@kernel.org>
Return-Path: <SRS0=sCe6=A3=free.fr=marc.w.gonzalez@kernel.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [RESEND PATCH v11 2/3] PCI: Use of_pci_dma_range_parser_init API
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Marc Zyngier
 <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Mason <slash.tmp@free.fr>
References: <93a30f88-17e1-af14-0c50-54f829c1158b@free.fr>
Message-ID: <c0279429-e0e4-096f-70be-7f89887bde4c@free.fr>
Date: Tue, 26 Sep 2017 12:26:55 +0200
MIME-Version: 1.0
In-Reply-To: <93a30f88-17e1-af14-0c50-54f829c1158b@free.fr>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Use the factorized implementation.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/pci/host/pci-ftpci100.c  | 20 +-------------------
 drivers/pci/host/pci-rcar-gen2.c | 20 +-------------------
 drivers/pci/host/pci-xgene.c     | 20 +-------------------
 drivers/pci/host/pcie-iproc.c    | 20 +-------------------
 drivers/pci/host/pcie-rcar.c     | 20 +-------------------
 5 files changed, 5 insertions(+), 95 deletions(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 5162dffc102b..12d78bba1bd3 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -370,24 +370,6 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 	return 0;
 }
 
-static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-				     struct device_node *node)
-{
-	const int na = 3, ns = 2;
-	int rlen;
-
-	parser->node = node;
-	parser->pna = of_n_addr_cells(node);
-	parser->np = parser->pna + na + ns;
-
-	parser->range = of_get_property(node, "dma-ranges", &rlen);
-	if (!parser->range)
-		return -ENOENT;
-	parser->end = parser->range + rlen / sizeof(__be32);
-
-	return 0;
-}
-
 static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p,
 					    struct device_node *np)
 {
@@ -402,7 +384,7 @@ static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p,
 	int i = 0;
 	u32 val;
 
-	if (pci_dma_range_parser_init(&parser, np)) {
+	if (of_pci_dma_range_parser_init(&parser, np)) {
 		dev_err(dev, "missing dma-ranges property\n");
 		return -EINVAL;
 	}
diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 6f879685fedd..e46de69f0380 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -293,24 +293,6 @@ static struct pci_ops rcar_pci_ops = {
 	.write	= pci_generic_config_write,
 };
 
-static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-				     struct device_node *node)
-{
-	const int na = 3, ns = 2;
-	int rlen;
-
-	parser->node = node;
-	parser->pna = of_n_addr_cells(node);
-	parser->np = parser->pna + na + ns;
-
-	parser->range = of_get_property(node, "dma-ranges", &rlen);
-	if (!parser->range)
-		return -ENOENT;
-
-	parser->end = parser->range + rlen / sizeof(__be32);
-	return 0;
-}
-
 static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
 					 struct device_node *np)
 {
@@ -320,7 +302,7 @@ static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
 	int index = 0;
 
 	/* Failure to parse is ok as we fall back to defaults */
-	if (pci_dma_range_parser_init(&parser, np))
+	if (of_pci_dma_range_parser_init(&parser, np))
 		return 0;
 
 	/* Get the dma-ranges from DT */
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index bd897479a215..f660513946d3 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -542,24 +542,6 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 	xgene_pcie_setup_pims(port, pim_reg, pci_addr, ~(size - 1));
 }
 
-static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-				     struct device_node *node)
-{
-	const int na = 3, ns = 2;
-	int rlen;
-
-	parser->node = node;
-	parser->pna = of_n_addr_cells(node);
-	parser->np = parser->pna + na + ns;
-
-	parser->range = of_get_property(node, "dma-ranges", &rlen);
-	if (!parser->range)
-		return -ENOENT;
-	parser->end = parser->range + rlen / sizeof(__be32);
-
-	return 0;
-}
-
 static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
 {
 	struct device_node *np = port->node;
@@ -568,7 +550,7 @@ static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
 	struct device *dev = port->dev;
 	u8 ib_reg_mask = 0;
 
-	if (pci_dma_range_parser_init(&parser, np)) {
+	if (of_pci_dma_range_parser_init(&parser, np)) {
 		dev_err(dev, "missing dma-ranges property\n");
 		return -EINVAL;
 	}
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index c57486348856..aa4f6d519053 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1000,24 +1000,6 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
 	return ret;
 }
 
-static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-				     struct device_node *node)
-{
-	const int na = 3, ns = 2;
-	int rlen;
-
-	parser->node = node;
-	parser->pna = of_n_addr_cells(node);
-	parser->np = parser->pna + na + ns;
-
-	parser->range = of_get_property(node, "dma-ranges", &rlen);
-	if (!parser->range)
-		return -ENOENT;
-
-	parser->end = parser->range + rlen / sizeof(__be32);
-	return 0;
-}
-
 static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 {
 	struct of_pci_range range;
@@ -1025,7 +1007,7 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 	int ret;
 
 	/* Get the dma-ranges from DT */
-	ret = pci_dma_range_parser_init(&parser, pcie->dev->of_node);
+	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 246d485b24c6..7975b10e21e8 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1029,24 +1029,6 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
 	return 0;
 }
 
-static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-				     struct device_node *node)
-{
-	const int na = 3, ns = 2;
-	int rlen;
-
-	parser->node = node;
-	parser->pna = of_n_addr_cells(node);
-	parser->np = parser->pna + na + ns;
-
-	parser->range = of_get_property(node, "dma-ranges", &rlen);
-	if (!parser->range)
-		return -ENOENT;
-
-	parser->end = parser->range + rlen / sizeof(__be32);
-	return 0;
-}
-
 static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 					  struct device_node *np)
 {
@@ -1055,7 +1037,7 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 	int index = 0;
 	int err;
 
-	if (pci_dma_range_parser_init(&parser, np))
+	if (of_pci_dma_range_parser_init(&parser, np))
 		return -EINVAL;
 
 	/* Get the dma-ranges from DT */
-- 
2.11.0
