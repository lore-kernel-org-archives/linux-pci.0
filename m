Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33399 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbcGJL5u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2016 07:57:50 -0400
From: Christoph Hellwig <hch@lst.de>
To: linux-pci@vger.kernel.org
Cc: agordeev@redhat.com
Subject: pci: automatic interrupt affinity for MSI/MSI-X capable devices
Date: Sun, 10 Jul 2016 20:57:41 +0900
Message-Id: <1468151866-7776-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series adds a new set of functions that transparently use the right
type of interrupt (MSI-X, MSI, legacy interrupt line) for a PCI device,
and if multiple vectors are supported automatically spreads the irq
routing to different CPUs.  This will allow the block layer (and hopefully
other consumers in the future) to use this information for mapping
queues to fit the interrupt affinity.

For the last patche to work you need to merge the irq/for-block branch of

   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

first.

There also is a git tree available at:

   git://git.infradead.org/users/hch/block.git pci-irq-spreading

Gitweb:

   http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/pci-irq-spreading

Changes since automatic interrupt affinity for MSI/MSI-X capable devices V3:
 - add PCI_IRQ_NOLEGACY flag
 - various error code fixes
 - reuse the pci_enable_msi(x)_range code instead of duplicating it
 - don't allocate msix_entry structures for the MSI-X case

