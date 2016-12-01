Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756546AbcLAWuP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 17:50:15 -0500
Date: Thu, 1 Dec 2016 16:50:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [GIT PULL] PCI fixes for v4.9
Message-ID: <20161201225009.GA17792@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - Fix Read Completion Boundary setting, which fixes a boot failure on
    IBM x3850 with Mellanox MT27500 ConnectX-3
  - Update some MAINTAINERS entries and email addresses


The following changes since commit bc79c9851a76d76f269d9ef5150e180825650b67:

  PCI: VMD: Update filename to reflect move (2016-11-10 16:26:32 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v4.9-fixes-4

for you to fetch changes up to e42010d8207f9d15a605ceb8e321bcd9648071b0:

  PCI: Set Read Completion Boundary to 128 iff Root Port supports it (_HPX) (2016-11-23 16:23:55 -0600)

----------------------------------------------------------------
pci-v4.9-fixes-4

----------------------------------------------------------------
Fabio Estevam (2):
      MAINTAINERS: Update Richard Zhu's email address
      MAINTAINERS: Add devicetree binding to PCI i.MX6 entry

Joao Pinto (2):
      PCI: designware: Change maintainer to Joao Pinto
      PCI: designware-plat: Update author email

Johannes Thumshirn (2):
      PCI: Export pcie_find_root_port
      PCI: Set Read Completion Boundary to 128 iff Root Port supports it (_HPX)

 MAINTAINERS                             | 13 ++++---------
 drivers/pci/host/pcie-designware-plat.c |  2 +-
 drivers/pci/pcie/aer/aer_inject.c       | 14 --------------
 drivers/pci/probe.c                     | 28 +++++++++++++++++++++++++++-
 include/linux/pci.h                     | 14 ++++++++++++++
 5 files changed, 46 insertions(+), 25 deletions(-)
