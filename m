Return-Path: <SRS0=H+2A=C2=amd.com=Christian.Koenig@kernel.org>
Return-Path: <SRS0=H+2A=C2=amd.com=Christian.Koenig@kernel.org>
Subject: Re: [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 30h-3fh) Processors v5
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, helgaas@kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 xen-devel <xen-devel@lists.xen.org>
References: <20171018135821.3248-1-deathsimple@vodafone.de>
 <20171018135821.3248-5-deathsimple@vodafone.de>
 <c5ca14bc-3812-ff15-7dd0-e862ce85a348@oracle.com>
 <d81d50e6-c267-fe43-214f-278e57903448@gmail.com>
 <26df0a78-8028-e42c-ce50-4cefe612a7e1@oracle.com>
 <3443aad0-8c3b-b97e-685a-96b0866827be@amd.com>
 <b937778c-556e-5587-c557-abba8cefe100@oracle.com>
 <bee2c953-0ab6-a086-9150-ae51e099655c@amd.com>
 <c2d52d00-8c3c-9944-29b3-3cab2f7c35f7@oracle.com>
 <7936fdd3-1615-ac1f-7b75-330ccb6a1a3f@amd.com>
 <0bb468d9-bc1d-e3c5-e313-1cf9408380f0@oracle.com>
 <275e859a-0ddd-ea7f-a681-67e42a5233fe@amd.com>
 <38bc76d9-2ed5-61f3-24b3-085031825181@oracle.com>
 <65885386-3dde-de23-7e95-7d96dfdf6033@oracle.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0ab28334-3ccc-2a93-9991-396ee01a3662@amd.com>
