Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: mvebu: Drop bogus comment above
 mvebu_pcie_map_registers()
Date: Fri, 29 Jun 2018 11:10:07 +0200
Message-Id: <20180629091007.31069-4-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
References: <20180629091007.31069-1-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Nadav Haklai <nadavh@marvell.com>, Russell King <linux@arm.linux.org.uk>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This comment has been there since the driver was introduced, but seems
to be a leftover from previous iterations of the driver. Indeed, we do
not lookup in a list to find the register ranges that matches the
given port/lane, as the "reg" property is in each sub-node
representing a PCI port. There is no lookup involved at all.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 6e801cef2c5f..e168f04565e7 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -720,11 +720,6 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 		return start;
 }
 
-/*
- * Looks up the list of register addresses encoded into the reg =
- * <...> property for one that matches the given port/lane. Once
- * found, maps it.
- */
 static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 					      struct device_node *np,
 					      struct mvebu_pcie_port *port)
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
