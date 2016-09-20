Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58945 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752124AbcITCdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2016 22:33:14 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8K2X3u8060031
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2016 22:33:13 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
        by mx0b-001b2d01.pphosted.com with ESMTP id 25jkn3w5kr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2016 22:33:13 -0400
Received: from localhost
        by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Tue, 20 Sep 2016 12:33:08 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
        by d23dlp01.au.ibm.com (Postfix) with ESMTP id EE4902CE8054
        for <linux-pci@vger.kernel.org>; Tue, 20 Sep 2016 12:33:05 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u8K2X5D95112114
        for <linux-pci@vger.kernel.org>; Tue, 20 Sep 2016 12:33:05 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u8K2X5di000400
        for <linux-pci@vger.kernel.org>; Tue, 20 Sep 2016 12:33:05 +1000
Date: Tue, 20 Sep 2016 12:33:28 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: yinghai@kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, ruscur@russell.cc,
        linux-pci@vger.kernel.org
Subject: [Discussion] PCI Resource Resizing & Assignment
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20160920023328.GA8527@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Yinghai,

The purpose of this is going to have some discussion on current PCI resource
resizing and assignment implementation, mainly related to __pci_bus_size_bridges()
and pbus_size_mem().

In current implementation, all 64-bits and prefetchable BARs are going to be covered
by 64-bits and prefetchable bridge windows, and all other types of BARs are covered
by 32-bits bridge windows. It means 64-bits and non-prefetchable BARs are assigned
from 32-bits bridge windows which is usually limited and 2GB on our PowerNV platform.
It seems the attribute ("prefetchable") plays important role in the design so that
the final resource layout is compatible with: non-prefetchable BARs cannot be covered
by prefetchable bridge windows. It seems that's not true any more in PCI express domain,
meaning non-prefetchable BARs can live under prefetchable bridge windows. If so, I
think the "prefetchable" attribute isn't important and shouldn't affect the implementation
so much as we had. PCI/PCIx domain still have the problem: non-prefetchable BARs cannot
live behind a prefetchable bridge window. Apart from PCI/PCIx, we probably need enhance
current implementation for PCIe domain: 64-bits BARs are covered by 64-bits bridge windows
and 32-bits BARs are covered by 32-bits bridge windows, meaning the attribute "prefetchable"
won't have effect during resizing/assignment in PCIe domain. We will benefit from the
enhancement: (A) 64-bits non-prefetchable BARs will be covered by 64-bits prefetchable
bridge windows instead of 32-bits bridge windows, avoid 32-bits resource to be exhausted
quickly. (B) VFs whose BARs isn't 64-bits and prefetchable cannot be enabled on PowerNV
platform. It's not a issue with this enhancement.

The situation becomes complicated when we have combination of PCIe and PCI/PCIx domains.
We still need follow the rule in this scenario: non-prefetchable BARs cannot be covered
by prefetchable bridge windows. It might be more complicated with PCI hotplug is under
consideration. However, the platform (e.g. PowerNV) could have clear idea if PCI/PCIx
is going to be supported on particular PHB. I think the above enhancement can be applied
if PCI/PCIx won't be supported on particular PHB.

Thanks,
Gavin


