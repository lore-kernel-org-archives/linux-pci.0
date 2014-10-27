Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:12053 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaJ0CCr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 26 Oct 2014 22:02:47 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <wangyijing@huawei.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH 0/3] xen MSI code clean up
Date: Mon, 27 Oct 2014 10:44:35 +0800
Message-ID: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Yijing Wang (3):
  x86/xen: Introduce a global flag to fix the MSI mask bug
  x86/xen: Revert "PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()"
  s390/MSI: Use __msi_mask_irq() instead of default_msi_mask_irq()

 arch/s390/pci/pci.c             |    4 ++--
 arch/x86/include/asm/x86_init.h |    3 ---
 arch/x86/kernel/x86_init.c      |   10 ----------
 arch/x86/pci/xen.c              |   15 +++------------
 drivers/pci/msi.c               |   29 ++++++++++++-----------------
 include/linux/msi.h             |    5 +++--
 6 files changed, 20 insertions(+), 46 deletions(-)

