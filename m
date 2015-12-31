Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([125.16.236.5]:45060 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbbLaIwQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Dec 2015 03:52:16 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Thu, 31 Dec 2015 14:22:11 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
	alex.williamson@redhat.com, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 0/3] vfio-pci: Allow to mmap sub-page MMIO BARs and MSI-X table on PPC64 platform
Date: Thu, 31 Dec 2015 16:50:41 +0800
Message-Id: <1451551844-11732-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current vfio-pci implementation disallows to mmap
sub-page(size < PAGE_SIZE) MMIO BARs and MSI-X table. This is because
sub-page BARs' mmio page may be shared with other BARs and MSI-X table
should not be accessed directly from the guest for security reasons.

But these will easily cause some performance issues for mmio accesses
in guest when vfio passthrough sub-page BARs or BARs containing MSI-X
table on PPC64 platform. This is because PAGE_SIZE is 64KB by default
on PPC64 platform and the big page may easily hit the sub-page MMIO
BARs' unmmapping and cause the unmmaping of the mmio page which
MSI-X table locate in, which lead to mmio emulation in host.

For sub-page MMIO BARs' unmmapping, this patchset adds a kernel
parameter for PCI resource allocator to enforce the alignment of all
MMIO BARs to be at least PAGE_SZIE and make it enabled by default on
PPC64 platform so that sub-page BAR's mmio page will not be shared
with other BARs. Then we can mmap sub-page MMIO BARs in vfio-pci driver
with this parameter enabled.

For MSI-X table's unmmapping, we think MSI-X table is safe to access
directly from userspace with EEH mechanism enabled which can ensure that
a given pci device can only shoot the MSIs assigned for its PE. So
we add a Kconfig option to support for mmapping MSI-X table in vfio-pci
driver if EEH is supported.

With this patchset applied, we can get almost 100% improvement on
performance for mmio accesses when we passthrough sub-page BARs to guest
in our test.

The last two patches are based on the proposed patchset[1].

Changelog v2:
- Rebase on v4.4-rc6 with the patchset[1] applied.
- Use kernel parameter to enforce all MMIO BARs to be page aligned
  on PCI core code instead of doing it on PPC64 arch code.
- Remove flags: VFIO_DEVICE_FLAGS_PCI_PAGE_ALIGNED
                VFIO_DEVICE_FLAGS_PCI_MSIX_MMAP
- Add a Kconfig option to support for mmapping MSI-X table.

[1] https://lkml.org/lkml/2015/11/23/748

Yongji Xie (3):
  PCI: Add support for enforcing all MMIO BARs to be page aligned
  vfio-pci: Allow to mmap sub-page MMIO BARs if all MMIO BARs are page aligned
  vfio-pci: Allow to mmap MSI-X table if EEH is supported

 Documentation/kernel-parameters.txt |    4 ++++
 arch/powerpc/include/asm/pci.h      |   11 +++++++++++
 drivers/pci/pci.c                   |   17 +++++++++++++++++
 drivers/pci/pci.h                   |    7 ++++++-
 drivers/vfio/pci/Kconfig            |    4 ++++
 drivers/vfio/pci/vfio_pci.c         |   13 ++++++++++---
 include/linux/pci.h                 |    2 ++
 7 files changed, 54 insertions(+), 4 deletions(-)

-- 
1.7.9.5

