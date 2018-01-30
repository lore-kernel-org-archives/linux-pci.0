Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54168 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeA3Gep (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 01:34:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 30 Jan 2018 12:04:44 +0530
From: poza@codeaurora.org
To: Oza Pawandeep <oza.pawandeep@gmail.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI/DPC: Leave interrupts enabled while handling
 event
In-Reply-To: <CAK1A=4w-uDm+gau6WdwM=ZrgO=bWDtDKqwabxWxm2EZZb+YoKw@mail.gmail.com>
References: <20180129213145.26068-1-keith.busch@intel.com>
 <20180129213145.26068-2-keith.busch@intel.com>
 <56d77093-b630-148d-52ab-14dcb7714e6b@codeaurora.org>
 <CAK1A=4w-uDm+gau6WdwM=ZrgO=bWDtDKqwabxWxm2EZZb+YoKw@mail.gmail.com>
Message-ID: <f0afb7badc99dcfc3b6818cc2356250d@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-30 11:59, Oza Pawandeep wrote:
> + Oza
> 
> On Tue, Jan 30, 2018 at 7:41 AM, Sinan Kaya <okaya@codeaurora.org> 
> wrote:
>> On 1/29/2018 4:31 PM, Keith Busch wrote:
>>> +     if (!work_busy(&dpc->work))
>>> +             schedule_work(&dpc->work);
>> 
>> Isn't there a race condition between the time that dpc_work() clears 
>> PCI_EXP_DPC_STATUS
>> register and when work actually completes by returning from 
>> dpc_work()?
>> 
>> If the interrupt arrives just in this window, this code will not 
>> schedule the work.
>> 
>> --
>> Sinan Kaya
>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
>> Technologies, Inc.
>> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
>> Linux Foundation Collaborative Project.

besides, there is one more problem which I was debugging:
if RP doesnt support MSI, then legacy interrupts are not well handled 
and we get interrupt storm.
this is because;
PCI_EXP_DPC_STATUS_INTERRUPT is being cleared in deferred work.
which should get cleared in dpc_irq interrupt handler.
I will post a patch for this, but I see there are lot of changes being 
made in dpc and aer lately.

Bjorn: Can you please help to review my AER/DPC series of patches so 
that I do not have to keep rebasing and do manual merge ?

Regards,
Oza.
