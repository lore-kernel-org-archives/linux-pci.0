Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:54196 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbeDJM6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2018 08:58:51 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v3 07/10] PCI: dwc: Define maximum number of vectors
Date: Tue, 10 Apr 2018 13:58:39 +0100
Message-Id: <04c2a7739be0a211e2123c54bf55368624a3ecd1.1523360166.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
References: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
References: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
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
Change v2->v3:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pcie-designware-plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 4be9c3a..04afa80 100644
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
