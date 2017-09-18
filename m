Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750711AbdIRT1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2017 15:27:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8IJQVHn040041
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2017 15:27:22 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d2ma2g1d6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2017 15:27:22 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <bryantly@linux.vnet.ibm.com>;
        Mon, 18 Sep 2017 15:27:21 -0400
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v1 0/3] Prepartion for SR-IOV PowerVM Enablement
Date: Mon, 18 Sep 2017 14:26:48 -0500
Message-Id: <20170918192651.78404-1-bryantly@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series is to prepare for enabling SR-IOV
on pseries. It separates the calls to be machine dependent
and does not change any current functionality.

Bryant G. Ly (3):
  powerpc/kernel: Split up pci_bus_add_device
  pseries: Override pci_bus_match_virtfn_driver
  powerpc/kernel: Separate SR-IOV Calls

 arch/powerpc/include/asm/machdep.h           |  7 ++++
 arch/powerpc/include/asm/pci-bridge.h        |  4 +--
 arch/powerpc/kernel/eeh_driver.c             |  4 +--
 arch/powerpc/kernel/pci-common.c             | 23 +++++++++++++
 arch/powerpc/kernel/pci_dn.c                 |  6 ----
 arch/powerpc/platforms/powernv/eeh-powernv.c | 34 ++++++++++---------
 arch/powerpc/platforms/powernv/pci-ioda.c    |  6 ++--
 arch/powerpc/platforms/pseries/pci.c         | 17 ++++++++++
 drivers/pci/bus.c                            | 51 +++++++++++++++++++++++-----
 drivers/pci/iov.c                            |  2 +-
 include/linux/pci.h                          |  3 ++
 11 files changed, 118 insertions(+), 39 deletions(-)

-- 
2.11.0 (Apple Git-81)
