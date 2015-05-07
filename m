Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26433 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbbEGDKp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 May 2015 23:10:45 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: [RFC 0/4] Introduce a mechanism to allocate PCI IRQ on demand
Date: Thu,  7 May 2015 11:12:50 +0800
Message-Id: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set introduces a mechanism to allocate PCI IRQ on demand and
free it when not used anymore by hooking pci_device_probe() and
pci_device_remove().

It will be used to track IOAPIC pin usage on x86 so we could support
IOAPIC hot-removal.

The patch set passes Fengguang's 0day test suite and is available at:
https://github.com/jiangliu/linux.git pci_irq_v1

Thanks!
Gerry

Jiang Liu (4):
  PCI: Add hooks to allocate/free IRQ resources when binding/unbinding
    driver
  PCI, MSI: Optionally free legacy PCI IRQ when enabling MSI/MSI-X
  PCI, x86: Allocate PCI IRQ on demand and free it when not used
    anymore
  PCI: Introduce helpers to manage pci_dev->irq and
    pci_dev->irq_managed

 arch/x86/include/asm/pci_x86.h |    2 --
 arch/x86/pci/common.c          |   20 +++++++++-----------
 arch/x86/pci/intel_mid_pci.c   |    9 ++++++---
 arch/x86/pci/irq.c             |   23 ++++-------------------
 drivers/acpi/pci_irq.c         |   17 ++++-------------
 drivers/pci/msi.c              |    6 +++++-
 drivers/pci/pci-driver.c       |   33 +++++++++++++++++++++++----------
 include/linux/pci.h            |   19 +++++++++++++++++++
 8 files changed, 70 insertions(+), 59 deletions(-)

-- 
1.7.10.4

