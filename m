Return-Path: <SRS0=67P7=DG=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=67P7=DG=gmail.com=ckoenig.leichtzumerken@kernel.org>
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 3/3] x86/PCI: limit the size of the 64bit BAR to 256GB
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171129141229.6107-1-christian.koenig@amd.com>
 <20171129141229.6107-4-christian.koenig@amd.com>
 <20171206195118.GL23510@bhelgaas-glaptop.roam.corp.google.com>
 <20171208175635.GB12367@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <be4fe1d8-0e86-1c06-a489-e0beca65ea10@gmail.com>
Date: Sun, 10 Dec 2017 11:03:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171208175635.GB12367@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 08.12.2017 um 18:56 schrieb Bjorn Helgaas:
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
> Ping?

Sorry for the delay, first been to busy and then got a bad cold and 
today is the first day I've got out of bed again.

> Is this change required to fix issues people are seeing?  If
> so, we either need to rework the changelog and get it merged, or
> revert the quirk as a whole.

It's just a precaution to eventually avoid problems, I will try to 
provided a patch with updated commit log tomorrow.

> I tentatively applied the first two patches to for-linus, but I
> haven't asked Linus to pull them because I assumed we really needed
> all three.

The first two patches are perfectly enough for now.

Thanks,
Christian.

>
> Bjorn
>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   arch/x86/pci/fixup.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>>> index c817ab85dc82..149adbc7f2a3 100644
>>> --- a/arch/x86/pci/fixup.c
>>> +++ b/arch/x86/pci/fixup.c
>>> @@ -701,7 +701,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
>>>   	res->name = "PCI Bus 0000:00";
>>>   	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
>>>   		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
>>> -	res->start = 0x100000000ull;
>>> +	res->start = 0xbd00000000ull;
>>>   	res->end = 0xfd00000000ull - 1;
>>>   
>>>   	/* Just grab the free area behind system memory for this */
>>> -- 
>>> 2.11.0
>>>
