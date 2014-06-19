Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:50086 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757561AbaFSIau (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jun 2014 04:30:50 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 0/5] Cleanup for MSI
Date: Thu, 19 Jun 2014 16:29:34 +0800
Message-ID: <1403166574-7032-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Yijing Wang (5):
  PCI/MSI: Introduce msix_clear_and_set_ctrl() function
  PCI/MSI: Remove the unused function msi_enabled_mask()
  PCI/MSI: Cache Multiple Message Capable info in msi_desc
  PCI/MSI: MSI cleanup, msi_setup_entry()
  s390/MSI: Fix msi mask issue

 arch/s390/pci/pci.c |    2 +-
 drivers/pci/msi.c   |  129 +++++++++++++++++++++++++--------------------------
 include/linux/msi.h |    1 +
 3 files changed, 65 insertions(+), 67 deletions(-)


