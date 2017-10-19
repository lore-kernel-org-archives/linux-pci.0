Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbdJSXBE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Oct 2017 19:01:04 -0400
Subject: [PATCH v5 0/3] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service
 drivers
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Charles Chenxin <charles.chenxin@huawei.com>, linuxarm@huawei.com,
        Christoph Hellwig <hch@lst.de>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        linux-pci@vger.kernel.org
Date: Thu, 19 Oct 2017 18:01:02 -0500
Message-ID: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is based on Dongdong's series:
  v3: http://lkml.kernel.org/r/1507553167-27833-1-git-send-email-liudongdong3@huawei.com
  v4: http://lkml.kernel.org/r/1507719178-112556-1-git-send-email-liudongdong3@huawei.com

The main idea is to fix IRQ issues when removing and adding back a Root
Port.  The problem is that when we allocate, free, and reallocate MSI/MSI-X
vectors for the device, we may not get the same vectors the second time,
but we saved IRQs based on the first set of vectors.

---

Bjorn Helgaas (2):
      PCI/portdrv: Remove excessive comments
      PCI/portdrv: Compute MSI/MSI-X IRQ vectors after final allocation

Dongdong Liu (1):
      PCI/portdrv: Add #defines for AER and DPC Interrupt Message Number masks


 drivers/pci/pcie/portdrv_core.c |  162 ++++++++++++++++-----------------------
 include/uapi/linux/pci_regs.h   |    2 
 2 files changed, 70 insertions(+), 94 deletions(-)
