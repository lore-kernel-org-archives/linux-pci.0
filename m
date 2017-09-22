Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752043AbdIVOTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2017 10:19:34 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8MEGMDD102778
        for <linux-pci@vger.kernel.org>; Fri, 22 Sep 2017 10:19:33 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d51jtbwse-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 22 Sep 2017 10:19:33 -0400
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <bryantly@linux.vnet.ibm.com>;
        Fri, 22 Sep 2017 08:19:32 -0600
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] Prepartion for SR-IOV PowerVM Enablement
Date: Fri, 22 Sep 2017 09:19:26 -0500
Message-Id: <20170922141928.49141-1-bryantly@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series is to prepare for enabling SR-IOV
on pseries. It separates the calls to be machine dependent
and does not change any current functionality.

The patch linked below which is currently in review is a dependency:
https://patchwork.kernel.org/patch/9882915/

v1 - Initial patch
v2 - Addressed Bjorn's comment on creating a highly platform
     dependent global exported symbol.
v3 - Based patch off linux-ppc/master

Bryant G. Ly (2):
  powerpc/kernel: Separate SR-IOV Calls
  pseries/eeh: Add Pseries pcibios_bus_add_device

 arch/powerpc/include/asm/machdep.h           |  7 ++++++
 arch/powerpc/include/asm/pci-bridge.h        |  4 +---
 arch/powerpc/kernel/eeh_driver.c             |  4 ++--
 arch/powerpc/kernel/pci-common.c             | 23 +++++++++++++++++++
 arch/powerpc/kernel/pci_dn.c                 |  6 -----
 arch/powerpc/platforms/powernv/eeh-powernv.c | 33 ++++++++++++++--------------
 arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++--
 arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++
 8 files changed, 78 insertions(+), 29 deletions(-)

-- 
2.11.0 (Apple Git-81)
