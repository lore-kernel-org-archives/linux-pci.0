Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54795 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753221AbdBPEcw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2017 23:32:52 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1G4ONbq161042
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 23:32:51 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0b-001b2d01.pphosted.com with ESMTP id 28mq9uhn27-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 23:32:50 -0500
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Thu, 16 Feb 2017 14:32:47 +1000
Subject: Re: [PATCH 2/3] pci/hotplug/pnv-php: Disable surprise hotplug
 capability on conflicts
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1487200954-14681-3-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        "# v4 . 9+" <stable@vger.kernel.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 16 Feb 2017 15:31:48 +1100
MIME-Version: 1.0
In-Reply-To: <1487200954-14681-3-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <48c227b2-756d-a5d3-227f-58ad51dd1565@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16/02/17 10:22, Gavin Shan wrote:
> The root port or PCIe switch downstream port might have been associated
> with driver other than pnv-php. The MSI or MSIx might also have been
> enabled by that driver (e.g. pcieport_drv). Attempt to enable MSI incurs
> below backtrace:
>
>  PowerPC PowerNV PCI Hotplug Driver version: 0.1
>  ------------[ cut here ]------------
>  WARNING: CPU: 19 PID: 1004 at drivers/pci/msi.c:1071 \
>                               __pci_enable_msi_range+0x84/0x4e0
>  NIP [c000000000665c34] __pci_enable_msi_range+0x84/0x4e0
>  LR [c000000000665c24] __pci_enable_msi_range+0x74/0x4e0
>  Call Trace:
>  [c000000384d67600] [c000000000665c24] __pci_enable_msi_range+0x74/0x4e0
>  [c000000384d676e0] [d00000000aa31b04] pnv_php_register+0x564/0x5a0 [pnv_php]
>  [c000000384d677c0] [d00000000aa31658] pnv_php_register+0xb8/0x5a0 [pnv_php]
>  [c000000384d678a0] [d00000000aa31658] pnv_php_register+0xb8/0x5a0 [pnv_php]
>  [c000000384d67980] [d00000000aa31dfc] pnv_php_init+0x60/0x98 [pnv_php]
>  [c000000384d679f0] [c00000000000cfdc] do_one_initcall+0x6c/0x1d0
>  [c000000384d67ab0] [c000000000b92354] do_init_module+0x94/0x254
>  [c000000384d67b40] [c00000000019719c] load_module+0x258c/0x2c60
>  [c000000384d67d30] [c000000000197bb0] SyS_finit_module+0xf0/0x170
>  [c000000384d67e30] [c00000000000b184] system_call+0x38/0xe0
> 360aebd85a4c
> This fixes the issue by skipping enabling the surprise hotplug
> capability if the MSI or MSIx on the PCI slot's upstream port has
> been enabled by other driver.
>
> Cc: <stable@vger.kernel.org> # v4.9+
> Fixes: 360aebd85a4c ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Should this print something to the kernel log to indicate that surprise 
hotplug is unavailable?

Otherwise:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
