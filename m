Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756751AbcIMJAi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2016 05:00:38 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8D8wbwt031966
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2016 05:00:38 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 25e3v0ndef-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2016 05:00:37 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
        Tue, 13 Sep 2016 05:00:36 -0400
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
        gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [PATCH v5 0/4] PCI: Introduce a way to enforce all MMIO BARs not to share PAGE_SIZE
Date: Tue, 13 Sep 2016 17:00:30 +0800
Message-Id: <1473757234-5284-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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

In this series, patch 1,2 fixed bugs of using resource_alignment;
patch 3 tried to add a new option for resource_alignment to use
IORESOURCE_STARTALIGN to specify the alignment of PCI BARs; patch 4
adds a macro to set the default alignment of all MMIO BARs.

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
  PCI: Ignore enforced alignment when kernel uses existing firmware setup
  PCI: Ignore enforced alignment to VF BARs
  PCI: Add a new option for resource_alignment to reassign alignment
  PCI: Add a macro to set default alignment for all PCI devices

 Documentation/kernel-parameters.txt |    9 +++--
 arch/powerpc/include/asm/pci.h      |    4 +++
 drivers/pci/pci.c                   |   63 +++++++++++++++++++++++++++++------
 3 files changed, 63 insertions(+), 13 deletions(-)

-- 
1.7.9.5

