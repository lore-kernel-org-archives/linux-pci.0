Return-Path: <SRS0=99Jw=C2=suse.com=JBeulich@kernel.org>
Return-Path: <SRS0=99Jw=C2=suse.com=JBeulich@kernel.org>
Message-Id: <5A1D4E1D0200007800192AEF@prv-mh.provo.novell.com>
Date: Tue, 28 Nov 2017 03:53:01 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "=?UTF-8?Q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: <helgaas@kernel.org>,<amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>,
 "xen-devel" <xen-devel@lists.xen.org>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on
 AMD Family 15h (Models 30h-3fh) Processors v5
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
In-Reply-To: <af7e8d49-4c3c-f9dc-4ddc-26ce7a1721d0@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

>>> On 28.11.17 at 11:17, <christian.koenig@amd.com> wrote:
> Am 28.11.2017 um 10:46 schrieb Jan Beulich:
>>>>> On 28.11.17 at 10:12, <christian.koenig@amd.com> wrote:
>>> In theory the BIOS would search for address space and won't find
>>> anything, so the hotplug operation should fail even before it reaches
>>> the kernel in the first place.
>> How would the BIOS know what the OS does or plans to do?
>=20
> As far as I know the ACPI BIOS should work directly with the register=20
> content.
>=20
> So when we update the register content to enable the MMIO decoding =
the=20
> BIOS should know that as well.

I'm afraid I don't follow: During memory hotplug, surely you don't
expect the BIOS to do a PCI bus scan? Plus even if it did, it would
be racy - some device could, at this very moment, have memory
decoding disabled, just for the OS to re-enable it a millisecond
later. Yet looking at BAR values is meaningless when memory
decode of a device is disabled.

>> I think
>> it's the other way around - the OS needs to avoid using any regions
>> for MMIO which are marked as hotpluggable in SRAT.
>=20
> I was under the impression that this is exactly what=20
> acpi_numa_memory_affinity_init() does.

Perhaps, except that (when I last looked) insufficient state is
(was) being recorded to have that information readily available
at the time MMIO space above 4Gb needs to be allocated for
some device.

>> Since there is
>> no vNUMA yet for Xen Dom0, that would need special handling.
>=20
> I think that the problem is rather that SRAT is NUMA specific and if =
I'm=20
> not totally mistaken the content is ignored when NUMA support isn't=20
> compiled into the kernel.
>=20
> When Xen steals some memory from Dom0 by hocking up itself into the =
e820=20
> call then I would say the cleanest way is to report this memory in =
e820=20
> as reserved as well. But take that with a grain of salt, I'm seriously=20=

> not a Xen expert.

The E820 handling in PV Linux is all fake anyway - there's a single
chunk of memory given to a PV guest (including Dom0), contiguous
in what PV guests know as "physical address space" (not to be
mixed up with "machine address space", which is where MMIO
needs to be allocated from). Xen code in the kernel then mimics
an E820 matching the host one, moving around pieces of memory
in physical address space if necessary.

Since Dom0 knows the machine E820, MMIO allocation shouldn't
need to be much different there from the non-Xen case.

Jan