Date: Tue, 28 Nov 2017 10:12:44 +0100
MIME-Version: 1.0
In-Reply-To: <65885386-3dde-de23-7e95-7d96dfdf6033@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------6B8B41B4035F4AC36787ABE7"
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------6B8B41B4035F4AC36787ABE7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.11.2017 um 19:30 schrieb Boris Ostrovsky:
> On 11/23/2017 09:12 AM, Boris Ostrovsky wrote:
>>
>> On 11/23/2017 03:11 AM, Christian König wrote:
>>> Am 22.11.2017 um 18:27 schrieb Boris Ostrovsky:
>>>> On 11/22/2017 11:54 AM, Christian König wrote:
>>>>> Am 22.11.2017 um 17:24 schrieb Boris Ostrovsky:
>>>>>> On 11/22/2017 05:09 AM, Christian König wrote:
>>>>>>> Am 21.11.2017 um 23:26 schrieb Boris Ostrovsky:
>>>>>>>> On 11/21/2017 08:34 AM, Christian König wrote:
>>>>>>>>> Hi Boris,
>>>>>>>>>
>>>>>>>>> attached are two patches.
>>>>>>>>>
>>>>>>>>> The first one is a trivial fix for the infinite loop issue, it now
>>>>>>>>> correctly aborts the fixup when it can't find address space for
>>>>>>>>> the
>>>>>>>>> root window.
>>>>>>>>>
>>>>>>>>> The second is a workaround for your board. It simply checks if
>>>>>>>>> there
>>>>>>>>> is exactly one Processor Function to apply this fix on.
>>>>>>>>>
>>>>>>>>> Both are based on linus current master branch. Please test if they
>>>>>>>>> fix
>>>>>>>>> your issue.
>>>>>>>> Yes, they do fix it but that's because the feature is disabled.
>>>>>>>>
>>>>>>>> Do you know what the actual problem was (on Xen)?
>>>>>>> I still haven't understood what you actually did with Xen.
>>>>>>>
>>>>>>> When you used PCI pass through with those devices then you have
>>>>>>> made a
>>>>>>> major configuration error.
>>>>>>>
>>>>>>> When the problem happened on dom0 then the explanation is most
>>>>>>> likely
>>>>>>> that some PCI device ended up in the configured space, but the
>>>>>>> routing
>>>>>>> was only setup correctly on one CPU socket.
>>>>>> The problem is that dom0 can be (and was in my case() booted with
>>>>>> less
>>>>>> than full physical memory and so the "rest" of the host memory is not
>>>>>> necessarily reflected in iomem. Your patch then tried to configure
>>>>>> that
>>>>>> memory for MMIO and the system hang.
>>>>>>
>>>>>> And so my guess is that this patch will break dom0 on a single-socket
>>>>>> system as well.
>>>>> Oh, thanks!
>>>>>
>>>>> I've thought about that possibility before, but wasn't able to find a
>>>>> system which actually does that.
>>>>>
>>>>> May I ask why the rest of the memory isn't reported to the OS?
>>>> That memory doesn't belong to the OS (dom0), it is owned by the
>>>> hypervisor.
>>>>
>>>>> Sounds like I can't trust Linux resource management and probably need
>>>>> to read the DRAM config to figure things out after all.
>>>> My question is whether what you are trying to do should ever be done
>>>> for
>>>> a guest at all (any guest, not necessarily Xen).
>>> The issue is probably that I don't know enough about Xen: What
>>> exactly is dom0? My understanding was that dom0 is the hypervisor,
>>> but that seems to be incorrect.
>>>
>>> The issue is that under no circumstances *EVER* a virtualized guest
>>> should have access to the PCI devices marked as "Processor Function"
>>> on AMD platforms. Otherwise it is trivial to break out of the
>>> virtualization.
>>>
>>> When dom0 is something like the system domain with all hardware
>>> access then the approach seems legitimate, but then the hypervisor
>>> should report the stolen memory to the OS using the e820 table.
>>>
>>> When the hypervisor doesn't do that and the Linux kernel isn't aware
>>> that there is memory at a given location mapping PCI space there will
>>> obviously crash the hypervisor.
>>>
>>> Possible solutions as far as I can see are either disabling this
>>> feature when we detect that we are a Xen dom0, scanning the DRAM
>>> settings to update Linux resource handling or fixing Xen to report
>>> stolen memory to the dom0 OS as reserved.
>>>
>>> Opinions?
>> You are right, these functions are not exposed to a regular guest.
>>
>> I think for dom0 (which is a special Xen guest, with additional
>> privileges) we may be able to add a reserved e820 region for host
>> memory that is not assigned to dom0. Let me try it on Monday (I am out
>> until then).
>
> One thing I realized while looking at solution for Xen dom0 is that this
> patch may cause problems for memory hotplug.

Good point. My assumption was that when you got an BIOS which can handle 
memory hotplug then you also got an BIOS which doesn't need this fixup. 
But I've never validated that assumption.

> What happens if new memory
> is added to the system and we have everything above current memory set
> to MMIO?

In theory the BIOS would search for address space and won't find 
anything, so the hotplug operation should fail even before it reaches 
the kernel in the first place.

In practice I think that nobody ever tested if that works correctly. So 
I'm pretty sure the system would just crash.

How about the attached patch? It limits the newly added MMIO space to 
the upper 256GB of the address space. That should still be enough for 
most devices, but we avoid both issues with Xen dom0 as most likely 
problems with memory hotplug as well.

Christian.

>
> -boris
>


--------------6B8B41B4035F4AC36787ABE7
Content-Type: text/x-patch;
 name="0001-x86-PCI-limit-the-size-of-the-64bit-BAR-to-256GB.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-x86-PCI-limit-the-size-of-the-64bit-BAR-to-256GB.patch"

>From 586bd9d67ebb6ca48bd0a6b1bd9203e94093cc8e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Tue, 28 Nov 2017 10:02:35 +0100
Subject: [PATCH] x86/PCI: limit the size of the 64bit BAR to 256GB
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This avoids problems with Xen which hides some memory resources from the
OS and potentially also allows memory hotplug while this fixup is
enabled.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 56c39a7bd080..6dffdee8a2de 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -690,7 +690,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	res->name = "PCI Bus 0000:00";
 	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
 		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
-	res->start = 0x100000000ull;
+	res->start = 0xbd00000000ull;
 	res->end = 0xfd00000000ull - 1;
 
 	/* Just grab the free area behind system memory for this */
-- 
2.11.0


--------------6B8B41B4035F4AC36787ABE7--
