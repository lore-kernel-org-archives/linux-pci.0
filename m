Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbeILRii (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2018 13:38:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CCUA2v049374
        for <linux-pci@vger.kernel.org>; Wed, 12 Sep 2018 08:34:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf1pubea0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 12 Sep 2018 08:34:17 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <sebott@linux.ibm.com>;
        Wed, 12 Sep 2018 13:34:16 +0100
From: Sebastian Ott <sebott@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 0/2] sriov enablement on s390
Date: Wed, 12 Sep 2018 14:34:09 +0200
Message-Id: <20180912123411.23229-1-sebott@linux.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

On s390 we currently handle SRIOV within firmware. Which means
that the PF is under firmware control and not visible to operating
systems. SRIOV enablement happens within firmware and VFs are
passed through to logical partitions.

I'm working on a new mode were the PF is under operating system
control (including SRIOV enablement). However we still need
firmware support to access the VFs. The way this is supposed
to work is that when firmware traps the SRIOV enablement it
will present machine checks to the logical partition that
triggered the SRIOV enablement and provide the VFs via hotplug
events.

The problem I'm faced with is that the VF detection code in
sriov_enable leads to unusable functions in s390.

Would you consider the following patches?

Sebastian Ott (2):
  pci: provide pcibios_sriov_add_vfs
  s390/pci: handle function enumeration after sriov enablement

 arch/s390/pci/pci.c | 11 +++++++++++
 drivers/pci/iov.c   | 43 +++++++++++++++++++++++++++++++------------
 include/linux/pci.h |  2 ++
 3 files changed, 44 insertions(+), 12 deletions(-)

-- 
2.13.4
