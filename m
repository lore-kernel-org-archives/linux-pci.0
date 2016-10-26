Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37455 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754075AbcJZGxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2016 02:53:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9Q6mUMP117041
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2016 02:53:37 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26amucrgnm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2016 02:53:36 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
        Wed, 26 Oct 2016 00:53:36 -0600
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
        gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [RFC PATCH v7 0/3] PCI: Introduce a way to enforce all MMIO BARs not to share PAGE_SIZE
Date: Wed, 26 Oct 2016 14:53:30 +0800
Message-Id: <1477464813-2499-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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
patch 3 adds a macro to set the default alignment of all MMIO BARs.

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

Yongji Xie (3):
  PCI: Ignore requested alignment for IOV BARs
  PCI: Restore resource's size if we expand it by using resource_alignment
  PCI: Add a macro to set default alignment for all PCI devices

 arch/powerpc/include/asm/pci.h |    4 ++++
 drivers/pci/pci.c              |    6 +++++-
 drivers/pci/setup-bus.c        |   19 +++++++++++++++++++
 include/linux/pci.h            |    1 +
 4 files changed, 29 insertions(+), 1 deletion(-)

-- 
1.7.9.5

