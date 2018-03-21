Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54110 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbeCUOnD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Mar 2018 10:43:03 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ley Foon Tan <lftan@altera.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH v2 00/10] PCI DT header refactoring and compile test improvements
Date: Wed, 21 Mar 2018 14:42:44 +0000
Message-Id: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rebased/reworked a patch series previously posted by Rob Herring[1].

v1 -> v2:
	- Rebased against v4.16-rc1
	- Refactored/split patches

[1] https://marc.info/?l=linux-pci&m=152043736711658&w=2

Original cover letter
---------------------

This started with just moving private functions from of_pci.h to
drivers/pci/pci.h, but I was annoyed with trying to build all the right
configs, so I enabled COMPILE_TEST on a bunch of drivers. Then I fixed
the fallout from doing that. I'm sending this as all one series, but
really there is no dependency for the header refactoring patch.

Needless to say, this series is *compile tested* only. This is based on 
Bjorn's for-linus branch (and the of_pci.h fix there).

Rob

Fengguang Wu (4):
  PCI: kirin: struct kirin_pcie_driver can be static
  PCI: faraday: struct faraday_pci_variant can be static
  PCI: rcar: Fix semicolon.cocci warnings
  PCI: v3-semi: Fix semicolon.cocci warnings

Rob Herring (6):
  PCI: kirin: Remove unnecessary asm/compiler.h include
  PCI: iproc: Remove dependency on ARM specific struct pci_sys_data
  PCI: kirin: Fix missing dependency on PCI_MSI_IRQ_DOMAIN
  PCI: Improve host drivers compile test coverage
  PCI: dwc: Move CONFIG_PCI depends to menu
  PCI: Move private DT related functions into private header

 drivers/pci/dwc/Kconfig                | 42 +++++++++++++---------------------
 drivers/pci/dwc/pci-dra7xx.c           |  1 +
 drivers/pci/dwc/pcie-designware-host.c |  1 +
 drivers/pci/dwc/pcie-kirin.c           |  3 +--
 drivers/pci/host/Kconfig               | 32 ++++++++++++--------------
 drivers/pci/host/pci-aardvark.c        |  2 ++
 drivers/pci/host/pci-ftpci100.c        |  6 +++--
 drivers/pci/host/pci-mvebu.c           |  2 ++
 drivers/pci/host/pci-rcar-gen2.c       |  2 ++
 drivers/pci/host/pci-tegra.c           |  2 ++
 drivers/pci/host/pci-v3-semi.c         |  4 +++-
 drivers/pci/host/pci-xgene.c           |  2 ++
 drivers/pci/host/pcie-altera.c         |  2 ++
 drivers/pci/host/pcie-iproc-bcma.c     |  3 +--
 drivers/pci/host/pcie-iproc-platform.c |  1 +
 drivers/pci/host/pcie-iproc.c          | 19 ++-------------
 drivers/pci/host/pcie-iproc.h          |  4 ----
 drivers/pci/host/pcie-mediatek.c       |  2 ++
 drivers/pci/host/pcie-rcar.c           |  4 +++-
 drivers/pci/host/pcie-rockchip.c       |  2 ++
 drivers/pci/host/pcie-xilinx-nwl.c     |  2 ++
 drivers/pci/host/pcie-xilinx.c         |  2 ++
 drivers/pci/pci.h                      | 40 ++++++++++++++++++++++++++++++++
 include/linux/of_pci.h                 | 34 ---------------------------
 24 files changed, 108 insertions(+), 106 deletions(-)

-- 
2.15.0
