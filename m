Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42398 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933450AbcBYRhq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Feb 2016 12:37:46 -0500
Subject: [PATCH v10 3/4] PCI: designware: Add default link up check if
 sub-driver doesn't override
To: Joao Pinto <Joao.Pinto@synopsys.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: mark.rutland@arm.com, Alexey.Brodkin@synopsys.com, arnd@arndb.de,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	linux-pci@vger.kernel.org, Vineet.Gupta1@synopsys.com,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-kernel@vger.kernel.org, CARLOS.PALMINHA@synopsys.com,
	robh+dt@kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
	galak@codeaurora.org, Jingoo Han <jingoohan1@gmail.com>,
	linux-snps-arc@lists.infradead.org
Date: Thu, 25 Feb 2016 11:37:43 -0600
Message-ID: <20160225173743.2103.52643.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160225172957.2103.8326.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160225172957.2103.8326.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joao Pinto <Joao.Pinto@synopsys.com>

Add a default DesignWare "link_up" test for use when a sub-driver doesn't
supply its own pcie_host_ops.link_up() method.

[bhelgaas: changelog, split into its own patch]
Signed-off-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 4fff2d2..d6013a2 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -70,6 +70,11 @@
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
+/* PCIe Port Logic registers */
+#define PLR_OFFSET			0x700
+#define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
+#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
+
 static struct pci_ops dw_pcie_ops;
 
 int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
@@ -401,10 +406,13 @@ int dw_pcie_wait_for_link(struct pcie_port *pp)
 
 int dw_pcie_link_up(struct pcie_port *pp)
 {
+	u32 val;
+
 	if (pp->ops->link_up)
 		return pp->ops->link_up(pp);
 
-	return 0;
+	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
+	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
 }
 
 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,

