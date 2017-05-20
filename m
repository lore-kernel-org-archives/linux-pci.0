Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdETNVd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 May 2017 09:21:33 -0400
From: Christoph Hellwig <hch@lst.de>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PCI irq affinity fix for 4.12
Date: Sat, 20 May 2017 15:21:28 +0200
Message-Id: <20170520132129.16430-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Steve found a case where the !CONFIG_PCI_MSI stub for pci_alloc_irq_vectors
did the wrong thing when used with the newly converted xhci driver.  While
the PCI code has been wrong since day 1 the fact that a newly converted
drivers triggers it makes it a regression in this cycle.
