Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdBANls (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2017 08:41:48 -0500
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-pci@vger.kernel.org
Subject: convert the PCIe portdrv to pci_alloc_irq_vectors
Date: Wed,  1 Feb 2017 14:41:41 +0100
Message-Id: <1485956503-8194-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

this series has a small tweak to pci_alloc_irq_vectors and the conversion
of the PCIe portdrv to use pci_alloc_irq_vectors.  Note that I could not
actually find a root port that uses MSI-X vectors - mine all either seem
to have no interrupts at all if they don't offer any interesting services
or a use a single MSI vector if hotplug capable, so the somewhat hairy
part of the patch isn't actually tested.  If anyone has a chance to
test it (or carefully review it) that would be great.
