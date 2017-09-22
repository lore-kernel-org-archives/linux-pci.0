Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbdIVOEv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Sep 2017 10:04:51 -0400
Date: Fri, 22 Sep 2017 09:04:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steve French <smfrench@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org
Subject: [GIT PULL] PCI fixes for v4.14
Message-ID: <20170922140449.GA15970@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix endpoint "end of test" interrupt issue (introduced in v4.14-rc1)
    (John Keeping)

  - fix MIPS use-after-free map_irq() issue (introduced in v4.14-rc1)
    (Lorenzo Pieralisi)


N.B.  The MIPS tree contains 8eba3651f1da ("MIPS: PCI: fix pcibios_map_irq
section mismatch"), a subset of the MIPS fix here.  I'm sending you this
one because (a) it's a little more comprehensive and (b) the problem was
with 04c81c7293df ("MIPS: PCI: Replace pci_fixup_irqs() call with host
bridge IRQ mapping hooks"), which was merged via the PCI tree.


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.14-fixes-2

for you to fetch changes up to 749aaf3372b8b56b8743c3e27700d64c8bd06921:

  PCI: endpoint: Use correct "end of test" interrupt (2017-09-20 13:56:06 -0500)

----------------------------------------------------------------
pci-v4.14-fixes-2

----------------------------------------------------------------
John Keeping (1):
      PCI: endpoint: Use correct "end of test" interrupt

Lorenzo Pieralisi (1):
      MIPS: PCI: Move map_irq() hooks out of initdata

 arch/mips/ath79/pci.c                         | 12 ++++++------
 arch/mips/pci/fixup-capcella.c                |  4 ++--
 arch/mips/pci/fixup-cobalt.c                  |  8 ++++----
 arch/mips/pci/fixup-emma2rh.c                 |  4 ++--
 arch/mips/pci/fixup-fuloong2e.c               |  2 +-
 arch/mips/pci/fixup-ip32.c                    |  4 ++--
 arch/mips/pci/fixup-jmr3927.c                 |  2 +-
 arch/mips/pci/fixup-lantiq.c                  |  2 +-
 arch/mips/pci/fixup-lemote2f.c                |  4 ++--
 arch/mips/pci/fixup-loongson3.c               |  2 +-
 arch/mips/pci/fixup-malta.c                   |  4 ++--
 arch/mips/pci/fixup-mpc30x.c                  |  6 +++---
 arch/mips/pci/fixup-pmcmsp.c                  |  8 ++++----
 arch/mips/pci/fixup-rbtx4927.c                |  2 +-
 arch/mips/pci/fixup-rbtx4938.c                |  2 +-
 arch/mips/pci/fixup-sni.c                     | 12 ++++++------
 arch/mips/pci/fixup-tb0219.c                  |  2 +-
 arch/mips/pci/fixup-tb0226.c                  |  2 +-
 arch/mips/pci/fixup-tb0287.c                  |  2 +-
 arch/mips/pci/pci-alchemy.c                   |  2 +-
 arch/mips/pci/pci-bcm47xx.c                   |  2 +-
 arch/mips/pci/pci-lasat.c                     |  2 +-
 arch/mips/pci/pci-mt7620.c                    |  2 +-
 arch/mips/pci/pci-octeon.c                    |  5 ++---
 arch/mips/pci/pci-rt2880.c                    |  2 +-
 arch/mips/pci/pci-rt3883.c                    |  2 +-
 arch/mips/pci/pci-tx4938.c                    |  2 +-
 arch/mips/pci/pci-tx4939.c                    |  4 ++--
 arch/mips/pci/pci-xlp.c                       |  2 +-
 arch/mips/pci/pci-xlr.c                       |  2 +-
 arch/mips/pci/pcie-octeon.c                   |  3 +--
 arch/mips/txx9/generic/pci.c                  |  8 ++++++--
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
 33 files changed, 68 insertions(+), 67 deletions(-)
