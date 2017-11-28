Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0077.outbound.protection.outlook.com ([104.47.36.77]:51309
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754281AbdK1L7r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Nov 2017 06:59:47 -0500
Subject: Re: [Xen-devel] [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD
 Family 15h (Models 30h-3fh) Processors v5
To: Jan Beulich <JBeulich@suse.com>
Cc: helgaas@kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        xen-devel <xen-devel@lists.xen.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
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
 <0ab28334-3ccc-2a93-9991-396ee01a3662@amd.com>
 <5A1D3E9D0200007800192A44@prv-mh.provo.novell.com>
 <af7e8d49-4c3c-f9dc-4ddc-26ce7a1721d0@amd.com>
 <5A1D4E1D0200007800192AEF@prv-mh.provo.novell.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <77d42a2c-8289-6f6e-daec-6678e3b3ffdd@amd.com>
Date: Tue, 28 Nov 2017 12:59:31 +0100
MIME-Version: 1.0
In-Reply-To: <5A1D4E1D0200007800192AEF@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 28.11.2017 um 11:53 schrieb Jan Beulich:
>>>> On 28.11.17 at 11:17, <christian.koenig@amd.com> wrote:
>> Am 28.11.2017 um 10:46 schrieb Jan Beulich:
>>>>>> On 28.11.17 at 10:12, <christian.koenig@amd.com> wrote:
>>>> In theory the BIOS would search for address space and won't find
>>>> anything, so the hotplug operation should fail even before it reaches
>>>> the kernel in the first place.
>>> How would the BIOS know what the OS does or plans to do?
>> As far as I know the ACPI BIOS should work directly with the register
>> content.
>>
>> So when we update the register content to enable the MMIO decoding the
>> BIOS should know that as well.
> I'm afraid I don't follow: During memory hotplug, surely you don't
> expect the BIOS to do a PCI bus scan? Plus even if it did, it would
> be racy - some device could, at this very moment, have memory
> decoding disabled, just for the OS to re-enable it a millisecond
> later. Yet looking at BAR values is meaningless when memory
> decode of a device is disabled.

No, sorry you misunderstood me. The PCI bus is not even involved here.

In AMD Family CPUs you have four main types of address space routed by 
the NB:
1.  Memory space targeting system DRAM.
2.  Memory space targeting IO (MMIO).
3.  IO space.
4.  Configuration space.

See section "2.8.2 NB Routing" in the BIOS and Kernel Developer’s Guide 
(https://support.amd.com/TechDocs/49125_15h_Models_30h-3Fh_BKDG.pdf).

Long story short you have fix addresses for configuration and legacy IO 
(VGA for example) and then configurable memory space for DRAM and MMIO.

What the ACPI BIOS does (or at least should do) is taking a look at the 
registers to find space during memory hotplug.

Now in theory the MMIO space should be configurable by similar ACPI BIOS 
functions, but unfortunately most BIOS doesn't enable that function 
because it can break some older Windows versions.

So what we do here is just what the BIOS should have provided in the 
first place.

>>> I think
>>> it's the other way around - the OS needs to avoid using any regions
>>> for MMIO which are marked as hotpluggable in SRAT.
>> I was under the impression that this is exactly what
>> acpi_numa_memory_affinity_init() does.
> Perhaps, except that (when I last looked) insufficient state is
> (was) being recorded to have that information readily available
> at the time MMIO space above 4Gb needs to be allocated for
> some device.

That was also my concern, but in the most recent version I'm 
intentionally doing this fixup very late after all the PCI setup is 
already done.

This way the extra address space is only available for devices which are 
added by PCI hotplug or for resizing BARs on the fly (which is the use 
case I'm interested in).

>>> Since there is
>>> no vNUMA yet for Xen Dom0, that would need special handling.
>> I think that the problem is rather that SRAT is NUMA specific and if I'm
>> not totally mistaken the content is ignored when NUMA support isn't
>> compiled into the kernel.
>>
>> When Xen steals some memory from Dom0 by hocking up itself into the e820
>> call then I would say the cleanest way is to report this memory in e820
>> as reserved as well. But take that with a grain of salt, I'm seriously
>> not a Xen expert.
> The E820 handling in PV Linux is all fake anyway - there's a single
> chunk of memory given to a PV guest (including Dom0), contiguous
> in what PV guests know as "physical address space" (not to be
> mixed up with "machine address space", which is where MMIO
> needs to be allocated from). Xen code in the kernel then mimics
> an E820 matching the host one, moving around pieces of memory
> in physical address space if necessary.

Good to know.

> Since Dom0 knows the machine E820, MMIO allocation shouldn't
> need to be much different there from the non-Xen case.

Yes, completely agree.

I think even if we don't do MMIO allocation with this fixup letting the 
kernel in Dom0 know which memory/address space regions are in use is 
still a good idea.

Otherwise we will run into exactly the same problem when we do the MMIO 
allocation with an ACPI method and that is certainly going to come in 
the next BIOS generations because Microsoft is pushing for it.

Regards,
Christian.

>
> Jan
>
