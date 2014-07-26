Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:60987 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbaGZBXM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jul 2014 21:23:12 -0400
From: <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 0/3] trivial changes for MSI
Date: Sat, 26 Jul 2014 09:48:33 +0800
Message-ID: <1406339316-20163-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yijing Wang <wangyijing@huawei.com>

Yijing Wang (3):
  PCI/MSI: Clean up the kobject in struct msi_desc
  PCI/MSI: Remove msi_desc->msi_attrib.pos
  PCI/MSI: Refactor msi_bus to support EP enable/disable MSI

 arch/mips/pci/msi-octeon.c         |    6 +++---
 drivers/pci/host/pcie-designware.c |    2 +-
 drivers/pci/msi.c                  |   13 -------------
 drivers/pci/pci-sysfs.c            |   12 ++++++------
 include/linux/msi.h                |    3 ---
 5 files changed, 10 insertions(+), 26 deletions(-)

