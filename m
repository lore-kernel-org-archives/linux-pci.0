Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:6914 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbdEZCAU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2017 22:00:20 -0400
From: Xiaowei Song <songxiaowei@hisilicon.com>
To: <bhelgaas@google.com>, <kishon@ti.com>, <jingoohan1@gmail.com>,
        <arnd@arndb.de>, <tn@semihalf.com>, <keith.busch@intel.com>,
        <niklas.cassel@axis.com>, <dhdang@apm.com>,
        <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <chenyao11@huawei.com>, <puck.chen@hisilicon.com>,
        <songxiaowei@hisilicon.com>, <guodong.xu@linaro.org>,
        <wangbinghui@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/4]   add PCIe driver for Kirin PCIe
Date: Fri, 26 May 2017 09:53:29 +0800
Message-ID: <20170526015333.92482-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Before Version Patches
======================
patch V7
https://www.spinics.net/lists/linux-pci/msg61664.html
patch V6
https://www.spinics.net/lists/linux-pci/msg61610.html

patch V4
https://www.spinics.net/lists/linux-pci/msg61406.html

patch V3
https://www.spinics.net/lists/linux-pci/msg61399.html


Changes between V8 and V7
=========================
1. Replace 'reset-gpios' of 'reset-gpio' in Documentation.

Changes between V7 and V6
=========================
1. add enumeration log Based on Hikey960 Board with these patches.
2. fix issues as fellows:
   (1) delete reduntant blankets in macro defination,
   (2) add blank line in  kirin_pcie_clk_ctrl function.
   (3) Fix compitable property in DT with the SoC name,
       for example "hisilicon,kirin960-pcie".

Changes between V6 and V4
=========================
1. seperate Document from .dtsi patch.
2. fix issues according to review comments
   from Bjorn Helgaas and Rob Herring: annotation stype, DT node,
   patch post method and so on.

Enumeration log
===============
These test logs come from patches running on Hikey960 Board
(1) Connect with Atheros Communications WIFI
	OF: PCI: host bridge /soc/kirin_pcie_rc@f4000000 ranges:
	OF: PCI:   MEM 0xf6000000..0xf7ffffff -> 0x00000000
	kirin-pcie f4000000.kirin_pcie_rc: PCI host bridge to bus 0000:00
	pci_bus 0000:00: root bus resource [bus 00-01]
	pci_bus 0000:00: root bus resource [mem 0xf6000000-0xf7ffffff] (bus address [0x00000000-0x01ffffff])
	pci 0000:00:00.0: [19e5:3660] type 01 class 0x060400
	pci 0000:00:00.0: reg 0x10: [mem 0xf6000000-0xf6ffffff]
	pci 0000:00:00.0: supports D1 D2
	pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
	pci 0000:01:00.0: [168c:002a] type 00 class 0x028000
	pci 0000:01:00.0: reg 0x10: [mem 0xf6000000-0xf600ffff 64bit]
	pci 0000:01:00.0: supports D1
	pci 0000:01:00.0: PME# supported from D0 D1 D3hot
	pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
	pci 0000:00:00.0: BAR 0: assigned [mem 0xf6000000-0xf6ffffff]
	pci 0000:00:00.0: BAR 14: assigned [mem 0xf7000000-0xf70fffff]
	pci 0000:01:00.0: BAR 0: assigned [mem 0xf7000000-0xf700ffff 64bit]
	pci 0000:00:00.0: PCI bridge to [bus 01]
	pci 0000:00:00.0:   bridge window [mem 0xf7000000-0xf70fffff]
	pcieport 0000:00:00.0: Signaling PME with IRQ 276
	pcieport 0000:00:00.0: AER enabled with IRQ 276	

(2) Connect with Sandisk SSD
	OF: PCI: host bridge /soc/kirin_pcie_rc@f4000000 ranges:
	OF: PCI:   MEM 0xf6000000..0xf7ffffff -> 0x00000000
	kirin-pcie f4000000.kirin_pcie_rc: PCI host bridge to bus 0000:00
	pci_bus 0000:00: root bus resource [bus 00-01]
	pci_bus 0000:00: root bus resource [mem 0xf6000000-0xf7ffffff] (bus address [0x00000000-0x01ffffff])
	pci 0000:00:00.0: [19e5:3660] type 01 class 0x060400
	pci 0000:00:00.0: reg 0x10: [mem 0xf6000000-0xf6ffffff]
	pci 0000:00:00.0: supports D1 D2
	pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
	pci 0000:01:00.0: [1b4b:1093] type 00 class 0x010802
	pci 0000:01:00.0: reg 0x10: [mem 0xf6000000-0xf6003fff 64bit]
	pci 0000:01:00.0: reg 0x30: [mem 0xf6000000-0xf600ffff pref]
	pci 0000:00:00.0: BAR 0: assigned [mem 0xf6000000-0xf6ffffff]
	pci 0000:00:00.0: BAR 14: assigned [mem 0xf7000000-0xf70fffff]
	pci 0000:00:00.0: BAR 15: assigned [mem 0xf7100000-0xf71fffff pref]
	pci 0000:01:00.0: BAR 6: assigned [mem 0xf7100000-0xf710ffff pref]
	pci 0000:01:00.0: BAR 0: assigned [mem 0xf7000000-0xf7003fff 64bit]
	pci 0000:00:00.0: PCI bridge to [bus 01]
	pci 0000:00:00.0:   bridge window [mem 0xf7000000-0xf70fffff]
	pci 0000:00:00.0:   bridge window [mem 0xf7100000-0xf71fffff pref]
	pcieport 0000:00:00.0: Signaling PME with IRQ 276
	pcieport 0000:00:00.0: AER enabled with IRQ 276

Patches list
============
Xiaowei Song (4):
  PCI: hisi: Add DT binding for PCIe of Kirin SoC series
  arm64: dts: hisi: add kirin pcie node
  PCI: dwc: kirin: add PCIe Driver for HiSilicon Kirin SoC
  defconfig: PCI: Enable  Kirin PCIe defconfig

 .../devicetree/bindings/pci/kirin-pcie.txt         |  49 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  31 ++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/pci/dwc/Kconfig                            |  10 +
 drivers/pci/dwc/Makefile                           |   1 +
 drivers/pci/dwc/pcie-kirin.c                       | 513 +++++++++++++++++++++
 6 files changed, 605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 drivers/pci/dwc/pcie-kirin.c

-- 
2.11.GIT
