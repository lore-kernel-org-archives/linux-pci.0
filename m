Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39952 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139AbcHLFnU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2016 01:43:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u7C5XdIw033508
	for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2016 01:42:27 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24rmj7rng9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2016 01:42:27 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Thu, 11 Aug 2016 23:42:26 -0600
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
	gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
	mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [PATCH v4 0/5] PCI: Introduce a way to enforce all MMIO BARs not to share PAGE_SIZE
Date: Fri, 12 Aug 2016 13:42:21 +0800
Message-Id: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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

In this series, patch 1,2,3 fixed bugs of using resource_alignment;
patch 4 tried to add a new option for resource_alignment to use 
IORESOURCE_STARTALIGN to specify the alignment of PCI BARs; patch 5
adds a macro to set the default alignment of all MMIO BARs.

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

Yongji Xie (5):
  PCI: Ignore enforced alignment when kernel uses existing firmware setup
  PCI: Ignore enforced alignment to VF BARs
  PCI: Do not disable memory decoding in pci_reassigndev_resource_alignment()
  PCI: Add a new option for resource_alignment to reassign alignment
  PCI: Add a macro to set default alignment for all PCI devices

 Documentation/kernel-parameters.txt |    9 +++--
 arch/powerpc/include/asm/pci.h      |    4 ++
 drivers/pci/pci.c                   |   71 ++++++++++++++++++++++++++---------
 3 files changed, 64 insertions(+), 20 deletions(-)

-- 
1.7.9.5

