Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34164 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753263AbdDJMA5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2017 08:00:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id o126so8790363pfb.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Apr 2017 05:00:56 -0700 (PDT)
From: Yongji Xie <elohimes@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com,
        aik@ozlabs.ru, benh@kernel.crashing.org, mpe@ellerman.id.au,
        paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: [PATCH v10 0/4] PCI: Introduce a way to enforce all MMIO BARs not to share PAGE_SIZE
Date: Mon, 10 Apr 2017 19:58:10 +0800
Message-Id: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series introduces a way for PCI resource allocator to force
MMIO BARs not to share PAGE_SIZE. This would make sense to VFIO
driver. Because current VFIO implementation disallows to mmap
sub-page(size < PAGE_SIZE) MMIO BARs which may share the same page
with other BARs for security reasons. Thus, we have to handle mmio
access to these BARs in QEMU emulation rather than in guest which
will cause some performance loss.

In our solution, we try to make use of the existing code path of
resource_alignment kernel parameter and add a macro to set default
alignment for it. Thus we can define this macro by default on some
archs which may easily hit the performance issue because of their
64K page.

In this series, patch 1 fixes a bug related to bridge window
size/alignment caculating; patch 2,3 add support for setting default
alignment of all MMIO BAR.

Changelog v10:
- Introduce an arch-specific function to set default alignment
  for all PCI devices instead of using macro
- Fix some minor comment issues
- Code style improvements

Changelog v9:
- Add a patch to fix for caculating bridge window's size and alignment
- Remove an unrelated patch
- Rework the patch that fix bug that reassign resources's alignment by
  changing its size

Changelog v8:
- Rebased against v4.10-rc4
- Rework the patch 2
- Change the commit log of patch 1

Changelog v7:
- Rebased against v4.9-rc2
- Drop two merged patches
- Rework the patch which fix a bug that resources's size is changed when
  using resource_alignment
- Add a patch that fix a bug for IOV BARs when using resource_alignment

Changelog v6:
- Remove the option "noresize@" of resource_alignment

Changelog v5:
- Rebased against v4.8-rc6
- Drop the patch that forbidding disable memory decoding in
  pci_reassigndev_resource_alignment()

Changelog v4:
- Rebased against v4.8-rc1
- Drop one irrelevant patch
- Drop the patch that adding wildcard to resource_alignment to enforce
  the alignment of all MMIO BARs to be at least PAGE_SIZE
- Change the format of option "noresize" of resource_alignment
- Code style improvements

Changelog v3:
- Ignore enforced alignment to fixed BARs
- Fix issue that disabling memory decoding when reassigning the alignment
- Only enable default alignment on PowerNV platform

Changelog v2:
- Ignore enforced alignment to VF BARs on pci_reassigndev_resource_alignment()

Yongji Xie (4):
  PCI: A fix for caculating bridge window's size and alignment
  PCI: Add pcibios_default_alignment() for arch-specific alignment control
  powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned
  PCI: Don't extend device's size when using default alignment for all devices

 arch/powerpc/include/asm/machdep.h        |    2 ++
 arch/powerpc/kernel/pci-common.c          |    8 ++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |    7 +++++
 drivers/pci/pci.c                         |   44 +++++++++++++++++++++--------
 drivers/pci/setup-bus.c                   |    4 +--
 5 files changed, 51 insertions(+), 14 deletions(-)

-- 
1.7.9.5
