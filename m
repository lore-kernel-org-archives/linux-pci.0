Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754509AbeGHDqa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Jul 2018 23:46:30 -0400
Date: Sat, 7 Jul 2018 22:46:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [GIT PULL] PCI fixes for v4.18
Message-ID: <20180708034627.GA90792@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


PCI fixes:

  - Fix a use-after-free in the endpoint code (Dan Carpenter) 

  - Stop defaulting CONFIG_PCIE_DW_PLAT_HOST to yes (Geert Uytterhoeven)

  - Fix an nfp regression caused by a change in how we limit the number of
    VFs we can enable (Jakub Kicinski)

  - Fix failure path cleanup issues in the new R-Car gen3 PHY support
    (Marek Vasut)

  - Fix leaks of OF nodes in faraday, xilinx-nwl, xilinx (Nicholas
    Mc Guire)


The following changes since commit 925d31668d5b6c9849c50167f31f9b5cf9eec892:

  PCI: controller: Move PCI_DOMAINS selection to arch Kconfig (2018-06-26 15:37:37 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-fixes-2

for you to fetch changes up to 83235822b8b4fe47ecbd6b6bcbcc902860ac00fc:

  nfp: stop limiting VFs to 0 (2018-06-29 15:09:00 -0500)

----------------------------------------------------------------
pci-v4.18-fixes-2

----------------------------------------------------------------
Dan Carpenter (1):
      PCI: endpoint: Use after free in pci_epf_unregister_driver()

Geert Uytterhoeven (1):
      PCI: controller: dwc: Do not let PCIE_DW_PLAT_HOST default to yes

Jakub Kicinski (2):
      PCI/IOV: Reset total_VFs limit after detaching PF driver
      nfp: stop limiting VFs to 0

Marek Vasut (2):
      PCI: rcar: Shut the PHY down in failpath
      PCI: rcar: Clean up PHY init on failure

Nicholas Mc Guire (3):
      PCI: xilinx: Add missing of_node_put()
      PCI: xilinx-nwl: Add missing of_node_put()
      PCI: faraday: Add missing of_node_put()

 drivers/net/ethernet/netronome/nfp/nfp_main.c |  6 +-----
 drivers/pci/controller/dwc/Kconfig            |  1 -
 drivers/pci/controller/pci-ftpci100.c         |  2 ++
 drivers/pci/controller/pcie-rcar.c            | 16 +++++++++++++---
 drivers/pci/controller/pcie-xilinx-nwl.c      |  2 +-
 drivers/pci/controller/pcie-xilinx.c          |  1 +
 drivers/pci/endpoint/pci-epf-core.c           |  4 ++--
 drivers/pci/iov.c                             | 16 ++++++++++++++++
 drivers/pci/pci-driver.c                      |  1 +
 drivers/pci/pci.h                             |  4 ++++
 10 files changed, 41 insertions(+), 12 deletions(-)
