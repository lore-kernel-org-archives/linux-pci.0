Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Content-Type: text/plain;
	charset=us-ascii
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe controller
Message-Id: <879A81F2-E6AF-4FA2-9752-EEE7018B54D9@redhat.com>
Date: Fri, 2 Dec 2016 03:08:34 -0500 (EST)
References: <1480549373-2123-1-git-send-email-dhdang@apm.com> <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com> <1480620053.4751.30.camel@redhat.com> <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com> <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com> <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com> <CADaLND=Ss8d-jv7wffbrtytrjj=SUnjDn9bognKUszhKguRV1A@mail.gmail.com> <d77e403c-81e9-114e-6ec6-bbffaa4ac36f@redhat.com> <cc77fe88-b36e-bb36-b5df-2934a88bea3c@redhat.com> <CADaLND=fYXf-NOw7qm-KbDX3U3YrtAXRyQ+aj=CMcwmEaNHmpQ@mail.gmail.com>
To: Duc Dang <dhdang@apm.com>
In-Reply-To: <CADaLND=fYXf-NOw7qm-KbDX3U3YrtAXRyQ+aj=CMcwmEaNHmpQ@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Mark Salter <msalter@redhat.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
List-ID: <linux-pci.vger.kernel.org>

Quick reply - sorry for top posting (it's 3am...) - I would favor keeping th=
e existing Fixed32Memory _CRS but switching over to prefer the PNP entry as a=
 good citizen. The trouble is that it would be unfortunate if existing distr=
os stopped working on newer firmware and it would lead to IMO more pain than=
 it is worth. Hopefully for this reason Bjorn will take your v4 as-is for no=
w and let us all figure out the cleanest long term cleanup later.

--=20
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Dec 2, 2016, at 02:34, Duc Dang <dhdang@apm.com> wrote:
>=20
>> On Thu, Dec 1, 2016 at 10:31 PM, Jon Masters <jcm@redhat.com> wrote:
>> Bjorn,
>>=20
>> Although I think the below still applies (that we need to leave that
>> Memory32Fixed for existing deployments, and this is going to result
>> in /proc/iomem polution), I've done some more reading of your ecam
>> tree and the implementation of acpi_get_rc_resources you mentioned,
>> and in particular how the PNP0C02 devices actually get wired up.
>>=20
>> I would like to be able to boot upstream on existing shipping and
>> deployed machines that are in the field (not to mention our labs), but
>> there's no reason we can't *also* get APM to add a new vendor specific
>> PNP0C02 to the ACPI namespace in future firmware updates (for at least
>> their own Mustang reference boards) matching segment to CSR, as in the
>> case of the HiSi patches. That might then allow for some later
>> preference to use that for the CSR rather than getting it from the RC
>> device. Still, it would be ideal to boot on machines that are shipping
>> from HPE and others at this moment, so I am still hopeful you'll
>> at least allow the approach from Duc's v4 for now (4.10).
>=20
> APM X-Gene 1 and X-Gene 2 ACPI tables will absolutely have PNP0C02
> nodes (in upcoming firmware release). I hope to have a solution that
> works for both old buggy firmware and the future improved firmware. So
> I am thinking the CSR discovery will be like this:
>=20
> (1) Use  acpi_get_rc_resources() to discover CSR resource by checking
> PNP0C02 nodes
> (2) (1) should succeed with the new firmware
> (3) If (1) fails, we can fall back to approach on v4 patch: calling
> xgene_get_csr_resource() to discover the CSR described by
> Memory32Fixed macro.
>=20
> How do you feel about this? The drawback is the new firmware that does
> not have the CSR space described with Memory32Fixed macro will fail on
> the distro version that uses the old quirk (that relies on this
> Memory32Fixed macro).
>=20
>>=20
>> Another nasty option for later consideration could then be having
>> the kernel fake up any missing PNP0C02 on existing machines, but
>> it would need special knowledge of the platform to generate that
>> so as to handle the problem Mark flagged earlier (segment vs
>> controller mismatch on some platforms). That could be done with a
>> DMI quirk that matched on a specific (e.g. HPE) machine. It would
>> only be needed on "broken" existing machines, and could be added
>> post-4.10 to clean this up if you really want to do that.
>=20
> Bjorn suggested similar approach (have a PNP quirk to fabricate a
> PNP0C02 device and decleare all the required resources there) on
> another thread. But as you said, this approach does not scale, it can
> only applicable for a specific machine (by checking DMI information to
> apply the PNP quirk).
>=20
>>=20
>> That's all very nasty...
>>=20
>> Jon.
>>=20
>>> On 12/01/2016 11:08 PM, Jon Masters wrote:
>>> Hi Bjorn, Duc, Mark,
>>>=20
>>> I switched my brain to the on mode and went and read some specs, and a f=
ew
>>> tables, so here's my 2 cents on this...
>>>=20
>>>> On 12/01/2016 06:22 PM, Duc Dang wrote:
>>>>> On Thu, Dec 1, 2016 at 3:07 PM, Bjorn Helgaas <helgaas@kernel.org> wro=
te:
>>>>> On Thu, Dec 01, 2016 at 02:10:10PM -0800, Duc Dang wrote:
>>>=20
>>>>>>>> The SoC provide some number of RC bridges, each with a different ba=
se
>>>>>>>> for some mmio registers. Even if segment is legitimate in MCFG, the=
re
>>>>>>>> is still a problem if a platform doesn't use the segment ordering
>>>>>>>> implied by the code. But the PNP0A03 _CRS does have this base addre=
ss
>>>>>>>> as the first memory resource, so we could get it from there and not=

>>>>>>>> have hard-coded addresses and implied ording in the quirk code.
>>>>>>>=20
>>>>>>> I'm confused.  Doesn't the current code treat every item in PNP0A03
>>>>>>> _CRS as a window?  Do you mean the first resource is handled
>>>>>>> differently somehow?  The Consumer/Producer bit could allow us to do=

>>>>>>> this by marking the RC MMIO space as "Consumer", but I didn't think
>>>>>>> that strategy was quite working yet.
>>>=20
>>> Let's see if I summarized this correctly...
>>>=20
>>> 1. The MMIO registers for the host bridge itself need to be described
>>>   somewhere, especially if we need to find those in a quirk and poke
>>>   them. Since those registers are very much part of the bridge device,
>>>   it makes sense for them to be in the _CRS for PNP0A08/PNP0A03.
>>>=20
>>> 2. The address space covering these registers MUST be described as a
>>>   ResourceConsumer in order to avoid accidentally exposing them as
>>>   available for use by downstream devices on the PCI bus.
>>>=20
>>> 3. The ACPI specification allows for resources of the type "Memory32Fixe=
d".
>>>   This is a macro that doesn't have the notion of a producer or consumer=
.
>>>   HOWEVER various interpretations seem to be that this could/should
>>>   default to being interpreted as a consumed region.
>>>=20
>>> 4. At one point, a regression was added to the kernel:
>>>=20
>>>   63f1789ec716 ("x86/PCI/ACPI: Ignore resources consumed by
>>>   host bridge itself")
>>>=20
>>>   Which lead to a series on conversations about what should happen
>>>   for bridge resources (e.g. https://lkml.org/lkml/2015/3/24/962 )
>>>=20
>>> 5. This resulted in the following commit reverting point 4:
>>>=20
>>>   2c62e8492ed7 ("x86/PCI/ACPI: Make all resources except [io 0xcf8-0xcff=
]
>>>   available on PCI bus")
>>>=20
>>>   Which also stated that:
>>>=20
>>>   "This solution will also ease the way to consolidate ACPI PCI host
>>>    bridge common code from x86, ia64 and ARM64"
>>>=20
>>> End of summary.
>>>=20
>>> So it seems that generally there is an aversion to having bridge resourc=
es
>>> be described in this manner and you would like to require that they be
>>> described e.g. using QWordMemory with a ResourceConsumer type?
>>>=20
>>> BUT if we were to do that, it would break existing shipping systems sinc=
e
>>> there are quirks out there that use this form to find the base CSR:
>>>=20
>>>       if (acpi_res->type =3D=3D ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
>>>                fixed32 =3D &acpi_res->data.fixed_memory32;
>>>                port->csr_base =3D ioremap(fixed32->address,
>>>                                         fixed32->address_length);
>>>                return AE_CTRL_TERMINATE;
>>>        }
>>>=20
>>> That's what's shipping in at least RHEL(SA) today, and probably in other=

>>> distros. So if we get vendors to take that out, existing stuff will brea=
k,
>>> which will have the downside that customers will have to choose between
>>> whether to run a given distro or be able to use upstream kernels. In
>>> that sense, to me, there are shipping platforms out there, which may wel=
l
>>> be doing the "wrong" thing, but they are deployed and they are doing it.=

>>>=20
>>> Which makes me wonder a couple of things (I think should NOT be done):
>>>=20
>>> 1. What would happen if we had both. A FixedMemory32 and the same region=

>>>   described again using the longer form as a consumed region. I doubt
>>>   that's legal, and the current code would still add the region if it
>>>   saw the FixedMemory32 first when walking the tree. I don't like it,
>>>   but I'm mentioning it in case that leads to some helpful thinking.
>>>=20
>>> 2. What would happen if we had a difference policy on arm64 for such
>>>   resources. x86 has an "exception" for accessing the config space
>>>   using IO port 0xCF8-0xCFF (a fairly reasonable exception!) and
>>>   we can make the rules for a new platform (i.e. actually prescribe
>>>   exactly what the behavior is, rather than have it not be defined).
>>>   This is of course terrible in that existing BIOS vendors and so on
>>>   won't necessarily know this when working on ARM ACPI later on.
>>>=20
>>> I don't like either of these obviously. I'm hoping there's some way we
>>> can say that this is tolerated in this one quirk (allow the use of
>>> FixedMemory32 in this case) on the grounds that the driver claims
>>> this bridge region and can be annotated to explain such.
>>>=20
>>> Once you let us know what you prefer, we will go and update the ARM
>>> SBBR to spell out that future platforms should not make this mistake
>>> again. We can prescribe whatever you'd like in terms of how bridge
>>> resources consumed by the bridge are exposed. I have spoken about
>>> this kind of situation within MS in the past, but they didn't have
>>> specific guidance since they don't really tolerate such quirks. I
>>> can, however, consult them before we change the SBBR as well.
>>>=20
>>>>>> The first resource is defined like below. It was introduced long time=

>>>>>> ago to use with older version of X-Gene ECAM quirks.
>>>>>> Memory32Fixed(ReadWrite, 0x1F2B0000, 0x10000, )
>>>=20
>>> Indeed. And in the case of m400, it is currently this in shipping system=
s:
>>>=20
>>>               Memory32Fixed (ReadWrite,
>>>                    0x1F500000,         // Address Base
>>>                    0x00010000,         // Address Length
>>>                    )
>>>=20
>>> The spec isn't clear on whether these are produced or consumed but the
>>> implication is that these are consumed resources in most cases. Not that=

>>> this changes any of the above, but one can understand why it happened.
>>>=20
>>>>>> [    0.822990] pci_bus 0000:00: root bus resource [mem 0x1f2b0000-0x1=
f2bffff]
>>>>>=20
>>>>> I think this is wrong.  The PCI core thinks [mem 0x1f2b0000-0x1f2bffff=
]
>>>>> is available for use by devices on bus 0000:00, but I think you're
>>>>> saying it is consumed by the bridge itself, not forwarded down to PCI.=

>>>=20
>>> Indeed.
>>>=20
>>>>> What's in your /proc/iomem?  I see that your quirks do call
>>>>> devm_ioremap_resource(), which calls devm_request_mem_region()
>>>>> internally, so the driver does at least request that region, which
>>>>> should keep us from assigning it to PCI devices.
>>>=20
>>> I'm hoping you can grant an exception on the grounds that the quirk will=

>>> keep the region from actually being used. And then somehow we document
>>> this in the driver.
>>>=20
>>>>> But it still isn't quite right to tell the PCI core that the region is=

>>>>> available on the root bus.
>>>>=20
>>>> This is /proc/iomem output on my Mustang board. The 64K "PCIe CSR"
>>>> region is consumed completely.
>>>> 1f2b0000-1f2bffff : PCI Bus 0000:00
>>>>  1f2b0000-1f2bffff : PCIe CSR
>>>>=20
>>>> e040000000-e07fffffff : PCI Bus 0000:00
>>>>  e040000000-e0401fffff : PCI Bus 0000:01
>>>>    e040000000-e0400fffff : 0000:01:00.0
>>>>      e040000000-e0400fffff : mlx4_core
>>>>    e040100000-e0401fffff : 0000:01:00.0
>>>> e0d0000000-e0dfffffff : PCI ECAM
>>>> f000000000-ffffffffff : PCI Bus 0000:00
>>>>  f000000000-f001ffffff : PCI Bus 0000:01
>>>>    f000000000-f001ffffff : 0000:01:00.0
>>>>      f000000000-f001ffffff : mlx4_core
>>>>=20
>>>> Using hard-coded resources for mmio space make the quirk rely on the
>>>> segment number passing from the firmware. Using Mark's method or
>>>> acpi_get_rc_resource can discover the mmio space and consume all of
>>>> the space, but as you mentioned, it leaves the defect that PCI core
>>>> considers the mmio space as available resource for secondary devices
>>>> although it will never allocate the mmio space to secondary devices as
>>>> the RC already reserves and consumes all of the space.
>>>=20
>>> Indeed. It's not clean, but perhaps we can get away with it on the
>>> grounds that there are existing systems out there and this won't
>>> be allowed to happen again in the future :)
>>>=20
>>> Jon.
>>>=20
>>=20
>>=20
>> --
>> Computer Architect | Sent from my Fedora powered laptop
