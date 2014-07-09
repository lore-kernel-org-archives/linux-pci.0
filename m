Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Jul 2014 16:58:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: [GIT PULL] PCI fixes for v3.16
Message-ID: <20140709225826.GA8252@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Just a fix for the device reset path and an email address update.

Bjorn


The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v3.16-fixes-1

for you to fetch changes up to bf177a1eb6d106ba195de86734392d43dfbef702:

  MAINTAINERS: Update mx6 PCI driver maintainer's email (2014-07-05 15:27:42 -0600)

----------------------------------------------------------------
PCI updates for v3.16:

  Virtualization
    - Fix "wait for pending transactions" for PCI AF reset (Alex Williamson)

  Miscellaneous
    - Update mx6 PCI driver maintainer email (Fabio Estevam)

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Fix unaligned access in AF transaction pending test

Fabio Estevam (1):
      MAINTAINERS: Update mx6 PCI driver maintainer's email

 MAINTAINERS       | 2 +-
 drivers/pci/pci.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)
