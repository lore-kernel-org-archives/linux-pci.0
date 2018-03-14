Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751508AbeCNSJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 14:09:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EI9AF6008761
        for <linux-pci@vger.kernel.org>; Wed, 14 Mar 2018 14:09:50 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gq44unw8x-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 14 Mar 2018 14:09:46 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <desnesn@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 14:09:35 -0400
Subject: Re: [PATCH 1/2, pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN
 attribute to the PCI subsystem
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc,
        aik@ozlabs.ru, david@gibson.dropbear.id.au,
        fbarrat@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
 <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
 <CAHp75VdOaE-efzbQV=Mtf+a1-6L5JxF10Uc+uZ+LYz3S757biw@mail.gmail.com>
From: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
        <desnesn@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 15:09:28 -0300
MIME-Version: 1.0
In-Reply-To: <CAHp75VdOaE-efzbQV=Mtf+a1-6L5JxF10Uc+uZ+LYz3S757biw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <588ea850-2b28-2b7e-6e95-13d267f05cfa@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Andy,

On 03/14/2018 02:41 PM, Andy Shevchenko wrote:
> On Wed, Mar 14, 2018 at 6:34 PM, Desnes A. Nunes do Rosario
> <desnesn@linux.vnet.ibm.com> wrote:
>> Add PCI_DEV_FLAGS_QUIET_PCI_REALIGN to pci_dev_flags and use it to
>> silent PCI realignment messages if the flag is turned on by a driver.
> 
> It doesn't explain "Why?"
> Why the driver needs that?

I have written down the reason on the cover letter, but I concur on 
creating a second version of the patch's comment. Basically, all PCI 
resources on powerpc are printing out expected realignment messages 
which are flooding the systems logs.

Perhaps this would be better?
---
"Some architectures such as powerpc has aligned all of its PCI resources 
to its PAGE_SIZE during boot, thus the system logs will be flooded by 
expected realignment messages, which can be interpreted as a false 
positive for total PCI failure on the system.

[root@system user]# dmesg | grep -i disabling
[    0.692270] pci 0000:00:00.0: Disabling memory decoding and releasing 
memory resources
[    0.692324] pci 0000:00:00.0: disabling bridge mem windows
[    0.729134] pci 0001:00:00.0: Disabling memory decoding and releasing 
memory resources
[    0.737352] pci 0001:00:00.0: disabling bridge mem windows
[    0.776295] pci 0002:00:00.0: Disabling memory decoding and releasing 
memory resources
[    0.784509] pci 0002:00:00.0: disabling bridge mem windows
... and goes on for all PCI devices ...

Thus, this patch adds PCI_DEV_FLAGS_NO_REALIGN_MSG to pci_dev_flags and 
uses it to silent PCI realignment messages if the flag is turned on by a 
driver.
"
---

> 
> Another approach is to increase level of the message. Would it be
> accepted by you (in case Bjorn agrees)?
> 
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -205,6 +205,8 @@ enum pci_dev_flags {
>>          PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
>>          /* Don't use Relaxed Ordering for TLPs directed at this device */
>>          PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
>> +       /* Silent PCI resource realignment messages */
>> +       PCI_DEV_FLAGS_QUIET_PCI_REALIGN = (__force pci_dev_flags_t) (1 << 12),
> 
> I would rather name it _NO_PCI_REALIGN_MSG

I concur on changing it to PCI_DEV_FLAGS_NO_REALIGN_MSG in a second 
version of the patchset.

> 
>>   };
> 

Thank you very much for your review,

-- 
Desnes A. Nunes do Rosário
