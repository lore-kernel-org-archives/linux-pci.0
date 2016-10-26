Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39367 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753758AbcJZBWq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2016 21:22:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9Q1K9pX079177
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2016 21:22:45 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26ah2bc8rg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2016 21:22:45 -0400
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Wed, 26 Oct 2016 11:22:43 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
        by d23dlp03.au.ibm.com (Postfix) with ESMTP id DDC9C3578057
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2016 12:22:40 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u9Q1Medu65732748
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2016 12:22:40 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u9Q1MdgW027833
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2016 12:22:40 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au, clsoto@us.ibm.com,
        Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] Disable VF's memory space on updating IOV BARs
Date: Wed, 26 Oct 2016 12:15:34 +1100
Message-Id: <1477444536-29612-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This moves pcibios_sriov_enable() to the point before VF and VF BARs
are enabled on PowerNV platform. Also, pci_update_resource() is used
to update IOV BARs on PowerNV platform, the PF might have been functional
when the function is called. We shouldn't disable PF's memory decoding
at that point. Instead, the VF's memory space should be disabled.

Changelog
=========
v3:
  * Disable VF's memory space when IOV BARs are updated in
    pcibios_sriov_enable().
v2:
  * Added one patch calling pcibios_sriov_enable() before the VF
    and VF BARs are enabled.

Gavin Shan (2):
  PCI: Call pcibios_sriov_enable() before IOV BARs are enabled
  PCI: Disable VF's memory space on updating IOV BAR in
    pci_update_resource()

 drivers/pci/iov.c       | 14 +++++++-------
 drivers/pci/setup-res.c | 28 ++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.1.0

