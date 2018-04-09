Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v2 6/9] PCI: dwc: Define maximum number of vectors
Date: Mon,  9 Apr 2018 10:41:15 +0100
Message-Id: <bf7062c863f33b2951acc586b1f22d3497ee2f10.1523266508.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds a callback that defines the maximum number of vectors that can be use
by the Root Complex.

Since this is a parameter associated to each SoC IP setting, makes sense to
be configurable and easily visible to future modifications.

The designware IP supports a maximum of 256 vectors.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pcie-designware-plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 5382a7a..94da252 100644
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
