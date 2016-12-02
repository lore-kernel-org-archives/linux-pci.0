Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750833AbcLBSne (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2016 13:43:34 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uB2Icgrc082166
        for <linux-pci@vger.kernel.org>; Fri, 2 Dec 2016 13:42:30 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2738m9buht-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 02 Dec 2016 13:42:30 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <ukrishn@linux.vnet.ibm.com>;
        Fri, 2 Dec 2016 11:42:29 -0700
Subject: Re: [PATCH] PCI: Increase VPD access timeout
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <1480442440-11540-1-git-send-email-mrochs@linux.vnet.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Date: Fri, 2 Dec 2016 12:43:17 -0600
MIME-Version: 1.0
In-Reply-To: <1480442440-11540-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <8c30026a-f9c2-6922-4154-0a832007046d@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> The PCI core uses a fixed 50ms timeout when waiting for VPD accesses to
> complete. When an access does not complete within this period, a warning
> is logged and an error returned to the caller.
>
> While this default timeout is valid for most hardware, some devices can
> experience longer access delays under certain circumstances. For example,
> one of the IBM CXL Flash devices can take up to ~120ms in a worst-case
> scenario. These types of devices can benefit from an extended timeout.
>
> To support devices with a longer access delay, increase the timeout in
> pci_vpd_wait() to 125ms. The PCI specification is silent with respect to
> VPD delays, therefore there is no concern for violating a threshold.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Tested-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

