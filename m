Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 25 Sep 2015 08:29:29 -0500
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [GIT PULL] PCI fixes for v4.3
Message-ID: <20150925132929.GA27521@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

These are fixes for things we merged for v4.3 (VPD, MSI, and bridge window
management), and a new Renesas R8A7794 SoC device ID.

Bjorn


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.3-fixes-1

for you to fetch changes up to de24c18c0faca5ebd618e1cb87f5489745e40475:

  PCI: rcar: Add R8A7794 support (2015-09-24 17:06:32 -0500)

----------------------------------------------------------------
PCI updates for v4.3:

  Resource management
    - Revert pci_read_bridge_bases() unification (Bjorn Helgaas)
    - Clear IORESOURCE_UNSET when clipping a bridge window (Bjorn Helgaas)

  MSI
    - Fix MSI IRQ domains for VFs on virtual buses (Alex Williamson)

  Renesas R-Car host bridge driver
    - Add R8A7794 support (Sergei Shtylyov)

  Miscellaneous
    - Fix devfn for VPD access through function 0 (Alex Williamson)
    - Use function 0 VPD only for identical functions (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (3):
      PCI/MSI: Fix MSI IRQ domains for VFs on virtual buses
      PCI: Fix devfn for VPD access through function 0
      PCI: Use function 0 VPD for identical functions, regular VPD for others

Bjorn Helgaas (2):
      PCI: Revert "PCI: Call pci_read_bridge_bases() from core instead of arch code"
      PCI: Clear IORESOURCE_UNSET when clipping a bridge window

Sergei Shtylyov (1):
      PCI: rcar: Add R8A7794 support

 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |  3 ++-
 arch/alpha/kernel/pci.c                            |  7 +++++-
 arch/frv/mb93090-mb00/pci-vdk.c                    |  2 ++
 arch/ia64/pci/pci.c                                |  5 ++--
 arch/microblaze/pci/pci-common.c                   |  9 +++++++-
 arch/mips/pci/pci.c                                |  6 +++++
 arch/mn10300/unit-asb2305/pci.c                    |  1 +
 arch/powerpc/kernel/pci-common.c                   |  8 ++++++-
 arch/x86/pci/common.c                              |  1 +
 arch/xtensa/kernel/pci.c                           |  4 ++++
 drivers/parisc/dino.c                              |  3 +++
 drivers/parisc/lba_pci.c                           |  1 +
 drivers/pci/access.c                               | 27 ++++------------------
 drivers/pci/bus.c                                  |  2 ++
 drivers/pci/host/pci-rcar-gen2.c                   |  1 +
 drivers/pci/probe.c                                | 23 +++++++++---------
 drivers/pci/quirks.c                               | 20 ++++++++++++++--
 17 files changed, 80 insertions(+), 43 deletions(-)
