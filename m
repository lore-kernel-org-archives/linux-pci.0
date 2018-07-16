Return-Path: <SRS0=b4Ma=KA=oracle.com=thomas.tai@kernel.org>
Return-Path: <SRS0=b4Ma=KA=oracle.com=thomas.tai@kernel.org>
Subject: Re: [PATCH V2, 0/1] PCI/AER: fix use-after-free in
 pcie_do_fatal_recovery
To: Keith Busch <keith.busch@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, poza@codeaurora.org, linux-pci@vger.kernel.org
References: <1531416823-17841-1-git-send-email-thomas.tai@oracle.com>
 <20180712215151.GD28466@bhelgaas-glaptop.roam.corp.google.com>
 <20180712215700.GA17092@localhost.localdomain>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <dbc4ae62-4e96-db73-9b47-7bff8343c8dd@oracle.com>
Date: Mon, 16 Jul 2018 10:06:31 -0400
MIME-Version: 1.0
In-Reply-To: <20180712215700.GA17092@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 07/12/2018 05:57 PM, Keith Busch wrote:
> On Thu, Jul 12, 2018 at 04:51:51PM -0500, Bjorn Helgaas wrote:
>> However, I think we're also slightly exposed in dpc_work(), in basically
>> the same (possibly harmless) way.
>>
>>    dpc_irq
>>      schedule_work(&dpc->work)
>>    ...
>>    dpc_work
>>      pdev = dpc->dev->port
>>      pcie_do_fatal_recovery(pdev)
>>
>> pdev may be removed by pcie_do_fatal_recovery(), but dpc_work() is still
>> holding onto a pointer (which it never uses again).
>>
>> The DPC driver should be holding a reference to pdev (through some black
>> magic I don't understand), but that would be released when pdev is removed,
>> and I don't know what ensures that dpc_work() runs before that release.
>>
>> Bjorn
> 
> Yep, you're right on that point. There's different ways we can fix
> that. The most recent one I proposed was to replace the scheduled work
> with the threaded irq[1]. That should make it safe since the lifetime of
> when bottom half can be executed is tied to the lifetime of the device
> that registered it.
> 
>   1. https://patchwork.kernel.org/patch/10478755/

Hi Bjorn, Keith and Poza,
I like the idea of using threaded irq if it can hold the device until 
the bottom half finished. It makes the AER and DPC driver codes more 
consistent. One problem I hit when changing the AER to threaded irq is 
that the error injection module aer_inject won't work anymore because it 
call the aer_irq directly and didn't go thru the threaded_irq path. I 
would have to fix that also. Will keep you posted.

Cheers,
Thomas

> 
