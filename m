Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 3 Mar 2017 10:49:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [GIT PULL] PCI fixes for v4.11
Message-ID: <20170303164950.GA30375@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix NULL pointer dereferences in many DesignWare-based drivers due to
    refactoring error

  - fix Altera config write breakage due to my refactoring error


The following changes since commit 9e314890292c0dd357eadef6a043704fa0b4c157:

  Merge tag 'openrisc-for-linus' of git://github.com/openrisc/linux (2017-02-24 18:37:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.11-fixes-1

for you to fetch changes up to 2a7275a3d867b228216886aae35e1f64291180b1:

  PCI: altera: Fix TLP_CFG_DW0 for TLP write (2017-02-28 15:06:29 -0600)

----------------------------------------------------------------
pci-v4.11-fixes-1

----------------------------------------------------------------
Guenter Roeck (1):
      PCI: dwc: Fix crashes seen due to missing assignments

Ley Foon Tan (1):
      PCI: altera: Fix TLP_CFG_DW0 for TLP write

 drivers/pci/dwc/pci-exynos.c           |  1 +
 drivers/pci/dwc/pci-imx6.c             |  1 +
 drivers/pci/dwc/pci-keystone.c         |  2 ++
 drivers/pci/dwc/pci-layerscape.c       |  2 ++
 drivers/pci/dwc/pcie-armada8k.c        |  2 ++
 drivers/pci/dwc/pcie-artpec6.c         |  2 ++
 drivers/pci/dwc/pcie-designware-plat.c |  2 ++
 drivers/pci/dwc/pcie-hisi.c            |  2 ++
 drivers/pci/dwc/pcie-qcom.c            |  2 ++
 drivers/pci/dwc/pcie-spear13xx.c       |  2 ++
 drivers/pci/host/pcie-altera.c         | 10 +++++++---
 11 files changed, 25 insertions(+), 3 deletions(-)
