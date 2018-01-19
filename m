Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45988 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754891AbeASJDN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 04:03:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 19 Jan 2018 14:33:12 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v5 3/4] PCI/DPC: Unify and plumb error handling into DPC
In-Reply-To: <f2356b95-1562-287a-95b9-d5e2c7c7ef56@codeaurora.org>
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
 <1516185438-31556-4-git-send-email-poza@codeaurora.org>
 <733abfcb-5b31-7394-ab62-19a0888d71c2@codeaurora.org>
 <c77a3302e34d55d557404d7bdc6892fc@codeaurora.org>
 <5cf7004e62a2979afb3c29e99d705c60@codeaurora.org>
 <35a9ce2b-156f-3235-c3b7-2c495fe9c52b@codeaurora.org>
 <64127dba1cebab196c88a160191ebee0@codeaurora.org>
 <0ab49441-548e-a5bc-d76b-bdc6fa7495dc@codeaurora.org>
 <c773081eadb89c4b4317d0a709a06a7d@codeaurora.org>
 <f2356b95-1562-287a-95b9-d5e2c7c7ef56@codeaurora.org>
Message-ID: <3f4e3cf0c9dee97894948b5cc9451d7e@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-19 10:14, Sinan Kaya wrote:
> On 1/18/2018 11:23 PM, poza@codeaurora.org wrote:
>> On 2018-01-18 23:33, Sinan Kaya wrote:
>>> On 1/18/2018 1:00 PM, poza@codeaurora.org wrote:
>>>>> I think you would put into include/linux/pci.h only if there is an 
>>>>> external
>>>>> use of constant outside of drivers/pci directory. Otherwise, you 
>>>>> should keep
>>>>> the setting inside one of the header files in drivers/pci 
>>>>> directory.
>>>>> 
>>>>> I don't see any other subsystem caring about DPC_FATAL definition.
>>>> 
>>>> ok so you are suggesting to move only DPC_FATAL ? so then AER can 
>>>> stay where it is.
>>> 
>>> Now that both AER and DPC handling is getting unified, I think it 
>>> makes sense to
>>> keep all error codes (AER+DPC) together in drivers/pci/pci.h rather 
>>> than having
>>> them split in aer.h and dpc.h.
>>> 
>>> Otherwise, how would we avoid having a new error type defined with 
>>> the
>>> existing values.
>> 
>> I agree, its is just that drivers/acpi/apet/ghes.c has to do
>> #include ../../pci/pci.h
> 
> That's bad. I was just thinking about the DPC error code only. I didn't 
> realize
> AER error codes are being referenced from ghes.c.
> 
>> 
>> but thats okay I think.  let me move error codes to drivers/pci/pci.h.
> 
> It is better if error codes move to include/linux/pci.h and keep them 
> together.
> 

The problem with moving them to include/linux/pci.h, it falls into 
global scope, besides
they have to be renamed to/prefixed with PCI_ERR_xxx

the use of AER_FATAL, DPC_FATAL etc.. is very limited in entire linux. 
and likely to be so.
I think moving them to drivers/pci/pci.h would be more restricted/local

let me make patch-set based on that, and see how it looks like. we can 
arrive at some consensus then.

>> 
>> Regards,
>> Oza.
>> 
