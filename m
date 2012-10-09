Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:53019 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746Ab2JIDEL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2012 23:04:11 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <jiang.liu@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
	<linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 0/7] disable bridge ari forwarding after connected ari device hot removed
Date: Tue, 9 Oct 2012 11:03:17 +0800
Message-ID: <1349751804-7476-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_enable_ari will be called if an ARI pci device found, then set its bridge ARI Forwarding Enable
bit in Device Control 2 Register. But the bridge ARI Forwarding Enable bit will never be cleared
when an ARI device hot removed.

my steps:
1. Hot add an ARI pci device;
2. Hot remove the ARI pci device;
3. Hot add an non ARI pci device;

In this case, after setp 3, we could only find fun 0 of non ARI pci device because of its bridge ARI Forwarding Enable
bit set.

As PCIe Spec 2.0(6.13/441) recommends:
"Following a hot-plug event below a Downstream Port, it is strongly recommended that software
Clear the ARI Forwarding Enable bit in the Downstream Port until software determines that a
newly added component is in fact an ARI Device"

This series of patches fix this problem.

Yijing Wang (7):
  PCI: rework pci_enable_ari for support disable ari forwarding
  PCI, acpiphp: disable ARI forwarding for acpiphp
  PCI, pciehp: disable ARI forwarding for pciehp
  PCI, cpqphp: disable ARI forwarding for cpqphp
  PCI, shpchp: disable ARI forwarding for shpchp
  PCI, sgi: disable ARI forwarding for sgiphp
  PCI, ibmphp: disable ARI forwarding for ibmphp

 drivers/pci/hotplug/acpiphp_glue.c     |    1 +
 drivers/pci/hotplug/cpci_hotplug_pci.c |    1 +
 drivers/pci/hotplug/cpqphp_pci.c       |    1 +
 drivers/pci/hotplug/ibmphp_core.c      |    1 +
 drivers/pci/hotplug/pciehp_pci.c       |    1 +
 drivers/pci/hotplug/sgi_hotplug.c      |    1 +
 drivers/pci/hotplug/shpchp_pci.c       |    1 +
 drivers/pci/pci.c                      |   16 +++++++++++-----
 drivers/pci/pci.h                      |    2 +-
 drivers/pci/probe.c                    |    2 +-
 10 files changed, 20 insertions(+), 7 deletions(-)


