Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40105 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752531AbeDBQT4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Apr 2018 12:19:56 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 0/7] DPC updates
Date: Mon,  2 Apr 2018 10:21:56 -0600
Message-Id: <20180402162203.3370-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I am terribly sorry about the delay getting this back to you. I had some
scheduling issues with test equipment and other unrelated conflicts.

I added Oza's legacy IRQ fix into this series, as I didn't see this
staged yet, and it really does fix some issues as well as provide the
means to clean up other parts.

I'm sending this later than I intended, but hoping you might see a way
to including this to 4.17. I can rebase to 'next' where the file is
renamed to 'dpc.c'.

Keith Busch (6):
  PCI/DPC: Enable ERR_COR
  PCI/DPC: Leave interrupts enabled while handling event
  PCI/DPC: Defer event handling to work queue
  PCI/DPC: Remove rp_pio_status from dpc struct
  PCI/AER: API for obtaining AER information
  PCI/DPC: Print AER status in DPC event handling

Oza Pawandeep (1):
  PCI/DPC: Fix PCI legacy interrupt acknowledgement

 drivers/pci/pcie/aer/aerdrv.h      |   1 +
 drivers/pci/pcie/aer/aerdrv_core.c |   8 +--
 drivers/pci/pcie/pcie-dpc.c        | 106 +++++++++++++++++--------------------
 include/uapi/linux/pci_regs.h      |   1 +
 4 files changed, 55 insertions(+), 61 deletions(-)

-- 
2.14.3
