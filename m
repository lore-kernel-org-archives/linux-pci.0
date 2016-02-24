Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:59430 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194AbcBXVZg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 16:25:36 -0500
From: jakeo@microsoft.com
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 0/5] hv: drivers: Ensure that bridge windows don't overlap
Date: Wed, 24 Feb 2016 21:23:57 +0000
Message-Id: <1456349042-16275-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

Hyper-V VMs expose paravirtual drivers through a mechanism called
VMBus, which is managed by hv_vmbus.ko.  For each paravirtual service
instance, this driver exposes a new child device.  Some of these child
devices need memory address space, into which Hyper-V will map things
like the virtual video framebuffer.  This memory-mapped address space
is chosen by the guest OS, not the hypervisor.

This is difficult to map onto the Linux pnp layer, as the code in the
pnp layer to choose MMIO space keys off of bus type and it doesn't know
anything about VMBus.  The maintainers of the pnp layer have asked that
we not offer patches to it that make it understand VMBus, but that we
rather find ways of using the code in its current state.  So hv_vmbus.ko
exports a function, vmbus_allocate_mmio() for choosing the address space
for any child driver that needs this facility.

The recently introduced PCI front-end driver for Hyper-V VMs
(pci-hyperv.ko) uses vmbus_allocate_mmio() for choosing both the region
of memory into which PCI configuration space can be mapped and the
region of memory into which real PCI Express devices which are passed
through to the VM should occupy.  The regions allocated are made to look
like root PCI bus bridge windows to the PCI driver, reusing all the code
in the PCI driver for the rest of the PCI device management.

The problem is that these bridge windows are marked in such a way that
devices can still allocate from the memory space spanned by them, and
this means that if two different PCI buses are created in the VM, each
with devices under them, they may allocate the same memory space, leading
to PCI Base Address Registers which overlap.

This patch series fixes the problem by tracking allocations to child
devices in a separate resource tree, marking them such that the bridge
windows can't overlap.  The main memory resource tree, iomem_resource,
contains resources properly marked as bridge windows, allowing their
children to overlap with them.

Jake Oshins (5):
  hv: Make a function to free mmio regions through vmbus
  hv: Lock access to hyperv_mmio resource tree
  hv: Use new vmbus_mmio_free() from client drivers.
  hv: Reverse order of resources in hyperv_mmio
  hv: Track allocations of children of hv_vmbus in private resource tree

 drivers/hv/vmbus_drv.c          | 56 +++++++++++++++++++++++++++++++++++------
 drivers/pci/host/pci-hyperv.c   | 14 +++++------
 drivers/video/fbdev/hyperv_fb.c |  4 +--
 include/linux/hyperv.h          |  2 +-
 4 files changed, 59 insertions(+), 17 deletions(-)

--
1.9.1

