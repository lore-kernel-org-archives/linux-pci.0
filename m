Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60487 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755766AbcKVTGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2016 14:06:42 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAMHdVSl064135
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2016 12:41:28 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26vku8tnct-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2016 12:41:27 -0500
Received: from localhost
        by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <fbarrat@linux.vnet.ibm.com>;
        Tue, 22 Nov 2016 17:41:26 -0000
Subject: Re: [PATCH 2/2] cxl: Set VPD timeout to avoid access failures
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ian Munsie <imunsie@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1479762606-51632-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 22 Nov 2016 18:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <1479762606-51632-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <05398bfe-5bd4-116b-a9d7-b974d4cc032a@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Le 21/11/2016 à 22:10, Matthew R. Ochs a écrit :
> Some IBM CXL devices can take up to ~120ms to complete a VPD access
> transaction when under heavy load. With an existing default VPD timeout
> of 50ms, reads/writes can fail despite there not being an issue with the
> underlying hardware.
>
> To avoid these false failures, increase the VPD wait timeout for certain
> CXL devices to a value that allows appropriate VPD access delay when faced
> with a worst-case scenario.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> ---

If the new pci API gets in, then I'm ok with the cxl change, at least 
for now. For longer term, we should consider opening up the cxl kernel 
API to give access to the new pci API so that it can be tuned by the AFU 
driver directly, since it would know better than cxl what the proper vpd 
access timeout should be.

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred

