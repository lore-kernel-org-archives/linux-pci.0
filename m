Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64079 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbcALUSN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 15:18:13 -0500
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv8 0/5] Driver for new "VMD" device 
Date: Tue, 12 Jan 2016 13:18:05 -0700
Message-Id: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Nothing changed; just contained in a single series, as requested.

Keith Busch (4):
  x86/IRQ: Export IRQ domain function for module use
  x86/PCI: Allow PCI domain specific dma ops
  PCI/AER: Use 32 bit int type domains
  x86/PCI: Initial commit for new VMD device driver

Liu Jiang (1):
  msi: Relax msi_domain_alloc() to support parentless MSI irqdomains

 MAINTAINERS                       |   6 +
 arch/x86/Kconfig                  |  13 +
 arch/x86/include/asm/device.h     |  10 +
 arch/x86/include/asm/hw_irq.h     |   5 +
 arch/x86/pci/Makefile             |   2 +
 arch/x86/pci/common.c             |  38 +++
 arch/x86/pci/vmd.c                | 699 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer/aer_inject.c |  16 +-
 kernel/irq/irqdomain.c            |   1 +
 kernel/irq/msi.c                  |   8 +-
 10 files changed, 787 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/pci/vmd.c

-- 
2.6.2.307.g37023ba

