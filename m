Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754950AbcI2Gq2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 02:46:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8T6gv51120243
        for <linux-pci@vger.kernel.org>; Thu, 29 Sep 2016 02:46:27 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 25rq5x8wmg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 29 Sep 2016 02:46:27 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
        Thu, 29 Sep 2016 00:46:26 -0600
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
        gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [PATCH v6 0/4] PCI: Introduce a way to enforce all MMIO BARs not to share PAGE_SIZE
Date: Thu, 29 Sep 2016 14:46:17 +0800
Message-Id: <1475131581-4373-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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
patch 3 tried to use IORESOURCE_STARTALIGN to specify the alignment
of PCI BARs when using resource_alignment; patch 4 adds a macro to
set the default alignment of all MMIO BARs.

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
  PCI: Ignore enforced alignment when kernel uses existing firmware setup
  PCI: Ignore enforced alignment to VF BARs
  PCI: Don't change resources' size when using resource_alignment
  PCI: Add a macro to set default alignment for all PCI devices

 arch/powerpc/include/asm/pci.h |    4 ++++
 drivers/pci/pci.c              |   38 +++++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 9 deletions(-)

-- 
1.7.9.5

