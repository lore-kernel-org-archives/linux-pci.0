Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:6811 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967154AbdEXIOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2017 04:14:52 -0400
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
Subject: [PATCH v6 0/4] DT and Driver review comments fix
Date: Wed, 24 May 2017 16:12:44 +0800
Message-ID: <20170524081248.67198-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Before Version Patches
======================

patch V4
https://www.spinics.net/lists/linux-pci/msg61406.html

patch V3
https://www.spinics.net/lists/linux-pci/msg61399.html

Changes between V6 and V5
=========================
1. seperate Document from .dtsi patch.
2. fix issues according to review comments
   from Bjorn Helgaas and Rob Herring: annotation stype, DT node,
   patch post method and so on.

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
 drivers/pci/dwc/pcie-kirin.c                       | 511 +++++++++++++++++++++
 6 files changed, 603 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 drivers/pci/dwc/pcie-kirin.c

-- 
2.11.GIT
