Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751650AbdJMUAH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Oct 2017 16:00:07 -0400
Date: Fri, 13 Oct 2017 15:00:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [GIT PULL] PCI fixes for v4.14
Message-ID: <20171013200004.GA10475@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - revert Tegra MSI change that caused a regression on TrimSlice (Thierry
    Reding)

  - finish Aardvark conversion to host bridge IRQ mapping.  We missed
    Aardvark the first time around so it regressed (Thomas Petazzoni)


The following changes since commit b1f9e5e355e909000fcccfd2bc31f7c1ded358ab:

  ide: fix IRQ assignment for PCI bus order probing (2017-10-03 14:03:31 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.14-fixes-5

for you to fetch changes up to 407dae1e4415acde2d9f48bb76361893c4653756:

  PCI: aardvark: Move to struct pci_host_bridge IRQ mapping functions (2017-10-10 21:17:43 -0500)

----------------------------------------------------------------
pci-v4.14-fixes-5

----------------------------------------------------------------
Thierry Reding (1):
      Revert "PCI: tegra: Do not allocate MSI target memory"

Thomas Petazzoni (1):
      PCI: aardvark: Move to struct pci_host_bridge IRQ mapping functions

 drivers/pci/host/pci-aardvark.c |  2 ++
 drivers/pci/host/pci-tegra.c    | 22 ++++++----------------
 2 files changed, 8 insertions(+), 16 deletions(-)
