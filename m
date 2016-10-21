Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934814AbcJUPUX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Oct 2016 11:20:23 -0400
Date: Fri, 21 Oct 2016 10:20:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joao Pinto <jpmpinto@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [GIT PULL] PCI fixes for v4.9
Message-ID: <20161021152018.GA9007@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This includes:

  - Fix for a Layerscape driver issue that causes a use-before-set crash
  - Maintainer update for the Synopsis prototyping device driver

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.9-fixes-1

for you to fetch changes up to 02a1b8f4167eac709d269341f7c3c340984c28a6:

  PCI: designware-plat: Update author email address (2016-10-21 09:54:46 -0500)

----------------------------------------------------------------
pci-v4.9-fixes-1

----------------------------------------------------------------
Joao Pinto (2):
      PCI: designware-plat: Change maintainer to Jose Abreu
      PCI: designware-plat: Update author email address

Marc Zyngier (1):
      PCI: layerscape: Fix drvdata usage before assignment

 MAINTAINERS                             | 2 +-
 drivers/pci/host/pci-layerscape.c       | 2 +-
 drivers/pci/host/pcie-designware-plat.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
