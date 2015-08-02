Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:36636 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbbHBBGb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2015 21:06:31 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 0/4] New Paravirtual front-end for PCI in a Hyper-V VM
Date: Sun,  2 Aug 2015 00:54:45 +0000
Message-Id: <1438476889-19220-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch series exposes the primitives necessary for an interrupt domain
in a module and then introduces a new driver.  This driver exposes a root
PCI bus when running in a Hyper-V VM for each device which is passed through
to the VM from the physical host.

This patch series differs from an earlier patch series in that the way
interrupts are managed for the devices has been rewritten, this time to use
IRQ domains, which allows the patches to be applied to the linux-next tree.

Jake Oshins (4):
  drivers:hv: Export a function that maps Linux CPU num onto Hyper-V
    proc num
  drivers:hv: Define the channel type for Hyper-V PCI Express
    pass-through
  drivers:x86:pci: Make it possible to implement a PCI MSI IRQ Domain in
    a module.
  drivers:pci:hv: New paravirtual PCI front-end for Hyper-V VMs

 MAINTAINERS                    |    1 +
 arch/x86/kernel/apic/vector.c  |    2 +
 drivers/hv/vmbus_drv.c         |   17 +
 drivers/pci/Kconfig            |    7 +
 drivers/pci/host/Makefile      |    1 +
 drivers/pci/host/hv_pcifront.c | 2228 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/msi.c              |    1 +
 include/linux/hyperv.h         |   13 +
 kernel/irq/chip.c              |    1 +
 9 files changed, 2271 insertions(+)
 create mode 100644 drivers/pci/host/hv_pcifront.c

-- 
1.9.1

