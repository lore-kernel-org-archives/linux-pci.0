Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:59070 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbbGQJUt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 05:20:49 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <rajatja@google.com>,
	<linux@roeck-us.net>, <rjw@rjwysocki.net>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 0/2] Fix a deadlock for aer and pciehp driver
Date: Fri, 17 Jul 2015 17:16:30 +0800
Message-ID: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yijing Wang (2):
  PCI: Use a local mutex instead of pci_bus_sem to avoid deadlock
  PCI: Lock pci_slot_mutex when traverse bus->slots

 arch/powerpc/kernel/pci_of_scan.c |    6 +-----
 arch/sparc/kernel/pci.c           |    6 +-----
 drivers/pci/probe.c               |    6 +-----
 drivers/pci/slot.c                |   26 +++++++++++++++++++++-----
 include/linux/pci.h               |    4 +++-
 5 files changed, 27 insertions(+), 21 deletions(-)

