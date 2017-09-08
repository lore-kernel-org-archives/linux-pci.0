Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ravi Shankar Jonnalagadda <venkata.ravi.jonnalagadda@xilinx.com>
To: <vinod.koul@intel.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <michal.simek@xilinx.com>, <soren.brinkmann@xilinx.com>,
 <dan.j.williams@intel.com>, <bhelgaas@google.com>, <vjonnal@xilinx.com>,
 <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@xilinx.com>,
 <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rgummal@xilinx.com>
Subject: [PATCH v2 0/5] dmaengine: ZynqMP PS PCIe DMA driver
Date: Fri, 8 Sep 2017 17:53:02 +0530
Message-ID: <1504873388-29195-1-git-send-email-vjonnal@xilinx.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

ZynqMP devices have PCIe Bridge along with DMA in PS.
These devices can be configured as either PCIe Endpoints
or as PCIe Root Complex.
This patch series shall provide a driver to initiate
transactions using this DMA.
Single platform driver shall handle both EndPoint and
Root DMA transfers.
Patch 1 enables Root DMA register translation and
	interrupts
Patch 2 corrects styling errors seen with checkpatch
Patch 3 adds PCIe driver for end points
Patch 4 adds Platform driver which handles DMA transactions
	for both PCI end points and Root DMA
Patch 5 describes device tree bindings for Root DMA


Ravi Shankar Jonnalagadda (5):
  PCI:xilinx-nwl: Enable Root DMA
  PCI:xilinx-nwl: Correcting Styling checks
  dmaengine: zynqmp_ps_pcie: Adding PS PCIe DMA driver
  dmaengine: zynqmp_ps_pcie: Adding PS PCIe platform DMA driver
  devicetree: zynqmp_ps_pcie: Devicetree binding for Root DMA

 .../devicetree/bindings/dma/xilinx/ps-pcie-dma.txt |   67 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/xilinx/Makefile                        |    2 +
 drivers/dma/xilinx/ps_pcie.h                       |   44 +
 drivers/dma/xilinx/ps_pcie_main.c                  |  200 ++
 drivers/dma/xilinx/ps_pcie_platform.c              | 3055 ++++++++++++++++++++
 drivers/pci/host/pcie-xilinx-nwl.c                 |   23 +-
 include/linux/dma/ps_pcie_dma.h                    |   69 +
 8 files changed, 3468 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/ps-pcie-dma.txt
 create mode 100644 drivers/dma/xilinx/ps_pcie.h
 create mode 100644 drivers/dma/xilinx/ps_pcie_main.c
 create mode 100644 drivers/dma/xilinx/ps_pcie_platform.c
 create mode 100644 include/linux/dma/ps_pcie_dma.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
