Return-Path: <SRS0=QfGx=76=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=QfGx=76=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v10] PCI: tango: Add MSI controller support
To: Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Marc Gonzalez <Marc_Gonzalez@sigmadesigns.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Phil Edworthy <phil.edworthy@renesas.com>, Ray Jui <ray.jui@broadcom.com>,
 Andrew Murray <amurray@embedded-bits.co.uk>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
 <8452c9ca-7131-cf43-d35c-afc4252844f0@arm.com>
 <4b93964c-49eb-efbf-f6b2-956c67694182@sigmadesigns.com>
 <86efs3wesi.fsf@arm.com>
 <20170824170445.GO31858@bhelgaas-glaptop.roam.corp.google.com>
 <e2d48341-3ab1-f80a-b044-ff7dcc059ed4@sigmadesigns.com>
 <CAKv+Gu8ksqfBgXUTitDOB8O6Ke5Swkp2Agdt=3F0KJ130uUkBw@mail.gmail.com>
 <e381170c-e462-01cd-12db-30773005602b@free.fr> <871so09j6g.fsf@arm.com>
 <acdef092-3fb9-4338-5199-a458ac2439c7@free.fr>
 <4954977e-46fd-8d54-ec76-db2134d3073a@arm.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <26b17bd9-232f-b992-68ac-3b5a7752ba54@free.fr>
Date: Mon, 28 Aug 2017 18:13:24 +0200
MIME-Version: 1.0
In-Reply-To: <4954977e-46fd-8d54-ec76-db2134d3073a@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 25/08/2017 17:25, Robin Murphy wrote:

> If your host controller driver needs to discover its windows from DT to
> configure *itself*, it needs to parse dma-ranges itself; see pcie-iproc,
> pcie-rcar, pcie-xgene, etc. for examples.

$ git grep '"dma-ranges"' drivers/pci/host
drivers/pci/host/pci-ftpci100.c:        parser->range = of_get_property(node, "dma-ranges", &rlen);
drivers/pci/host/pci-rcar-gen2.c:       parser->range = of_get_property(node, "dma-ranges", &rlen);
drivers/pci/host/pci-xgene.c:   parser->range = of_get_property(node, "dma-ranges", &rlen);
drivers/pci/host/pcie-iproc.c:  parser->range = of_get_property(node, "dma-ranges", &rlen);
drivers/pci/host/pcie-rcar.c:   parser->range = of_get_property(node, "dma-ranges", &rlen);

These 5 drivers are using the same function: pci_dma_range_parser_init

pci-ftpci100.c:		d3c68e0a7e34a (Linus Walleij     2017-03-12
pci-rcar-gen2.c:	8d598cabf50d8 (Phil Edworthy     2015-11-03
pci-xgene.c:		5f6b6ccdbe1cd (Tanmay Inamdar    2014-10-01
pcie-iproc.c:		dd9d4e7498de3 (Ray Jui           2016-10-31
pcie-rcar.c:		c25da4778803b (Phil Edworthy     2014-05-12

which seems to be a copy of of_pci_range_parser_init
with "ranges" changed to "dma-ranges"

drivers/of/address.c	29b635c00f3eb (Andrew Murray     2013-05-16

Perhaps pci_dma_range_parser_init() can be factorized?

Rob, Frank, what do you think of the patch below?


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
