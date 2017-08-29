Return-Path: <SRS0=XMcr=77=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=XMcr=77=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: [PATCH 2/3] PCI: Use of_pci_dma_range_parser_init API
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Linus Walleij
	<linus.walleij@linaro.org>, Ray Jui <ray.jui@broadcom.com>, Simon Horman
	<horms@verge.net.au>
References: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
Message-ID: <05956f46-6882-7f7b-1c4c-5851b4e8b8e6@sigmadesigns.com>
Date: Tue, 29 Aug 2017 16:27:20 +0200
MIME-Version: 1.0
In-Reply-To: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Use the factorized implementation.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/pci/host/pci-ftpci100.c  | 20 +-------------------
 drivers/pci/host/pci-rcar-gen2.c | 20 +-------------------
 drivers/pci/host/pci-xgene.c     | 20 +-------------------
 drivers/pci/host/pcie-iproc.c    | 20 +-------------------
 drivers/pci/host/pcie-rcar.c     | 20 +-------------------
 5 files changed, 5 insertions(+), 95 deletions(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci10=
0.c
index 5162dffc102b..12d78bba1bd3 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -370,24 +370,6 @@ static int faraday_pci_setup_cascaded_irq(struct farad=
ay_pci *p)
 =09return 0;
 }
=20
-static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-=09=09=09=09     struct device_node *node)
-{
-=09const int na =3D 3, ns =3D 2;
-=09int rlen;
-
-=09parser->node =3D node;
-=09parser->pna =3D of_n_addr_cells(node);
-=09parser->np =3D parser->pna + na + ns;
-
-=09parser->range =3D of_get_property(node, "dma-ranges", &rlen);
-=09if (!parser->range)
-=09=09return -ENOENT;
-=09parser->end =3D parser->range + rlen / sizeof(__be32);
-
-=09return 0;
-}
-
 static int faraday_pci_parse_map_dma_ranges(struct faraday_pci *p,
 =09=09=09=09=09    struct device_node *np)
 {
@@ -402,7 +384,7 @@ static int faraday_pci_parse_map_dma_ranges(struct fara=
day_pci *p,
 =09int i =3D 0;
 =09u32 val;
=20
-=09if (pci_dma_range_parser_init(&parser, np)) {
+=09if (of_pci_dma_range_parser_init(&parser, np)) {
 =09=09dev_err(dev, "missing dma-ranges property\n");
 =09=09return -EINVAL;
 =09}
diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-g=
en2.c
index 6f879685fedd..e46de69f0380 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -293,24 +293,6 @@ static struct pci_ops rcar_pci_ops =3D {
 =09.write=09=3D pci_generic_config_write,
 };
=20
-static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-=09=09=09=09     struct device_node *node)
-{
-=09const int na =3D 3, ns =3D 2;
-=09int rlen;
-
-=09parser->node =3D node;
-=09parser->pna =3D of_n_addr_cells(node);
-=09parser->np =3D parser->pna + na + ns;
-
-=09parser->range =3D of_get_property(node, "dma-ranges", &rlen);
-=09if (!parser->range)
-=09=09return -ENOENT;
-
-=09parser->end =3D parser->range + rlen / sizeof(__be32);
-=09return 0;
-}
-
 static int rcar_pci_parse_map_dma_ranges(struct rcar_pci_priv *pci,
 =09=09=09=09=09 struct device_node *np)
 {
@@ -320,7 +302,7 @@ static int rcar_pci_parse_map_dma_ranges(struct rcar_pc=
i_priv *pci,
 =09int index =3D 0;
=20
 =09/* Failure to parse is ok as we fall back to defaults */
-=09if (pci_dma_range_parser_init(&parser, np))
+=09if (of_pci_dma_range_parser_init(&parser, np))
 =09=09return 0;
=20
 =09/* Get the dma-ranges from DT */
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index bd897479a215..f660513946d3 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -542,24 +542,6 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_=
port *port,
 =09xgene_pcie_setup_pims(port, pim_reg, pci_addr, ~(size - 1));
 }
=20
-static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-=09=09=09=09     struct device_node *node)
-{
-=09const int na =3D 3, ns =3D 2;
-=09int rlen;
-
-=09parser->node =3D node;
-=09parser->pna =3D of_n_addr_cells(node);
-=09parser->np =3D parser->pna + na + ns;
-
-=09parser->range =3D of_get_property(node, "dma-ranges", &rlen);
-=09if (!parser->range)
-=09=09return -ENOENT;
-=09parser->end =3D parser->range + rlen / sizeof(__be32);
-
-=09return 0;
-}
-
 static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie_port *port)
 {
 =09struct device_node *np =3D port->node;
@@ -568,7 +550,7 @@ static int xgene_pcie_parse_map_dma_ranges(struct xgene=
_pcie_port *port)
 =09struct device *dev =3D port->dev;
 =09u8 ib_reg_mask =3D 0;
=20
-=09if (pci_dma_range_parser_init(&parser, np)) {
+=09if (of_pci_dma_range_parser_init(&parser, np)) {
 =09=09dev_err(dev, "missing dma-ranges property\n");
 =09=09return -EINVAL;
 =09}
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index c57486348856..aa4f6d519053 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1000,24 +1000,6 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pc=
ie,
 =09return ret;
 }
=20
-static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-=09=09=09=09     struct device_node *node)
-{
-=09const int na =3D 3, ns =3D 2;
-=09int rlen;
-
-=09parser->node =3D node;
-=09parser->pna =3D of_n_addr_cells(node);
-=09parser->np =3D parser->pna + na + ns;
-
-=09parser->range =3D of_get_property(node, "dma-ranges", &rlen);
-=09if (!parser->range)
-=09=09return -ENOENT;
-
-=09parser->end =3D parser->range + rlen / sizeof(__be32);
-=09return 0;
-}
-
 static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 {
 =09struct of_pci_range range;
@@ -1025,7 +1007,7 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pci=
e *pcie)
 =09int ret;
=20
 =09/* Get the dma-ranges from DT */
-=09ret =3D pci_dma_range_parser_init(&parser, pcie->dev->of_node);
+=09ret =3D of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
 =09if (ret)
 =09=09return ret;
=20
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 246d485b24c6..7975b10e21e8 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1029,24 +1029,6 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie=
 *pcie,
 =09return 0;
 }
=20
-static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
-=09=09=09=09     struct device_node *node)
-{
-=09const int na =3D 3, ns =3D 2;
-=09int rlen;
-
-=09parser->node =3D node;
-=09parser->pna =3D of_n_addr_cells(node);
-=09parser->np =3D parser->pna + na + ns;
-
-=09parser->range =3D of_get_property(node, "dma-ranges", &rlen);
-=09if (!parser->range)
-=09=09return -ENOENT;
-
-=09parser->end =3D parser->range + rlen / sizeof(__be32);
-=09return 0;
-}
-
 static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 =09=09=09=09=09  struct device_node *np)
 {
@@ -1055,7 +1037,7 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar=
_pcie *pcie,
 =09int index =3D 0;
 =09int err;
=20
-=09if (pci_dma_range_parser_init(&parser, np))
+=09if (of_pci_dma_range_parser_init(&parser, np))
 =09=09return -EINVAL;
=20
 =09/* Get the dma-ranges from DT */
--=20
2.11.0
