Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:57239 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcBITZF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 14:25:05 -0500
From: jakeo@microsoft.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH RESEND v2 0/3] PCI: hv: New paravirtual PCI front-end driver
Date: Tue,  9 Feb 2016 19:24:25 +0000
Message-Id: <1455045869-38341-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This version incorporates feedback from Bjorn Helgaas and fixes a build
break reported by the kbuild test robot.

This is a resend of patches that enable PCI pass-through within Hyper-V
VMs.  This patch series only includes those which were deemed appropriate
for being incorportated via the PCI tree.  All other patches in previous
patch series have gone through other trees and are now in mainline.

The first two patches modify PCI so that new root PCI buses can be marked with
an associated fwnode_handle, and so that root PCI buses can look up their
associated IRQ domain by that handle.

The last patch, introduces a new driver, hv_pcifront, which exposes root PCI
buses in a Hyper-V VM.  These root PCI buses expose real PCIe devices, or PCI
Virtual Functions.

Jake Oshins (3):
  PCI: Add fwnode_handle to pci_sysdata
  PCI: irqdomain: Look up IRQ domain by fwnode_handle
  PCI: hv: New paravirtual PCI front-end for Hyper-V VMs

 MAINTAINERS                   |    1 +
 arch/x86/include/asm/pci.h    |   15 +
 drivers/pci/Kconfig           |    7 +
 drivers/pci/host/Makefile     |    1 +
 drivers/pci/host/pci-hyperv.c | 2373 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |   15 +
 include/linux/pci.h           |    4 +
 7 files changed, 2416 insertions(+)
 create mode 100644 drivers/pci/host/pci-hyperv.c

--
1.9.1

