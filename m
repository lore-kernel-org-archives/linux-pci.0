Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:11874 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbaKSGwG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Nov 2014 01:52:06 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>, <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	Liviu Dudau <liviu@dudau.co.uk>, Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 0/5] PCI scan interfaces clean up
Date: Wed, 19 Nov 2014 15:32:44 +0800
Message-ID: <1416382369-13587-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Yijing Wang (5):
  PCI: Rip out pci_bus_add_devices() from pci_scan_bus()
  PCI: Introduce pci_scan_bus_simple()
  PCI: Use pci_scan_bus_simple() in simple scene.
  PCI: Remove pci_scan_bus() and pci_scan_bus_parented()
  PCI: Rip out pci_bus_add_devices() from pci_scan_root_bus()

 arch/alpha/kernel/pci.c           |    2 ++
 arch/alpha/kernel/sys_nautilus.c  |    3 ++-
 arch/frv/mb93090-mb00/pci-vdk.c   |    6 ++++--
 arch/ia64/sn/kernel/io_init.c     |    1 +
 arch/m68k/coldfire/pci.c          |    3 ++-
 arch/microblaze/pci/pci-common.c  |    1 +
 arch/mips/pci/pci.c               |    1 +
 arch/mn10300/unit-asb2305/pci.c   |    5 ++++-
 arch/s390/pci/pci.c               |    2 +-
 arch/sh/drivers/pci/pci.c         |    1 +
 arch/sparc/kernel/leon_pci.c      |    1 +
 arch/sparc/kernel/pcic.c          |    5 ++++-
 arch/tile/kernel/pci.c            |    2 ++
 arch/tile/kernel/pci_gx.c         |    2 ++
 arch/unicore32/kernel/pci.c       |   15 +++++----------
 arch/x86/pci/common.c             |    1 +
 arch/xtensa/kernel/pci.c          |    2 ++
 drivers/pci/host/pci-xgene.c      |    1 +
 drivers/pci/hotplug/ibmphp_core.c |    7 +++++--
 drivers/pci/probe.c               |   26 ++------------------------
 drivers/pci/xen-pcifront.c        |    2 +-
 include/linux/pci.h               |    3 +--
 22 files changed, 46 insertions(+), 46 deletions(-)

