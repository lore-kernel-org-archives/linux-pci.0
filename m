Return-Path: <SRS0=sCe6=A3=free.fr=marc.w.gonzalez@kernel.org>
Return-Path: <SRS0=sCe6=A3=free.fr=marc.w.gonzalez@kernel.org>
Subject: [RESEND PATCH v11 1/3] of/pci: Add dma-ranges parsing support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Marc Zyngier
 <marc.zyngier@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Mason <slash.tmp@free.fr>
References: <93a30f88-17e1-af14-0c50-54f829c1158b@free.fr>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <5f6bcfa9-05ec-4cdc-483d-65b098b198d8@free.fr>
Date: Tue, 26 Sep 2017 12:22:54 +0200
MIME-Version: 1.0
In-Reply-To: <93a30f88-17e1-af14-0c50-54f829c1158b@free.fr>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Several host bridge drivers duplicate of_pci_range_parser_init()
in order to parse their dma-ranges property.

Provide of_pci_dma_range_parser_init() for that use-case.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/of/address.c       | 19 ++++++++++++++++---
 include/linux/of_address.h | 10 +++++++++-
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 580bbf6ca2b1..4cfd29e4ee1b 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -232,8 +232,8 @@ int of_pci_address_to_resource(struct device_node *dev, int bar,
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
 
-int of_pci_range_parser_init(struct of_pci_range_parser *parser,
-				struct device_node *node)
+static int parser_init(struct of_pci_range_parser *parser,
+			struct device_node *node, const char *name)
 {
 	const int na = 3, ns = 2;
 	int rlen;
@@ -242,7 +242,7 @@ int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 	parser->pna = of_n_addr_cells(node);
 	parser->np = parser->pna + na + ns;
 
-	parser->range = of_get_property(node, "ranges", &rlen);
+	parser->range = of_get_property(node, name, &rlen);
 	if (parser->range == NULL)
 		return -ENOENT;
 
@@ -250,8 +250,21 @@ int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 
 	return 0;
 }
+
+int of_pci_range_parser_init(struct of_pci_range_parser *parser,
+				struct device_node *node)
+{
+	return parser_init(parser, node, "ranges");
+}
 EXPORT_SYMBOL_GPL(of_pci_range_parser_init);
 
+int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
+				struct device_node *node)
+{
+	return parser_init(parser, node, "dma-ranges");
+}
+EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
+
 struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 						struct of_pci_range *range)
 {
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 37864734ca50..8beed2de98e9 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -49,6 +49,8 @@ extern const __be32 *of_get_address(struct device_node *dev, int index,
 
 extern int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node);
+extern int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
+			struct device_node *node);
 extern struct of_pci_range *of_pci_range_parser_one(
 					struct of_pci_range_parser *parser,
 					struct of_pci_range *range);
@@ -85,7 +87,13 @@ static inline const __be32 *of_get_address(struct device_node *dev, int index,
 static inline int of_pci_range_parser_init(struct of_pci_range_parser *parser,
 			struct device_node *node)
 {
-	return -1;
+	return -ENOSYS;
+}
+
+static inline int of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
+			struct device_node *node)
+{
+	return -ENOSYS;
 }
 
 static inline struct of_pci_range *of_pci_range_parser_one(
-- 
2.11.0
