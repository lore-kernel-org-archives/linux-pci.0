Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36393 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbbIKXWG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2015 19:22:06 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH 0/6] PCI: generic: Misc. bug fixes and enhanced support for MSI.
Date: Fri, 11 Sep 2015 16:21:53 -0700
Message-Id: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

While using the pci-host-generic driver to add PCI support for the
Cavium ThunderX processors, several bugs were discovered.  We also
need the ability to specify a per-bus MSI controller, so support for
that was added.

David Daney (6):
  PCI: Make global and export pdev_fixup_irq().
  PCI: generic: Only fixup irqs for bus we are creating.
  PCI: generic: Quit clobbering our pci_ops.
  PCI: generic: Correct, and avoid overflow, in bus_max calculation.
  PCI: generic: Pass proper starting bus number to pci_scan_root_bus().
  PCI: generic: Allow bus default MSI controller to be specified.

 .../devicetree/bindings/pci/host-generic-pci.txt   |  5 ++
 drivers/pci/host/pci-host-generic.c                | 55 +++++++++++++++-------
 drivers/pci/setup-irq.c                            |  7 +--
 include/linux/pci.h                                |  3 ++
 4 files changed, 50 insertions(+), 20 deletions(-)

-- 
1.7.11.7

