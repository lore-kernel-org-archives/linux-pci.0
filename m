Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <michals@xilinx.com>,
	<lorenzo.pieralisi@arm.com>, <paul.burton@imgtec.com>,
	<yinghai@kernel.org>, <wangyijing@huawei.com>, <robh@kernel.org>,
	<russell.joyce@york.ac.uk>, <sorenb@xilinx.com>,
	<jiang.liu@linux.intel.com>, <arnd@arndb.de>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>
CC: <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Bharat Kumar Gogada" <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: [PATCH V3 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver to work on both  Zynq and Microblaze
Date: Tue, 9 Feb 2016 16:11:56 +0530
Message-ID: <1455014518-8708-4-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1455014518-8708-1-git-send-email-bharatku@xilinx.com>
References: <1455014518-8708-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Modifying Xilinx AXI PCIe Host Bridge Soft IP driver to work on both
Zynq and Microblaze Architectures.
With these modifications drivers/pci/host/pcie-xilinx.c, will
work on both Zynq and Microblaze Architectures.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
---
Changes:
Removed unneccessary architecture dependent number of MSI's.
Added #ifdef to pci_fixup_irqs which is ARM specific API.
---
 drivers/pci/host/pcie-xilinx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 13fec35..6cbce34 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -704,7 +704,9 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 #endif
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+#ifdef CONFIG_ARM
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+#endif
 	pci_bus_add_devices(bus);
 	platform_set_drvdata(pdev, port);
 
-- 
2.1.1
