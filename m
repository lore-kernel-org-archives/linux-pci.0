Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:27688 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbaGDIQX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jul 2014 04:16:23 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 0/5] Cleanup for MSI
Date: Fri, 4 Jul 2014 16:14:27 +0800
Message-ID: <1404461667-9636-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset is based Bjorn's pci/msi branch.

v1->v2: Modify msi_setup_entry() return type suggested by Bjorn.
        Post a new s390 MSI patch to fix and simplify MSI code.
		Post another 3 cleanup patch for MSI.

Patch 2(s390/MSI) just compiled fine, no real machine test.

Yijing Wang (5):
  PCI/MSI: MSI cleanup, msi_setup_entry()
  s390/MSI: Use standard mask and unmask funtions
  PCI/MSI: Remove unused function msi_remove_pci_irq_vectors()
  PCI/MSI: Retrieve first MSI irq from msi_desc rather than pci_dev
  PCI/MSI: Clean up the useless code

 arch/s390/pci/pci.c |   49 ++++------------------------------
 drivers/pci/msi.c   |   72 ++++++++++++++++++++++++---------------------------
 include/linux/pci.h |    2 -
 3 files changed, 40 insertions(+), 83 deletions(-)


