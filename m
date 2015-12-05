Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:38675 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbbLEAgQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2015 19:36:16 -0500
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v7 0/7] PCI: hv: New paravirtual PCI front-end for Hyper-V VMs
Date: Sat,  5 Dec 2015 00:35:59 +0000
Message-Id: <1449275767-1510-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This version of the patch series incorporates feedback from Gerry Liu.

First, export functions that allow correlating Hyper-V virtual processors
and Linux cpus, along with the means for invoking a hypercall that targets
interrupts at chosen vectors on specific cpus.

Second, mark various parts of IRQ domain related code as exported, so that
this PCI front-end can implement an IRQ domain as part of a module.  (The
alternative would be to pull all tyhis into the kernel, which would pull
in a lot of other Hyper-V related code, as this IRQ domain depends on
vmbus.ko.)

Third, modify PCI so that new root PCI buses can be marked with an associated
fwnode_handle, and so that root PCI buses can look up their associated IRQ
domain by that handle.

Fourth, introduce a new driver, hv_pcifront, which exposes root PCI buses in
a Hyper-V VM.  These root PCI buses expose real PCIe device, or PCI Virtual
Functions.

Jake Oshins (7):
  drivers:hv: Export a function that maps Linux CPU num onto Hyper-V
    proc num
  drivers:hv: Export hv_do_hypercall()
  PCI: Make it possible to implement a PCI MSI IRQ Domain in a module.
  PCI: Add fwnode_handle to pci_sysdata
  PCI: irqdomain: Look up IRQ domain by fwnode_handle
  drivers:hv: Define the channel type of Hyper-V PCI Express
    pass-through
  PCI: hv: New paravirtual PCI front-end for Hyper-V VMs

 MAINTAINERS                    |    1 +
 arch/x86/include/asm/msi.h     |    6 +
 arch/x86/include/asm/pci.h     |   15 +
 arch/x86/kernel/apic/msi.c     |    8 +-
 arch/x86/kernel/apic/vector.c  |    2 +
 drivers/hv/hv.c                |   20 +-
 drivers/hv/hyperv_vmbus.h      |    2 +-
 drivers/hv/vmbus_drv.c         |   17 +
 drivers/pci/Kconfig            |    7 +
 drivers/pci/host/Makefile      |    1 +
 drivers/pci/host/hv_pcifront.c | 2241 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/msi.c              |    4 +
 drivers/pci/probe.c            |   14 +
 include/asm-generic/pci.h      |    4 +
 include/linux/hyperv.h         |   14 +
 kernel/irq/chip.c              |    1 +
 kernel/irq/irqdomain.c         |    4 +
 17 files changed, 2347 insertions(+), 14 deletions(-)
 create mode 100644 drivers/pci/host/hv_pcifront.c

-- 
1.9.1

