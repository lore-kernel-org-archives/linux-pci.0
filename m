Return-Path: <SRS0=94dt=DI=oracle.com=boris.ostrovsky@kernel.org>
Return-Path: <SRS0=94dt=DI=oracle.com=boris.ostrovsky@kernel.org>
Subject: Re: [PATCH] x86/PCI: limit the size of the 64bit BAR to 256GB
To: christian.koenig@amd.com, Bjorn Helgaas <helgaas@kernel.org>
References: <20171211150452.23518-1-christian.koenig@amd.com>
 <20171212181237.GD53955@bhelgaas-glaptop.roam.corp.google.com>
 <ca0ac4ea-59cd-375c-f0ef-a80b2eb6deb0@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>, xen-devel <xen-devel@lists.xen.org>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <96adda17-b20e-5c37-2e6e-830b01405c1d@oracle.com>
Date: Tue, 12 Dec 2017 13:49:19 -0500
MIME-Version: 1.0
In-Reply-To: <ca0ac4ea-59cd-375c-f0ef-a80b2eb6deb0@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 12/12/2017 01:38 PM, Christian König wrote:
> Am 12.12.2017 um 19:12 schrieb Bjorn Helgaas:
>> [+cc Boris, Juergen, xen-devel]
>>
>> On Mon, Dec 11, 2017 at 04:04:52PM +0100, Christian König wrote:
>>> Xen hides a bit of system memory from the OS for its own purpose by
>>> intercepting e820. This memory is unfortunately not reported as
>>> reserved, but rather completely invisible.
>>>
>>> Avoid this address space collision and possible similar problems by
>>> limiting the size of the newly allocated root hub window to 256GB which
>>> should be sufficient for the short term.
>> It sounds like Boris is working on a more complete fix, so I'm going
>> to drop this for now.  This changelog includes a few more details, but
>> I think it makes implicit assumptions about where memory and holes
>> are and how big they are, and it's still not clear why 256GB is the
>> right number.  Is it connected to the expected size of the BAR, or
>> related somehow to the size of the hole?
>
> 256GB was just an arbitrary number I've thought should work for at
> least my use case.
>
> And yes Boris is working on a more complete and cleaner fix. I agree
> that we can completely drop my patch for now.
>
>> If we need this as a short-term workaround, we can do that, but I
>> would like to include a reference to f5775e0b6116 ("x86/xen: discard
>> RAM regions above the maximum reservation") and somehow make what's
>> going on here a little more explicit.

Let me clean up what I have and post it and we will see if it is
acceptable (I don't especially like it, TBH).

>
> That patch looks more like it only applies to Xen guests, but not
> dom0. But take that with a grain of salt I really don't know anything
> about that code.

dom0 is a guest too.

-boris


>
> Christian.
>
>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   arch/x86/pci/fixup.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>>> index 8f86060f5cf6..ed8bc6ab0573 100644
>>> --- a/arch/x86/pci/fixup.c
>>> +++ b/arch/x86/pci/fixup.c
>>> @@ -702,7 +702,7 @@ static void pci_amd_enable_64bit_bar(struct
>>> pci_dev *dev)
>>>       res->name = "PCI Bus 0000:00";
>>>       res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
>>>           IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
>>> -    res->start = 0x100000000ull;
>>> +    res->start = 0xbd00000000ull;
>>>       res->end = 0xfd00000000ull - 1;
>>>         /* Just grab the free area behind system memory for this */
>>> -- 
>>> 2.11.0
>>>
>
