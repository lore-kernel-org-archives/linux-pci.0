Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4652 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab2IUDpz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2012 23:45:55 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v4 0/5] Fix aer_inject bug caused by pci hot-plug
Date: Fri, 21 Sep 2012 11:44:11 +0800
Message-ID: <1348199056-7696-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series of patch mainly to fix the aer_inject bug described as below:

-+-[0000:40]-+-00.0-[0000:41]--
 |           +-01.0-[0000:42]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection
 |           +-03.0-[0000:43]----00.0  LSI Logic / Symbios Logic SAS1064ET PCI-Express Fusion-MPT SAS
 |           +-04.0-[0000:44]--
 |           +-05.0-[0000:45]--
 |           +-07.0-[0000:46-49]----00.0-[0000:47-49]--+-02.0-[0000:48]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                                         |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection
 |           |                                         \-04.0-[0000:49]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                                                           \-00.1  Intel Corporation 82576 Gigabit Network Connection

my steps:
1)modprobe aer_inject
2)inject aer errors to pcie device 0000:48:00.0
3)modprobe pciehp
4)hot remove Network Card in slot(port 0000:40:07.0)
5)hot add Network Card in slot(port 0000:40:07.0)
6)system panic

in step 2) the pci_ops of bus 0000:48 and bus 0000:40 will be assigned to pci_ops_aer
in step 5) the pci_ops of the newly created bus 0000:46 will be assigned to pci_ops_aer(inherited by parent pci_ops),
but this pci_ops(0000:46) is not tracked in pci_bus_ops_list in aer_inject module. So every access to pci_config space
by pci_ops of 0000:46 will cause system panic, Since pci_ops_aer cannot find its original pci_ops, thus , a NULL pci_ops return;

The first patch fix this bug by finding parent pci_ops(tracked in pci_ops_list) instead of returning NULL in step 5);
The second patch fix a small race condition window in aer_inject_exit;
The Third patch to find and clean all untracked pci_ops_aer in system when aer_inject module exit
The rest two patch mainly about to clean bus_ops;

Yijing Wang (5):
  PCI/AER: Fix pci_ops return NULL in pci_read/write_aer
  PCI/AER: introduce pci_bus_ops_get() to avoid a small race condition
    window
  PCI/AER: clean all untracked pci_ops_aer when rmmod aer_inject
  PCI/AER: clean pci_bus_ops when related pci bus was removed
  PCI/AER: free pci_bus_ops_list and remove pci_bus_ops_pop

 drivers/pci/pcie/aer/aer_inject.c |  127 ++++++++++++++++++++++++++++++++-----
 1 files changed, 112 insertions(+), 15 deletions(-)


