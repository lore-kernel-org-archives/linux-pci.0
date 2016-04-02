Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from p3plsmtps2ded04.prod.phx3.secureserver.net ([208.109.80.198]:58628
	"EHLO p3plsmtps2ded04.prod.phx3.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754182AbcDAXKY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Apr 2016 19:10:24 -0400
From: Jake Oshins <jakeo@microsoft.com>
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v4 0/7] drivers:hv: Ensure that bridge windows don't overlap
Date: Fri,  1 Apr 2016 17:47:40 -0700
Message-Id: <1459558067-1725-1-git-send-email-jakeo@microsoft.com>
In-Reply-To: <y>
References: <y>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series differs from v3 in that it folds in a patch suggested by
the kbuild test robot, substituting resource_size() for directly
calculating the size.

Hyper-V VMs expose paravirtual drivers through a mechanism called
VMBus, which is managed by hv_vmbus.ko.  For each parvirtual service
instance, this driver exposes a new child device.  Some of these child
devices need memory address space, into which Hyper-V will map things
like the virtual video frame buffer.  This memory-mapped address space
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
of memory space into which real PCI Express devices are mapped.  The
regions allocated are made to look like root PCI bus bridge windows
to the PCI driver, reusing all the code in the PCI driver for the rest
of PCI device management.

The problem is that these bridge windows are marked in such a way that
devices can still allocate from the memory space spanned by them, and
this means that if two different PCI buses are created in the VM, each
with devices under them, they may allocate the same memory space, leading
to PCI Base Address Register which overlap.

This patch series fixes the problem by tracking allocations to child
devices in a separate resource tree, marking them such that the bridge
windows can't overlap.  The main memory resource tree, iomem_resource,
contains resources properly marked as bridge windows, allowing their
children to overlap with them.

Jake Oshins (7):
  drivers:hv: Lock access to hyperv_mmio resource tree
  drivers:hv: Make a function to free mmio regions through vmbus
  drivers:hv: Use new vmbus_mmio_free() from client drivers.
  drivers:hv: Reverse order of resources in hyperv_mmio
  drivers:hv: Track allocations of children of hv_vmbus in private
    resource tree
  drivers:hv: Record MMIO range in use by frame buffer
  drivers:hv: Separate out frame buffer logic when picking MMIO range

 drivers/hv/vmbus_drv.c          | 143 +++++++++++++++++++++++++++++-----------
 drivers/pci/host/pci-hyperv.c   |  14 ++--
 drivers/video/fbdev/hyperv_fb.c |   4 +-
 include/linux/hyperv.h          |   2 +-
 4 files changed, 115 insertions(+), 48 deletions(-)

--
1.9.1

