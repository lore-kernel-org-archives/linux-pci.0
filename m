Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:60870 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbaGHCHQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jul 2014 22:07:16 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>,
	<linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 0/6] Cleanup for MSI
Date: Tue, 8 Jul 2014 10:07:01 +0800
Message-ID: <1404785221-6428-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset is based Bjorn's pci/msi branch.

v2->v3: Fix the misuse of MSI and MSIX default mask functions.
		Integrate "Use irq_get_msi_desc() to simplify code" into patchset.
v1->v2: Modify msi_setup_entry() return type suggested by Bjorn.
		Post a new s390 MSI patch to fix and simplify MSI code.
		Post another 3 cleanup patch for MSI.

Yijing Wang (6):
  PCI/MSI: MSI cleanup, msi_setup_entry()
  s390/MSI: Use standard mask and unmask funtions
  PCI/MSI: Remove unused function msi_remove_pci_irq_vectors()
  PCI/MSI: Retrieve first MSI irq from msi_desc rather than pci_dev
  PCI/MSI: Clean up the useless code
  PCI/MSI: Use irq_get_msi_desc() to simplify code

 arch/s390/pci/pci.c |   49 ++++--------------------------
 drivers/pci/msi.c   |   84 +++++++++++++++++++++++---------------------------
 include/linux/pci.h |    2 -
 3 files changed, 45 insertions(+), 90 deletions(-)


