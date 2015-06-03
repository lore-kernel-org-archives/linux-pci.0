Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:37678 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbbFCIem (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2015 04:34:42 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, <fabrice.gasnier@st.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<yuanzhichang@hisilicon.com>, <zhudacai@hisilicon.com>,
	<zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v2 0/4] PCI: hisi: Add PCIe host support for Hisilicon Soc Hip05
Date: Wed, 3 Jun 2015 16:35:38 +0800
Message-ID: <1433320542-49576-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset adds PCIe host support for Hisilicon Soc Hip05. The PCIe hosts
use PCIe IP core from Synopsys, So this driver is base on designware PCIe driver.

Hip05 is an ARMv8 architecture Soc. It should be able to use ARM64 PCIe API in
designeware PCIe driver.

This patchset is based on v4.1-rc1.

Change from RFC v1:
1. Add 1/4 patch by Arnd which removes align_resource callback in ARM
   pcibios_align_resource.
2. Change head file in pcie-designware from asm/hardirq.h to linux/hardirq.h.
3. Set pp->root_bus_nr = 0 in dra7xx, exynos, imx6, keystone, layerscape,
   spear13xx.
4. Remove unnecessary parentheses of some macros in pcie-hisi.
5. Use macro to replace some magic values.
6. Merge two loops together and add some comments about it in context_config
   function in pcie-hisi.
7. Modify some value of items in pcie node example in binding document. 

Change from RFC:
1. delete dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
   merge related operations into dw_pcie_host_init.

Link of RFC v1:
- http://www.spinics.net/lists/linux-pci/msg41305.html
Link of RFC:
- http://www.spinics.net/lists/linux-pci/msg40434.html

Zhou Wang (4):
  ARM/PCI: remove align_resource callback in pcibios_align_resource
  PCI: designware: Add ARM64 support
  PCI: hisi: Add PCIe host support for Hisilicon Soc Hip05
  Documentation: DT: Add Hisilicon PCIe host binding

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  46 ++++
 arch/arm/kernel/bios32.c                           |   4 -
 drivers/pci/host/Kconfig                           |   5 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-dra7xx.c                      |   1 +
 drivers/pci/host/pci-exynos.c                      |   2 +-
 drivers/pci/host/pci-imx6.c                        |   2 +-
 drivers/pci/host/pci-keystone.c                    |   2 +-
 drivers/pci/host/pci-layerscape.c                  |   2 +-
 drivers/pci/host/pci-mvebu.c                       |  47 ++--
 drivers/pci/host/pcie-designware.c                 | 128 ++++------
 drivers/pci/host/pcie-hisi.c                       | 258 +++++++++++++++++++++
 drivers/pci/host/pcie-spear13xx.c                  |   2 +-
 drivers/pci/setup-res.c                            |  27 ++-
 include/linux/pci.h                                |   3 +
 15 files changed, 421 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 create mode 100644 drivers/pci/host/pcie-hisi.c

-- 
1.9.1

