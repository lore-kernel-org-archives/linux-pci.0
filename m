Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36070 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbJBAuh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2015 20:50:37 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Frank Rowand <frowand.list@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH v4 0/4] MSI, of, irqchip/gicv3-its: Handle "msi-map" properties.
Date: Thu,  1 Oct 2015 17:50:21 -0700
Message-Id: <1443747025-9918-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

The first patch from Mark Rutland adds the OF device tree binding
description, which explains what we are attempting to do here.  For
MSI messages on GICv3 systems there is some side-band data that
accompanies the message, this data is specified in the OF device tree
"msi-map" property of the PCI host driver.

The second patch adds a parser to get the required information out of
the device tree.

The third patch creates the pci_msi_domain_get_msi_rid() function to
make it more convenient to generate the proper PCI/MSI requester id.

The final patch converts gicv3-its to use the new infrastructure.

Changes from v1: Factor out the device tree access code to a separate
function in drivers/of/irq.c

Changes from v2: Added the pci_msi_domain_get_msi_rid() patch to
generalize the support a bit more.

Changes from v3: Added Acked-by to 2/4.  Simplified and improved
pci_msi_domain_get_msi_rid() as suggested by Marc Zyngier in 3/4.  1/4
and 4/4 unchanged.

David Daney (3):
  of/irq: Add new function of_msi_map_rid()
  PCI/MSI:  Add helper function pci_msi_domain_get_msi_rid().
  irqchip/gic-v3-its:  Add handling of PCI requester id.

Mark Rutland (1):
  Docs: dt: Add PCI MSI map bindings

 Documentation/devicetree/bindings/pci/pci-msi.txt | 220 ++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its-pci-msi.c          |   4 +-
 drivers/of/irq.c                                  |  84 +++++++++
 drivers/pci/msi.c                                 |  30 +++
 include/linux/msi.h                               |   1 +
 include/linux/of_irq.h                            |   7 +
 6 files changed, 343 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt

-- 
1.9.1

