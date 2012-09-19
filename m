Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:52768 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab2ISCmJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 22:42:09 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>,
	Chen Gong <gong.chen@linux.intel.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: =?utf-8?q?=5BPATCH=200/6=5D=20fix=20aer=5Finject=20bug=20while=20doing=20pci=20hot-plug?=
Date: Wed, 19 Sep 2012 10:40:36 +0800
Message-ID: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v2--->v3
1、find the pci_ops of nearest parent bus in patch 1;
2、introduce pci_bus_ops_get to avoid race condition window in aer_inject_exit;
3、scan the root bus for cleaning untracked pci_ops_aer instead of scan all pci bus as Huang Ying suggestion;
4、remove unused code pci_bus_ops_pop;

Yijing Wang (6):
  PCI/AER: fix pci_ops return NULL when hotplug a pci bus doing aer
    error inject
  PCI/AER: introduce pci_bus_ops_get() function to avoid a small race
    condition window
  PCI/AER: clean all untracked pci_ops_aer when rmmod aer_inject
  PCI/AER: clean pci_bus_ops when related pci bus was removed
  PCI/AER: introduce pci_bus_ops_free to free pci_bus_ops
  PCI/AER: clean unused code pci_bus_ops_pop

 drivers/pci/pcie/aer/aer_inject.c |  149 ++++++++++++++++++++++++++++++++-----
 1 files changed, 131 insertions(+), 18 deletions(-)


