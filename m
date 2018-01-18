Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] PCI/DPC: Unify and plumb error handling into DPC
To: poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
 <1516185438-31556-4-git-send-email-poza@codeaurora.org>
 <733abfcb-5b31-7394-ab62-19a0888d71c2@codeaurora.org>
 <c77a3302e34d55d557404d7bdc6892fc@codeaurora.org>
 <5cf7004e62a2979afb3c29e99d705c60@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <35a9ce2b-156f-3235-c3b7-2c495fe9c52b@codeaurora.org>
Date: Thu, 18 Jan 2018 11:31:11 -0500
MIME-Version: 1.0
In-Reply-To: <5cf7004e62a2979afb3c29e99d705c60@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/18/2018 12:57 AM, poza@codeaurora.org wrote:
> On 2018-01-18 10:47, poza@codeaurora.org wrote:
>> On 2018-01-17 22:16, Sinan Kaya wrote:
>>> On 1/17/2018 5:37 AM, Oza Pawandeep wrote:
>>>> +++ b/include/linux/dpc.h
>>>> @@ -0,0 +1,9 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +
>>>> +#ifndef _DPC_H_
>>>> +#define _DPC_H_
>>>> +
>>>> +#define DPC_FATAL        4
>>>> +
>>>> +#endif //_DPC_H_
>>>> +
>>>
>>> can you keep this in drivers/pci.h and get rid of this file?
>>
>> I thought about this, but if I keep it in drivers/pci.h,
>> then AER's defines have to be in that as well. (for unification)
>>
>> and then all the dependent files who are using AER_FATAL such as
>> drivers/acpi/apei/ghees.c
>> have to go on including this drivers file which is odd way of doing it.
>>
>> So I am not very sure about this....since AER_FATAL are in aer.h, I
>> have made dpc.h
>>
>>
>> Regards,
>> Oza.
> 
> Should I be doing in next patch-set series ?
> 

I think you would put into include/linux/pci.h only if there is an external
use of constant outside of drivers/pci directory. Otherwise, you should keep
the setting inside one of the header files in drivers/pci directory.

I don't see any other subsystem caring about DPC_FATAL definition.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
