Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:27357 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab3HANHL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 09:07:11 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v4 0/6] Use PCI Serial Number to identify device change
Date: Thu, 1 Aug 2013 21:06:23 +0800
Message-ID: <1375362389-26096-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v3->v4: introudce PCI VPD Sn support suggested by Bjorn, and other rework things.
		
v2->v3: add a wrap function pci_dsn_init, fix other typo error and git am error.
		Thanks for Don Dutile and Paul Bolle 's review,comments and test.
v1->v2: Modify pci_get_dsn to pci_device_serial_number,
	    power off slot before remove the old device during resume to avoid
		old .remove() method to touch new hardware.
		Fix other typo and fail check problems.
		split the list_empty() guard into new patch.
	    Thanks for Bjorn's review and comments.

This series applied to Bjorn's pci-next branch.

Yijing Wang (6):
  PCI,pciehp: avoid add a device already exist before suspend during
    resume
  PCI: introduce PCIe Device Serial Number Capability support
  PCI: Introduce Vital Product Data Serial Number capability support
  PCI: add pci_serial_number_changed() for device change identification
  PCI: add inspection of device change in pci_scan_single_device
  PCI,pciehp: identify device change during suspend

 drivers/pci/access.c              |   13 +-----
 drivers/pci/hotplug/pciehp_core.c |   40 +++++++++++++++++--
 drivers/pci/pci.c                 |   77 +++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h                 |   14 ++++++-
 drivers/pci/probe.c               |    4 ++
 drivers/pci/vpd.c                 |   70 +++++++++++++++++++++++++++++++++
 include/linux/pci.h               |    4 ++
 7 files changed, 207 insertions(+), 15 deletions(-)


