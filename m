Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:53450 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbaHVHpc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 03:45:32 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 0/5] Some cleanup for MSI code
Date: Fri, 22 Aug 2014 16:07:55 +0800
Message-ID: <1408694880-8260-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is collection of two cleanup patchset,
http://marc.info/?l=linux-pci&m=140807095026813&w=2 and
http://marc.info/?l=linux-pci&m=140633779729162&w=2

I rebased it on 3.17-rc1, and dropped a incorrect patch.

Yijing Wang (5):
  PCI/MSI: Clean up the kobject in struct msi_desc
  PCI/MSI: Remove msi_attrib->pos in struct msi_desc
  PCI/MSI: Change msi_bus attribute to support enable/disable MSI for
    EP
  MSI: Use __get_cached_msi_msg() instead of get_cached_msi_msg()
  MSI: Use __read_msi_msg() instead of read_msi_msg()

 arch/ia64/kernel/msi_ia64.c          |    2 +-
 arch/ia64/sn/kernel/msi_sn.c         |    4 ++--
 arch/mips/pci/msi-octeon.c           |    6 +++---
 arch/powerpc/platforms/pseries/msi.c |    2 +-
 arch/x86/kernel/apic/io_apic.c       |    2 +-
 arch/x86/pci/xen.c                   |    2 +-
 drivers/pci/host/pcie-designware.c   |    2 +-
 drivers/pci/msi.c                    |   31 ++-----------------------------
 drivers/pci/pci-sysfs.c              |   12 ++++++------
 include/linux/msi.h                  |    9 ++-------
 10 files changed, 20 insertions(+), 52 deletions(-)

