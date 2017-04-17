Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbdDQVg3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Apr 2017 17:36:29 -0400
Subject: [PATCH v11 0/7] PCI: Introduce a way to enforce all MMIO BARs not
 to share PAGE_SIZE
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yongji Xie <elohimes@gmail.com>
Cc: zhong@linux.vnet.ibm.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Apr 2017 16:36:25 -0500
Message-ID: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is another iteration on Yongji's series to force MMIO BARs not to
share pages, which allows direct passthrough instead of QEMU emulation.

The only things I really changed were to add some comments and factor out
the code that requests resize.  I also pulled in the IOV patch, which
touches the same code but was posted separately.

These are all on my pci/resource branch, and if all goes well, I plan to
merge these for v4.12.

Changelog v11:
- Include patch to ignore IOV alignment
- Add patches to factor out realignment
- Add comment about "resize" usage
---

Bjorn Helgaas (2):
      PCI: Factor pci_reassigndev_resource_alignment()
      PCI: Don't reassign resources that are already aligned

Yongji Xie (5):
      PCI: Ignore requested alignment for IOV BARs
      PCI: A fix for caculating bridge window's size and alignment
      PCI: Add pcibios_default_alignment() for arch-specific alignment control
      powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned
      PCI: Don't resize resources when realigning all devices in system


 arch/powerpc/include/asm/machdep.h        |    2 +
 arch/powerpc/kernel/pci-common.c          |    8 ++
 arch/powerpc/platforms/powernv/pci-ioda.c |    7 ++
 drivers/pci/pci.c                         |  106 ++++++++++++++++++++++-------
 drivers/pci/setup-bus.c                   |    4 +
 5 files changed, 100 insertions(+), 27 deletions(-)
