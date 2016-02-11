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
	"Bharat Kumar Gogada" <bharatku@xilinx.com>
Subject: [PATCH V4 0/5] PCIe Xilinx generic driver for Microblaze and 
Date: Thu, 11 Feb 2016 21:58:06 +0530
Message-ID: <1455208091-15556-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series does modifications to pcie-xilinx.c, to support common
driver on both Zynq and Microblaze architectures.
Microblaze pci-common.c has been modified to support generic driver.

Bharat Kumar Gogada (5):
  PCI: xilinx: Removing xilinx_pcie_parse_and_add_res function
  PCI: xilinx: Removing struct hw_pci structure.
  PCI: xilinx: Modifying AXI PCIe Host Bridge driver to work on both
     Zynq and Microblaze
  PCI: xilinx: Updating Zynq PCI binding documentation with 
    Microblaze node.
  Microblaze: Modifying microblaze PCI subsytem to support  generic
    Xilinx  AXI PCIe Host Bridge IP driver

 .../devicetree/bindings/pci/xilinx-pcie.txt        |  32 +++-
 arch/microblaze/Kconfig                            |   3 +
 arch/microblaze/pci/pci-common.c                   |  56 ++----
 drivers/pci/host/Kconfig                           |   2 +-
 drivers/pci/host/pcie-xilinx.c                     | 191 +++------------------
 5 files changed, 66 insertions(+), 218 deletions(-)

-- 
2.1.1
