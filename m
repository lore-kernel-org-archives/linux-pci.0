Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ravi Shankar Jonnalagadda <venkata.ravi.jonnalagadda@xilinx.com>
To: <bhelgaas@google.com>, <michal.simek@xilinx.com>,
 <soren.brinkmann@xilinx.com>, <lorenzo.pieralisi@arm.com>,
 <bharat.kumar.gogada@xilinx.com>, <vjonnal@xilinx.com>,
 <paul.gortmaker@windriver.com>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <dan.j.williams@intel.com>, <vinod.koul@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH 0/4] ZynqMP PS PCIe DMA Driver
Date: Tue, 8 Aug 2017 16:42:15 +0530
Message-ID: <1502190739-13474-1-git-send-email-vjonnal@xilinx.com>
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
Patch 3 adds DMA driver functionality for both PCI
	end points and Root DMA
Patch 4 describes device tree bindings for Root DMA

Ravi Shankar Jonnalagadda (4):
  PCI:xilinx-nwl: Enable Root DMA
  PCI:xilinx-nwl: Correcting Styling checks
  PCI: ZYNQMP PS PCIe DMA driver: Adding support for DMA driver
  PCI: ZYNQMP PS PCIe DMA driver: Devicetree binding for Root DMA

 .../devicetree/bindings/dma/xilinx/ps-pcie-dma.txt |   67 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/xilinx/Makefile                        |    2 +
 drivers/dma/xilinx/xilinx_ps_pcie.h                |   43 +
 drivers/dma/xilinx/xilinx_ps_pcie_main.c           |  200 ++
 drivers/dma/xilinx/xilinx_ps_pcie_platform.c       | 3059 ++++++++++++++++++++
 drivers/pci/host/pcie-xilinx-nwl.c                 |   23 +-
 include/linux/dma/xilinx_ps_pcie_dma.h             |   69 +
 8 files changed, 3471 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/ps-pcie-dma.txt
 create mode 100644 drivers/dma/xilinx/xilinx_ps_pcie.h
 create mode 100644 drivers/dma/xilinx/xilinx_ps_pcie_main.c
 create mode 100644 drivers/dma/xilinx/xilinx_ps_pcie_platform.c
 create mode 100644 include/linux/dma/xilinx_ps_pcie_dma.h

-- 
2.1.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
