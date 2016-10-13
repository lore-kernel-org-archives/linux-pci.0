Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932418AbcJMOHw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Oct 2016 10:07:52 -0400
Date: Thu, 13 Oct 2016 09:07:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL] PCI changes for v4.9
Message-ID: <20161013140746.GA14174@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are some more changes I'd like to have in v4.9.  There's one small
Tegra bug fix in the PHY poweroff path, which is only used in failure
paths.  The rest is all strictly cleanup that should make host bridge
drivers more readable, but shouldn't actually change any behavior.

Bjorn


The following changes since commit bdf530984d10b6b88b10a6d03057409a3f1c6897:

  Merge branch 'pci/host-vmd' into next (2016-10-05 14:00:21 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.9-changes-2

for you to fetch changes up to 217c6d21e9245e590971905fd4501fd53730c800:

  Merge branches 'pci/host-armada', 'pci/host-artpec', 'pci/host-dra7xx', 'pci/host-exynos', 'pci/host-hisi', 'pci/host-imx6', 'pci/host-keystone', 'pci/host-layerscape', 'pci/host-qcom' and 'pci/host-spear' into next (2016-10-12 11:15:06 -0500)

----------------------------------------------------------------
PCI changes for the v4.9 merge window:

  Altera host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove unused platform data (Bjorn Helgaas)
    Remove redundant platform_get_resource() return value check (Bjorn Helgaas)
    Rename altera_pcie_valid_config() to altera_pcie_valid_device() (Bjorn Helgaas)
    Simplify TLB_CFG_DW0 usage (Bjorn Helgaas)
    Simplify TLP_CFG_DW1 usage (Bjorn Helgaas)

  APM X-Gene host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove unused platform data (Bjorn Helgaas)
    Pass struct xgene_pcie_port to setup functions (Bjorn Helgaas)
    Add register accessors (Bjorn Helgaas)

  Axis ARTPEC-6 host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove unused platform data (Bjorn Helgaas)
    Add register accessors (Bjorn Helgaas)
    Use generic DesignWare accessors (Bjorn Helgaas)
    Remove unnecessary artpec6_pcie_link_up() (Bjorn Helgaas)
    Pass device-specific struct to internal functions (Bjorn Helgaas)
    Add resource name comments (Bjorn Helgaas)

  Broadcom iProc host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Set drvdata at end of probe function (Bjorn Helgaas)
    Validate CSR base in BCMA setup code (Bjorn Helgaas)
    Remove redundant null pointer checking (Bjorn Helgaas)
    Hard-code PCIe capability offset instead of searching (Bjorn Helgaas)

  Freescale i.MX6 host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove redundant of_node pointer (Bjorn Helgaas)
    Removed unused struct imx6_pcie.mem_base (Bjorn Helgaas)
    Pass struct imx6_pcie to PHY accessors (Bjorn Helgaas)
    Pass device-specific struct to internal functions (Bjorn Helgaas)
    Use generic DesignWare accessors (Bjorn Helgaas)
    Reorder struct imx6_pcie (Bjorn Helgaas)
    Remove unused return values (Bjorn Helgaas)

  Freescale Layerscape host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove unused platform data (Bjorn Helgaas)
    Remove redundant struct ls_pcie.dbi (Bjorn Helgaas)
    Pass device-specific struct to internal functions (Bjorn Helgaas)
    Move struct pcie_port setup to probe function (Bjorn Helgaas)
    Remove unused ls_add_pcie_port() platform_device arg (Bjorn Helgaas)
    Reorder struct ls_pcie (Bjorn Helgaas)

  HiSilicon host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove unused platform data (Bjorn Helgaas)
    Name private struct pointer "hisi_pcie" consistently (Bjorn Helgaas)
    Remove redundant struct hisi_pcie.reg_base (Bjorn Helgaas)
    Use generic DesignWare accessors (Bjorn Helgaas)
    Include register block base in PCIE_SYS_STATE4 address (Bjorn Helgaas)
    Pass device-specific struct to internal functions (Bjorn Helgaas)
    Reorder struct hisi_pcie (Bjorn Helgaas)

  Marvell Aardvark host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove unused platform data (Bjorn Helgaas)
    MAINTAINERS: Add DT binding to the Aardvark PCIe driver maintainer (Thomas Petazzoni)

  Marvell Armada host bridge driver
    Remove unused platform data (Bjorn Helgaas)
    Add local base pointer (Bjorn Helgaas)
    Remove redundant struct armada8k_pcie.base (Bjorn Helgaas)
    Use generic DesignWare accessors (Bjorn Helgaas)
    Pass device-specific struct to internal functions (Bjorn Helgaas)
    Reorder struct armada8k_pcie (Bjorn Helgaas)
    MAINTAINERS: Add maintainer for the PCIe Marvell Armada 8K driver (Thomas Petazzoni)

  Marvell MVEBU host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Use existing of_node pointer (Bjorn Helgaas)

  NVIDIA Tegra host bridge driver
    Fix argument order in tegra_pcie_phy_disable() (Bjorn Helgaas)
    Add local struct device pointers (Bjorn Helgaas)
    Remove unused platform data (Bjorn Helgaas)

  Qualcomm host bridge driver
    Remove unused platform data (Bjorn Helgaas)
    Remove redundant struct qcom_pcie.dbi (Bjorn Helgaas)
    Remove redundant struct qcom_pcie.dev (Bjorn Helgaas)
    Reorder struct qcom_pcie (Bjorn Helgaas)

  Renesas R-Car host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove unused platform data (Bjorn Helgaas)
    Remove unused rcar_pcie_get_resources() platform_device arg (Bjorn Helgaas)
    Remove DRV_NAME macro (Bjorn Helgaas)
    rcar-gen2: Add local struct device pointers (Bjorn Helgaas)

  Rockchip host bridge driver
    Remove unused platform data (Bjorn Helgaas)
    Indent "if" statement body (Dan Carpenter)

  Samsung Exynos host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Uninline register accessors (Bjorn Helgaas)
    Name private struct pointer "exynos_pcie" consistently (Bjorn Helgaas)
    Pass device-specific struct to internal functions (Bjorn Helgaas)
    Reorder struct exynos_pcie (Bjorn Helgaas)

  ST Microelectronics SPEAr13xx host bridge driver
    Remove unused constants (Bjorn Helgaas)
    Pass device-specific struct to internal functions (Bjorn Helgaas)
    Reorder struct spear13xx_pcie (Bjorn Helgaas)
    Clean up struct device usage (Bjorn Helgaas)

  Synopsys DesignWare host bridge driver
    Rename dw_pcie_valid_config() to dw_pcie_valid_device() (Bjorn Helgaas)
    Simplify pcie_host_ops.readl_rc() and .writel_rc() interfaces (Bjorn Helgaas)
    Swap order of dw_pcie_writel_rc() reg/val arguments (Bjorn Helgaas)
    Export dw_pcie_readl_rc(), dw_pcie_writel_rc() (Bjorn Helgaas)
    Uninline register accessors (Bjorn Helgaas)
    Simplify dw_pcie_readl_unroll(), dw_pcie_writel_unroll() (Kishon Vijay Abraham I)
    Swap order of dw_pcie_writel_unroll() reg/val arguments (Bjorn Helgaas)
    designware-plat: Remove redundant dw_plat_pcie.mem_base (Bjorn Helgaas)
    designware-plat: Add local struct device pointers (Bjorn Helgaas)
    designware-plat: Remove unused platform data (Bjorn Helgaas)

  TI DRA7xx host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove redundant struct device pointer from dra7xx_pcie (Bjorn Helgaas)
    Set drvdata at end of probe function (Bjorn Helgaas)
    Use generic DesignWare accessors (Bjorn Helgaas)
    Pass device-specific struct to internal functions (Bjorn Helgaas)
    Move struct pcie_port setup to probe function (Bjorn Helgaas)
    Reorder struct dra7xx_pcie (Bjorn Helgaas)

  TI Keystone host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Use generic DesignWare accessors (Bjorn Helgaas)
    Pass keystone_pcie, not address, to IRQ functions (Bjorn Helgaas)
    Pass keystone_pcie, not va_app_base, to DBI functions (Bjorn Helgaas)
    Add app register accessors (Bjorn Helgaas)
    Reorder struct keystone_pcie (Bjorn Helgaas)

  Xilinx AXI host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove unused platform data (Bjorn Helgaas)
    Removed unused xilinx_pcie_assign_msi() argument (Bjorn Helgaas)

  Xilinx NWL host bridge driver
    Add local struct device pointers (Bjorn Helgaas)
    Remove unused platform data (Bjorn Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (107):
      PCI: designware: Rename dw_pcie_valid_config() to dw_pcie_valid_device()
      PCI: rcar: Add local struct device pointers
      PCI: xgene: Add local struct device pointers
      PCI: designware: Simplify pcie_host_ops.readl_rc() and .writel_rc() interfaces
      PCI: designware: Swap order of dw_pcie_writel_rc() reg/val arguments
      PCI: designware: Export dw_pcie_readl_rc(), dw_pcie_writel_rc()
      PCI: designware: Uninline register accessors
      PCI: designware: Swap order of dw_pcie_writel_unroll() reg/val arguments
      PCI: designware-plat: Remove redundant dw_plat_pcie.mem_base
      PCI: designware-plat: Add local struct device pointers
      PCI: designware-plat: Remove unused platform data
      PCI: spear: Remove unused constants
      PCI: spear: Pass device-specific struct to internal functions
      PCI: spear: Reorder struct spear13xx_pcie
      PCI: spear: Clean up struct device usage
      PCI: aardvark: Add local struct device pointers
      PCI: aardvark: Remove unused platform data
      PCI: altera: Add local struct device pointers
      PCI: altera: Remove unused platform data
      PCI: altera: Remove redundant platform_get_resource() return value check
      PCI: altera: Rename altera_pcie_valid_config() to altera_pcie_valid_device()
      PCI: altera: Simplify TLB_CFG_DW0 usage
      PCI: altera: Simplify TLP_CFG_DW1 usage
      PCI: armada: Remove unused platform data
      PCI: armada: Add local base pointer
      PCI: armada: Remove redundant struct armada8k_pcie.base
      PCI: armada: Use generic DesignWare accessors
      PCI: armada: Pass device-specific struct to internal functions
      PCI: armada: Reorder struct armada8k_pcie
      PCI: artpec6: Add local struct device pointers
      PCI: artpec6: Remove unused platform data
      PCI: artpec6: Add register accessors
      PCI: artpec6: Use generic DesignWare accessors
      PCI: artpec6: Remove unnecessary artpec6_pcie_link_up()
      PCI: artpec6: Pass device-specific struct to internal functions
      PCI: artpec6: Add resource name comments
      PCI: dra7xx: Add local struct device pointers
      PCI: dra7xx: Remove redundant struct device pointer from dra7xx_pcie
      PCI: dra7xx: Set drvdata at end of probe function
      PCI: dra7xx: Use generic DesignWare accessors
      PCI: dra7xx: Pass device-specific struct to internal functions
      PCI: dra7xx: Move struct pcie_port setup to probe function
      PCI: exynos: Add local struct device pointers
      PCI: exynos: Uninline register accessors
      PCI: exynos: Name private struct pointer "exynos_pcie" consistently
      PCI: exynos: Pass device-specific struct to internal functions
      PCI: exynos: Reorder struct exynos_pcie
      PCI: hisi: Add local struct device pointers
      PCI: hisi: Remove unused platform data
      PCI: hisi: Name private struct pointer "hisi_pcie" consistently
      PCI: hisi: Remove redundant struct hisi_pcie.reg_base
      PCI: hisi: Use generic DesignWare accessors
      PCI: imx6: Add local struct device pointers
      PCI: imx6: Remove redundant of_node pointer
      PCI: imx6: Removed unused struct imx6_pcie.mem_base
      PCI: imx6: Pass struct imx6_pcie to PHY accessors
      PCI: imx6: Pass device-specific struct to internal functions
      PCI: imx6: Use generic DesignWare accessors
      PCI: imx6: Reorder struct imx6_pcie
      PCI: imx6: Remove unused return values
      PCI: iproc: Add local struct device pointers
      PCI: iproc: Set drvdata at end of probe function
      PCI: iproc: Validate CSR base in BCMA setup code
      PCI: iproc: Remove redundant null pointer checking
      PCI: iproc: Hard-code PCIe capability offset instead of searching
      PCI: keystone: Add local struct device pointers
      PCI: keystone: Use generic DesignWare accessors
      PCI: keystone: Pass keystone_pcie, not address, to IRQ functions
      PCI: keystone: Pass keystone_pcie, not va_app_base, to DBI functions
      PCI: keystone: Add app register accessors
      PCI: keystone: Reorder struct keystone_pcie
      PCI: layerscape: Add local struct device pointers
      PCI: layerscape: Remove unused platform data
      PCI: layerscape: Remove redundant struct ls_pcie.dbi
      PCI: layerscape: Pass device-specific struct to internal functions
      PCI: layerscape: Move struct pcie_port setup to probe function
      PCI: layerscape: Remove unused ls_add_pcie_port() platform_device arg
      PCI: layerscape: Reorder struct ls_pcie
      PCI: mvebu: Add local struct device pointers
      PCI: mvebu: Use existing of_node pointer
      PCI: qcom: Remove unused platform data
      PCI: qcom: Remove redundant struct qcom_pcie.dbi
      PCI: qcom: Remove redundant struct qcom_pcie.dev
      PCI: qcom: Reorder struct qcom_pcie
      PCI: rcar: Remove unused platform data
      PCI: rcar: Remove unused rcar_pcie_get_resources() platform_device arg
      PCI: rcar: Remove DRV_NAME macro
      PCI: rcar-gen2: Add local struct device pointers
      PCI: rockchip: Remove unused platform data
      PCI: tegra: Fix argument order in tegra_pcie_phy_disable()
      PCI: tegra: Add local struct device pointers
      PCI: tegra: Remove unused platform data
      PCI: xgene: Remove unused platform data
      PCI: xgene: Pass struct xgene_pcie_port to setup functions
      PCI: xgene: Add register accessors
      PCI: xilinx: Add local struct device pointers
      PCI: xilinx: Remove unused platform data
      PCI: xilinx: Removed unused xilinx_pcie_assign_msi() argument
      PCI: xilinx-nwl: Add local struct device pointers
      PCI: xilinx-nwl: Remove unused platform data
      PCI: dra7xx: Reorder struct dra7xx_pcie
      PCI: hisi: Include register block base in PCIE_SYS_STATE4 address
      PCI: hisi: Pass device-specific struct to internal functions
      PCI: hisi: Reorder struct hisi_pcie
      Merge branches 'pci/host-aardvark', 'pci/host-altera', 'pci/host-iproc', 'pci/host-mvebu', 'pci/host-rcar', 'pci/host-rockchip', 'pci/host-tegra', 'pci/host-xgene' and 'pci/host-xilinx' into next
      Merge branch 'pci/host-designware' into next
      Merge branches 'pci/host-armada', 'pci/host-artpec', 'pci/host-dra7xx', 'pci/host-exynos', 'pci/host-hisi', 'pci/host-imx6', 'pci/host-keystone', 'pci/host-layerscape', 'pci/host-qcom' and 'pci/host-spear' into next

Dan Carpenter (1):
      PCI: rockchip: Indent "if" statement body

Kishon Vijay Abraham I (1):
      PCI: designware: Simplify dw_pcie_readl_unroll(), dw_pcie_writel_unroll()

Thomas Petazzoni (2):
      MAINTAINERS: Add DT binding to the Aardvark PCIe driver maintainer
      MAINTAINERS: Add maintainer for the PCIe Marvell Armada 8K driver

 MAINTAINERS                             |   9 ++
 drivers/pci/host/pci-aardvark.c         |  39 ++---
 drivers/pci/host/pci-dra7xx.c           | 103 ++++++-------
 drivers/pci/host/pci-exynos.c           | 220 +++++++++++++---------------
 drivers/pci/host/pci-imx6.c             | 250 ++++++++++++++++----------------
 drivers/pci/host/pci-keystone-dw.c      | 123 +++++++++-------
 drivers/pci/host/pci-keystone.c         |  28 ++--
 drivers/pci/host/pci-keystone.h         |   9 +-
 drivers/pci/host/pci-layerscape.c       |  65 +++++----
 drivers/pci/host/pci-mvebu.c            |  21 ++-
 drivers/pci/host/pci-rcar-gen2.c        |  46 +++---
 drivers/pci/host/pci-tegra.c            | 237 +++++++++++++++---------------
 drivers/pci/host/pci-xgene.c            | 151 ++++++++++---------
 drivers/pci/host/pcie-altera.c          |  77 +++++-----
 drivers/pci/host/pcie-armada8k.c        |  78 +++++-----
 drivers/pci/host/pcie-artpec6.c         | 115 ++++++++-------
 drivers/pci/host/pcie-designware-plat.c |  25 ++--
 drivers/pci/host/pcie-designware.c      | 102 ++++++-------
 drivers/pci/host/pcie-designware.h      |   7 +-
 drivers/pci/host/pcie-hisi.c            |  86 +++++------
 drivers/pci/host/pcie-iproc-bcma.c      |  14 +-
 drivers/pci/host/pcie-iproc-platform.c  |  27 ++--
 drivers/pci/host/pcie-iproc.c           |  52 +++----
 drivers/pci/host/pcie-qcom.c            |  30 ++--
 drivers/pci/host/pcie-rcar.c            |  98 +++++++------
 drivers/pci/host/pcie-rockchip.c        |   4 +-
 drivers/pci/host/pcie-spear13xx.c       | 108 +++-----------
 drivers/pci/host/pcie-xilinx-nwl.c      | 109 +++++++-------
 drivers/pci/host/pcie-xilinx.c          |  62 ++++----
 29 files changed, 1108 insertions(+), 1187 deletions(-)
