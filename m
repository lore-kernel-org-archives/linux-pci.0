Return-Path: <SRS0=foCx=FR=linux.vnet.ibm.com=bryantly@kernel.org>
Return-Path: <SRS0=foCx=FR=linux.vnet.ibm.com=bryantly@kernel.org>
Subject: Re: [PATCH] PCI/AER: Move pci_uevent_ers() out of pci.h
To: Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
        torvalds@linux-foundation.org, ruscur@russell.cc,
        jjalvare@linux.vnet.ibm.com
References: <20180208122035.9305-1-mpe@ellerman.id.au>
 <dcfc6411-20cf-5b3f-20c5-14167de54700@linux.vnet.ibm.com>
 <20180222231236.GB14632@bhelgaas-glaptop.roam.corp.google.com>
 <87h8q8pcr9.fsf@concordia.ellerman.id.au>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 08:38:57 -0600
MIME-Version: 1.0
In-Reply-To: <87h8q8pcr9.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <0217a4a8-015b-f4d8-9859-a41967038500@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>



On 2/22/18 10:10 PM, Michael Ellerman wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
>
>> On Thu, Feb 08, 2018 at 09:05:45AM -0600, Bryant G. Ly wrote:
>>> On 2/8/18 6:20 AM, Michael Ellerman wrote:
>>>
>>>> There's no reason pci_uevent_ers() needs to be inline in pci.h, so
>>>> move it out to a C file.
>>>>
>>>> Given it's used by AER the obvious location would be somewhere in
>>>> drivers/pci/pcie/aer, but because it's also used by powerpc EEH code
>>>> unfortunately that doesn't work in the case where EEH is enabled but
>>>> PCIEPORTBUS is not.
>>>>
>>>> So for now put it in pci-driver.c, next to pci_uevent(), with an
>>>> appropriate #ifdef so it's not built if AER and EEH are both disabled.
>>>>
>>>> While we're moving it also fix up the kernel doc comment for @pdev to
>>>> be accurate.
>>>>
>>>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>> ---
>>>>  drivers/pci/pci-driver.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>  include/linux/pci.h      | 38 +++-----------------------------------
>>>>  2 files changed, 39 insertions(+), 35 deletions(-)
>>> Looks good, thanks for fixing it!
>>>
>>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
>> This would normally be a "Reviewed-by" unless you actually
>> participated in developing the patch, and in that case, your
>> "Signed-off-by" would normally be included in the original posting.
>>
>> What do you intend?  I'll be glad to add either.
> I wrote the patch, so Bryant meant Reviewed-by or maybe Acked-by.
>
> cheers
>
Yes, I mean't, 

Reviewed-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>

Thanks, 

Bryant
