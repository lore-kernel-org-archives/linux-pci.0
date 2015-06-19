Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:8875 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbbFSICO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 04:02:14 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 0/3] Trivial pci hotplug changes
Date: Fri, 19 Jun 2015 15:57:43 +0800
Message-ID: <1434700666-6346-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Yijing Wang (3):
  PCI: Use "slot" and "pci_slot" for struct hotplug_slot and struct
    pci_slot
  PCI: Simplify pcie_poll_cmd()
  PCI: Use usleep_range() instead of msleep() for better accuracy

 drivers/pci/hotplug/pci_hotplug_core.c |  122 ++++++++++++++++----------------
 drivers/pci/hotplug/pciehp_hpc.c       |   14 ++---
 2 files changed, 66 insertions(+), 70 deletions(-)

