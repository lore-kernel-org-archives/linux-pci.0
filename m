Return-Path: <SRS0=Jw/T=XQ=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=Jw/T=XQ=redhat.com=jcm@kernel.org>
Content-Type: text/plain;
	charset=us-ascii
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe controller
Message-Id: <F9F11C75-D8B5-45F0-948E-812F22FF22A2@redhat.com>
Date: Thu, 1 Dec 2016 17:31:21 -0500 (EST)
References: <1480549373-2123-1-git-send-email-dhdang@apm.com> <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com> <1480620053.4751.30.camel@redhat.com> <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com> <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
To: Duc Dang <dhdang@apm.com>
In-Reply-To: <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Mark Salter <msalter@redhat.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
List-ID: <linux-pci.vger.kernel.org>

Thanks Duc! I will test quickly if you have it today :)

--=20
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Dec 1, 2016, at 17:10, Duc Dang <dhdang@apm.com> wrote:
>=20
>> On Thu, Dec 1, 2016 at 11:41 AM, Bjorn Helgaas <helgaas@kernel.org> wrote=
:
>>> On Thu, Dec 01, 2016 at 02:20:53PM -0500, Mark Salter wrote:
>>>> On Thu, 2016-12-01 at 12:33 -0600, Bjorn Helgaas wrote:
>>>> On Wed, Nov 30, 2016 at 03:42:53PM -0800, Duc Dang wrote:
>>=20
>>>>> +static struct resource xgene_v1_csr_res[] =3D {
>>>>> + [0] =3D DEFINE_RES_MEM_NAMED(0x1f2b0000UL, SZ_64K, "PCIe CSR"),
>>>>> + [1] =3D DEFINE_RES_MEM_NAMED(0x1f2c0000UL, SZ_64K, "PCIe CSR"),
>>>>> + [2] =3D DEFINE_RES_MEM_NAMED(0x1f2d0000UL, SZ_64K, "PCIe CSR"),
>>>>> + [3] =3D DEFINE_RES_MEM_NAMED(0x1f500000UL, SZ_64K, "PCIe CSR"),
>>>>> + [4] =3D DEFINE_RES_MEM_NAMED(0x1f510000UL, SZ_64K, "PCIe CSR"),
>>>> I assume these ranges are not the actual ECAM space, right?
>>>> If they *were* ECAM, I assume you would have included them in the
>>>> quirk itself in the mcfg_quirks[] table.
>>>=20
>>> These are base addresses for some RC mmio registers.
>>>>=20
>>>>>=20
>>>>> +static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
>>>>> +{
>>>>> + struct acpi_device *adev =3D to_acpi_device(cfg->parent);
>>>>> + struct acpi_pci_root *root =3D acpi_driver_data(adev);
>>>>> + struct device *dev =3D cfg->parent;
>>>>> + struct xgene_pcie_port *port;
>>>>> + struct resource *csr;
>>>>> +
>>>>> + port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>>>>> + if (!port)
>>>>> +         return -ENOMEM;
>>>>> +
>>>>> + csr =3D &xgene_v1_csr_res[root->segment];
>>>> This makes me nervous because root->segment comes from the ACPI _SEG,
>>>> and if firmware gives us junk in _SEG, we will reference something in
>>>> the weeds.
>>>=20
>>> The SoC provide some number of RC bridges, each with a different base
>>> for some mmio registers. Even if segment is legitimate in MCFG, there
>>> is still a problem if a platform doesn't use the segment ordering
>>> implied by the code. But the PNP0A03 _CRS does have this base address
>>> as the first memory resource, so we could get it from there and not
>>> have hard-coded addresses and implied ording in the quirk code.
>>=20
>> I'm confused.  Doesn't the current code treat every item in PNP0A03
>> _CRS as a window?  Do you mean the first resource is handled
>> differently somehow?  The Consumer/Producer bit could allow us to do
>> this by marking the RC MMIO space as "Consumer", but I didn't think
>> that strategy was quite working yet.
>=20
> The first resource is defined like below. It was introduced long time
> ago to use with older version of X-Gene ECAM quirks.
> Memory32Fixed(ReadWrite, 0x1F2B0000, 0x10000, )
>=20
> The resource discovered during booting will be like following:
> [    0.728117] ACPI: MCFG table detected, 1 entries
> [    0.735330] ACPI: Power Resource [SCVR] (on)
> [    0.767478] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.774013] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> ClockPM Segments MSI]
> [    0.782864] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
> AER PCIeCapability]
> [    0.791331] acpi PNP0A08:00: MCFG quirk: ECAM at [mem
> 0xe0d0000000-0xe0dfffffff] for [bus 00-ff] with xgene_v1_pcie_ecam_ops
> [    0.803207] acpi PNP0A08:00: ECAM at [mem
> 0xe0d0000000-0xe0dfffffff] for [bus 00-ff]
> [    0.811399] Remapped I/O 0x000000e010000000 to [io  0x0000-0xffff windo=
w]
> [    0.818678] PCI host bridge to bus 0000:00
> [    0.822990] pci_bus 0000:00: root bus resource [mem 0x1f2b0000-0x1f2bff=
ff]
> [    0.830257] pci_bus 0000:00: root bus resource [io  0x0000-0xffff
> window] (bus address [0x10000000-0x1000ffff])
> [    0.840917] pci_bus 0000:00: root bus resource [mem
> 0xe040000000-0xe07fffffff window] (bus address
> [0x40000000-0x7fffffff])
> [    0.852675] pci_bus 0000:00: root bus resource [mem
> 0xf000000000-0xffffffffff window]
> [    0.860950] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.866761] pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400
> [    0.873175] pci 0000:00:00.0: supports D1 D2
> [    0.877980] pci 0000:01:00.0: [15b3:1003] type 00 class 0x020000
> [    0.884597] pci 0000:01:00.0: reg 0x10: [mem 0xe040000000-0xe0400fffff 6=
4bit]
> [    0.892337] pci 0000:01:00.0: reg 0x18: [mem
> 0xe042000000-0xe043ffffff 64bit pref]
> [    0.900694] pci 0000:01:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref=
]
> [    0.923853] pci_bus 0000:00: on NUMA node 0
> [    0.928269] pci 0000:00:00.0: BAR 15: assigned [mem
> 0xf000000000-0xf001ffffff 64bit pref]
> [    0.936908] pci 0000:00:00.0: BAR 14: assigned [mem
> 0xe040000000-0xe0401fffff]
> [    0.944539] pci 0000:01:00.0: BAR 2: assigned [mem
> 0xf000000000-0xf001ffffff 64bit pref]
> [    0.953210] pci 0000:01:00.0: BAR 0: assigned [mem
> 0xe040000000-0xe0400fffff 64bit]
> [    0.961430] pci 0000:01:00.0: BAR 6: assigned [mem
> 0xe040100000-0xe0401fffff pref]
> [    0.969438] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.974690] pci 0000:00:00.0:   bridge window [mem 0xe040000000-0xe0401=
fffff]
> [    0.982231] pci 0000:00:00.0:   bridge window [mem
> 0xf000000000-0xf001ffffff 64bit pref]
>=20
>>=20
>>> I have tested a modified version of these quirks using this to
>>> get the CSR base and it works on the 3 different platforms I have
>>> access to.
>>>=20
>>> static int xgene_pcie_get_csr(struct device *dev, struct resource *r)
>>> {
>>>      struct acpi_device *adev =3D to_acpi_device(dev);
>>>      unsigned long flags;
>>>      struct list_head list;
>>>      struct resource_entry *entry;
>>>      int ret;
>>>=20
>>>      INIT_LIST_HEAD(&list);
>>>      flags =3D IORESOURCE_MEM;
>>>      ret =3D acpi_dev_get_resources(adev, &list,
>>>                                   acpi_dev_filter_resource_type_cb,
>>>                                   (void *)flags);
>>>      if (ret < 0) {
>>>              dev_err(dev, "failed to parse _CRS, error: %d\n", ret);
>>>              return ret;
>>>      } else if (ret =3D=3D 0) {
>>>              dev_err(dev, "no memory resources present in _CRS\n");
>>>              return -EINVAL;
>>>      }
>>>=20
>>>      entry =3D list_first_entry(&list, struct resource_entry, node);
>>>      *r =3D *entry->res;
>>>      acpi_dev_free_resource_list(&list);
>>>      return 0;
>>> }
>>=20
>> The code above is identical to acpi_get_rc_addr(), which is used in
>> the acpi_get_rc_resources() path by the other quirks.  Can you use
>> that path, too, instead of reimplementing it here?
>=20
> I will post a new version using acpi_get_rc_resources and includes
> other changes that you suggested.
>=20
> Regards,
> Duc Dang.
