Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 5 Jun 2015 12:04:21 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [GIT PULL] PCI fixes for v4.1
Message-ID: <20150605170421.GM3631@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here's a MAINTAINERS update and two fixes for the bus sizing code that was
updated by Wei Yang's powerpc SR-IOV support (this was merged via the
powerpc tree during the v4.1 merge window).

Bjorn


The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.1-fixes-2

for you to fetch changes up to 552bc94ebeeb189d0ac682dae95cf05e6b72d7fd:

  PCI: Preserve resource size during alignment reordering (2015-06-01 17:56:32 -0500)

----------------------------------------------------------------
PCI updates for v4.1:

  Resource management
    - Fix IOV sorting by alignment (Wei Yang)
    - Preserve resource size during alignment reordering (Yinghai Lu)

  Miscellaneous
    - MAINTAINERS: Add Pratyush for SPEAr13xx and DesignWare PCIe (Pratyush Anand)

----------------------------------------------------------------
Pratyush Anand (1):
      MAINTAINERS: Add Pratyush Anand as SPEAr13xx and DesignWare PCIe maintainer

Wei Yang (1):
      PCI: Fix IOV resource sorting by alignment requirement

Yinghai Lu (1):
      PCI: Preserve resource size during alignment reordering

 MAINTAINERS             | 4 +++-
 drivers/pci/setup-bus.c | 9 ++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)
