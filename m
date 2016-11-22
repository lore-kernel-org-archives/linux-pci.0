Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46877 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753709AbcKVAku (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2016 19:40:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAM0d49r079551
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2016 19:40:50 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26v5j4ymeq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2016 19:40:50 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <mrochs@linux.vnet.ibm.com>;
        Mon, 21 Nov 2016 17:40:49 -0700
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH 2/2] cxl: Set VPD timeout to avoid access failures
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <24ea6084-35e7-677f-a083-a6909adf881e@au1.ibm.com>
Date: Mon, 21 Nov 2016 18:40:43 -0600
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ian Munsie <imunsie@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1479762606-51632-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <24ea6084-35e7-677f-a083-a6909adf881e@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <EA501FD1-9873-4109-98B4-DC5A2F5C361F@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Nov 21, 2016, at 6:32 PM, Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:
> On 22/11/16 08:10, Matthew R. Ochs wrote:
>> Some IBM CXL devices can take up to ~120ms to complete a VPD access
> 
> Which devices?

Flash GT

