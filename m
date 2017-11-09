Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753041AbdKIX6U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Nov 2017 18:58:20 -0500
Date: Thu, 9 Nov 2017 17:58:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <stephen.bates@microsemi.com>
Subject: [GIT PULL] PCI fixes for v4.14
Message-ID: <20171109235818.GA14817@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - update MAINTAINERS for HiSilicon, Microsemi Switchtec, and native host
    bridge drivers (Gabriele Paoloni, Sebastian Andrzej Siewior)

Note that starting with changes intended for v4.16, Lorenzo Pieralisi will
maintain the drivers/pci/{dwc,endpoint,host} directories.  My intent is to
continue to merge those changes via my tree, so this should be transparent
to you.


The following changes since commit 814eae5982cc55988f642f7f1d10eaf340845c00:

  alpha/PCI: Move pci_map_irq()/pci_swizzle() out of initdata (2017-10-26 11:53:38 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.14-fixes-7

for you to fetch changes up to 6b7be529634bbfbf6395f23217a66d731fbed0a0:

  MAINTAINERS: Add Lorenzo Pieralisi for PCI host bridge drivers (2017-11-08 08:49:49 -0600)

----------------------------------------------------------------
pci-v4.14-fixes-7

----------------------------------------------------------------
Bjorn Helgaas (1):
      MAINTAINERS: Add Lorenzo Pieralisi for PCI host bridge drivers

Gabriele Paoloni (1):
      MAINTAINERS: Remove Gabriele Paoloni as HiSilicon PCI maintainer

Sebastian Andrzej Siewior (1):
      MAINTAINERS: Remove Stephen Bates as Microsemi Switchtec maintainer

 MAINTAINERS | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)
