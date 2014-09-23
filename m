Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:53416 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbaIWFDQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 01:03:16 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 0/9] Some cleanup for MSI code
Date: Tue, 23 Sep 2014 13:27:21 +0800
Message-ID: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v2->v3: Split into several patches for better readability.
        Add document description for msi_bus attribute in 
		Documentation/ABI/testing/sysfs-bus-pci.
v1->v2: Rebased it on 3.17-rc1, and dropped a incorrect patch.

Yijing Wang (9):
  PCI/MSI: Clean up the kobject in struct msi_desc
  PCI/MSI: Remove msi_attrib->pos in struct msi_desc
  PCI/MSI: Change msi_bus attribute to support enable/disable MSI for
    EP
  MSI: Use __get_cached_msi_msg() instead of get_cached_msi_msg()
  PCI/MSI: Remove unused function get_cached_msi_msg()
  PCI/MSI: Rename __get_cached_msi_msg() to get_cached_msi_msg()
  MSI/powerpc: Use __read_msi_msg() instead of read_msi_msg()
  PCI/MSI: Remove unused function read_msi_msg()
  PCI/MSI: Rename __read_msi_msg() to read_msi_msg()

 Documentation/ABI/testing/sysfs-bus-pci |    9 +++++++++
 arch/ia64/kernel/msi_ia64.c             |    2 +-
 arch/ia64/sn/kernel/msi_sn.c            |    4 ++--
 arch/mips/pci/msi-octeon.c              |    6 +++---
 arch/powerpc/platforms/pseries/msi.c    |    2 +-
 arch/x86/kernel/apic/io_apic.c          |    2 +-
 arch/x86/pci/xen.c                      |    2 +-
 drivers/pci/host/pcie-designware.c      |    2 +-
 drivers/pci/msi.c                       |   31 ++-----------------------------
 drivers/pci/pci-sysfs.c                 |   12 ++++++------
 include/linux/msi.h                     |    9 ++-------
 11 files changed, 29 insertions(+), 52 deletions(-)

