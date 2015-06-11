Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:15186 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971AbbFKQba (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jun 2015 12:31:30 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	mebersol@microsoft.com, haiyangz@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 0/6] Front-end driver for PCIe Pass-through on Hyper-V
Date: Thu, 11 Jun 2015 16:22:21 +0000
Message-Id: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch does some slight refactoring on the hv_vmbus driver and its
dependents and then introduces a new paravirtual front-end driver for PCI
which supports PCI Express devices passed through to a Linux guest running
in a Hyper-V VM.

To support this front-end, several new mechanisms are introduced:

1 - A common way of finding free memory-mapped I/O space in a Hyper-V VM, 
    available to all Hyper-V-related drivers.

2 - A way of handling PCI Message-Signaled Interrupt (MSI and MSI-X)
    creation and formatting when Hyper-V is running.

3 - A mapping function from Linux processor number to Hyper-V virtual
    processor number, available to drivers, which is necessary for MSI(-X)
    creation.

The Hyper-V Frame Buffer driver is modified to use the MMIO space
allocation function so that its allocations both don't collide with the
PCI front end and so that the chosen range can come from any available
part of MMIO space.

Finally, the new PCI front-end driver is the last patch in the series.

Jake Oshins (6):
  drivers:hv: Modify vmbus to search for all MMIO ranges available
  drivers:hv: Move MMIO range picking from hyper_fb.mod to hv_vmbus.mod
  arch:x86:hv: Add mechanism for Hyper-V paravirt drivers to hook msi
    message creation
  drivers:hv: Export a function that maps Linux proc num onto Hyper-V
    proc num
  drivers:hv: Define the channel type for Hyper-V PCI Express
    pass-through
  drivers:pci:hv: New paravirtual PCI front-end for Hyper-V VMs

 MAINTAINERS                     |    1 +
 arch/x86/include/asm/mshyperv.h |    2 +
 arch/x86/kernel/cpu/mshyperv.c  |   30 +
 drivers/hv/vmbus_drv.c          |  208 +++-
 drivers/pci/Kconfig             |    9 +
 drivers/pci/host/Makefile       |    1 +
 drivers/pci/host/hv_pcifront.c  | 2177 +++++++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/hyperv_fb.c |   46 +-
 include/linux/hyperv.h          |   38 +-
 9 files changed, 2469 insertions(+), 43 deletions(-)
 create mode 100644 drivers/pci/host/hv_pcifront.c

-- 
1.9.1

