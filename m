Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751831AbdJ0URZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Oct 2017 16:17:25 -0400
Date: Fri, 27 Oct 2017 15:17:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Meelis Roos <mroos@linux.ee>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: [GIT PULL] PCI fixes for v4.14
Message-ID: <20171027201721.GA9235@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - move alpha PCI IRQ map/swizzle functions out of initdata to fix
    regression from PCI core IRQ mapping changes (Lorenzo Pieralisi)


The following changes since commit 407dae1e4415acde2d9f48bb76361893c4653756:

  PCI: aardvark: Move to struct pci_host_bridge IRQ mapping functions (2017-10-10 21:17:43 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.14-fixes-6

for you to fetch changes up to 814eae5982cc55988f642f7f1d10eaf340845c00:

  alpha/PCI: Move pci_map_irq()/pci_swizzle() out of initdata (2017-10-26 11:53:38 -0500)

----------------------------------------------------------------
pci-v4.14-fixes-6

----------------------------------------------------------------
Lorenzo Pieralisi (1):
      alpha/PCI: Move pci_map_irq()/pci_swizzle() out of initdata

 arch/alpha/kernel/sys_alcor.c     |  4 ++--
 arch/alpha/kernel/sys_cabriolet.c | 12 ++++++------
 arch/alpha/kernel/sys_dp264.c     | 20 ++++++++++----------
 arch/alpha/kernel/sys_eb64p.c     |  4 ++--
 arch/alpha/kernel/sys_eiger.c     |  4 ++--
 arch/alpha/kernel/sys_miata.c     |  6 +++---
 arch/alpha/kernel/sys_mikasa.c    |  4 ++--
 arch/alpha/kernel/sys_nautilus.c  |  2 +-
 arch/alpha/kernel/sys_noritake.c  |  6 +++---
 arch/alpha/kernel/sys_rawhide.c   |  4 ++--
 arch/alpha/kernel/sys_ruffian.c   |  6 +++---
 arch/alpha/kernel/sys_rx164.c     |  4 ++--
 arch/alpha/kernel/sys_sable.c     | 10 +++++-----
 arch/alpha/kernel/sys_sio.c       |  8 ++++----
 arch/alpha/kernel/sys_sx164.c     |  4 ++--
 arch/alpha/kernel/sys_takara.c    |  6 +++---
 arch/alpha/kernel/sys_wildfire.c  |  4 ++--
 17 files changed, 54 insertions(+), 54 deletions(-)
