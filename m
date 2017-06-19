Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:8330 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753368AbdFSKYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 06:24:02 -0400
From: Xiaowei Song <songxiaowei@hisilicon.com>
To: <guodong.xu@linaro.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>
CC: <songxiaowei@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 0/3]add PCIe driver for Kirin PCIe
Date: Mon, 19 Jun 2017 18:23:46 +0800
Message-ID: <20170619102349.50652-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Before Version Patches
======================
patch v9
http://www.spinics.net/lists/linux-pci/msg61821.html
patch V8
http://www.spinics.net/lists/linux-pci/msg61715.html
patch V7
https://www.spinics.net/lists/linux-pci/msg61664.html
patch V6
https://www.spinics.net/lists/linux-pci/msg61610.html

patch V4
https://www.spinics.net/lists/linux-pci/msg61406.html

patch V3
https://www.spinics.net/lists/linux-pci/msg61399.html

Changes between V11 and V9
========================
1. Fix the indent issues according to the review comments from Bjorn:
   (1) The value of reg is right-aligned in both dtsi file and Documentation file.
   (2) Re-indent the space of macro defination pointed out by Bjorn.
   (3) Adjust the space in 'struct kirin_pcie' defination.
   (4) Use dev replace of pdev->dev in function  kirin_pcie_get_clk and kirin_pcie_get_resource.
   (5) Aligned params with '(' in function kirin_apb_ctrl_writel and several others.
2. Fix the issues that compitable value in Documentation was different with .dtsi file.
3. For dependance during compiling, the dtsi patch is deleted, and it was merged in patch[1].
4. The indent style issues will be pull with MSI-patch in the next weeks;

patch[1]: https://www.spinics.net/lists/arm-kernel/msg588944.html

=========================
Changes between V8 and V7
=========================
1. Fix the indent issues in Documentation, dtsi file and macro defination.
2. Replace pdev->dev with dev in kirin_pcie_get_resource and 
   kirin_pcie_get_clk functions.
3. Put variables "pci" and "kirin_pcie" to be initialized at first
   in kirin_pcie_wr_own_config, kirin_pcie_read_dbi and other functions.
4. Add space before blankets in "Low power mode(L1 ".
5. Short the Makefile sentence to lower than 80 characters
   and delete reduntant words.
6. Use word 'located' instead of the wrong one 'lacated'.
7. Fix the problem of return value type.

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


Xiaowei Song (3):
  PCI: hisi: Add DT binding for PCIe of Kirin SoC series
  PCI: dwc: kirin: add PCIe Driver for HiSilicon Kirin SoC
  ARM4: defconfig: Enable  Kirin PCIe

 .../devicetree/bindings/pci/kirin-pcie.txt         |  55 +++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/pci/dwc/Kconfig                            |  10 +
 drivers/pci/dwc/Makefile                           |   1 +
 drivers/pci/dwc/pcie-kirin.c                       | 518 +++++++++++++++++++++
 5 files changed, 585 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 drivers/pci/dwc/pcie-kirin.c

-- 
2.11.GIT
