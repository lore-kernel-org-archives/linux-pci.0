Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10931 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744AbaIQQfk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Sep 2014 12:35:40 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 0/2] PCI: Remove dead code after DMA alias work
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org
Date: Wed, 17 Sep 2014 10:35:38 -0600
Message-ID: <20140917163412.21412.51729.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that IOMMU drivers have completed the DMA alias transition,
remove the left behind dead code.  Thanks,

Alex

---

Alex Williamson (2):
      PCI: Remove pci_get_dma_source()
      PCI: Remove pci_find_upstream_pcie_bridge()


 drivers/pci/quirks.c |   51 --------------------------------------------------
 drivers/pci/search.c |   34 ---------------------------------
 include/linux/pci.h  |   16 ----------------
 3 files changed, 101 deletions(-)
