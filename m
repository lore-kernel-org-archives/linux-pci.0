Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43511 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751801AbdBPGLZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 01:11:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1G6929G073863
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2017 01:11:24 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0b-001b2d01.pphosted.com with ESMTP id 28n26ngwtu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2017 01:11:24 -0500
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <vaibhav@linux.vnet.ibm.com>;
        Thu, 16 Feb 2017 16:11:21 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        "# v4 . 8+" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] pci/hotplug/pnv-php: Remove WARN_ON() in pnv_php_put_slot()
In-Reply-To: <6c4942ee-7704-5686-8bf3-3cff775eff89@au1.ibm.com>
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com> <1487200954-14681-2-git-send-email-gwshan@linux.vnet.ibm.com> <6c4942ee-7704-5686-8bf3-3cff775eff89@au1.ibm.com>
Date: Thu, 16 Feb 2017 11:40:15 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a89mbr94.fsf@vajain21.in.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>> Cc: <stable@vger.kernel.org> # v4.8+
>> Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Tested-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
