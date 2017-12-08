Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:58968 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbdLHVaQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Dec 2017 16:30:16 -0500
Subject: Re: [PATCH 3/3] x86/PCI: limit the size of the 64bit BAR to 256GB
To: Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20171129141229.6107-1-christian.koenig@amd.com>
 <20171129141229.6107-4-christian.koenig@amd.com>
 <20171206195118.GL23510@bhelgaas-glaptop.roam.corp.google.com>
 <20171208175635.GB12367@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel <xen-devel@lists.xen.org>,
        Juergen Gross <jgross@suse.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <c8968d82-2c83-a3b9-d656-702987b0a0b7@oracle.com>
Date: Fri, 8 Dec 2017 16:30:03 -0500
MIME-Version: 1.0
In-Reply-To: <20171208175635.GB12367@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/08/2017 12:56 PM, Bjorn Helgaas wrote:
> On Wed, Dec 06, 2017 at 01:51:18PM -0600, Bjorn Helgaas wrote:
>> On Wed, Nov 29, 2017 at 03:12:29PM +0100, Christian König wrote:
>>> This avoids problems with Xen which hides some memory resources from the
>>> OS and potentially also allows memory hotplug while this fixup is
>>> enabled.
>> The patch itself is OK, but the changelog doesn't say enough about
>> what the problem is.  I have no clue about what the Xen issue is or
>> why limiting the BAR to 256GB avoids the problem or what this has to
>> do with memory hotplug.
>>
>> For example, we should be able to tell why 256GB is the right number.
>> Maybe there's something specific in Xen you can reference?  Maybe an
>> example of what goes wrong with some details?
> Ping?  Is this change required to fix issues people are seeing?  If
> so, we either need to rework the changelog and get it merged, or
> revert the quirk as a whole.
>
> I tentatively applied the first two patches to for-linus, but I
> haven't asked Linus to pull them because I assumed we really needed
> all three.

This is not a fix but rather is a workaround. The problem is that Xen
dom0 may be running with less than all of the system memory and the
chunk of host memory that dom0 doesn't have is not exposed in e820 as
reserved. And so pci_amd_enable_64bit_bar() assumes that it can be used
for MMIO, with predictable results. Only trying to use very high
addresses limits chances that there is memory there.

The alternative is to revert f5775e0b6116b7e2425ccf535243b21768566d87.

I have been working on a proper fix but haven't been able to finish it yet.

-boris


>
> Bjorn
>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>  arch/x86/pci/fixup.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>>> index c817ab85dc82..149adbc7f2a3 100644
>>> --- a/arch/x86/pci/fixup.c
>>> +++ b/arch/x86/pci/fixup.c
>>> @@ -701,7 +701,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
>>>  	res->name = "PCI Bus 0000:00";
>>>  	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
>>>  		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
>>> -	res->start = 0x100000000ull;
>>> +	res->start = 0xbd00000000ull;
>>>  	res->end = 0xfd00000000ull - 1;
>>>  
>>>  	/* Just grab the free area behind system memory for this */
>>> -- 
>>> 2.11.0
>>>
