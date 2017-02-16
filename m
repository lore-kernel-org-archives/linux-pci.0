Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752760AbdBPEqC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2017 23:46:02 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1G4irDs023687
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 23:46:02 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28my6y4kaf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 23:46:01 -0500
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Thu, 16 Feb 2017 14:45:59 +1000
Subject: Re: [PATCH 3/3] pci/hotplug/pnv-php: Disable MSI and PCI device
 properly
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1487200954-14681-4-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        "# v4 . 9+" <stable@vger.kernel.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 16 Feb 2017 15:45:00 +1100
MIME-Version: 1.0
In-Reply-To: <1487200954-14681-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9b2fa48d-c63f-b525-f1fa-3183976963e9@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16/02/17 10:22, Gavin Shan wrote:
> pnv_php_disable_irq() can be called in two paths: Bailing path in
> pnv_php_enable_irq() or releasing slot. The MSI (or MSIx) interrupts
> is disabled unconditionally in pnv_php_disable_irq(). It's wrong
> because that might be enabled by drivers other than pnv-php.
>
> This disables MSI (or MSIx) interrupts and the PCI device only if
> it was enabled by pnv-php. In the error path of pnv_php_enable_irq(),
> we rely on the newly added parameter @disable_device. In the path
> of releasing slot, @pnv_php->irq is checked.
>
> Cc: <stable@vger.kernel.org> # v4.9+
> Fixes: 360aebd85a4c ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
