Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/6] PCI: mvebu: fix I/O space end address calculation
Date: Fri,  3 Aug 2018 16:38:44 +0200
Message-Id: <20180803143848.21551-3-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
References: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pcie->realio.end should be the address of last byte of the area,
therefore using resource_size() of another resource is not correct, we
must substract 1 to get the address of the last byte.

Fixes: 11be65472a427 ("PCI: mvebu: Adapt to the new device tree layout")
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
This bug never had any visible impact, so there is no need to push to
stable.
---
 drivers/pci/controller/pci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 38fa2d08527d..a195592723c2 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1219,7 +1219,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		pcie->realio.start = PCIBIOS_MIN_IO;
 		pcie->realio.end = min_t(resource_size_t,
 					 IO_SPACE_LIMIT,
-					 resource_size(&pcie->io));
+					 resource_size(&pcie->io) - 1);
 	} else
 		pcie->realio = pcie->io;
 
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
