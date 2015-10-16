Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40981 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbbJPMNc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Oct 2015 08:13:32 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	David Daney <ddaney.cavm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PULL v2] msi-map support and msi-parent updates for 4.4
Date: Fri, 16 Oct 2015 13:13:26 +0100
Message-Id: <1444997606-12668-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

Here's a number of patches that introduce the msi-map DT property, and
puts it to a good use is the MSI layer. The msi-parent property also
gets reworked in order to cope with its sideband information
extension.

This replaces the previous PR which had a couple of merge issues.

Please pull!

Thanks,

	M.

The following changes since commit a71225e204f5ba8b41e7bb100ca37c074861d5b1:

  irqchip/gic-v2m: Add support for multiple MSI frames (2015-10-15 10:18:48 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/msi-map-4.4

for you to fetch changes up to 54fa97eeb9e22b47d68b67ee00987afa7fbc2178:

  PCI/MSI: Allow the MSI domain to be device-specific (2015-10-16 13:07:16 +0100)

----------------------------------------------------------------
Support for msi-map, and msi-parent update:

- New map-map property to describe the remapping of requester-ids,
  and the routing of MSIs to controllers
- New hooks to make MSI domains per-device if required
- Extension of msi-parent to provide sideband information
- Extensive documentation for both msi-map and msi-parent

----------------------------------------------------------------
David Daney (3):
      of/irq: Add new function of_msi_map_rid()
      PCI/MSI: Add helper function pci_msi_domain_get_msi_rid().
      irqchip/gic-v3-its: Add handling of PCI requester id.

Marc Zyngier (8):
      of/irq: Add support code for multi-parent version of "msi-parent"
      of/irq: Use of_msi_get_domain instead of open-coded "msi-parent" parsing
      PCI/MSI: Use of_msi_get_domain instead of open-coded "msi-parent" parsing
      irqchip/gic-v3-its: Parse new version of msi-parent property
      of/irq: Split of_msi_map_rid to reuse msi-map lookup
      of/irq: Use the msi-map property to provide device-specific MSI domain
      PCI: Add per-device MSI domain hook
      PCI/MSI: Allow the MSI domain to be device-specific

Mark Rutland (1):
      Docs: dt: Add PCI MSI map bindings

 Documentation/devicetree/bindings/pci/pci-msi.txt | 220 ++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its-pci-msi.c          |   4 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c     |  18 +-
 drivers/of/irq.c                                  | 185 +++++++++++++++++-
 drivers/pci/msi.c                                 |  49 +++++
 drivers/pci/of.c                                  |  13 +-
 drivers/pci/probe.c                               |  43 ++++-
 include/linux/msi.h                               |   7 +
 include/linux/of_irq.h                            |  23 +++
 9 files changed, 534 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt
