Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44175 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754377AbeFMGaH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 02:30:07 -0400
Received: by mail-pg0-f65.google.com with SMTP id p21-v6so755399pgd.11
        for <linux-pci@vger.kernel.org>; Tue, 12 Jun 2018 23:30:07 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patchV2 0/2] shpchp: no claim on pcie port device
Date: Wed, 13 Jun 2018 14:29:55 +0800
Message-Id: <1528871397-17917-1-git-send-email-kernelfans@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Linux Device Driver Model allows a physical device to be handled
by only a single driver. But at present, both shpchp and portdrv_pci
claim PCI_CLASS_BRIDGE_PCI. This cause problems, such as the wrong
shutdown seq. This series keeps shpchp driver away from pcie port device.

V1 -> V2:
implement the checking in the process of matching, instead of probing,
which is too late.

Pingfan Liu (2):
  pci: introduce an extra method for matching in pci_driver
  pci/shpchp: no claim on pcie port device

 drivers/pci/hotplug/shpchp_core.c | 13 +++++++++++++
 drivers/pci/pci-driver.c          |  4 ++++
 include/linux/pci.h               |  2 ++
 3 files changed, 19 insertions(+)

-- 
2.7.4
