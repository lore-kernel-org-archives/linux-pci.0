Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:50304 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbcD0Mqg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2016 08:46:36 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Wed, 27 Apr 2016 22:46:33 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
	alistair@popple.id.au, ruscur@russell.cc,
	Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH 0/5] vfio-pci: Add support for mmapping MSI-X table
Date: Wed, 27 Apr 2016 20:43:25 +0800
Message-Id: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current vfio-pci implementation disallows to mmap the page 
containing MSI-X table in case that users can write to MSI-X
table and generate an incorrect MSIs.

However, this will cause some performance issue when there
are some critical device registers in the same page as the 
MSI-X table. We have to handle the mmio access to these 
registers in QEMU emulation rather than in guest.

To solve this issue, this series allows to mmap MSI-X table 
when hardware supports the capability of interrupt remapping 
which can ensure that a given pci device can only shoot the 
MSIs assigned for it. And we introduce a new bus_flags 
PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side 
for different archs.

The patch 3 are based on the proposed patchset[1].

[1] http://www.spinics.net/lists/kvm/msg130256.html

Yongji Xie (5):
  PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
  iommu: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
  PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller supports IRQ remapping
  pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
  vfio-pci: Allow to mmap MSI-X table if interrupt remapping is supported

 arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
 drivers/iommu/iommu.c                     |   15 +++++++++++++++
 drivers/pci/msi.c                         |   12 ++++++++++++
 drivers/pci/probe.c                       |    3 +++
 drivers/vfio/pci/vfio_pci.c               |    7 +++++--
 drivers/vfio/pci/vfio_pci_rdwr.c          |    3 ++-
 include/linux/msi.h                       |    6 +++++-
 include/linux/pci.h                       |    1 +
 8 files changed, 51 insertions(+), 4 deletions(-)

-- 
1.7.9.5

