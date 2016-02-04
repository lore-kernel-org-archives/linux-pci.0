Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [193.47.165.129] ([193.47.165.129]:33954 "EHLO mellanox.co.il"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755217AbcBDI3j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 03:29:39 -0500
From: Ilya Lesokhin <ilyal@mellanox.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com, ilyal@mellanox.com
Subject: [RFC V2 0/4] VFIO SRIOV support
Date: Thu,  4 Feb 2016 10:28:53 +0200
Message-Id: <1454574537-123466-1-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes from v1:
	Due to the security concern raised in v1, we add two patches
	to make sure the VFs belong to the same IOMMU group as
	the PF and are probed by VFIO.

Today the QEMU hypervisor allows assigning a physical device to a VM,
facilitating driver development. However, it does not support enabling
SR-IOV by the VM kernel driver. Our goal is to implement such support,
allowing developers working on SR-IOV physical function drivers to work
inside VMs as well.

This patch series implements the kernel side of our solution.  It extends
the VFIO driver to support the PCIE SRIOV extended capability with
following features:
1. The ability to probe SRIOV BAR sizes.
2. The ability to enable and disable sriov.

This patch series is going to be used by QEMU to expose sriov capabilities
to VM. We already have an early prototype based on Knut Omang's patches for
SRIOV[1]. 

Open issues:
1. How to tell if it is safe to disable SRIOV?
In the current implementation, a userspace can enable sriov, grab one of
the VFs and then call disable sriov without releasing the device.  This
will result in a deadlock where the user process is stuck inside disable
sriov waiting for itself to release the device. Killing the process leaves
it in a zombie state.
We also get a strange warning saying:
[  181.668492] WARNING: CPU: 22 PID: 3684 at kernel/sched/core.c:7497 __might_sleep+0x77/0x80() 
[  181.668502] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff810aa193>] prepare_to_wait_event+0x63/0xf0

2. How to expose the Supported Page Sizes and System Page Size registers in
the SRIOV capability? 
Presently the hypervisor initializes Supported Page Sizes once and assumes
it doesn't change therefore we cannot allow user space to change this
register at will. The first solution that comes to mind is to expose a
device that only supports the page size selected by the hypervisor.
Unfourtently, Per SR-IOV spec section 3.3.12, PFs are required to support
4-KB, 8-KB, 64-KB, 256-KB, 1-MB, and 4-MB page sizes. We currently map both
registers as virtualized and read only and leave user space to worry about
this problem.

3. Other SRIOV capabilities.
Do we want to hide capabilities we do not support in the SR-IOV
Capabilities register? or leave it to the userspace application?

[1] https://github.com/knuto/qemu/tree/sriov_patches_v6

Ilya Lesokhin (4):
  VFIO: Probe new devices in a live VFIO group with the VFIO driver
  IOMMU: Force the VFs of an untrusted PF device to be in the PFs IOMMU
    group
  PCI: Expose iov_set_numvfs and iov_resource_size for modules.
  VFIO: Add support for SRIOV extended capablity

 drivers/iommu/iommu.c              |   4 +
 drivers/pci/iov.c                  |   4 +-
 drivers/vfio/pci/vfio_pci.c        |   3 +
 drivers/vfio/pci/vfio_pci_config.c | 169 +++++++++++++++++++++++++++++++++----
 drivers/vfio/vfio.c                |  18 +++-
 include/linux/pci.h                |   5 ++
 6 files changed, 182 insertions(+), 21 deletions(-)

-- 
1.8.3.1

