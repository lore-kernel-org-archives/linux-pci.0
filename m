Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37731 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751801AbdBPGM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 01:12:59 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1G68p1q119065
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2017 01:12:58 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28n5qr1syj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2017 01:12:57 -0500
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <vaibhav@linux.vnet.ibm.com>;
        Thu, 16 Feb 2017 16:12:55 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        "# v4 . 9+" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] pci/hotplug/pnv-php: Disable surprise hotplug capability on conflicts
In-Reply-To: <48c227b2-756d-a5d3-227f-58ad51dd1565@au1.ibm.com>
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com> <1487200954-14681-3-git-send-email-gwshan@linux.vnet.ibm.com> <48c227b2-756d-a5d3-227f-58ad51dd1565@au1.ibm.com>
Date: Thu, 16 Feb 2017 11:41:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877f4qbr6j.fsf@vajain21.in.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

>>
>> Cc: <stable@vger.kernel.org> # v4.9+
>> Fixes: 360aebd85a4c ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Tested-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
