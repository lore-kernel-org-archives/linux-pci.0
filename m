Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v7 6/9] PCI: dwc: Define maximum number of vectors
Date: Tue, 24 Apr 2018 14:44:43 +0100
Message-Id: <6b2c7ec1835cf422af5703aa14c99dbad8c6ffb8.1524577064.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524577064.git.gustavo.pimentel@synopsys.com>
References: <cover.1524577064.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524577064.git.gustavo.pimentel@synopsys.com>
References: <cover.1524577064.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds a callback that defines the maximum number of vectors that can be use
by the Root Complex.

Since this is a parameter associated to each SoC IP setting, makes sense to
be configurable and easily visible to future modifications.

The designware IP supports a maximum of 256 vectors.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
---
Change v1->v2:
 - Nothing changed, just to follow the patch set version.
Change v2->v3:
 - Nothing changed, just to follow the patch set version.
Changes v3->v4:
 - Nothing changed, just to follow the patch set version.
Changes v4->v5:
 - Nothing changed, just to follow the patch set version.
Changes v5->v6:
 - Nothing changed, just to follow the patch set version.
Changes v6->v7:
 - Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pcie-designware-plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index efc315c..5937fed 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -48,8 +48,14 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static void dw_plat_set_num_vectors(struct pcie_port *pp)
+{
+	pp->num_vectors = MAX_MSI_IRQS;
+}
+
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 	.host_init = dw_plat_pcie_host_init,
+	.set_num_vectors = dw_plat_set_num_vectors,
 };
 
 static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
-- 
2.7.4
