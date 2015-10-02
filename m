Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH v4 0/5] PCI: generic: Misc. bug fixes/enhancements
Date: Fri,  2 Oct 2015 11:43:58 -0700
Message-Id: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

While using the pci-host-generic driver to add PCI support for the
Cavium ThunderX processors, several bugs were discovered.  This patch
set fixes the bugs, a follow-on set will add the ThunderX support.

Changes from v3:

  - Drop "PCI: generic: Claim device resources if PCI_PROBE_ONLY"

  - Add some Acked-by:

  - Add to explanation of "reg" property in host-generic-pci.txt.

  - Add error message if "reg" property is too big.

  - Use pointer to ops rather than make a copy.

Changes from v2:

  - Added " PCI: generic: Claim device resources if PCI_PROBE_ONLY"

Changes from v1:

  - "PCI: generic: Allow bus default MSI controller to be specified."
    patch was dropped as it is no longer necessary.

  - "PCI: Make global and export pdev_fixup_irq()." and "PCI: generic:
    Only fixup irqs for bus we are creating." were rewritten to move
    the support into a somewhat more generic form in setup-irq.c.

  - Add some clarifying text to host-generic-pci.txt

  - Add some Acked-by:


David Daney (5):
  PCI: Add pci_bus_fixup_irqs().
  PCI: generic: Only fixup irqs for bus we are creating.
  PCI: generic: Quit clobbering our pci_ops.
  PCI: generic: Correct, and avoid overflow, in bus_max calculation.
  PCI: generic: Pass proper starting bus number to pci_scan_root_bus().

 .../devicetree/bindings/pci/host-generic-pci.txt   |  6 +++-
 drivers/pci/host/pci-host-generic.c                | 42 +++++++++++++---------
 drivers/pci/setup-irq.c                            | 30 ++++++++++++++++
 include/linux/pci.h                                |  4 +++
 4 files changed, 65 insertions(+), 17 deletions(-)

-- 
1.9.1

