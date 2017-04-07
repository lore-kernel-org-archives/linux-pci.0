Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933841AbdDGT0E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Apr 2017 15:26:04 -0400
Date: Fri, 7 Apr 2017 14:26:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Nowicki <tn@semihalf.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [GIT PULL] PCI fixes for v4.11
Message-ID: <20170407192600.GA12235@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix ThunderX legacy firmware resources

  - fix ARTPEC-6 and DesignWare platform driver NULL pointer dereferences

  - fix HiSilicon link error


The following changes since commit 9abb27c7594a62bbf6385e20b7f5a90b4eceae2f:

  PCI: thunder-pem: Add legacy firmware support for Cavium ThunderX host controller (2017-03-23 17:11:26 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.11-fixes-4

for you to fetch changes up to 794a8604fe6e4a311373cde57a86ad4aab9d32b8:

  PCI: dwc: Fix dw_pcie_ops NULL pointer dereference (2017-04-04 08:24:25 -0500)

----------------------------------------------------------------
pci-v4.11-fixes-4

----------------------------------------------------------------
Arnd Bergmann (1):
      PCI: dwc: Select PCI_HOST_COMMON for hisi

Niklas Cassel (1):
      PCI: dwc: Fix dw_pcie_ops NULL pointer dereference

Tomasz Nowicki (1):
      PCI: thunder-pem: Fix legacy firmware PEM-specific resources

 drivers/pci/dwc/Kconfig                |  1 +
 drivers/pci/dwc/pcie-artpec6.c         |  4 ++++
 drivers/pci/dwc/pcie-designware-plat.c |  4 ++++
 drivers/pci/host/pci-thunder-pem.c     | 10 ++++++++--
 4 files changed, 17 insertions(+), 2 deletions(-)
