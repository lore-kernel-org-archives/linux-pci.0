Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53501 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031AbbJFRE0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Oct 2015 13:04:26 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Rob Herring <robh+dt@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>,
	David Daney <ddaney.cavm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 0/8] of: Handle multi-parent version of msi-parent & msi-map
Date: Tue,  6 Oct 2015 18:03:55 +0100
Message-Id: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we have a useable and documented version of msi-parent that
can deal with multiple parenting, we can properly handle it in the
kernel. This leads to a new OF helper, some rework in the PCI and
platform layers, as well as a small patch for the ITS driver, which is
the only thing in the kernel requirering this functionality so far.

On top of that, the msi-map property also offers a new feature, which
is that ability to have a per-device MSI controller (instead of having
a global one). The last four patches enable this.

These patches are on top of David Daney's series:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/373986.html

(of_msi_map_rid is a dependency), and has been tested on 4.3-rc3,
using both platform and PCI MSI devices.

* From the initial version
  - Dropped the of parsing patch
  - Built on top of David's series to reuse of_msi_map_rid
  - New per-device PCI/MSI domain assignment hook
  - Parse msi-map at bus probing time and populate the msi_domain field

Marc Zyngier (8):
  of/irq: Add support code for multi-parent version of "msi-parent"
  of/irq: Use of_msi_get_domain instead of open-coded "msi-parent"
    parsing
  PCI/MSI: Use of_msi_get_domain instead of open-coded "msi-parent"
    parsing
  irqchip/gic-v3-its: Parse new version of msi-parent property
  of/irq: Split of_msi_map_rid to reuse msi-map lookup
  of/irq: Use the msi-map property to provide device-specific MSI domain
  PCI: Add per-device MSI domain hook
  PCI/MSI: Allow the MSI domain to be device-specific

 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  18 ++-
 drivers/of/irq.c                              | 151 ++++++++++++++++++++------
 drivers/pci/msi.c                             |  17 +++
 drivers/pci/of.c                              |  13 +--
 drivers/pci/probe.c                           |  43 +++++++-
 include/linux/msi.h                           |   6 +
 include/linux/of_irq.h                        |  16 +++
 7 files changed, 214 insertions(+), 50 deletions(-)

-- 
2.1.4

