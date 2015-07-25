Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:42363 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbbGYDPg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2015 23:15:36 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, <gabriele.paoloni@huawei.com>,
	<lorenzo.pieralisi@arm.com>, James Morse <james.morse@arm.com>,
	<Liviu.Dudau@arm.com>, <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>, <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liudongdong3@huawei.com>,
	<qiujiang@huawei.com>, <kangfenglong@huawei.com>,
	<liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v5 0/5] PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
Date: Sat, 25 Jul 2015 11:21:21 +0800
Message-ID: <1437794486-21134-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset adds PCIe host support for HiSilicon SoC Hip05. The PCIe hosts
use PCIe IP core from Synopsys, So this driver is base on designware PCIe driver.

Hip05 is an ARMv8 architecture SoC. It should be able to use ARM64 PCIe API in
designeware PCIe driver. So this patch also adds ARM64 support for designware
pcie.

This patchset is based on v4.2-rc1 and Gabriele's patch about of_pci_range
fix[1].

Change from v4:
- Change the author of 1/5 to Gabriele.
- Modify problems in 3/5 pointed by Bjorn.
- Modify spelling problems in 4/5.

Change from v3:
- Change 1/5 to what Gabriele suggested.
- Use win->__res.start to get *_mod_base in 2/5, this fix a bug in v3 series.

Change from v2:
- Move struct pci_dev *dev and struct pci_sys_data *sys in
  pcibios_align_resource in 1/5.
- Add Gabriele's codes in 2/5 which delete unnecessary information parse and
  use of_pci_get_host_bridge_resources for both ARM32 and ARM64.
- Add maintainer patch 5/5.

Change from RFC v1:
- Add 1/4 patch by Arnd which removes align_resource callback in ARM
  pcibios_align_resource.
- Change head file in pcie-designware from asm/hardirq.h to linux/hardirq.h.
- Set pp->root_bus_nr = 0 in dra7xx, exynos, imx6, keystone, layerscape,
  spear13xx.
- Remove unnecessary parentheses of some macros in pcie-hisi.
- Use macro to replace some magic values.
- Merge two loops together and add some comments about it in context_config
  function in pcie-hisi.
- Modify some value of items in pcie node example in binding document. 

Change from RFC:
- delete dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
  merge related operations into dw_pcie_host_init.

Link of v4:
- http://www.spinics.net/lists/arm-kernel/msg433050.html
Link of v3:
- http://www.spinics.net/lists/linux-pci/msg42539.html
Link of v2:
- http://www.spinics.net/lists/linux-pci/msg41844.html
Link of RFC v1:
- http://www.spinics.net/lists/linux-pci/msg41305.html
Link of RFC:
- http://www.spinics.net/lists/linux-pci/msg40434.html

[1] https://patchwork.ozlabs.org/patch/495018/

Gabriele Paoloni (1):
  ARM/PCI: remove align_resource in pci_sys_data

Zhou Wang (4):
  PCI: designware: Add ARM64 support
  PCI: hisi: Add PCIe host support for Hisilicon Soc Hip05
  Documentation: DT: Add Hisilicon PCIe host binding
  MAINTAINERS: Add pcie-hisi maintainer

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  46 ++++
 MAINTAINERS                                        |   7 +
 arch/arm/include/asm/mach/pci.h                    |   5 -
 arch/arm/kernel/bios32.c                           |  12 +-
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-dra7xx.c                      |   1 +
 drivers/pci/host/pci-exynos.c                      |   2 +-
 drivers/pci/host/pci-imx6.c                        |   2 +-
 drivers/pci/host/pci-keystone-dw.c                 |   2 +-
 drivers/pci/host/pci-keystone.c                    |   2 +-
 drivers/pci/host/pci-layerscape.c                  |   2 +-
 drivers/pci/host/pcie-designware.c                 | 217 ++++++------------
 drivers/pci/host/pcie-designware.h                 |  10 +-
 drivers/pci/host/pcie-hisi.c                       | 254 +++++++++++++++++++++
 drivers/pci/host/pcie-spear13xx.c                  |   2 +-
 16 files changed, 410 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 create mode 100644 drivers/pci/host/pcie-hisi.c

-- 
1.9.1

