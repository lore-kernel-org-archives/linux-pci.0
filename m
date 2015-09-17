Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33849 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbIQWCU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 18:02:20 -0400
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
Subject: [PATCH v2 0/5] PCI: generic: Misc. bug fixes
Date: Thu, 17 Sep 2015 15:02:07 -0700
Message-Id: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

While using the pci-host-generic driver to add PCI support for the
Cavium ThunderX processors, several bugs were discovered.  This patch
set fixes the bugs, a follow-on set will add the ThunderX support.

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

 .../devicetree/bindings/pci/host-generic-pci.txt   |  4 ++-
 drivers/pci/host/pci-host-generic.c                | 38 ++++++++++++----------
 drivers/pci/setup-irq.c                            | 30 +++++++++++++++++
 include/linux/pci.h                                |  4 +++
 4 files changed, 58 insertions(+), 18 deletions(-)

-- 
1.9.1

