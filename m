Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v4 15/21] PCI: armada8k: update PCI config space remap function
Date: Wed, 19 Apr 2017 17:49:04 +0100
Message-Id: <20170419164913.19674-16-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_pci_remap_cfg* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/dwc/pcie-armada8k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
index f110e3b..3ff3130 100644
--- a/drivers/pci/dwc/pcie-armada8k.c
+++ b/drivers/pci/dwc/pcie-armada8k.c
@@ -230,7 +230,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 	/* Get the dw-pcie unit configuration/control registers base. */
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
-	pci->dbi_base = devm_ioremap_resource(dev, base);
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, base);
 	if (IS_ERR(pci->dbi_base)) {
 		dev_err(dev, "couldn't remap regs base %p\n", base);
 		ret = PTR_ERR(pci->dbi_base);
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
