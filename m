Return-Path: <SRS0=X+pv=CU=oracle.com=boris.ostrovsky@kernel.org>
Return-Path: <SRS0=X+pv=CU=oracle.com=boris.ostrovsky@kernel.org>
Subject: Re: [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 30h-3fh) Processors v5
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, xen-devel <xen-devel@lists.xen.org>
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
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <0bb468d9-bc1d-e3c5-e313-1cf9408380f0@oracle.com>
Date: Wed, 22 Nov 2017 12:27:55 -0500
MIME-Version: 1.0
In-Reply-To: <7936fdd3-1615-ac1f-7b75-330ccb6a1a3f@amd.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/22/2017 11:54 AM, Christian König wrote:
> Am 22.11.2017 um 17:24 schrieb Boris Ostrovsky:
>> On 11/22/2017 05:09 AM, Christian König wrote:
>>> Am 21.11.2017 um 23:26 schrieb Boris Ostrovsky:
>>>> On 11/21/2017 08:34 AM, Christian König wrote:
>>>>> Hi Boris,
>>>>>
>>>>> attached are two patches.
>>>>>
>>>>> The first one is a trivial fix for the infinite loop issue, it now
>>>>> correctly aborts the fixup when it can't find address space for the
>>>>> root window.
>>>>>
>>>>> The second is a workaround for your board. It simply checks if there
>>>>> is exactly one Processor Function to apply this fix on.
>>>>>
>>>>> Both are based on linus current master branch. Please test if they
>>>>> fix
>>>>> your issue.
>>>> Yes, they do fix it but that's because the feature is disabled.
>>>>
>>>> Do you know what the actual problem was (on Xen)?
>>> I still haven't understood what you actually did with Xen.
>>>
>>> When you used PCI pass through with those devices then you have made a
>>> major configuration error.
>>>
>>> When the problem happened on dom0 then the explanation is most likely
>>> that some PCI device ended up in the configured space, but the routing
>>> was only setup correctly on one CPU socket.
>> The problem is that dom0 can be (and was in my case() booted with less
>> than full physical memory and so the "rest" of the host memory is not
>> necessarily reflected in iomem. Your patch then tried to configure that
>> memory for MMIO and the system hang.
>>
>> And so my guess is that this patch will break dom0 on a single-socket
>> system as well.
>
> Oh, thanks!
>
> I've thought about that possibility before, but wasn't able to find a
> system which actually does that.
>
> May I ask why the rest of the memory isn't reported to the OS?

That memory doesn't belong to the OS (dom0), it is owned by the hypervisor.

>
> Sounds like I can't trust Linux resource management and probably need
> to read the DRAM config to figure things out after all.


My question is whether what you are trying to do should ever be done for
a guest at all (any guest, not necessarily Xen).

-boris
