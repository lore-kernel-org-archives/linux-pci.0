Return-Path: <SRS0=H+2A=C2=amd.com=Christian.Koenig@kernel.org>
Return-Path: <SRS0=H+2A=C2=amd.com=Christian.Koenig@kernel.org>
Subject: Re: [Xen-devel] [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD
 Family 15h (Models 30h-3fh) Processors v5
To: Jan Beulich <JBeulich@suse.com>
Cc: helgaas@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, xen-devel <xen-devel@lists.xen.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <af7e8d49-4c3c-f9dc-4ddc-26ce7a1721d0@amd.com>
Date: Tue, 28 Nov 2017 11:17:33 +0100
MIME-Version: 1.0
In-Reply-To: <5A1D3E9D0200007800192A44@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 28.11.2017 um 10:46 schrieb Jan Beulich:
>>>> On 28.11.17 at 10:12, <christian.koenig@amd.com> wrote:
>> In theory the BIOS would search for address space and won't find
>> anything, so the hotplug operation should fail even before it reaches
>> the kernel in the first place.
> How would the BIOS know what the OS does or plans to do?

As far as I know the ACPI BIOS should work directly with the register 
content.

So when we update the register content to enable the MMIO decoding the 
BIOS should know that as well.

> I think
> it's the other way around - the OS needs to avoid using any regions
> for MMIO which are marked as hotpluggable in SRAT.

I was under the impression that this is exactly what 
acpi_numa_memory_affinity_init() does.

> Since there is
> no vNUMA yet for Xen Dom0, that would need special handling.

I think that the problem is rather that SRAT is NUMA specific and if I'm 
not totally mistaken the content is ignored when NUMA support isn't 
compiled into the kernel.

When Xen steals some memory from Dom0 by hocking up itself into the e820 
call then I would say the cleanest way is to report this memory in e820 
as reserved as well. But take that with a grain of salt, I'm seriously 
not a Xen expert.

Regards,
Christian.

>
> Jan
>
